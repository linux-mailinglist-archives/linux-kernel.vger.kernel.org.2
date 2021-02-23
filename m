Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49373231B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhBWT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhBWT52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:57:28 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED6C061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 11:56:47 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id p186so17804852ybg.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 11:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8L5CVjBzjyYhS2iyV9NiMH1p1oKX7CjOOgjtA1md4M=;
        b=FP5owbWfXj2W3qh8lbdzR0ZVhu7RNM5xDBKb1dkTw3ts2215y2B1jOQfqdRFcNbcxu
         Vm9EzVmpdOVzinnbr0avHOXUFDXjVFQPWEj0fe6XuO7r/1h54QWZk7Nz+VRURfAndkg2
         9UtLvBaR1N1cz/kRD+bgZMqvPW2ffochIkSQpQK1zKxNFzgRXugbNxWvLLvZlNltj1tn
         OxWtA6frs1u/Dz5vnp9VZ14Y+0jLv1Xfi49n1laBX4xkJQI+zaH/N1P7P3NMUZumwXjV
         /wTPvDQW/lhGi5zqFa/Qm5B6uxsNoK3xSgYvb1Hl9TNBaEBwawRG3jLvluG4rno6MASQ
         Zgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8L5CVjBzjyYhS2iyV9NiMH1p1oKX7CjOOgjtA1md4M=;
        b=pYAHk35WniLgXbMQZ3xJ0m1ABJb7qedJuT9HA6xj0vH/36CCiio5vZSqzeW5UBolW9
         TA5JG1xaGd4qyIZ4KNYMxogupvdT2mn1f8cAfeFmvyACcEBpRw46PGTOQz0GjA4NpT7a
         QLVAQtEjRX1gc8DNuFIsIaKWLRy8POTadu529KsyUqvOMkAeLiUxcJ+Hl8f4KFj6mp5O
         QZiM7FKoUePKdlqHJZeOvF2ObKzhO4CajxMEA+h0AtmCjLSdtFdmkmFVAWvUlRcdzYHQ
         ci+ahEISMcxgfGLx1LmxGD4FOZLYSJ7RDnUroVGO1f0VYhFWjw4mOkz1qrQwy/DAWPty
         Lq9w==
X-Gm-Message-State: AOAM53141FpmOagJ7/Q45Yq4UopO3EU9+8N6cX5ws6O5oE0RhBi3ffr7
        KdH2qvKCDwk/oUdUWK8aojrfQ8+FammKy79FPv7PMQ8SNoU=
X-Google-Smtp-Source: ABdhPJx99grxzml+Z6ONJ7LbEvX4S6xXJxvpi3vEbMZQioMa5oec9vgRtWbwFYfzk6yC95fMZ4aGWuXP9bYpLmVmSLU=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr39009236ybl.310.1614110206531;
 Tue, 23 Feb 2021 11:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20210217235130.1744843-1-saravanak@google.com> <CAMuHMdUo_2WPxDeckhF3nt2+p5eG=mpP84a_fWFZnXyeohqo0g@mail.gmail.com>
In-Reply-To: <CAMuHMdUo_2WPxDeckhF3nt2+p5eG=mpP84a_fWFZnXyeohqo0g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 23 Feb 2021 11:56:10 -0800
Message-ID: <CAGETcx_BJhR353sbMu2syiwMoep=-oJNAe-GAB_-yAPXGfihKw@mail.gmail.com>
Subject: Re: [PATCH] driver core: Avoid pointless deferred probe attempts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 2:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Thu, Feb 18, 2021 at 12:51 AM Saravana Kannan <saravanak@google.com> wrote:
> > There's no point in adding a device to the deferred probe list if we
> > know for sure that it doesn't have a matching driver. So, check if a
> > device can match with a driver before adding it to the deferred probe
> > list.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch!
>
> > ---
> > Geert,
> >
> > Can you give this a shot for your I2C DMA issue with fw_devlink=on?
>
> Yes, this makes I2C use DMA again on Salvator-XS during kernel boot-up.

Thanks for testing Geert!

> I haven't run any more elaborate tests on other platforms.

Yeah, this change should only go into 5.13 after it gets tested as
part of driver-core-next.

-Saravana
