Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70505342CAC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 13:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCTMCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCTMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 08:01:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF38C061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 05:01:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u20so15100042lja.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 05:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMagXXq1ozulP0IHUR1ris/jHl9iVkXW+AsEGcpODOk=;
        b=ZSHy4EbM6Hefb24Ur0ttR591rgBi9P9Dz1/lla7J4s05/UyJs/PApCm5mlFahtc9WH
         OQp00XMWPuhjOXnqnhA9RKh5apkHhLRxF8cm/hvcw+To7bVAI15eDG5npXmlUne/k724
         JBnzVLk4Ct/skrT45S6PzQ118kZZsyONh9kwjVDF3QpaD06D7y4LALRr16a4Fr+Y5ZsS
         yd8rw77aRbc2bwMi1RUYYER1VRBYBr6tG/C5kGd9SpHqKB9CbnhAYOuiTrADwwfIxFty
         DyIPfRIJidftkQtQKgvpPyqbZADzKOGlo5ywWsgsIniVRwVl4aYx8TO9hBNUzfyji4b6
         TwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMagXXq1ozulP0IHUR1ris/jHl9iVkXW+AsEGcpODOk=;
        b=V5vdjG7e0SBSMOFLRcAcP0ydQMDimgibQjpHsdKSGSf/1BuG/kQSELVEpYqMbhsS0Y
         avuGRV/lFZVBHks/g0ewaMft2Hl/QRJrwfl9ASRpkqkEFae0eJP671jEIJf2aZwNrVgv
         gUhESpPbBELNwK5h7AbgKpkYTx0tQvfEe2iU9C0HpE9IojaxJ1n9f28TW6tgmrx7bl8g
         AgXreRn8rNkS91XzpRC3de62a2hK5dxZvLg5Q6JYhJMx2XLsmhJXUS0i4ehkiPBo/KPB
         Tr2ZREIE4Jc5ivk5qRBMOfrDIYL0FFHMyPKzSCo6G8tN8jUMTOnrRlS7Ltkhx0iPjDxT
         XVfw==
X-Gm-Message-State: AOAM5301teozS6NaUSwYdLApU2tlzIhfwdpSCaR2iYoXWoNHkh28fAwu
        b0zPJ4+juWB352AbMLZKvju7k+QOakHQD/gBITMblA==
X-Google-Smtp-Source: ABdhPJzqb54x7eHriMdMozRrKWRH+fbSuTOYGyu3ifFZBCafRLKw5TgRMSdk757rW9zq2hDWq39fVCTZ+GWQhSosK8k=
X-Received: by 2002:a2e:9004:: with SMTP id h4mr3695308ljg.326.1616241716433;
 Sat, 20 Mar 2021 05:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210316133700.2376662-1-geert+renesas@glider.be>
In-Reply-To: <20210316133700.2376662-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Mar 2021 13:01:45 +0100
Message-ID: <CACRpkdY2qW+qRCMD8WFYGf8c7h5wb2QbJoQ+v1pKPfmvhp5pXg@mail.gmail.com>
Subject: Re: [PATCH] mfd: ABX500_CORE should depend on ARCH_U8500
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 2:37 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The ST-Ericsson ABX500 Mixed Signal IC family chips are only present on
> ST-Ericsson U8500 Series platforms.  Hence add a dependency on
> ARCH_U8500, to prevent asking the user about this driver when
> configuring a kernel without U8500 support.
>
> Also, merely enabling CONFIG_COMPILE_TEST should not enable additional
> code, and thus should not enable this driver by default.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Very nice. Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
