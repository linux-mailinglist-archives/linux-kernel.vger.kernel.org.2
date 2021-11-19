Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A58456686
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 00:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhKRXnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 18:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhKRXnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:43:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57258C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:40:01 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c4so7660697pfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oXVLgn7Fm48aBJFzNVOVlXR9OEHonO1R9lF3Un+NrdE=;
        b=adean6vy4yeH/XRaSWPDn2eF5HEXAskqbiJ4tLKSBOb1kEyQu9T00sNYEWyuZYH2gk
         BuF3Urre/F4ibEf37iZjBvW4IZEl0BMap4ubCE63aePPvfePIQAiI+s9xh6cRSH/QQrU
         BDvNCfnznWgz+Gl09t2mFIMIKWsWkcTIDmIKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oXVLgn7Fm48aBJFzNVOVlXR9OEHonO1R9lF3Un+NrdE=;
        b=X/ZJ6D3gaxm2HdxWBjRd8fm95m+scoxw+x8J7te2Y6qyeTe3ER2DDVxkztUPhW1mfS
         5qw2tufUzQ9lXNAAPuRhFuUZGelZWjPLisUxCmBXN3pEbfHjRMe0Ikwr3sd97dWfddSs
         BhE8Xnbu0KjjswWo65F2txPUN1c56ZI57Klz5b8XEYrovP5rBKF6W6gpWDlMkLx0+DNf
         UJdo6hNY3SPeLTXkC7gL4Bs+xn6cniQoGPVmhmLPH/oQUCnoZoWITO5uUgOlsMg/8VGk
         YFriwVCKLLbkfkL7p2p4XHQAtvBANHfGr4XYW5McK3BBKbdosXXjMCk5kWlOIqdhsypb
         bJMA==
X-Gm-Message-State: AOAM530Vlft4ZdliwZ4NBKmvawVLsR0D8M1w2ckr1lNutYiFnlNRo8W/
        CtlL+ScSn+WHriHY06YgnBjd9A==
X-Google-Smtp-Source: ABdhPJzhq8/zLZS54halfY22K3R0DFf+8t9M9mL7GrX7pO1LuSwDghC9VZ8n/iGRKAxpPjjpRv4NSg==
X-Received: by 2002:a63:e216:: with SMTP id q22mr14105524pgh.3.1637278800301;
        Thu, 18 Nov 2021 15:40:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3sm680152pff.211.2021.11.18.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:40:00 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:39:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sata_fsl: Use struct_group() for memcpy() region
Message-ID: <202111181533.2D90E391@keescook>
References: <20211118183807.1283332-1-keescook@chromium.org>
 <0dd24142-a5e6-b146-9315-d2680ef4ed35@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd24142-a5e6-b146-9315-d2680ef4ed35@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 08:17:14AM +0900, Damien Le Moal wrote:
> On 2021/11/19 3:38, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring fields.
> > 
> > Use struct_group() in struct command_desc around members acmd and fill,
> > so they can be referenced together. This will allow memset(), memcpy(),
> > and sizeof() to more easily reason about sizes, improve readability,
> > and avoid future warnings about writing beyond the end of acmd:
> > 
> > In function 'fortify_memset_chk',
> >     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
> > ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
> >   199 |    __write_overflow_field();
> >       |    ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> This lacks some context with regard to FORTIFY_SOURCE and struct_group(). Is
> that already in 5.16 ? It sounds like it is not. Do you want a ack ? Or do you
> want me to queue this up for 5.17 ?

Ah yes, some details are here in the earlier "big" series cover letter
here:
https://lore.kernel.org/linux-hardening/20210818060533.3569517-1-keescook@chromium.org/

One of the requests from earlier review was to split it up for separate
trees for the maintainers that wanted to take stuff via their trees
directly.

The new helpers are landed as of v5.16-rc1, so it can go either way, but
given that the merge window is closed, I would expect this to be for
v5.17.

I am happy to to carry it in my fortify topic branch that I'm expecting
to send for 5.17, but totally up to you. Some folks like to take these
changes via their trees, others would rather not be bothered with it. :)

Thanks!

-Kees

> 
> Cheers.
> 
> > ---
> >  drivers/ata/sata_fsl.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> > index e5838b23c9e0..fec3c9032606 100644
> > --- a/drivers/ata/sata_fsl.c
> > +++ b/drivers/ata/sata_fsl.c
> > @@ -246,8 +246,10 @@ enum {
> >  struct command_desc {
> >  	u8 cfis[8 * 4];
> >  	u8 sfis[8 * 4];
> > -	u8 acmd[4 * 4];
> > -	u8 fill[4 * 4];
> > +	struct_group(cdb,
> > +		u8 acmd[4 * 4];
> > +		u8 fill[4 * 4];
> > +	);
> >  	u32 prdt[SATA_FSL_MAX_PRD_DIRECT * 4];
> >  	u32 prdt_indirect[(SATA_FSL_MAX_PRD - SATA_FSL_MAX_PRD_DIRECT) * 4];
> >  };
> > @@ -531,8 +533,8 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
> >  	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
> >  	if (ata_is_atapi(qc->tf.protocol)) {
> >  		desc_info |= ATAPI_CMD;
> > -		memset((void *)&cd->acmd, 0, 32);
> > -		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
> > +		memset(&cd->cdb, 0, sizeof(cd->cdb));
> > +		memcpy(&cd->cdb, qc->cdb, qc->dev->cdb_len);
> >  	}
> >  
> >  	if (qc->flags & ATA_QCFLAG_DMAMAP)
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

-- 
Kees Cook
