Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFD2366BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbhDUNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240595AbhDUND7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB67461456;
        Wed, 21 Apr 2021 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010205;
        bh=ld0PwyBt9p2mbBe5BFqAQI7ti3sglfeOVA0t+YuVDCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sx00gTtaI7ya4+mlSzStb3iL8RwGY5Ywe4+ST0+zhtp7SC1R5eW6VrySSpDwyzV29
         brHqKFe9jvB91xr7CjtoPYKG8cVig3/K+iNMKuVX3bVPbw9HriEQxp0LupENw99HBC
         JH8ihbFv9SM8gWNSAB0XOifssLWShMqdkaWVTV/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 050/190] Revert "nfp: abm: fix a memory leak bug"
Date:   Wed, 21 Apr 2021 14:58:45 +0200
Message-Id: <20210421130105.1226686-51-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit bd4af432cc71b5fbfe4833510359a6ad3ada250d.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/abm/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/abm/main.c b/drivers/net/ethernet/netronome/nfp/abm/main.c
index bdbf0726145e..341773b43a4d 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/main.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
@@ -283,7 +283,6 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf, struct nfp_abm *abm, struct nfp_net *nn,
 	if (!nfp_nsp_has_hwinfo_lookup(nsp)) {
 		nfp_warn(pf->cpp, "NSP doesn't support PF MAC generation\n");
 		eth_hw_addr_random(nn->dp.netdev);
-		nfp_nsp_close(nsp);
 		return;
 	}
 
-- 
2.31.1

