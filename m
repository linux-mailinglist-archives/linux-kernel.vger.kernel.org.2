Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1744ACD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbhKILuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbhKILuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:50:12 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E4C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:47:26 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id t19so2893694oij.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFIaOEBE3jLlzl6nBmZ3jg57oyX5JW9xJ2v9BAzzICM=;
        b=LeL9etCeX8uwNqkyylsOjPnNZMdwwusOGMOEeW3rU91ddwANV9F460ShhpFrXwEKUu
         AnHaSEFTF+I14vnJJv7Am22NNyAgQvtHjzrucgLjK4yF1Xhl0RUCdVpuDRLR/FH4qvsB
         u+X0jhFb5z3wC3pzI3A/BqEgfymLUkhwXwI98jrHX6B+TYqVlPaBTFJLgIYeDbsZD4Rv
         Gh9rZlnmXl+hEB1EG21CwcdRVKQ3UMJAa2p2pk+1gT18qu7dYcUFhmZbP1KbF1mfB2wl
         skyVmuNW5+Q7gWlJOR6DD8kMZWmgv3tqwcute5zFXB5ce1c1J0VngvOQOntQYMAj2SmF
         4njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFIaOEBE3jLlzl6nBmZ3jg57oyX5JW9xJ2v9BAzzICM=;
        b=egidjCaf9kTD9vG0D4uxjeJUfrLTgAsTznZD45kWIF1GRhSPUVDHvq4DkGDmPftzsl
         y4GAtLTEjpEw1WBq+Zev+qgXhtv9A5gHUYfP2XzsXS1JBfDJ6NkDlLb8jN2+i8iGttmR
         9JhEKp0zXKPIJoWHNMF1+gemnZimc+RgtsoSAm6KSVN9hxggwJv46XDbPJptp+XADNOE
         aSlRo4xTHynBw5LyoVTp7T7Qg7BAM1CFaT290aRy/NIZ3rC43C/z50hjvpB60lNjZ1Qm
         SQT2NIJP45MNWfzghrrCy0EfxifmRRqLnc9MV3DIXJ1r7cfs1T0gLVrkupVnjG5ubJzT
         qbgw==
X-Gm-Message-State: AOAM531PTaBfNSW6B5sddGtSyERKN3+qem+FOoXoOoMA3bSnxaqqS/d1
        Hc2yCw9M9BjpDKByOwgpbhAzE/6/AYVSJ1Ig75qsQcre74s=
X-Google-Smtp-Source: ABdhPJwEOP6hTw/QdLuaZqo0gQ+u9f+SSIeTdJ5gnFmYLjdI5+WU5LUyOlx+SqVjELBxLZX8CpI6iiNsihQHXWFUkXg=
X-Received: by 2002:aca:120f:: with SMTP id 15mr4887619ois.132.1636458445642;
 Tue, 09 Nov 2021 03:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20211107225458.111068-1-alexandre.belloni@bootlin.com> <20211107225458.111068-6-alexandre.belloni@bootlin.com>
In-Reply-To: <20211107225458.111068-6-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:47:14 +0100
Message-ID: <CACRpkdYyxhvVphR7b=b42qEUDGNM3jB_Zc6CjBR5ZK7PhDmVOw@mail.gmail.com>
Subject: Re: [PATCH 06/12] rtc: ab8500: let the core handle the alarm resolution
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 7, 2021 at 11:55 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Tell the RTC core UIE are not supported because the resolution of the alarm
> is a minute.
>
> Note that this is in fact also fixing how the resolution is reported as the
> previous test was simply ensuring the alarm was more than a minute in the
> future while the register has a minute resolution.
> This would be ok if the alarm was a countdown but ab8500_rtc_read_alarm
> suggests otherwise and the AB8500 datasheet states that the RTC
> documentation is not public.
>
> Finally, the comment is wrong and what makes the UIE emulation work is
> uie_unsupported being set.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

I trust you on this one!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
