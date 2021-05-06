Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAAB37546C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhEFNI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhEFNIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:08:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91379C061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 06:07:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z9so7660245lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s2qBYSONFf8oTRJo223fI5ppnTybdoSNatNgsyTAANk=;
        b=wzR7O9Exm5PyYdlIe1FDgrFDOr7hTDVS5QgTbB/j/KdTpFChF+64xKDQKoeSzmLEXd
         aoUjjdo5oWzzvhRJL2ODcKYh6BZsfPS0F4vKyQsp1quojhNXr1NAKdTVhsoxqq5teYSx
         JSCx4BUpHHEvEwrUoJAZ/8SxbbBsxk6NUjSSV6d//jA38yW8fcC9WR/TMs1Z5+TCb9fp
         DrKauYDjG/ZqXZ/+LYI8t8l+7pcsNP+HXtFVJ8vJ6oS/Y8N1snz+WlOQTEdKRpqwWvZL
         QhNm1X1cPxPjXKe1MISIU1EY3YU/oEUMCVgjH6yuttYvn0TbeDaW9lB/fF2+EAIHSHV9
         bZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2qBYSONFf8oTRJo223fI5ppnTybdoSNatNgsyTAANk=;
        b=JHgIEqclDPgAJQVXFier2D15IajBHVagAhhWUE/ocgCFAbPOfVGQg0HnbksDuYBS0b
         xEKb39K8vm8/AWocEUAMlbvSzzny9bPn9eKNcLj5ig8w5iqjpcVwp5GWaumkWCO6hj/d
         iCW1xltHdUY3se0SMMvdI9Uk441YZ72Pc+xKwov6lWsaaVpWcXUeS7njduUnCs3CBUHJ
         0UxH6qfjAwuDvz3120WkHWSZW3hKdgsDZt9sEiLfC+EsM7/5VWEWnFN3fHlQiYLCCQWw
         WU+kASG8DDuH0d/ALHtu79K+aR5MvYEhOondd7ZKGhvCQfXx3gZjhnVmHYNi7S8rhOas
         zoPg==
X-Gm-Message-State: AOAM533qz/6SvkZiiJet+hD2ScETrU347plCpHWtvgGvNPG3wyYDGSrw
        5JyDZDjSr/Tu+VziQinZthL71fSYe89flxWxv6/JoQ==
X-Google-Smtp-Source: ABdhPJzR0emV6Ru3vGRyX2JFlINRH5COYpUOUBc7sWBMBmKFHZDusG8gT+rIHcy3lJdt4cRizrkrMAXcf9S968ch0nQ=
X-Received: by 2002:a19:a418:: with SMTP id q24mr2720790lfc.649.1620306444116;
 Thu, 06 May 2021 06:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-12-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-12-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:07:12 +0200
Message-ID: <CACRpkdbvZarQYREKk8g7NFc6wUveMTDdPVxC7+2ny6p=L63UFA@mail.gmail.com>
Subject: Re: [PATCH 11/11] mmc: core: Add support for Power Off Notification
 for SD cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Rather than only deselecting the SD card via a CMD7, before we cut power to
> it at system suspend, at runtime suspend or at shutdown, let's add support
> for a graceful power off sequence via enabling the SD Power Off
> Notification feature.
>
> Note that, the Power Off Notification feature was added in the SD spec
> v4.x, which is several years ago. However, it's still a bit unclear how
> often the SD card vendors decides to implement support for it. To validate
> these changes a Sandisk Extreme PRO A2 64GB has been used, which seems to
> work nicely.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Given how these things work in some quarters I would not be
surprised if some SD card vendors tend to start to implement
this when they see that Linux (Android) has started to support
it. So let's encourage them:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
