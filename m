Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686F13ACF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhFRPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhFRPgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:36:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069FAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:34:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ji1so10422959ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KpCm5HqaoEkPNbQiojzQ8l9+3E69oFCh0+FoMDmFeh4=;
        b=MactzmFW0XABE7AExi4kBxs63YPf+yunoMYq+qM5FFhLpVHUw8gEmJj6IbOkWDBQdr
         2VIvZVk9Vy+CpY2TSVx8lgs6J7EfMTwAMgPhfbb7a6WDgp/vcPLOfqO9XgLoj6/0lVVV
         g9W3Py8MvGtm4/WQCZhnGkmSyTwWbpAXGj5Uk1iJv7cgPzOrJdzf+KpAd3BZmpI47MVT
         WHECmkvnXIAdpWVPwEKOVW44ajl+OVN71VcQgC6I2WKptBJckf/xlVnSpAVS2RViTOP7
         0GpR64HTa73N6kn85zp+zPrCOYS1XTomSp8n6VsaFBN/Z6Eukzfn0zByARVHmtgwhMs5
         fkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KpCm5HqaoEkPNbQiojzQ8l9+3E69oFCh0+FoMDmFeh4=;
        b=eDoHnq0xnqfEXWNnkmQJv7ZI3cTwVoq+JYHJKNu4Vj50jvWtglkiazHRy3UDNq3Esa
         7Yi89nF+kKqdABvX+xQgiFYwqdWrVejh5lNkKGM/aLKGDE2+ggnNf1ex3T3QsiyuNszV
         ZXAnNfSOStIEPBtl4oVtRqE4kpTr5pZ6H6AKupz7/pGwsDfZ8sTV4x0F5SuBnvDEWnOn
         JY4ltYACQUM/OTXdQZw/Pc0+dnCW117VkM3cKJxOlJsk9GUpEThxbPUeRSHRvg8/nmRV
         CZ6DWohRax8+0GIXY73m1FeCVUmGC4AkYXu1hxO+Yz08OD3604ndQ/RjRkDlnzGW8VPS
         QE8A==
X-Gm-Message-State: AOAM533CKTvEkuUEx0+LEa73VDGRRtGL3N/xQG2+FnTMlA27bbWUOHwg
        xbTLq4qHGr6q/hPND7WBCbheLQM3o9BaAD+474s=
X-Google-Smtp-Source: ABdhPJxUm2je64XwNMhTthmRUU5/BtOXPNJD5uuJE0r7hQUcZ7mgQZmOIQ3HW3fBRtxL7fQKlfTKElduF5w2vqTV9hM=
X-Received: by 2002:a17:906:5407:: with SMTP id q7mr11951545ejo.158.1624030449498;
 Fri, 18 Jun 2021 08:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-6-linux.amoon@gmail.com>
 <CAFBinCD1dJ=oqjzkCrAdMMdxF8W1Aujcwo20vJ1oLv=mtn5TZw@mail.gmail.com>
In-Reply-To: <CAFBinCD1dJ=oqjzkCrAdMMdxF8W1Aujcwo20vJ1oLv=mtn5TZw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 18 Jun 2021 21:03:57 +0530
Message-ID: <CANAwSgT9cdk5eWsDnpJ5TZt2i1hCdiW3BvXDQp4dN5BgtGZM=w@mail.gmail.com>
Subject: Re: [RFCv1 5/8] phy: amlogic: meson8b-usb2: Reorder phy poweroff
 callback function
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Fri, 18 Jun 2021 at 03:47, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Thu, Jun 17, 2021 at 9:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Move the phy_meson8b_usb2_power_off fundtion to avoid compilation
> > error.
> >
> > drivers/phy/amlogic/phy-meson8b-usb2.c:247:3: error:
> >         implicit declaration of function 'phy_meson8b_usb2_power_off';
> you have introduced this warning in patch #4 of this series
>
>

Oops, I simply needed a forward declaration of the function to resolve
the issue.

> Best regards,
> Martin

Thanks


-Anand
