Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFC37AC05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhEKQf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhEKQf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:35:58 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6EBC061574;
        Tue, 11 May 2021 09:34:51 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id t17-20020a4a3e110000b02901fab2f46a48so4326335oot.6;
        Tue, 11 May 2021 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtRsLR7tw7/ws6UHbTbAGxhYbBVVPFNMe8r9CvkiMc0=;
        b=nuaEaWAoXueXoY/9qSf6sZqWHJXaeAYBy6geLvW4dsHjpoYaG8QXoKFX0e4D0XCUqI
         6xn+RW13swL6jSnq3hOuAdmBELDtTrTQGSStd4bRc8PGu2WSX4UKbARDR/xfBkZwpS9D
         hSLDooni+LjoGLjSZX3MCCpXpfH/pyX5FE/d/AaVzuLpWrLvOrzTUfnlCpSAlmRroa+Y
         oPAY/rrvGNMLdYf4gmgKizpK3NA1n5ZkvJP5fBeugPo3SQAUEySM6HhQqfiEH6mVvL/r
         nzFllOLwJAf1s7dQXAiPpCiTuAZwznyrRG8EnRz25PegLBOYPCfn0cUzHBacwD2jKink
         OCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtRsLR7tw7/ws6UHbTbAGxhYbBVVPFNMe8r9CvkiMc0=;
        b=l8QfJzWwdjveZvaHI+Knl1lIVMjI7Q72F5C6bHIxR5bTxdBvJHTd7UCujZank0wRf9
         MiRJG/VFf4UTXEkLKT+3pRxpUZM7MZJVrjzbhLWDE7uiuLQOTGnrnD+Lt60ELh1bUw8w
         FM5Ni9Vx30l6RFanAeUgm+FnAeQzONk4pxxs6Mr4TNEcI6zrhuPqbsfSo0UyZqe2CmfI
         X0V4+eY2XCe5iTvRCfrWjduvvDm3PCvlJMqzuZx1YMr1YIqqGTW6tGeIFjxWImcCuCzT
         3z4e7i8orOr8xhbUqJpZG3LDW81AjOO3FlP1Wzz6+ki55WDWOBOEl5OUHGN9pMp2J0kR
         p9ng==
X-Gm-Message-State: AOAM53245DHxrCcpM4jUCm9sAWTp5/NHYBTAdlhMgbjAFeIIXbBAcefw
        ZhpbstmWLLPM/2LbPLP1bAr5Jrwj0VVCfsnQ6wQ=
X-Google-Smtp-Source: ABdhPJy/TooDudc1x0tUUgGg7n3GuOdw0E07h/+JgNNDyTCdr5Gf+xa4k8kzfufi5jIdVEyZjDowBRvtg3AyzwAsV+8=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr24141937oor.61.1620750891309;
 Tue, 11 May 2021 09:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210511155512.582798-1-maxime@cerno.tech>
In-Reply-To: <20210511155512.582798-1-maxime@cerno.tech>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 11 May 2021 12:34:40 -0400
Message-ID: <CADnq5_NG8dwfk9uu83_CM7430Pj1CTK1=UTuQR7U7nnmcdPu2g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpu: Mention the requirements for new properties
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:55 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> New KMS properties come with a bunch of requirements to avoid each
> driver from running their own, inconsistent, set of properties,
> eventually leading to issues like property conflicts, inconsistencies
> between drivers and semantics, etc.
>
> Let's document what we expect.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/gpu/drm-kms.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> index 87e5023e3f55..30f4c376f419 100644
> --- a/Documentation/gpu/drm-kms.rst
> +++ b/Documentation/gpu/drm-kms.rst
> @@ -463,6 +463,24 @@ KMS Properties
>  This section of the documentation is primarily aimed at user-space developers.
>  For the driver APIs, see the other sections.
>
> +Requirements
> +------------
> +
> +KMS drivers might need to add extra properties to support new features.
> +Each new property introduced in a driver need to meet a few
> +requirements, in addition to the one mentioned above.:
> +
> +- It must be standardized, with some documentation to describe the

"to describe how the"

With that fixed, it looks good to me.

Alex

> +  property can be used.
> +
> +- It must provide a generic helper in the core code to register that
> +  property on the object it attaches to.
> +
> +- Its content must be decoded by the core and provided in the object
> +  associated state structure.
> +
> +- An IGT test must be submitted.
> +
>  Property Types and Blob Property Support
>  ----------------------------------------
>
> --
> 2.31.1
>
