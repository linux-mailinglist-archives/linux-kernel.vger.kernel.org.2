Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9171940BD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhIOBYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhIOBYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:24:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A5C561164;
        Wed, 15 Sep 2021 01:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631668965;
        bh=34pMuOrExtoHtRZ9Gf9/zwAtQwy7VI+WAiaN+pkvJA4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=iog5jdpmbLkNrJwTUHixTrBW8dJcX7Nn22lx0XXX9dTsxliTHJZPCqfbCu+mcTt/C
         96OHH/AYMexmxb6Exzr8I0Ep5SzNufmbFz3AMA+yVe1H6wTSqDDl52/q2mV2KCymsL
         a3oVie8VcPZmw3Lsmtf02bzSJgIUhuhf1oetKtaKh8QKbzcTn58UUbhJLMpZazA3cS
         iDbXkndq5gAgXYLe4R/fvTiiEW2k14BcNsmOE4/40XNE0dTexSnbGAv8RxFCYrxt5p
         h1iNmHzbfD4O0TQu9l9utoq4hPIOEIRaFjiPf95dZgCeTNNdN+y/zl2Uor8w7kmsTY
         gInqIPxhlCiHQ==
Date:   Tue, 14 Sep 2021 18:22:43 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 04/12] swiotlb-xen: ensure to issue well-formed
 XENMEM_exchange requests
In-Reply-To: <9819a6e9-93d5-e62a-7b4a-ffc2ecd996dc@suse.com>
Message-ID: <alpine.DEB.2.21.2109141817150.21985@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <397bf325-f81e-e104-6142-e8c9c4955475@suse.com> <alpine.DEB.2.21.2109101613130.10523@sstabellini-ThinkPad-T480s> <d868bbcc-e800-ed30-3524-a30a5feb7e5a@suse.com> <alpine.DEB.2.21.2109131328130.10523@sstabellini-ThinkPad-T480s>
 <9819a6e9-93d5-e62a-7b4a-ffc2ecd996dc@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021, Jan Beulich wrote:
> On 13.09.2021 22:31, Stefano Stabellini wrote:
> > On Mon, 13 Sep 2021, Jan Beulich wrote:
> >> On 11.09.2021 01:14, Stefano Stabellini wrote:
> >>> On Tue, 7 Sep 2021, Jan Beulich wrote:
> >>>> While the hypervisor hasn't been enforcing this, we would still better
> >>>> avoid issuing requests with GFNs not aligned to the requested order.
> >>>>
> >>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >>>> ---
> >>>> I wonder how useful it is to include the alignment in the panic()
> >>>> message.
> >>>
> >>> Not very useful given that it is static. I don't mind either way but you
> >>> can go ahead and remove it if you prefer (and it would make the line
> >>> shorter.)
> >>>
> >>>
> >>>> I further wonder how useful it is to wrap "bytes" in
> >>>> PAGE_ALIGN(), when it is a multiple of a segment's size anyway (or at
> >>>> least was supposed to be, prior to "swiotlb-xen: maintain slab count
> >>>> properly").
> >>>
> >>> This one I would keep, to make sure to print out the same amount passed
> >>> to memblock_alloc.
> >>
> >> Oh - if I was to drop it from the printk(), I would have been meaning to
> >> also drop it there. If it's useless, then it's useless everywhere.
> > 
> > That's fine too
> 
> Thanks, I'll see about dropping that then.
> 
> Another Arm-related question has occurred to me: Do you actually
> mind the higher-than-necessary alignment there? If so, a per-arch
> definition of the needed alignment would need introducing. Maybe
> that could default to PAGE_SIZE, allowing Arm and alike to get away
> without explicitly specifying a value ...

Certainly a patch like that could be good. Given that it is only one
allocation I was assuming that the higher-than-necessary alignment
wouldn't be a problem worth addressing (and I cannot completely rule out
that one day we might have to use XENMEM_exchange on ARM too).
