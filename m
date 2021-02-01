Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B12730A56A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhBAKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:32:47 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:47010 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhBAKcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:32:45 -0500
Received: by mail-ot1-f51.google.com with SMTP id d1so15725848otl.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEz9JbzZ/AJWyi5cYDNo36zch3xhlNqzSsTkQFyeOLA=;
        b=hPAMQRtrUUc/u3Gj5InfYq+KnTz/z47AGtnrxNSmciGe/hBRpUXoMkkGaFGrvQTTH8
         K8syZ8NRXS4d3Y9J+ISeWLtbhWgfcptrrI3Lcu5rcqhCR3bjpkBzDM5cbLR+l4TrBNtf
         Zthem8TlnPUEJWU/8R65JhXdxItX4F1X1+RiW8bbstofKjkQ1Pot85tDpnyW/ckJ+aDw
         0gOHjRc9HF/9gSKoo1Pla999axEbqrZMlMWUZxmeLUP1fD0BIIO6fo/0wUCGZ6lzVqon
         6KZuYuaRmjf2tT8y38742HDmnt4VIcpxncBiWQIpOYxXYvY4AWFvdMTczyfi7PI6jBd2
         T19g==
X-Gm-Message-State: AOAM533mjo/sDVlMPuy5/NklfbH/UYsNNanp4fYNHFF+mfNCN9JflEQS
        3d9Pz6FjM1P6vFFFLFk/wHMR1PP2zTsCMtN+CmM=
X-Google-Smtp-Source: ABdhPJxreOfOW7G89I8e3ktRql4LH6cUeuDugrYAqFm144cBR1Bjmw24p/73ueEflqitPTtMkJSehqJAQ+N/JQBg1Sg=
X-Received: by 2002:a05:6830:15cc:: with SMTP id j12mr11352990otr.145.1612175524376;
 Mon, 01 Feb 2021 02:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com> <20210130040344.2807439-3-saravanak@google.com>
In-Reply-To: <20210130040344.2807439-3-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Feb 2021 11:31:53 +0100
Message-ID: <CAMuHMdVWJZrGDvtMiyaAOfnZP5jBJec42oQvYeZSgt9ZLhqDvA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] driver core: fw_devlink: Handle missing drivers
 for optional suppliers
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Sat, Jan 30, 2021 at 5:03 AM Saravana Kannan <saravanak@google.com> wrote:
> After a deferred probe attempt has exhaused all the devices that can be
> bound, any device that remains unbound has one/both of these conditions
> true:
>
> (1) It is waiting on its supplier to bind
> (2) It does not have a matching driver
>
> So, to make fw_devlink=on more forgiving of missing drivers for optional
> suppliers, after we've done a full deferred probe attempt, this patch
> deletes all device links created by fw_devlink where the supplier hasn't
> probed yet and the supplier itself is not waiting on any of its
> suppliers. This allows consumers to probe during another deferred probe
> attempt if they were waiting on optional suppliers.
>
> When modules are enabled, we can't differentiate between a driver
> that'll never be registered vs a driver that'll be registered soon by
> loading a module. So, this patch doesn't do anything for the case where
> modules are enabled.

For the modular case, can't you do a probe regardless? Or limit it
to devices where the missing provider is a DMAC or IOMMU driver?
Many drivers can handle missing DMAC controller drivers, and are even
supposed to work that way.  They may even retry obtaining DMA releases
later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
