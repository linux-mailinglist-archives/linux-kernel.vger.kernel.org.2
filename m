Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC1B333F82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhCJNn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhCJNnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:43:21 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B75C061762
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:43:20 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 18so33492276lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Gtn7a3SlZcZcLg9Wg50TppuDrba0MjDBKcLLojbDF8=;
        b=USasne00YKM9uYo6kMhDbJsaBjmmOaztCoOaWEXD1YbBoHm2IN9dXF4EjtTfnpTkUJ
         V7PCl4Ts4yJgH86RLK8a/mpIKJxH/iftPoSYF6PEjo2SkfyYcDAjRswirkIIy0uTM6W0
         smrdpREQUHDk5GIP78hjVtcO8kKduphzg1lNoT5fxlsMsm7WyivE0bxGsZaMzOruWnWj
         TWXqN7+hl9UjfcJhXsdh50/Pr6aVzpjU4jU+4HGVyMvjib3vi4YKcybj/t4ycAqlFPUs
         GgbR1nisDhdwjaG3RWg5OSOoAdzz8tpbA2Y6VexFy65vLpFX5YBKWl4VqBE+RZRl5KeJ
         bxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Gtn7a3SlZcZcLg9Wg50TppuDrba0MjDBKcLLojbDF8=;
        b=LopNcIeEc/Xf60F/r/2WtjDKjEV3a3Rtrq6fc69yaZZsXrcOD4kwuL9ZWSjdruJqmj
         0fF/C6AVXrZmR/Kp0k8f0BMTxfLNRYo4cvmVNbImq2HkSiUBDzRIOUbLRL/EHWDPshqF
         +ae0Iksi1tIi/zADLdBypjxpiJLFyFwc2uGXY5G5G/yXzdu8eLmcDjgmjWs+zehk/OiV
         Qc4INcSZVbCJuVS2FMDSXzRFsDQRtaY1Z3kYGp43blNZKEQXkgAWacPtb/LT8CSLi61B
         2MwJjO9yq4ul0t9Hcoj4b3v3FgTXzlZ3fPP6WEpfPy3NArrZzKDz2XVz1iL/ak3uGILi
         G7LQ==
X-Gm-Message-State: AOAM531BdowQcuUo+pDPKDVCu20lAXKO+ADR21sEb1GP5a/e37syA5G/
        YvsRGZk1HILdaCj1+FySBsyrwS065f5z+/pKRWWG/g==
X-Google-Smtp-Source: ABdhPJxloZHW0uPelXMb0ewD3vJZPiEIEU7042/GrR6h+mFR3JKWf+KHRcSPMGa0gkdaR3uD3cbSzJQsWcIy+WWcrvA=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr2145553lfo.529.1615383799394;
 Wed, 10 Mar 2021 05:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20210302053059.1049035-1-drew@beagleboard.org>
In-Reply-To: <20210302053059.1049035-1-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Mar 2021 14:43:08 +0100
Message-ID: <CACRpkdbnipjuFU3pTHanhirExWct6OQ2t0T22tne2PHwD7jgUg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] pinctrl: pinmux: Add pinmux-select debugfs file
To:     Drew Fustini <drew@beagleboard.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 6:32 AM Drew Fustini <drew@beagleboard.org> wrote:

> This series first converts the debugfs files in the pinctrl subsystem to
> octal permissions and then adds a new debugfs file "pinmux-select".
>
> Group name and function name can be written to "pinmux-select" which
> will cause the pin function for the specified group to be activated on
> the pin controller.
>
> This series also renames documentation from pinctl to pin-control and
> adds documentation for the pinctrl debugfs files.
>
> Notes for PATCH v9:
> - rename pinctl.rst documentation to pin-control.rst per discussion
>   with Linus W.

Excellent, I have applied this v9 version!

Good job!
Linus Walleij
