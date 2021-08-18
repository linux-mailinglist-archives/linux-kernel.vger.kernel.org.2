Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A717E3F0EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhHRXiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhHRXiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:38:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0474CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:37:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i9so8329433lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhIy9znc3R8woK0Yh7F5fhaRRY/b4r09z95kantGp8k=;
        b=FAqmndSysaYMKv2k/Pyn7x9vHZIivco6iQoVrwvorawqJeWA9tQL7JnBsCMSVmty7T
         94Wc1dg257KjAz7v9Kpzx5JSi55gxpMnI0qV5vv1FQnxTnjY1eUiru0RDozdmDfBkJdz
         lDS+y/nRRraZ4UmagC9hDeu/faE4sOqxE5d2LX4Q2Z83lThYsY7Z7Ao41JA/+OJKQrst
         qKoMN8Pi2yU6wnD1+UXa3T7OO9k7U6WHFoBlIZ7+ASZeOqK9QVr9mSebI3xc1Wq2V2SV
         JGrnbLc1+IiCmtNx22ZSaig75ywBThanKqC8UDOaxD6Y05hpCs6pOm8wzFgp2DvFjjW7
         SWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhIy9znc3R8woK0Yh7F5fhaRRY/b4r09z95kantGp8k=;
        b=Dd+0yumrQI/b5+86tRrILiOog8m6tEdIc8f7+992nekuHHJ/knSuzTt+cK3WYJB675
         TfBEZLEjsBFbhZN10EYwKb78j5LfPXwJ/8yGEqAhoGhI7vcglknwB15hYMC/vskoApkq
         Qd00WaAFOTXo6UyeO8oNsukI8P/yITqv9On83DuAsWZ1YvQ8XwXf52/ucXoaK/eMSk9a
         Ns1Fnb4Eefp072uWcCXKDM6SpgxzpwNNxt0NZaBl22YR36fcVFNqdq1hYWGWn9GI2Muk
         33LDqYjB6SXTWI8nZFVmkww2o/I0zaEKFDfnEMaXGFdXkJLRGc+uvS2hPQTPYZfi/SaI
         ej6w==
X-Gm-Message-State: AOAM531C7XIDzkuHRW43ta3sCHoqCXBcwbfVqOfNyRzXb5/bgK+YIynX
        kevpKAeKG//6dZ+n/ZGILDuyCZVCFCCPtbXMRtwziQ==
X-Google-Smtp-Source: ABdhPJxFuwdipfU8mB3bkgwXWO5+wtIESz6BPxgGvCF6DejBFdyr9qxRYbgcxPe0FYC4XcON3bjyXaLoS2nwu6Hz1Ak=
X-Received: by 2002:a05:6512:3e26:: with SMTP id i38mr8422086lfv.29.1629329864245;
 Wed, 18 Aug 2021 16:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <1629265999-33358-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <447d7205-f562-72c2-8317-031cd733d60c@xilinx.com>
In-Reply-To: <447d7205-f562-72c2-8317-031cd733d60c@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Aug 2021 01:37:33 +0200
Message-ID: <CACRpkdadQujzApH_XKhe5LD46S4GUseXKQ_mV4Jv7eaA5u1yUg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-zynq: Add warning for not to use 'io-standard'
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        git <git@xilinx.com>, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 8:00 AM Michal Simek <michal.simek@xilinx.com> wrote:

> Linus: would be good to know how long we should keep the support for
> this deprecated dt property.

We use the "noone hears the tree fall in an empty forest"-metric.
If no user suffers, we can drop it. Determining that requires some
kind of reasoning about when that happens, and then the maintainer
of the driver decides.

Yours,
Linus Walleij
