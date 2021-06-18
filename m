Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9B3AD27A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhFRTDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:03:14 -0400
Received: from guerre.jabatus.fr ([109.234.163.21]:57083 "EHLO
        guerre.jabatus.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhFRTDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:03:13 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jun 2021 15:03:12 EDT
X-Spam-Status: No
X-MailPropre-MailScanner-From: contact@divlo.fr
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-1.08, required 5, autolearn=disabled, RCVD_IN_DNSWL_HI 0.01,
        SPF_HELO_PASS -0.10, SPF_PASS -1.00, SUKB_11 0.01)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailPropre-MailScanner-ID: 21D141004BD.AA863
X-MailPropre-MailScanner-Information: Please contact the ISP for more information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=divlo.fr;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AfttoLgeujcJLSBj/KgtVKZdzTRxQ/k97NhfPqRv00s=; b=hGSsUgb6imz3K3NLPzLEoP4Wr/
        zbNc4bG5+2UXrvEbN5C/sH1g96CJTwK46jh9VYOs+LeV/cM+CxRmLMgdDgLYLEemUFsAk7tJPFOc9
        4omdAJBLs//tI5GLMOlyFbziKYZdWMxvT0cL9hdbZuS3tirdpwVm5XXlgT+aycXs1xDgEkx3ReaOO
        H0pdksAevYbnmBqLFlSNCvONUGR5g+leYZhe01KLr8CmizwfV4cJP1+llxiDA3X/AqVgYhCsn8PaU
        FHiXIvJHfSFe7PluclByR7krpqQs9hWDNwZIIifRjbTyUvmU/IbAB+NMezcyBdJ1ON68f2p7k3Cps
        CB3dnLtw==;
From:   divlo <contact@divlo.fr>
To:     linux-kernel@vger.kernel.org
Cc:     divlo <contact@divlo.fr>
Subject: [PATCH] CHECKPATCH: correct spelling error, from "reqired" to "required"
Date:   Fri, 18 Jun 2021 20:55:12 +0200
Message-Id: <20210618185512.73005-1-contact@divlo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - carlos.o2switch.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - divlo.fr
X-Get-Message-Sender-Via: carlos.o2switch.net: authenticated_id: contact@divlo.fr
X-Authenticated-Sender: carlos.o2switch.net: contact@divlo.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: divlo <contact@divlo.fr>
---
 arch/s390/include/uapi/asm/pkey.h | 4 ++--
 fs/nfsd/xdr4.h                    | 6 +++---
 scripts/spelling.txt              | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/uapi/asm/pkey.h b/arch/s390/include/uapi/asm/pkey.h
index 7349e96d28a0..c04bc9e0614f 100644
--- a/arch/s390/include/uapi/asm/pkey.h
+++ b/arch/s390/include/uapi/asm/pkey.h
@@ -365,7 +365,7 @@ struct pkey_kblob2pkey2 {
  * is empty (apqn_entries is 0) the apqn_entries field is updated to the number
  * of apqn targets found and the ioctl returns with 0. If apqn_entries is > 0
  * but the number of apqn targets does not fit into the list, the apqn_targets
- * field is updatedd with the number of reqired entries but there are no apqn
+ * field is updatedd with the number of required entries but there are no apqn
  * values stored in the list and the ioctl returns with ENOSPC. If no matching
  * APQN is found, the ioctl returns with 0 but the apqn_entries value is 0.
  */
@@ -403,7 +403,7 @@ struct pkey_apqns4key {
  * is empty (apqn_entries is 0) the apqn_entries field is updated to the number
  * of apqn targets found and the ioctl returns with 0. If apqn_entries is > 0
  * but the number of apqn targets does not fit into the list, the apqn_targets
- * field is updatedd with the number of reqired entries but there are no apqn
+ * field is updatedd with the number of required entries but there are no apqn
  * values stored in the list and the ioctl returns with ENOSPC. If no matching
  * APQN is found, the ioctl returns with 0 but the apqn_entries value is 0.
  */
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a7c425254fee..6496d6a2528a 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -198,7 +198,7 @@ struct nfsd4_lockt {
 	struct nfsd4_lock_denied  	lt_denied;
 };
 
- 
+
 struct nfsd4_locku {
 	u32             lu_type;
 	u32             lu_seqid;
@@ -301,7 +301,7 @@ struct nfsd4_read {
 	u32			rd_length;          /* request */
 	int			rd_vlen;
 	struct nfsd_file	*rd_nf;
-	
+
 	struct svc_rqst		*rd_rqstp;          /* response */
 	struct svc_fh		*rd_fhp;             /* response */
 };
@@ -821,7 +821,7 @@ extern void nfsd4_bump_seqid(struct nfsd4_compound_state *, __be32 nfserr);
 enum nfsd4_op_flags {
 	ALLOWED_WITHOUT_FH = 1 << 0,    /* No current filehandle required */
 	ALLOWED_ON_ABSENT_FS = 1 << 1,  /* ops processed on absent fs */
-	ALLOWED_AS_FIRST_OP = 1 << 2,   /* ops reqired first in compound */
+	ALLOWED_AS_FIRST_OP = 1 << 2,   /* ops required first in compound */
 	/* For rfc 5661 section 2.6.3.1.1: */
 	OP_HANDLES_WRONGSEC = 1 << 3,
 	OP_IS_PUTFH_LIKE = 1 << 4,
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 7b6a01291598..6787c8d1db7f 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1227,6 +1227,7 @@ replys||replies
 reponse||response
 representaion||representation
 reqeust||request
+reqired||required
 reqister||register
 requestied||requested
 requiere||require
-- 
2.25.1

