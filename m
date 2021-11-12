Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB8544EEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhKLVlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbhKLVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:40:58 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2FC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:38:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z10so16550194edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCxwnQCDR0eJyCVNlEWzdsZAk9jtBC7W2J8msKvVqpU=;
        b=WqzHqDbnt/+jF2n1F59ai/W0Nq428ldUNWjyMV5m32acjV1SvMOR4wyy35SsAX8gRr
         2Fi/Jtb/EQs/rqMVUXtInOKR9oIOkyXzhE+aehxoyYIxN/WaJ6pjCOzBEzhTtgg8Rwv1
         yhNcD7yTSUBHLuzuPFBfYsqx1UjpeyXOvrsUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCxwnQCDR0eJyCVNlEWzdsZAk9jtBC7W2J8msKvVqpU=;
        b=RLOvhhEgXdrATDI4e98WxsdJj8ImpX7+WmTJM4BagjHt4jK7ZXDj9JEFcd/AwxidZo
         hJikivJHRItFOWeFVmdQ2boZliIbRkCFtw6j8B2I4bogbTJJVq7GIqmgWPWC67c661qy
         8iaHSZZrFt3/CU7BEuvhaQsfpjrojQlZn9hpNIqVkh/+NEBRV/xFMdqDWYmI+h4/ZWaP
         14XvJLztRLDKuXN17ePL5eE32/aLsCH9zlvrhlkcKhf7TCGjwmB38WuiwUGMKR2nrHSY
         0c4usPyaoiaBxR+r+lkQ8Ejlw7T7hKFZ0bYmfUuGHpRk7PAb8rpY4MHggf7J+AZDzLyp
         i76A==
X-Gm-Message-State: AOAM532/elPoCjsH81Zx/ephrOvO3oSCX7wCuvIJS5k2OjmbOckMPJQQ
        uKpCjULuoca7MZBmxMeTke+yC4YbF91uc2V5TkA=
X-Google-Smtp-Source: ABdhPJwaF18wLHeMinrY0j+Ie8W2Sow3nLV19j+1Uy4YNwO7l9gqd63X+j5zYsg3kJ5ZP7OQd7zEEw==
X-Received: by 2002:a17:907:7094:: with SMTP id yj20mr23619584ejb.265.1636753085100;
        Fri, 12 Nov 2021 13:38:05 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id i13sm3980306edc.62.2021.11.12.13.38.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 13:38:04 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id c4so17810591wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:38:02 -0800 (PST)
X-Received: by 2002:adf:cf05:: with SMTP id o5mr23057906wrj.325.1636753082761;
 Fri, 12 Nov 2021 13:38:02 -0800 (PST)
MIME-Version: 1.0
References: <mhng-109b0503-bc7c-4da8-8621-28aec8d9df59@palmer-ri-x1c9>
In-Reply-To: <mhng-109b0503-bc7c-4da8-8621-28aec8d9df59@palmer-ri-x1c9>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 13:37:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkh5Qma5rHtiRQXF9jVRXDe=bRG+D+LFu4dZpwP1uWAw@mail.gmail.com>
Message-ID: <CAHk-=whkh5Qma5rHtiRQXF9jVRXDe=bRG+D+LFu4dZpwP1uWAw@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.16 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 9:32 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> RISC-V Patches for the 5.16 Merge Window, Part 1

What's "part 1" about this?

This was sent on a Friday of the second week of the merge window.

No way in hell is there going to be a "part 2" that I would possibly
accept at this stage. It's late as-is.

                 Linus
