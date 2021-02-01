Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C830A495
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhBAJpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhBAJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:45:36 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B1DC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:44:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id df22so2114266edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5sHWC9y/Hj/k3MjCweTDVJloPdNZBgsHShhsKDRTSM=;
        b=R8ksIxKy5SfvjU41UH/PxeyxXtcr4TiVkAZxtCsyaU7KuPxitA78UfQHfgMzb+qX9q
         pL1vHh7wOuipUUTmogr53O3lMNtd60IXHOqLfumDJ5qmME5MV3F2fOCOncE1Q1oa/qDz
         FEyAVRvi+fuvfoj2B7XcD/bBcKfSaLjLeuq1D5eNkh2k1+jjjAWiqQhd7wtaqQOHoexh
         RGpCL2k7dhyYYENh8p9Zmv5wW3fOpqNNBKEwRSlJsCX704YkbwsrGNkOFYsIkF25zK6Q
         A6H0jOZq3ikXZSr35HZnOqqu7QoHbJijhp9NjN1DZU3RolZHOY8Agt7FhOjVoO+ifzNO
         yTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5sHWC9y/Hj/k3MjCweTDVJloPdNZBgsHShhsKDRTSM=;
        b=J7KKYs5yOEQJ8gI0djwjfwkolSkHwyLuEVp2E6rO3oRc1WsVXsdY4mVim5Bkna/9nk
         MhvrAC9BtUV79jZz3xSWHSc30OeVLJTOHl/bjkNE9MlsjUuXtaTq0PAPX6TDjgBVKr/9
         bTIFSM1tBrQN/5lfgrGPQQXB5MCYM/rTcVnDRzlrpNBi8lr0W3E/rBd98hXjecTbPzBh
         bQpS7GHniA9t/ktJnKZqkVkHO1txqIbN7/9VN/3by3fTpNFB/wVSRhozmGNfs+R9ZuYx
         6t8SpPLltW9g2WbskrfsY2KwbRh3rIJlpsvB9iY1mHffOiFQYEZwPXzgmEUXW/WquWxU
         Ki/g==
X-Gm-Message-State: AOAM530waGj1r6XAu+mKo4I/B7y4X3gISUvBqJ989kLLUSMIZqMAzQs3
        ynNO65+4o6+T2WHPNMxy4kk7L+55IYGWDPiTcgFvFw==
X-Google-Smtp-Source: ABdhPJxS2V+wmAKY/bIXVLBw6Tmt56CjvJHtjUWVkFY0SZrhceTrae2S21BcutZkTmqoTuqaccPqzSNqjCC+JSy0oLk=
X-Received: by 2002:a05:6402:3508:: with SMTP id b8mr17994271edd.341.1612172694552;
 Mon, 01 Feb 2021 01:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20210127000303.436595-1-drew@beagleboard.org>
In-Reply-To: <20210127000303.436595-1-drew@beagleboard.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 1 Feb 2021 10:44:43 +0100
Message-ID: <CAMpxmJUqAMKHsc6_HRhps6KgmcqDtQK=fDKiyAEaNMbZMM1CBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: am335x-pocketbeagle: unique gpio-line-names
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Benoit Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 1:04 AM Drew Fustini <drew@beagleboard.org> wrote:
>
> Based on linux-gpio discussion [1], it is best practice to make the
> gpio-line-names unique. Generic names like "[ethernet]" are replaced
> with the name of the unique signal on the AM3358 SoC ball corresponding
> to the gpio line. "[NC]" is also renamed to the standard "NC" name to
> represent "not connected".
>
> [1] https://lore.kernel.org/linux-gpio/20201216195357.GA2583366@x1/
>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
