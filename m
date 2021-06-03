Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB479399742
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFCA5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:57:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40894 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229667AbhFCA5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:57:08 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1530sKVv019941
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jun 2021 17:55:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=yiPoD68+sDtq2panK610F9d/gT/Vb3ovaQ8YE52c+AY=;
 b=dzP4JXPpVUqk4YZb1QBDC1odmdtkSp9HM0WR//9FfGhTUK+um4cxrx8i0zEN1DutA+Pz
 xeKXynsxLRNc7Fbhxq2xam8BV2LwNGGQ//+CpWntFgxe6GncJKMRZbXPKRvqAr6p+kg5
 FTz9fAFn7ZE/3+vhMMEC8nl+sv54dJJlu7E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 38xby4bknu-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 17:55:24 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:55:23 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 934D17F192A2; Wed,  2 Jun 2021 17:55:22 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v6 0/5] cgroup, blkcg: prevent dirty inodes to pin dying memory cgroups
Date:   Wed, 2 Jun 2021 17:55:12 -0700
Message-ID: <20210603005517.1403689-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AzoOZMzfzCV4QNYfPeVn9qaQ_K7fqT6F
X-Proofpoint-GUID: AzoOZMzfzCV4QNYfPeVn9qaQ_K7fqT6F
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=359 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106030004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an inode is getting dirty for the first time it's associated
with a wb structure (see __inode_attach_wb()). It can later be
switched to another wb (if e.g. some other cgroup is writing a lot of
data to the same inode), but otherwise stays attached to the original
wb until being reclaimed.

The problem is that the wb structure holds a reference to the original
memory and blkcg cgroups. So if an inode has been dirty once and later
is actively used in read-only mode, it has a good chance to pin down
the original memory and blkcg cgroups forewer. This is often the case wit=
h
services bringing data for other services, e.g. updating some rpm
packages.

In the real life it becomes a problem due to a large size of the memcg
structure, which can easily be 1000x larger than an inode. Also a
really large number of dying cgroups can raise different scalability
issues, e.g. making the memory reclaim costly and less effective.

To solve the problem inodes should be eventually detached from the
corresponding writeback structure. It's inefficient to do it after
every writeback completion. Instead it can be done whenever the
original memory cgroup is offlined and writeback structure is getting
killed. Scanning over a (potentially long) list of inodes and detach
them from the writeback structure can take quite some time. To avoid
scanning all inodes, attached inodes are kept on a new list (b_attached).
To make it less noticeable to a user, the scanning and switching is perfo=
rmed
from a work context.

Big thanks to Jan Kara, Dennis Zhou and Hillf Danton for their ideas and
contribution to this patchset.


v6:
  - extended and reused wbs switching functionality to switch inodes
    on cgwb cleanup
  - fixed offline_list handling
  - switched to the unbound_wq
  - other minor fixes

v5:
  - switch inodes to bdi->wb instead of zeroing inode->i_wb
  - split the single patch into two
  - only cgwbs maintain lists of attached inodes
  - added cond_resched()
  - fixed !CONFIG_CGROUP_WRITEBACK handling
  - extended list of prohibited inodes flag
  - other small fixes


Roman Gushchin (5):
  writeback, cgroup: switch to rcu_work API in inode_switch_wbs()
  writeback, cgroup: keep list of inodes attached to bdi_writeback
  writeback, cgroup: split out the functional part of
    inode_switch_wbs_work_fn()
  writeback, cgroup: support switching multiple inodes at once
  writeback, cgroup: release dying cgwbs by switching attached inodes

 fs/fs-writeback.c                | 201 ++++++++++++++++++++++---------
 include/linux/backing-dev-defs.h |   2 +
 include/linux/writeback.h        |   1 +
 mm/backing-dev.c                 |  60 ++++++++-
 4 files changed, 204 insertions(+), 60 deletions(-)

--=20
2.31.1

