Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05133D1065
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbhGUNUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbhGUNUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:20:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15027C061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:00:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y42so3322796lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsvJRDxyY5UbCVX7sGabd497i4VkHjlUGB0A4qGDBiM=;
        b=blMhE7FHuYJvQ1jjr+eBeAoe0VtX2eu7Ve2CWtDtuuospCBc5iAQLUu0A6jR/ynetF
         SPnplHFagBkDTKPQ7D4dX1CTKIT+Zpq0RGWPMEagc0uYZ66Sd+VQ35EWVZjiRNXHExOn
         FjwJcVQx6m3GkAkZdxYrV1EF0HAKW+t5CI29SFuf5n2wnFPEFo7pgOCzZLaLYJZRPMgs
         Edn645SrSlfVxr4SLzgTjeuM7Frlr+GZ5OFpRZNtLSNy4TCHJfKM0vEY3m2FfgUbP5pi
         5TmpbmrV+zyjRWlnXOYbMXbn93WMk4AWn8PwpwMOCdVj7OFWg9tcDeVD/dOp9o+DDvTM
         dvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsvJRDxyY5UbCVX7sGabd497i4VkHjlUGB0A4qGDBiM=;
        b=Hhd7foSG4Ahmxnt4q27aEG8wtgma55hgD5+vhA6dtQzFQWYuc3b6RXvBRMXjt0V7Dh
         4YLimD6dqqodWbWxHeMgnsTzNYAAdt7ZRONEno7/EGiIaRXi+tvGTlBlGEmryK2ETBcj
         4YHc5xE1ltvQq/8OGlyZiOpVEnXiEyqPbMua1ceB3d8kICd9yTdBB2r9ZA5M+De+vRai
         u8LpgqXevDWnS9B3cAp/xAFKuAQ5VFmlgD1VlGwhqKqvWTa9XkZjk4tMO0uiAXjwCDUt
         aU+Zt56kcmBw7dQNWxWScvuUJmnRq/fC9S+OiY63Zag19iD9FTT1dtY5YdyxmVu7eYgo
         lfYw==
X-Gm-Message-State: AOAM531WoX5qXOQ+QVucsxcJxVzKLHAxMJHdKnrmo7YJrCfbxvBrrb8I
        djqoXZu5bkiWoFudXwSklNJhqXJdlDJq1h7BcRXDZA==
X-Google-Smtp-Source: ABdhPJxEOaTZyJ//VL0xm+qjsBbECijs8kafihDiLsk9j4fdAjhS7j5/f6rj7V9/XmHDPmtM1H58IrDvM4Y9VTGHhKs=
X-Received: by 2002:a05:6512:3f1f:: with SMTP id y31mr19471776lfa.29.1626876046329;
 Wed, 21 Jul 2021 07:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com> <1626853288-31223-2-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1626853288-31223-2-git-send-email-dillon.minfei@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jul 2021 16:00:35 +0200
Message-ID: <CACRpkdYerVu_LyNOJoxMTqhuNd9QBSFWTM7bfRnrsOyrxqE_kw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: panel: Add ilitek ili9341
 panel bindings
To:     dillon min <dillon.minfei@gmail.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 9:41 AM <dillon.minfei@gmail.com> wrote:

> From: Dillon Min <dillon.minfei@gmail.com>
>
> Add documentation for "ilitek,ili9341" panel.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
