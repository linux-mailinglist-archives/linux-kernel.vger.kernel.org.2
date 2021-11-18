Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F356456651
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 00:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhKRXRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 18:17:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39152 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhKRXRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:17:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7FA52170E;
        Thu, 18 Nov 2021 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637277282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+T3+AC//U32S54eK96JFxe6YTH+QG23o+QTpg+MWBg=;
        b=XiKNcVmND/Ld3xDzCaAuxhxLIKgm9SjvNpw/hrNAkpgSHKsmOhVHqsjDlKaWcRS1S0+Q26
        wjADst+RlW59NFmkq8c3JLEY8e+tSOG6l1eh4gQj6DXbx8EVsIJv1NYk0SamuyMoCIFd56
        bl7rt3uCnF67MGim+hyXRdHdpDlmCes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637277282;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+T3+AC//U32S54eK96JFxe6YTH+QG23o+QTpg+MWBg=;
        b=Kqvgpf2EVq7491a6MDAqZpjOdxlHpX9e8EOIvWYInXIc4ymEowqynCeYp16u507ZR1URQh
        LBb5a/Y4TuYWeDCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE63713AA8;
        Thu, 18 Nov 2021 23:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v5PrJmDelmG5QAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 18 Nov 2021 23:14:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Thierry Reding" <thierry.reding@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
In-reply-to: <YZUBIbALcSHn4Rub@casper.infradead.org>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>,
 <YZUBIbALcSHn4Rub@casper.infradead.org>
Date:   Fri, 19 Nov 2021 10:14:38 +1100
Message-id: <163727727803.13692.15470049610672496362@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021, Matthew Wilcox wrote:
> On Wed, Nov 17, 2021 at 03:39:30PM +1100, NeilBrown wrote:
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -676,12 +676,12 @@ static struct page *as_get_pde_page(struct tegra_sm=
mu_as *as,
> >  	 * allocate page in a sleeping context if GFP flags permit. Hence
> >  	 * spinlock needs to be unlocked and re-locked after allocation.
> >  	 */
> > -	if (!(gfp & __GFP_ATOMIC))
> > +	if (gfp & __GFP_DIRECT_RECLAIM)
> >  		spin_unlock_irqrestore(&as->lock, *flags);
> > =20
> >  	page =3D alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
> > =20
> > -	if (!(gfp & __GFP_ATOMIC))
> > +	if (gfp & __GFP_DIRECT_RECLAIM)
> >  		spin_lock_irqsave(&as->lock, *flags);
> > =20
> >  	/*
>=20
> Surely this should be gfpflags_allow_blocking() instead of poking about
> in the innards of gfp flags?

Possibly.  Didn't know about gfpflags_allow_blocking().  From a quick
grep in the kernel, a whole lot of other people don't know about it
either, though clearly some do.

Maybe we should reaname "__GFP_DIRECT_RECLAIM" to
"__GFP_ALLOW_BLOCKING", because that is what most users seems to care
about.

If not, then we probably want a gfpflags_without_block() function that
removes that flag, as lots of code wants to do that - and using the flag
for one, and an inline for the other is not consistent.

My leaning would be to __GFP_ALLOW_BLOCKING

NeilBrown


>=20
> This patch seems like a good simplification to me.
>=20
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks,
NeilBrown
