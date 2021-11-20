Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5215E4580FE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbhKTXyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 18:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbhKTXyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 18:54:40 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66462C061574;
        Sat, 20 Nov 2021 15:51:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so14842442eds.10;
        Sat, 20 Nov 2021 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYJh43bo2xHXTh2noh4gGbHA058L8tZGc1wOJPe1jdI=;
        b=qp+o+sOGRqN/IjQjqTZcx81YCv2L16rjo7MPiwhbt3K2cWSTXNpazc1d6hwn5Fgvo8
         FOicp6PtJMYiJY513qp/I5rga4ZX+orhrkuxqfy/5Zxk4NDzDsyoUkbUrMEox+n0okEb
         P7LcF5vRvyK+9CmSVmEInhaCIzwy2NR1VgjrfEDp6icAuqJg0D9LHtkaeZYrK/ZL02vU
         iPP8RbUmsmy+lmb7FBFT0jo7WeweKNEbN49iSEXRkKZZ864tByVidePyzbuwk+FlT5df
         UmbGXLr0ey/FPs7jH6JL5cioiiMWkGjfve1ZAb4BVp/wjnon+7AUjD9WtdxTXNGIoydh
         NfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYJh43bo2xHXTh2noh4gGbHA058L8tZGc1wOJPe1jdI=;
        b=UQOSmmpYfF6WoAjW8ep8OiqNWouJzAk099cfKBSkx5H31jNo3zAxec5pE4ul/CH8Rs
         kexeywFRG+IdLMzIthqc4VGMJYeR253Bxl5SNVyvq5/dOByWmenErsCPNdM0cYG9r700
         ualjWTEBDCIBubbcZjb2m9/jFpX6kv2/FwAqjBwg8tM4796Ns90+QcMp/KT0VFUn8r7L
         l5/WQ70ej9Luojh4eylpdw7ZTbUx6Xns2hyaVMAFrdYrA1Jt8lSEtbxARtezNEzqumV+
         cP3dW/vE6BEu/k9bO/3092h7k7KwGm1/aEIP3nwA9UCuCZ3eRmlgwYho61OD9nRCvhlC
         iI6Q==
X-Gm-Message-State: AOAM532YmodmOncrzlHOuukc4P2ynnGkix/yDCquj5r9jvpz/wrGiPGi
        U1HfyXuSpkI8s15x4Bl+Hpo3G88IBGWdCAdVx9w=
X-Google-Smtp-Source: ABdhPJy8DtMhHdjdfXbtNVR4nEHP0YIpJsQcWgtXf9YoPr3JEgOk0vFZaXb9K9e6p5FtqDSZPZk82XIcRvSmqQQKZGo=
X-Received: by 2002:a17:906:37d2:: with SMTP id o18mr24548013ejc.278.1637452294851;
 Sat, 20 Nov 2021 15:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20211112162827.128319-1-aouledameur@baylibre.com> <20211112162827.128319-3-aouledameur@baylibre.com>
In-Reply-To: <20211112162827.128319-3-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 21 Nov 2021 00:51:24 +0100
Message-ID: <CAFBinCDNMCT4KZjw8HnYer9NJBx09yF=KpguGm8Q4vKw8eBr9A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] usb: dwc3: meson-g12a: fix shared reset control use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     balbi@kernel.org, p.zabel@pengutronix.de, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

+Cc Anand who was also investigating the original issue one year ago

On Fri, Nov 12, 2021 at 5:33 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
>
it seems that there's an extraneous blank line here

> reset_control_(de)assert() calls are called on a shared reset line when
> reset_control_reset has been used. This is not allowed by the reset
> framework.
>
> Use reset_control_rearm() call in suspend() and remove() as a way to state
> that the resource is no longer used, hence the shared reset line
> may be triggered again by other devices. Use reset_control_rearm() also in
> case probe fails after reset() has been called.
>
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework, use of reset_control_reset() on shared reset line should be
> balanced with reset_control_rearm().
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
