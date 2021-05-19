Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9D3883D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 02:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbhESAlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 20:41:01 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:42760 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbhESAlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 20:41:00 -0400
Received: by mail-oi1-f174.google.com with SMTP id c196so3377102oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNQKrAS9Fmj/HNgXgdWLXxrMrjZ6Nj8qfJHCsdUtjyo=;
        b=Uhgj4Xe//Q6iwxEPzbbUlC64S6uqetQczzxMtJ5OY6XmKPsfDu44m7shk0rvkgrgfF
         b8p6sgiXgKXnxEmhzd1KYdlZwpPkajKYwCE9RpfF2x/2bb2ytqbUzIuEB4GIF83W1p1L
         rw1eTl2wF4dwsrNCZe6Qbht0dfmr/J3iruZ3sZ5pckZpCUb7oV6HEBMbC7DIZYiwFtSH
         lZO1tTiTq+znGWjcLRHnuUOh0/UFxtLQNaJjveP4rp7vkhVljYC1u3eAN2Csc1XZVRb6
         c98Pl0ZJsoGmRyt7MSfUmUnYsWYqhhuqlh63qQ/kx+vJRGnsfobn/pB4GAVuab6Y3k5P
         mL1g==
X-Gm-Message-State: AOAM532Ci1xL0kWqEsH2F6Bhza9SBdt93elHIVSQRFlMsgg4lxd69kiq
        I9vDGUlHIjxLc291tKdZkw==
X-Google-Smtp-Source: ABdhPJy9e6txHCLiCHJb2GTFX8BsOI+NA/lpnDNdNiDcAKQy68/atvDiC3eOimwQ6+QT2nArvxR1HA==
X-Received: by 2002:aca:5d08:: with SMTP id r8mr5897921oib.51.1621384780136;
        Tue, 18 May 2021 17:39:40 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 128sm4126870ooh.45.2021.05.18.17.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 17:39:39 -0700 (PDT)
Received: (nullmailer pid 1661184 invoked by uid 1000);
        Wed, 19 May 2021 00:39:38 -0000
Date:   Tue, 18 May 2021 19:39:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        hanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Add devm helper for work-queue initialization
Message-ID: <20210519003938.GA1649581@robh.at.kernel.org>
References: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 03:31:37PM +0300, Matti Vaittinen wrote:
> This series adds new devm_work_autocancel() helper.
> 
> Many drivers which use work-queues must ensure the work is not queued when
> driver is detached. Often this is done by ensuring new work is not added and
> then calling cancel_work_sync() at remove(). In many cases this also requires
> cleanup at probe error path - which is easy to forget (or get wrong).
> 
> Also the "by ensuring new work is not added" has a gotcha.
> 
> It is not strange to see devm managed IRQs scheduling work.
> Mixing this with manual wq clean-up is hard to do correctly because the
> devm is likely to free the IRQ only after the remove() is ran. So manual
> wq cancellation and devm-based IRQ management do not mix well - there is
> a short(?) time-window after the wq clean-up when IRQs are still not
> freed and may schedule new work.
> 
> When both WQs and IRQs are managed by devm things are likely to just
> work. WQs should be initialized before IRQs (when IRQs need to schedule
> work) and devm unwinds things in "FILO" order.

Wouldn't it be better to convert drivers to use threaded IRQ handlers?

> 
> This series implements wq cancellation on top of devm and replaces
> the obvious cases where only thing remove call-back in a driver does is
> cancelling the work. There might be other cases where we could switch
> more than just work cancellation to use managed version and thus get rid
> of remove or mixed (manual and devm) resource management.
> 
> Changelog v2:
>   - rebased on v5.13-rc2
>   - split the extcon-max8997 change into two. First a simple,
>     back-portable fix for omitting IRQ freeing at error path, second
>     being the devm-simpification which does not need backporting.
> 
> ---
> 
> Matti Vaittinen (5):
>   devm-helpers: Add resource managed version of work init
>   extcon: extcon-max14577: Fix potential work-queue cancellation race
>   extcon: extcon-max77693.c: Fix potential work-queue cancellation race
>   extcon: extcon-max8997: Fix IRQ freeing at error path
>   extcon: extcon-max8997: Simplify driver using devm
> 
>  drivers/extcon/extcon-max14577.c | 16 ++++--------
>  drivers/extcon/extcon-max77693.c | 17 ++++--------
>  drivers/extcon/extcon-max8997.c  | 45 +++++++++++---------------------
>  include/linux/devm-helpers.h     | 25 ++++++++++++++++++
>  4 files changed, 50 insertions(+), 53 deletions(-)
> 
> 
> base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
> -- 
> 2.25.4
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 


