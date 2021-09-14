Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EF740A719
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbhINHK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:10:57 -0400
Received: from mail-vk1-f182.google.com ([209.85.221.182]:34580 "EHLO
        mail-vk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbhINHKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:10:50 -0400
Received: by mail-vk1-f182.google.com with SMTP id 13so4443104vkl.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saxwiOrMQux4utpjc3YYE3pe8qPFO8tP4XAe7Pl8cfE=;
        b=VVWlA9gU2j++WFmn8EWe3Az/VU+/fo3YExOau4yUkYRDH33a/qF3Fkba6tQ4a6+nRj
         BiBaTOZECswKYSp+1pwM55fMwlXWSAolsl7dWDW7O+AsR7xKfprE3VdeHXMsyUSRw1W7
         XCKyuYPtOzQybCujTPk36dLLWbeV45XHNrg9ahnUBLLxOvyp44PdCWJP43zsJLES7qNv
         2Lo3eFHKebFQ3zohmDlCe1ez3RG6tG1LjZ2g0stvZYHPyVO/tFwv0hy/8tX9h9KIx/6L
         Yd6+kr7P/XU8g75fKyUyQPYbHWjkUqhlsgppG+EqscbbB1KOHqljgiA9sRfTf5n2EkEn
         zbNQ==
X-Gm-Message-State: AOAM532aWBMsJTYFv9oPaBukGXWjvbOFKwF2M0ZatUi1DaKjdaczveNo
        kM5bBl88FORnNBdcc8CNzO3abYZuwtV+U5r1IYHQXbsC
X-Google-Smtp-Source: ABdhPJwtH0fzfhw5kI8DUaCOOuHWNj9B3Z85JKqsUnM1DTTLlKDmHQ/npR6LJBYNBygFtgPNX+Q4exBGSt/HH2jW/s0=
X-Received: by 2002:a1f:9743:: with SMTP id z64mr7398091vkd.15.1631603373724;
 Tue, 14 Sep 2021 00:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com> <20210914043928.4066136-5-saravanak@google.com>
In-Reply-To: <20210914043928.4066136-5-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Sep 2021 09:09:22 +0200
Message-ID: <CAMuHMdV7K1Le5ed3KVizcRDJHp7Ntw2wdUOjz-6_A_MA1x6P+Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] driver core: Add debug logs when fwnode links are added/deleted
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 6:39 AM Saravana Kannan <saravanak@google.com> wrote:
> This will help with debugging fw_devlink issues.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
