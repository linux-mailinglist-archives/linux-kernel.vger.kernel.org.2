Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E193B434B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJTM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhJTM4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:56:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C6C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:54:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j129-20020a1c2387000000b00322f53b9bbfso1445235wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RaJru0LeJpp+5gdjew/h/QiM8NOqvMypszVPqMO2bps=;
        b=oZ6IDXUlY7cvhwSvrcAq7EeqRaqyNFERA30XsAN/R0atKAg0QxWlzqduJ8bvkKfzaL
         iFFJGIU/gYoi2smwZmc4C4EZ3jD0zqqcq6U+TQwNzyWSqBuJuMvxi8KFz1Lg1GRB6Tmg
         2T5ACUdq32UKsj+mrEjUOFsFabxxO0uB+Py89RayddZv+QOZohytvuCcV3OpQ/zpWGAP
         mGREZkfqely9KNwtznFnGyz4VITMXlIcrN0HP63rXc1s3Gb1MAFQ7b+CJkkYW5n8g+Ii
         fVUu1u1IHOb3Xu80Ym1Bhp9IOoEQNIPULF4sWksWawHUaOgfD8O+4N6grDZVaf42RGkU
         aVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RaJru0LeJpp+5gdjew/h/QiM8NOqvMypszVPqMO2bps=;
        b=6XkKCkwbU0Am3yK9AppvWcronGAe8W52ZkleT8/0f+dxF39kJ/JsSGBApZMUrMO9lO
         vfRDOK6tow/ICfwfMLE2bmgzipS9xorEnhMy7B70L+gf9ppwFForcI8kwGyu4MVScygX
         BqyOUJkP65rUdEQSKFFnd+JkQX9sbLWEYKeK+y57RO61CpVaypmUISCOLWWYfoPkv+IX
         tFHEgNuIKbm/8e0r6rVjNEKSL7A6d4RxVarPxwM9x9/BYxXGVwBwNnOQY0Rq1x8okuUY
         x/rT+zXrTjLkZSlCV+sInimcaauP0qybcZFH+RqXiwXhww/R5nkQZmc38Jmlf0icXvUC
         e3cQ==
X-Gm-Message-State: AOAM531gLD5YtLmn6WwNNovkcZqYffdzJ4lMDuATrWQzV3xNmTp+fstv
        Omzgp1/MFc3NqloLRfDwwGk=
X-Google-Smtp-Source: ABdhPJweDfWhprqQZ9TXfiXrLPD5b+5FrmVKVr2vfhA4Lm4MbMQzCfLjd2D/qdn6gs98pMAtb6L5iw==
X-Received: by 2002:a5d:6d51:: with SMTP id k17mr51031912wri.233.1634734473573;
        Wed, 20 Oct 2021 05:54:33 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62? ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id j16sm2253167wms.16.2021.10.20.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:54:33 -0700 (PDT)
Message-ID: <6089e564f89ceaa7303bf3a4b4c864bf1389ac25.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: vt6655: Rename
 `by_preamble_type` parameter
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Oct 2021 13:54:27 +0100
In-Reply-To: <alpine.DEB.2.22.394.2110201051300.2930@hadrien>
References: <20211020084033.414994-1-karolinadrobnik@gmail.com>
         <alpine.DEB.2.22.394.2110201051300.2930@hadrien>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-20 at 10:54 +0200, Julia Lawall wrote:
> On Wed, 20 Oct 2021, Karolina Drobnik wrote:
> 
> > Drop `by` prefix in the first parameter of `bb_get_frame_time`
> > function.
> > As the original argument, `byPreambleType`, was renamed to
> > `preamble_type`,
> > the parameter referring to it is now renamed to match the new
> > naming
> > convention.
> > Update `bb_get_frame_time` comment to reflect that change.
> > 
> > This patch is a follow-up work to this commit:
> >     Commit 548b6d7ebfa4 ("staging: vt6655: Rename byPreambleType
> > field")
> 
> This is not going to be practical.  If the previous patch is
> accepted, then this it not needed.

This change was there before but Greg told me to do only one logical
change per patch (which was a struct member rename), so I reverted it.
I believe this is needed because this parameter still uses Hungarian
notation, which is against the LK coding style. Also, it makes sense to
update the name given my previous change.

> there needs to be a vn+1 putting the patches together into a series.

I didn't know that it should be send this way, especially given the
fact that Outreachy applicants should first get 3-5 patches out before
creating a patchset. Or has something changed in this regard?

> > @@ -1691,7 +1691,7 @@ static const unsigned short
> > awc_frame_time[MAX_RATE] = {
> >   *
> >   * Parameters:
> >   *  In:
> > - *      by_preamble_type  - Preamble Type
> > + *      preamble_type     - Preamble Type
> >   *      by_pkt_type        - PK_TYPE_11A, PK_TYPE_11B,
> > PK_TYPE_11GB, PK_TYPE_11GA
> 
> In the realm of small cleanups to this driver, the extra space in
> front of the - above is a bit annoying.

I can add this in but will that still count as a one logical change? 
I described the comment update, will that suffice?

> > @@ -1717,7 +1717,7 @@ unsigned int bb_get_frame_time(unsigned char
> > by_preamble_type,
> >         rate = (unsigned int)awc_frame_time[rate_idx];
> > 
> >         if (rate_idx <= 3) {                /* CCK mode */
> > -               if (by_preamble_type == 1) /* Short */
> > +               if (preamble_type == 1) /* Short */
> 
> I hope you will get around to replacing the 1 by the appropriate
> constant and removing the "Short" comment.

I plan to do so after correcting the name variable.


On Wed, 2021-10-20 at 10:55 +0200, Greg KH wrote:
> On Wed, Oct 20, 2021 at 09:40:33AM +0100, Karolina Drobnik wrote:
> > Drop `by` prefix in the first parameter of `bb_get_frame_time`
> > function.
> > As the original argument, `byPreambleType`, was renamed to
> > `preamble_type`,
> > the parameter referring to it is now renamed to match the new
> > naming
> > convention.
> > Update `bb_get_frame_time` comment to reflect that change.
> > 
> > This patch is a follow-up work to this commit:
> >     Commit 548b6d7ebfa4 ("staging: vt6655: Rename byPreambleType
> > field")
> 
> There is no need for these two lines in the changelog text.  They can
> go
> below --- if you want to have them.

Thank you for clarifying this. I've been following the Submitting
Patches docs[1] and thought this is needed.


Thanks,
Karolina
-------------------------------------------------------------------
[1]:
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L106


