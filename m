Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D82C36C80B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbhD0Oyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238362AbhD0Oyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:54:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA0C7613DC;
        Tue, 27 Apr 2021 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619535244;
        bh=bZXe+RVa/zhAqQzqMP53+krkWI37IFZjwq9cKyWcFqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ExFZKDzf6e76EpzK6kxiZCUyuw+vyz2ztxSt3Bh/imtoqOQVLAA9sS87AuMEYJcPk
         SIsGSjxTqXIVbF0mlpNs2y90WOxAAW5Cee24L1nRDO5vyopdvqlxkmiJ8mzvIRaHuf
         HTFtXl6QZU7BKp3Qme1IaWQ3gbYpOyT8qDRwBWD8=
Date:   Tue, 27 Apr 2021 16:54:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        oss-drivers@netronome.com,
        Simon Horman <simon.horman@netronome.com>
Subject: Re: [PATCH 050/190] Revert "nfp: abm: fix a memory leak bug"
Message-ID: <YIgliviAfp9Chzsa@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-51-gregkh@linuxfoundation.org>
 <20210421090315.11cc4eaf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421090315.11cc4eaf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:03:15AM -0700, Jakub Kicinski wrote:
> On Wed, 21 Apr 2021 14:58:45 +0200 Greg Kroah-Hartman wrote:
> > This reverts commit bd4af432cc71b5fbfe4833510359a6ad3ada250d.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/net/ethernet/netronome/nfp/abm/main.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/netronome/nfp/abm/main.c b/drivers/net/ethernet/netronome/nfp/abm/main.c
> > index bdbf0726145e..341773b43a4d 100644
> > --- a/drivers/net/ethernet/netronome/nfp/abm/main.c
> > +++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
> > @@ -283,7 +283,6 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf, struct nfp_abm *abm, struct nfp_net *nn,
> >  	if (!nfp_nsp_has_hwinfo_lookup(nsp)) {
> >  		nfp_warn(pf->cpp, "NSP doesn't support PF MAC generation\n");
> >  		eth_hw_addr_random(nn->dp.netdev);
> > -		nfp_nsp_close(nsp);
> >  		return;
> >  	}
> >  
> 
> This one still looks correct to me :S

Thanks for the review, now dropped.

greg k-h
