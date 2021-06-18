Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47903ACE10
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbhFRO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:58:06 -0400
Received: from pv50p00im-ztdg10021101.me.com ([17.58.6.44]:53438 "EHLO
        pv50p00im-ztdg10021101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234712AbhFRO6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1624028156; bh=Ij8tlaut9s05rN09YP89e/qZ1FIC8Gnd8swZTHoz/Oo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=bab//e/f3y/EuyyFAtpgFwHub4SUYa+zFgXa3Q7XFZbtAGkoMmu1nrIvlbRaLlEsl
         IKRjXvYuAONmb4c3rFA+zjFaxr58QvRoIpC84hkgBR6HdKlOKY61LXfIJ93ldPYyIt
         4ExtFz2pvIzSb1qSnLpzqkNVpyoAC85/UrV7WYhtpCrIqQdxLzkMYFDOb4oB9iWajp
         DEewb/cqzJ0dKPvu1i0+wH8N29cF8OYVJnQdO9P1oAaZVA26OQhkmEJfgonaEmMe17
         /mPFCjS9xQ8K9MK0GbtlffhY2hJTaBgvYepP5wThleKoGauXoyxfG+9s7XCkujDFtA
         GFZmzlcA/0PDg==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 655BB18038B;
        Fri, 18 Jun 2021 14:55:53 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 0/3] some improvements for lockdep
Date:   Fri, 18 Jun 2021 22:55:31 +0800
Message-Id: <20210618145534.438816-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=304 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106180088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Unlikely the checks of return values of graph walk will improve the
performance to some degree, patch 1 and patch 2 are for this.

The patch 3 will print a warning after counting lock deps when hitting
bfs errors.

v2:
* For patch 3, avoid to call lockdep_unlock() twice after counting deps.
  Please see https://lkml.org/lkml/2021/6/17/741. 

Xiongwei Song (3):
  locking/lockdep: Unlikely bfs_error() inside
  locking/lockdep: Unlikely conditons about BFS_RMATCH
  locking/lockdep: Print possible warning after counting deps

 kernel/locking/lockdep.c | 55 +++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

-- 
2.30.2

