Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C523FA6B0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 18:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhH1QIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhH1QH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 12:07:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D79C061756;
        Sat, 28 Aug 2021 09:07:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a25so20763844ejv.6;
        Sat, 28 Aug 2021 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LL6/XDkELtJGzj7bv+EahXfdLznXO7JwuHps8bbcfhg=;
        b=IxCiQofbwWRdmlbWjkVYx9X0EwfA39yCRnGNeY1wQV8OrMMlSQWxSls8SpJMz++KMN
         qXEBGA4rb0o4u786EA2smvODJVR/pu2m2Au85UJFLjaA9aedW+LGw+1DZiU2bT2pb2XA
         R8iSXn/xB5WrENK+gXk2EfZTYPq3CZInmY18qzufbFgrOvw7NOa5wWIVKgsnX+gfYPgp
         VKXeZfubEYmLnF6CEVopa/vYmHqVOilZuXIfInX8N2S1BZkmqOE4cd+dSmWV4sdhJeUR
         K4f3we13o6+kHoJleAleDR3KNs3gLhTmFxmhzlJ8pIowJqL53kq5azuBv0pwWdt2y3ps
         d9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LL6/XDkELtJGzj7bv+EahXfdLznXO7JwuHps8bbcfhg=;
        b=OHsVHvVw4Zwwz64FPl3b0PTjCK5a8Ve7pQlxjKiudQ/37SASxfyWUdYPpVjaX7+tnt
         jbyrfumHQbihxkvigy4n7+nIGijhmE6T6a4Scq6dcqkrnZ9N+95HnklqZk0RdgpKKx6o
         fNQyseUH6pCk++rC1LwSR6WKeRkaRWumFFFH1aVOSHRVTuRi71/h3racC7aokQGVImxD
         AOo2iTa6FJtd8jGsOruFkRIsGq9H6y1nMK5deLlEvfKx7Z+IebnJqfXZqw+vuowq2EK1
         pC7l2gH6jfxMvoacI8nsEmRvSetKEz2jZYuvDiQXOfDJnW7wAy5GEAiyTebxfXpnSVFZ
         U1MA==
X-Gm-Message-State: AOAM531tL8ECXHWFjqc2LH61GIcANGxbOZJYyfqjT4mbvEYflS84kpez
        raaQULmyTws6ZAHJBIR4u/Dyo6pwdjlht8/zHGE=
X-Google-Smtp-Source: ABdhPJyPZVzHL76lGJOroGS4GEkuoeintMbGC3iDT8wzVLyfCWlNhiw7RFWxKmQZ7hYxPdW7PTXctCG+cmMAPDPpHeM=
X-Received: by 2002:a17:906:369a:: with SMTP id a26mr15801598ejc.539.1630166826553;
 Sat, 28 Aug 2021 09:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210817041548.1276-1-linux.amoon@gmail.com> <20210817041548.1276-5-linux.amoon@gmail.com>
In-Reply-To: <20210817041548.1276-5-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 28 Aug 2021 18:06:55 +0200
Message-ID: <CAFBinCDDASbbwBWdPnzq4352yepamD-ziG09Ki=BvjZ9xMLXdQ@mail.gmail.com>
Subject: Re: [PATCHv3 4/6] arm64: dts: amlogic: odroidc2: use vbus-supply for
 power source for usb nodes
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Tue, Aug 17, 2021 at 6:18 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Use vbus-supply instead of phy-supply as power source for dwc2
> nodes. Drop vbus-supply for usb0 node, as it will handle later.
This is more of a question than a review comment:
Do you think that the USB power setup on Odroid-C1 and Odroid-C2 is
different or the same?
On Odroid-C1 we know that only the PWREN signal which goes to the
Micro-USB connector is configurable while VBUS for the USB host ports
is always enabled.

> Fixes: e841ec956e53 ("ARM64: dts: meson-gxbb-odroidc2:
>        fix usb1 power supply")
>
most Linux commits which I have seen don't use a blank line here
Also I think it's recommended not to break the "Fixes" tag into
multiple lines, even if the text is long
see [0] for example


Best regards,
Martin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=425bec0032f59eeee12520085cd054fac09cc66e
