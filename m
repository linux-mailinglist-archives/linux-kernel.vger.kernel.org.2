Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C050402B58
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbhIGPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:11:04 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:46055 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhIGPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:11:03 -0400
Received: by mail-vs1-f46.google.com with SMTP id a21so8570155vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 08:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8l0cUSrwFCbO6kHbGt2o6pLB11QVwahthUcMbDbq4I=;
        b=RkKQ1PyiiNUc+5z6+XnLsd+YVPVb0wIVmUEf1BcdRXNi05NQJH3+XPVJxlfsn0cyNs
         twaH/OgbDzm+/M9wNqt8X8TQelWx5c/gxc3dfo8ruYFMJrJrnV1HaI+Q7IKbCWcpocZT
         67oOU+PGhHN1xQIFjrSnPgqUwxPDxJz1aY5ePAT3Df0uaAOJbc8jdr6NFYQ1lG3p/+9d
         VzOncBrR/s93jaaWYaxbwG3FmNvwB0/DySfcmZJGOlVHaRTIu+Afx9Nu3KF/6mEGjIUl
         aHxAqvspu8s1KjT92EWKO/vijlxO3gcrWXstqSyPj0W2O1UTGVnIZPwlfP4ckg7IQ0Qh
         CRdA==
X-Gm-Message-State: AOAM531tnmXlrmAFucXRtLPzrkB52K5vvWQGI79d1JAukngURGOFDtNj
        ImbV+CHoDpPHhRuqdq6QoyZk+THNv2s6vi+jG2lEpnlV
X-Google-Smtp-Source: ABdhPJxvEzqt8kM3rANpKJzkjwv6wnV92niqg5dnrdpXihwyC38Sp859mU3XV3hIOfcoL/HA7jerEoZML3s7+lWv4Sk=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr9715503vsl.9.1631027397108;
 Tue, 07 Sep 2021 08:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210907145652.63362-1-bert@biot.com>
In-Reply-To: <20210907145652.63362-1-bert@biot.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Sep 2021 17:09:46 +0200
Message-ID: <CAMuHMdViJU7Na8D0n=-xrF0OOCKMArg4vzjb7q73e4xpS1EtpQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: decompress: Use /memreserve/ DTS nodes when
 validating memory
To:     Bert Vermeulen <bert@biot.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 4:57 PM Bert Vermeulen <bert@biot.com> wrote:
> If the bootloader needs the start of memory to be preserved, for example
> because it dropped the Trusted Firmware blob there, this chunk of memory
> shouldn't be used by the kernel.
>
> To avoid adding yet another SoC-specific text offset to arch/arm/Makefile,
> this patch allows for a /memreserve/ entry in the DTS to mark off the
> memory chunk instead.
>
> Signed-off-by: Bert Vermeulen <bert@biot.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
