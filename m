Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97C3CC74D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 05:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhGRDyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 23:54:20 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44830 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhGRDyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 23:54:19 -0400
Received: by mail-lj1-f182.google.com with SMTP id u25so20169335ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 20:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=d/Drpnya1fdxaSmm7q/Snr3jS7yyspDnbd6u81b/Sbw=;
        b=rj8TF/z36qTCTzdR2Br/uVPZdA27qMx0kNA6m34MIwd/0J86LcxwSF5VBrlFN6/yS5
         t6psLCdbfVwZipD4w7+zGe+ycoq5c4ZEI1WzzvD+yVGA3PNmKqsEb97+69eFxc5c5pZX
         1qw2C4tlIOUMiNjRnX/TEuw5BCkj3WZEpsT6CsjIx0hpJFhYp+sUZDFi9T4KBgMwb86K
         pFUP6AslIfZd83PczADBRSA1KVSSCt28y4NI5m4vC7uiIW6+iSlPlTN0KQIG5zBk2n7f
         LNPJ7TzLBYn8W05GSnwRo8v6iBY7Vnrtj8z69133AqUmcwQY9QSUCewhTMa0Vu5cYm5w
         ZH8A==
X-Gm-Message-State: AOAM531KcXL6qCmsJDziz08J1d0NDUn4vZsBgEYu8eovPi0wCKwjXkMK
        I+8MSRjxj1Yej9dMLJdccNSr53yLsuKs9Q==
X-Google-Smtp-Source: ABdhPJwmJJuavRkgB6NQqQhou7zgT1d2XXYV/tzjn6BwCEvj7NzopKZUqer4UFKGNpJKXcC/0MmXDQ==
X-Received: by 2002:a2e:884e:: with SMTP id z14mr16444965ljj.39.1626580279856;
        Sat, 17 Jul 2021 20:51:19 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q187sm1562495ljb.15.2021.07.17.20.51.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 20:51:19 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u14so20291653ljh.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 20:51:19 -0700 (PDT)
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr16880789ljq.94.1626580279094;
 Sat, 17 Jul 2021 20:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210717162528.272797-1-hdegoede@redhat.com>
In-Reply-To: <20210717162528.272797-1-hdegoede@redhat.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 18 Jul 2021 11:51:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v66wG6J-XigQNFh4qR=GNkLWGkrFjsSqSNirCOF2-ypXYw@mail.gmail.com>
Message-ID: <CAGb2v66wG6J-XigQNFh4qR=GNkLWGkrFjsSqSNirCOF2-ypXYw@mail.gmail.com>
Subject: Re: [PATCH] mfd: axp20x: Add supplied-from property to
 axp288_fuel_gauge cell
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>, "C++ / GCC" <cpp@gcc.lt>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 12:25 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The power-supply framework has the notion of one power-supply device
> being supplied by another. A typical example of this is a charger
> charging a battery.
>
> A tablet getting plugged in to charge (or plugged out) only results in
> events seen by the axp288_charger device / MFD cell. Which means that
> a change udev-event only gets send for the charger power-supply class
> device, not for the battery (the axp288_fuel_gauge device).
>
> The axp288_fuel_gauge does have an external_power_change'd callback
> which will generate a change udev-event when called. But before this
> commit this never got called because the power-supply core only calls
> this when a power-supply class device's supplier changes and the
> supplier link from axp288_charger to axp288_fuel_gauge was missing.
>
> Add a "supplied-from" property to axp288_fuel_gauge cell, pointing
> to the "axp288_charger" power-supply class device, so that the
> axp288_fuel_gauge's external_power_change'd callback gets called on
> axp288_charger state changes.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Makes sense to me.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
