Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBE458143
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhKUAAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 19:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhKUAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 19:00:45 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA91C0613E1;
        Sat, 20 Nov 2021 15:57:21 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e3so59339026edu.4;
        Sat, 20 Nov 2021 15:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5sv4rcMTrhYHornG640LvlmFUzYpzF/uMv5wuwnFA4=;
        b=KqF35IvUaoojoKBQHxLa+EhPGzpcMTC8+x718D5FuVl6VeWd604ugCjjre5otbt5PV
         bG3m2Jtu/s3Umpi4aFznHxGqyAwh8R+XOy7wAUHfYJoeVcOHOiptPq8aPiYsSsaDkXLw
         ovvBD+N6g0La0ZsoTNIJY3sVChWs/hUnYDsz99dHyJuqWsHQIfQCjCRdmCAxjn/U/Oel
         GvbJlryGkJInHx9D9G0UmlQt7ojwP1LjP0AdtQP1nl2nmZrtuUwnhNHRu/N3nVIUDa7P
         +gp/S9fTBEp9J1D1Ti3vGiA+HLIg3MTLnvcvAlLyocudM67N8QI5G1SIzXeNc/fZ8OZc
         Ka4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5sv4rcMTrhYHornG640LvlmFUzYpzF/uMv5wuwnFA4=;
        b=Yt7rSTVpgcNcZfSJlIIpt03j62SBmJsAhyKNXGK0ujPCp57PMdJRyKnmpGNfQ5H1rq
         gEeNBOxtWFsQpkqcl0EawtEdQvFx7CybhuaeIkS6p6hfq2QNyORE3ZAfhphmhcOiEihS
         PaPblv7Ro51eKNs2M3lFTyy3YCi0tGuxzhFC3Y7hdfyu25mJB1NFwcyUk8GzxRrfVUL9
         YXDJ86LAxns6nlXa9rdia07R0P7e2NjRZzhAkGLsehur5OZ4Z0ZDjm3HfnqMXjAzWhRN
         poaDos6l/QOe6OyTu9K/d7XuubHp81YAD2vrX8ewrAaerLUz7HpBYPLC8nChYvX0T/dm
         Q/Xg==
X-Gm-Message-State: AOAM532zGBdKTsNv3CIwEwgrnyxkR9Ee3PpcUxInfAJX9ZOuVu6C2kpl
        aGEKwe8f00CU7PPDKuCbNxk03nbOC6kUuqbt8KfQMfffki0=
X-Google-Smtp-Source: ABdhPJzn8mqm8xib8HnioRMdm0uhJxnJSh9wqmShlbVnLNSL1nB8uBXlhDbcbNqXHaabpnMoro2qzWyD++Zopf4gFpQ=
X-Received: by 2002:a50:f68c:: with SMTP id d12mr35001969edn.307.1637452640350;
 Sat, 20 Nov 2021 15:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20211112162827.128319-1-aouledameur@baylibre.com> <20211112162827.128319-4-aouledameur@baylibre.com>
In-Reply-To: <20211112162827.128319-4-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 21 Nov 2021 00:57:09 +0100
Message-ID: <CAFBinCCvOnrvC64sA++5DegZq1g9MmwvnCiYh-WB4dSkoBsCBA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] phy: amlogic: meson8b-usb2: fix shared reset
 control use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     khilman@baylibre.com, p.zabel@pengutronix.de, balbi@kernel.org,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

Thanks for working on this!

On Fri, Nov 12, 2021 at 5:33 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
[...]
> +               reset_control_rearm(priv->reset);
Using priv->reset in this driver currently requires an IS_ERR check beforehand.
When I wrote the driver originally I used the following code in
phy_meson8b_usb2_probe:
  priv->reset = ...
  if (PTR_ERR(priv->reset) == -EPROBE_DEFER)
    return PTR_ERR(priv->reset);

That means: priv->reset can (in theory) be an error pointer at runtime.
Since your patch is valid: can you please add another one (before this
one) in the series and change the priv->reset error checking to use
something like:
  if (IS_ERR(priv->reset))
    return dev_err_probe(&pdev->dev, PTR_ERR(priv->reset), "Failed to
get the reset line");

With such a patch you can consider this one as:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
