Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E158B402FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbhIGUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347004AbhIGUwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:52:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E05FC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:51:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n2so433487lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H83XDR5yiRIxqWB2WwqMMGV8X/KgdmEIglGXxV2ZmFY=;
        b=p8Dbjz23mSMtmoOdbzIR0EkM9FxkbpZoZ2ZpdgEbJHI4FOCp5puD/bRxkTMNLE25RS
         2pYXTNF2fEPgCAAN1ubLAQm6dEr2kyOFJy2E1M9oFTtTcTYTFHJrcWlqplkp92v1a8oE
         iurursMWyumOUOhFyt3xq0VvDbcNuPk2cztErfcMyvBGDiT32liXMG8zRnVeyNKsNg5d
         Gg1T+ucA2si9m1o6kXy/ogho1EaEMx08zlHg4mj9MoNopolZIYDzhZpzU8GRy04ctnoB
         V9OlLvk5b7cve2x1/wq1EADxtBvOZcmiPm0F0uBlmPu3cc9syTwSptTpTPXdgdXQLzfq
         yF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H83XDR5yiRIxqWB2WwqMMGV8X/KgdmEIglGXxV2ZmFY=;
        b=IkbgKwObzZAHkz/zR2JI+0c3Yi08HZ44uJxBGLkOzk3Fzr91e2ySe5QuKsLkqYvsK0
         mFrWXOMOFAMPhg9bv62gnjbdzetg2pl9l39TF6rnXmSHBJuk8O9OIEZhwC6fk2+bgWS6
         dy3KZZ4TD62gicAWLGVBUBQWmwRb3kFl7JYUVRKyI+Wlmw0lWnIqXOj8WYUdFnokWp1q
         VPxs7Jp4nFz3yjqJv5Ub0hyH2vqDiVg3eKyCWm28h7/OWImMohDZ3BbFH7idZkorRBJt
         umDi+xkC9RdS4d1ud/K8cSHDv2co0m8/QR4onUSDLQgNb/X64wqQZv9lZbfJIgzFbGvV
         3W3A==
X-Gm-Message-State: AOAM531NM3pgjsRc3jCL/ji0p8j2dUYvNEiITsVjvJIePcxB4Epd0Lrc
        vKS7/iEprD0g5Z28kMD+U1xbdNZo3n9e6xMY8cM1Jw==
X-Google-Smtp-Source: ABdhPJw/s2+umwvpUOEOyJq1xy8mOoWzaPMLcDKqHBpM+YPMAybQZDnb5U3DtHu/hDulb5NifytPNCEeGeKn9d7R+7s=
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr246495lfg.72.1631047865550;
 Tue, 07 Sep 2021 13:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210831135602.4476-1-caihuoqing@baidu.com>
In-Reply-To: <20210831135602.4476-1-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Sep 2021 22:50:54 +0200
Message-ID: <CACRpkdY7nz0RC9qmJ69+CQZ6rLQ4pLtdSEgfDgHVTS63Z=4imA@mail.gmail.com>
Subject: Re: [PATCH] drm/mcde: Make use of the helper function devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 3:56 PM Cai Huoqing <caihuoqing@baidu.com> wrote:

> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Patch applied!

Yours,
Linus Walleij
