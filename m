Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C60366FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244203AbhDUQD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244113AbhDUQDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C6BF6144B;
        Wed, 21 Apr 2021 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619020997;
        bh=7CsJfe+j4d9FkYen0AQp2LykjWqg4OXhoV31J3rCAio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=caMC0h6yhh838CEWizFVUUctBzTQsLXS6wBySTCQWFXDSQlp+6GQQqvOPL2Ie6WZZ
         6/G0wDCQ3gF8VCY1bBuzyPTJxDUkvttwdO4rksSf72Z6zbfmp8xRz87h4QWQQkX9Ye
         SwDaXt6er53XN0EqdXpl+FbD7bVkgr2nvTX3au5ZdQ5MV6QNcbRBNofjOy1xY5FtMY
         wJ7hLa3ZVI/pLnTrTxkI/15ZaoHX1wH8OLBF1UhhfCVA48BXhewjGiaBlA+fDFAZ1x
         n3D4fEDADCbiv1Kr08Jj87ElFofM2E+v4BHk6cjPKvJXgipKunWD7SfrGryWCpOU/g
         7d1l0tZ13jN4w==
Date:   Wed, 21 Apr 2021 09:03:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        oss-drivers@netronome.com,
        Simon Horman <simon.horman@netronome.com>
Subject: Re: [PATCH 050/190] Revert "nfp: abm: fix a memory leak bug"
Message-ID: <20210421090315.11cc4eaf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210421130105.1226686-51-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
        <20210421130105.1226686-51-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 14:58:45 +0200 Greg Kroah-Hartman wrote:
> This reverts commit bd4af432cc71b5fbfe4833510359a6ad3ada250d.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ethernet/netronome/nfp/abm/main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/abm/main.c b/drivers/net/ethernet/netronome/nfp/abm/main.c
> index bdbf0726145e..341773b43a4d 100644
> --- a/drivers/net/ethernet/netronome/nfp/abm/main.c
> +++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
> @@ -283,7 +283,6 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf, struct nfp_abm *abm, struct nfp_net *nn,
>  	if (!nfp_nsp_has_hwinfo_lookup(nsp)) {
>  		nfp_warn(pf->cpp, "NSP doesn't support PF MAC generation\n");
>  		eth_hw_addr_random(nn->dp.netdev);
> -		nfp_nsp_close(nsp);
>  		return;
>  	}
>  

This one still looks correct to me :S
