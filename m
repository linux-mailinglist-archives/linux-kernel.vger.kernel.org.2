Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131C0322253
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhBVWpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:45:15 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:33950 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhBVWoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:44:54 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 433F272C8B3;
        Tue, 23 Feb 2021 01:44:10 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 364F67CC89C; Tue, 23 Feb 2021 01:44:10 +0300 (MSK)
Date:   Mon, 22 Feb 2021 08:00:00 +0000
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: nfnetlink_cthelper.h: fix userspace compilation error
Message-ID: <20210222080000.GA5900@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, <linux/netfilter/nfnetlink_cthelper.h> and
<linux/netfilter/nfnetlink_acct.h> could not be included into the same
compilation unit because of a cut-and-paste typo in the former header.

Fixes: 12f7a505331e6 ("netfilter: add user-space connection tracking helper infrastructure")
Cc: <stable@vger.kernel.org> # v3.6
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/netfilter/nfnetlink_cthelper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter/nfnetlink_cthelper.h b/include/uapi/linux/netfilter/nfnetlink_cthelper.h
index a13137afc429..70af02092d16 100644
--- a/include/uapi/linux/netfilter/nfnetlink_cthelper.h
+++ b/include/uapi/linux/netfilter/nfnetlink_cthelper.h
@@ -5,7 +5,7 @@
 #define NFCT_HELPER_STATUS_DISABLED	0
 #define NFCT_HELPER_STATUS_ENABLED	1
 
-enum nfnl_acct_msg_types {
+enum nfnl_cthelper_msg_types {
 	NFNL_MSG_CTHELPER_NEW,
 	NFNL_MSG_CTHELPER_GET,
 	NFNL_MSG_CTHELPER_DEL,
-- 
ldv
