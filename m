Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BDC42C500
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhJMPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhJMPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:44:22 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4642C061570;
        Wed, 13 Oct 2021 08:42:18 -0700 (PDT)
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DEoeFe022425;
        Wed, 13 Oct 2021 16:42:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=DO0lCRBNP6M5Y5Vbcjjxet85Ai56VRLRgzAv8gTnEi4=;
 b=LutFxOtBHH79K4N5/a25Rr5fdS8vCseKjZljj9fq3w8Y7I1Mx1JulDF+glH0gK6yXyQc
 oEAUkdA3bi9qSk3qOWdHMEj8mhPqOjQx+LxgSi4JzZY6vv55XF/Tk68P4JRju1oy4Kod
 CLUcnNRIKFtL7ToA/UoKrZqLNyS4nF4XzrxKNr99T6838UztHHqMUIIpcEZ0l4JB/e8M
 zO8u7zmKca8KFu9tGVvi05F9gKpvaG44sICgCOY74UN+cViLKJ6L5khXEwZJbKBWkb7y
 NE4ACHdSsDfRw+LOiNZhC6JS8lP/cS0wJtMcCi50sN5XqTZ7kbLCGWnbCMERJNaP6xkx Kg== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 3bp1jy15hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:42:13 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 19DFXxKI013080;
        Wed, 13 Oct 2021 11:42:12 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint1.akamai.com with ESMTP id 3bneah9r5t-1;
        Wed, 13 Oct 2021 11:42:12 -0400
Received: from bos-lpjec.145bw.corp.akamai.com (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 9E4F127751;
        Wed, 13 Oct 2021 15:42:12 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     gregkh@linuxfoundation.org
Cc:     ahalaney@redhat.com, jim.cromie@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Trivial dynamic debug fixups
Date:   Wed, 13 Oct 2021 11:40:19 -0400
Message-Id: <1634139622-20667-1-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-13_06:2021-10-13,2021-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=758 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130101
X-Proofpoint-ORIG-GUID: BFN7zaovYHcpRbmz3HlFNSeoqVYD4-jF
X-Proofpoint-GUID: BFN7zaovYHcpRbmz3HlFNSeoqVYD4-jF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=713 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's the patch series from Andrew. Please consider applying to -next.
I copied his cover letter message below.

Thanks!

-Jason


Here is round 3 of some trivial dynamic debug improvements.

v2 -> v3:
 * Use a more clear example in the cli param examples

v1 -> v2:
 * Use different example when showing misleading error message
 * Justify dynamic debug scanning the whole command line
 * Add patch removing ddebug_query
 * Add patch improving cli param examples for dyndbg/$module.dyndbg

v2: https://lore.kernel.org/all/20210913222440.731329-1-ahalaney@redhat.com/
v1: https://lore.kernel.org/all/20210909161755.61743-1-ahalaney@redhat.com/


Andrew Halaney (3):
  dyndbg: make dyndbg a known cli param
  dyndbg: Remove support for ddebug_query param
  Documentation: dyndbg: Improve cli param examples

 Documentation/admin-guide/dynamic-debug-howto.rst | 13 ++++++-----
 Documentation/admin-guide/kernel-parameters.txt   |  5 -----
 lib/dynamic_debug.c                               | 27 ++++++-----------------
 3 files changed, 14 insertions(+), 31 deletions(-)

-- 
2.7.4

