Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72F45945D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhKVR5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhKVR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:57:23 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F018BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:54:16 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id 8so17360187qtx.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UjrtRg1LqalLPKr1AWX1gQDA0Ps1SnF3wSZtFRr60mo=;
        b=A1WJSIHWnaZ2uCkoBsPB+n1JT4/ulvix8Z5QPgRYC6zs60cN8XUhQ58uyOe2raG2Wg
         y6ygr970ZPgddS0ET6v84W9MzsUIWLLWFMfHIzIfOPcsUP+zPJK+uzTsLYBmQw5xiUvh
         w8rAAL/o327W4tN/69GE6f+PIt8hofNMcetz00ZW+xybg+FeZGu1ZVuHqZxgzy+HhvPu
         JNO1M8lbs9oaWTbldhx6GLih1wTsNymh2XSTpkWWMPxgg6V3btB2eJghbpTlPUnk9oK/
         Yv82viIqMH5P8z8/1cM/Grn6Op91WgSbI7hXdHAbpALz7avZq436PnLouvlM0zL96jpU
         2Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UjrtRg1LqalLPKr1AWX1gQDA0Ps1SnF3wSZtFRr60mo=;
        b=eQwxWPp4IsjYjleOF2w7m6EOGj6jY+ZNbIOVK/beTHWit5+GL3069oVEBKcedOccV/
         HrdlNFhALndgxhWP/wtGA/QnYPKLm4Ix0/iWF1wQhaPSKU9xmkO033uV7meksQLYm3+B
         fcRB2k+22WzxBkzFKox0IP3uW5MKpEJO8HSg1SlcpogFHfvmx3xLrpops9q2qSI4zaU3
         RaMpydI+lxVUdnM/IdG23OVjdoDBWAD9NJy+vxXeFheXhj7FwUklJOxeGSbpGvGKLKNo
         mo54AYROS15Nc7U0M5zL/DnZl2JNQAAUbAYHsWk094QPX957cfShCXo6RDgjLfa90TpT
         2mAw==
X-Gm-Message-State: AOAM533E9TGZ53g7f5crtqaeuJVYZeBxWjRRW8D5B3EH9lzUWCHnm3d4
        aQCuy/vd8X7hURWkmmmgj4SRiJFYCsA=
X-Google-Smtp-Source: ABdhPJxavGl5eMwE0Lyn3KjCniyNv7YmcrEae42m9xCf3dmCgFdMVWGC3+d3tIAx7ygqE7+NlCjLZA==
X-Received: by 2002:ac8:7f43:: with SMTP id g3mr33728519qtk.127.1637603656051;
        Mon, 22 Nov 2021 09:54:16 -0800 (PST)
Received: from localhost ([66.216.211.25])
        by smtp.gmail.com with ESMTPSA id v4sm5042049qkp.118.2021.11.22.09.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 09:54:15 -0800 (PST)
Date:   Mon, 22 Nov 2021 09:54:14 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] bitops: Add single_bit_set()
Message-ID: <20211122175414.GA1588@lapt>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 02:57:27PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 22, 2021 at 12:42:21PM +0000, Vaittinen, Matti wrote:
> > On 11/22/21 13:28, Andy Shevchenko wrote:
> > > On Mon, Nov 22, 2021 at 01:03:25PM +0200, Matti Vaittinen wrote:
> > >> There are cases when it is useful to check a bit-mask has only one bit
> > >> set. Add a generic helper for it instead of baking own one for each
> > >> user.
> 
> > > So, you decided to reinvent hamming weight...
> > > Please, drop this patch and use corresponding hweight() call.
> 
> > Thanks Andy.
> > 
> > There are few differences to hamming weight here. We scan only given 
> > amount of bits - and we will end scanning immediately when we hit second 
> > set bit. Oh, and obviously we only return information whether there is 
> > exactly one bit set. So no, this is not hamming weight().
> 
> What do you mean by this?
> 
> hweight() will return you the number of the non-zero elements in the set.
> In application to boolean based arrays it means the number of bits that
> are set. Obviously, the condition `hweight() == 1` is what you are looking
> for.

Hi Andy,

I think, Matti means earlier return when part of bitmap counts set
bits to a greater nubmer, and we can skip the rest. Right, Matti?

I agree that for Matti's usecase it's useless because 32-bit int is small,
and hweight() would count set bits with a single machine instruction. (And
it should be hweight32(), not bitmap_weight() in this case.)

But in general, it might be useful for long bitmaps.

The more complete way of doing this would be adding a new set of
functions: bitmap_weight_{eq,neq,gt,le}

I'm looking at how bitmap_weight is used in the kernel and see
quite a lot of places where this optimization may take place. For
example otx2_remove_flow() in drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:

        if (bitmap_weight(&flow_cfg->dmacflt_bmap,
                          flow_cfg->dmacflt_max_flows) == 1)
                otx2_update_rem_pfmac(pfvf, DMAC_ADDR_DEL);

may be replaced with:

        if (bitmap_weight_eq(&flow_cfg->dmacflt_bmap, flow_cfg->dmacflt_max_flows, 1)
                otx2_update_rem_pfmac(pfvf, DMAC_ADDR_DEL);

Most of that places are in drivers however, and the length of bitmaps
there is typically small, so that there's no chance to get any
measurable performance improvement.

There is always a chance that we have opencoded bitmap_weight_eq()
et all. If we add these API, it might help people wright better code.

What do you think?

Thanks,
Yury
