Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056803F86BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbhHZLxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhHZLxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:53:53 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0635C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 04:53:05 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f2so4640575ljn.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 04:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBxBPr3Kmhx+gtlKVfwmBEiG03qJgZIhVmQgwh7w3cs=;
        b=FB0fHEaVXvKluHgvDlnT+jczLkZlGErjJJcgRmo6eZQTf8xdHEvDAuWFcB/QkxF4am
         7sLfKCqAoC/rjaaZHeVT2p9sjEtnFNvrhixpDYcebthv5V3m1B5T6dFAzyInBteoOSNd
         y9P1RkLqYOd5FxhAiqyQxxXLQBsMJMWpioS0KfxUkaik13asCvQy42uEp/vg36WtcETW
         oHKYlfRq4qtHu5Lycp66zFgKzPZ7iorXB4UMbRosPksChFZByPmFLl8EsXkWmWG6hv6h
         LImOeUz3lp8A2xT7OPoa+JpAxsfvM8+5SVf5hb3uUjEoDbQoU/rBuk342Bvys2IgoDKu
         uZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBxBPr3Kmhx+gtlKVfwmBEiG03qJgZIhVmQgwh7w3cs=;
        b=jkxidXz8RXklZiBun5YsEclclv95G2AM8/XU81seekHle4yFzRMKl4jBo0Nn9Bkigs
         22ir6Fdu5FtPai6AsDvFbSru8CdFAtilYs+9TMy9ck0+1cONTPg76XVmFOLs+B1iNhBO
         RDrV5WqG8qPcbY0vvUcHRQjCreuzGCEvCQtDxHmBW5vKKsC2MfxD02UYY9sltRUVBAk9
         /I5EIRKAzUFEk5aL1y9GwgeEMN0UbSXcVSTFgiYaj5haTp/FqC/h14bS3qGumLG/HTP7
         x90o2JIlRGyE6nvAnG2z737yrCcyf+eB7dpQVg+3HX9IEyyVNJ6NbToJVIE+kEaDkx6e
         Wviw==
X-Gm-Message-State: AOAM5306S8i3UBtfb0MABYWAbbHlfwOuwSPRlWI9rhz2bpmBIn/S6eQy
        k17udvqB1PH9seVHBEb2sH3GIGsBMnY98jSALvM=
X-Google-Smtp-Source: ABdhPJz7/MeHPulwySfsZ/IqdizUu7xk9XmvlQXItyDL8PXG0Cim011tjNevkpfh3ADXQSZ3F7nxSBrSo9s72Oey3Go=
X-Received: by 2002:a2e:a903:: with SMTP id j3mr2694040ljq.347.1629978784221;
 Thu, 26 Aug 2021 04:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <1629975460-17990-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1629975460-17990-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 26 Aug 2021 08:52:53 -0300
Message-ID: <CAOMZO5BCsTMjJJPtLN6_seVcWb24A2ms11FP3HzR0i7t3GLSuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_rpmsg: add soc specific data structure
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Thu, Aug 26, 2021 at 8:19 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

> +       rpmsg->soc_data = of_device_get_match_data(&pdev->dev);
> +       if (rpmsg->soc_data) {

This check is not necessary, because rpmsg->soc_data is always non-NULL.

Other than that:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
