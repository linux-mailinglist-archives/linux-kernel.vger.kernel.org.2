Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21577324327
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhBXR0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhBXR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:26:44 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13AC061574;
        Wed, 24 Feb 2021 09:26:03 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e2so2425355ilu.0;
        Wed, 24 Feb 2021 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=e80EQh7hVv+4c3U/7UtIpUX2KwAr6+TQZag1c7eN4zA=;
        b=FvzQ+JB179Yf31qs/ZBHBls9pKBNan7wR8sb25MswGs7Wm+oO7nHby+0aRWb7qCT5l
         fhbUGYoGXNym+eIGN2gRpVHWkXTgTsicMtq2jH8llTElVxXfLnueIpJGVSp7uQbi3QNd
         2cliS6W9SvnfRAqa7BdfkijMuXOekcd9msQR2xmR/EdXYvbfm9uWsxX22/mzKrGzAkDp
         XxgOmhOz5SrvED1P8JRQgkmQp3JKzfaBAUiYsIEU2F5dtcR1piL0Vo9YDfcR1NPDeTt2
         mswfW3tMc/TU5A/JZY+1jQ9lfFj7hmrn5TBt7rxYpn91JP09Gu9qD6/VokdaEKA6Fzg0
         sg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=e80EQh7hVv+4c3U/7UtIpUX2KwAr6+TQZag1c7eN4zA=;
        b=MiWX7EcG0CRta9Rc7t9vzEm1Dn4DKc4d3mbbqJzcL87P3S5pxxLrAMCPhyHwfrd5mF
         qtnMSjRSMzfnPVwAmyT19YDFb3VvA2qNQBpSEzxMTzmqpwhAgsH0ztLE9tNh1d0dkADU
         +qESIZKINEfo3brWmKafYoR5zKHwLW6C4V060wzTCvBLoWkDWNiTaG63LyFkwtlLm/zY
         Y9QnUIdh9g026pXBn4HnqFm3tkr1sLlHtvEMVfQnEtT2kGWTuwrbm2x/JFAu51jcm7/2
         fEplnv0JwOLKw7YXliPZmPEw51VGGhN8FZq4W8ihngQfYTDz5U12IKSZhGkLYAITIF/7
         dXRQ==
X-Gm-Message-State: AOAM532cWy69Gb8A3olNT7TxGba3jxPG5wY9TF/So23uT7NXCQOUdpw1
        g13Q9oZCvvlvyIoGxuVsekeZ7gRbDrhOovDTcxU=
X-Google-Smtp-Source: ABdhPJyGDBXg6O3yHls+OEsO/pBKYQ2vawP6waasNSPBgPD5qbUdhgotxtNVAugF8AdmfjvH056/5KyEKZpQM51S/OM=
X-Received: by 2002:a92:c145:: with SMTP id b5mr19129663ilh.186.1614187561973;
 Wed, 24 Feb 2021 09:26:01 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
In-Reply-To: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 24 Feb 2021 18:25:51 +0100
Message-ID: <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 2:44 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi Mathias,
>
> I am here on Linux-v5.11-10201-gc03c21ba6f4e.
>
> I see a lot xhci-resets in my dmesg-log:
>
> root# LC_ALL=C dmesg -T | grep 'usb 4-1: reset SuperSpeed Gen 1 USB
> device number 2 using xhci_hcd' | wc -l
> 75
>
> This is what I have:
>
> root# lsusb -s 004:001
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>
> root# lsusb -s 004:002
> Bus 004 Device 002: ID 174c:55aa ASMedia Technology Inc. ASM1051E SATA
> 6Gb/s bridge, ASM1053E SATA 6Gb/s bridge, ASM1153 SATA 3Gb/s bridge,
> ASM1153E SATA 6Gb/s bridge
>
> My external USB 3.0 HDD contains the partition with my Debian-system
> and is attached to the above xhci bus/device.
>
> Can you enlighten what this means?
> Is this a known issue?
> Is there a fix around?
>
> BTW, in which Git tree is the xhci development happening?
> Can you point me to it?
>
> I am attaching my linux-config and full dmesg-log.
>
> Also I have attached outputs of:
>
> $ sudo lsusb -vvv -d 1d6b:0003
> $ sudo lsusb -vvv -d 174c:55aa
>
> If you need further information, please let me know.
>
> Thanks.
>

Looks like that xhci-reset happens here every 10min.

- Sedat -
