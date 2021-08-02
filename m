Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3F3DD401
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhHBKkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhHBKkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:40:18 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21888C0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 03:40:09 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id m11so11299954qtx.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tu9oYeOBswUb031Yjp53w6z/8TnC/wbddAHGRPP+IEw=;
        b=J/+SDKEj8GHiNxWrghg4YbRnMgIBMIW/K400NCSdX819DXPsuo3psqtXqWtQKdmPFt
         Qltvp8EL5VFYapBitgCb54TiKhy4NOcgF4IPOK81OJfWdPKOJyXAHFv+rZMOmxVNRBnw
         2BF2uQh7vyLNb5N8v4a3MbnF0hlMH38kGcSpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tu9oYeOBswUb031Yjp53w6z/8TnC/wbddAHGRPP+IEw=;
        b=uktmVXC1gQp+VYSqHunNB0PJY7rwtp5ItfmUeBivwinEgwOdNZXfCKs7wzyW2z/Fj0
         JeBB64MUKHLV1IQt4YKwlbf3AOC+iWFxeczqx/2AGDOFUWAqz3WcXwhTxBHf/PUNFIk1
         epvCRvJnXjfrQHlxkW1G0MlMc95iosgTuWfk4yoq0F4xMkcyM84UGaGXGpVO16okt4jg
         vFzoOwAb9rqmL52M3i6qQzHshkwGu94OlXDHU7Rdr9JqqYIL1AZU0KkstNKaR2boLjHK
         iPxNp8FRnToINVPlHbjTJuToC63ZaM9zMtiupybEqYlF6NTMrPI+uauVPqhOL2TyNpiU
         URXA==
X-Gm-Message-State: AOAM530XCBvyU+2hGRcZFruUvJBLBL0uCYWNdesxrwjdASF4s+y8V/Ir
        P2oHZ0zzo8Pacpu2dc4NfEdoRGxtWMB6tggwzSqMGQ==
X-Google-Smtp-Source: ABdhPJyn3Xnoa1W0+VeBNy0IvOb6d4QL/35IsVcJxMUzim3ZLjugnsv+IftrUfL+qImfxD3tgfBm2vsw+9jR82/T28Y=
X-Received: by 2002:ac8:4f11:: with SMTP id b17mr13431338qte.33.1627900808259;
 Mon, 02 Aug 2021 03:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210801160921.233081-1-romain.perier@gmail.com> <20210801160921.233081-4-romain.perier@gmail.com>
In-Reply-To: <20210801160921.233081-4-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 2 Aug 2021 19:39:57 +0900
Message-ID: <CAFr9PXmqiu=toGf9DjoH8XMbPaiXaWLV=GsmR7OCkkqix5tRvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: mstar: Add rtc device node
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Mon, 2 Aug 2021 at 01:09, Romain Perier <romain.perier@gmail.com> wrote:
> +++ b/arch/arm/boot/dts/mstar-v7.dtsi
> @@ -116,6 +116,13 @@ watchdog@6000 {
>                                 clocks = <&xtal_div2>;
>                         };
>
> +                       rtc@2400 {

I think the rtc should be before the watchdog as the address is lower.
I think maybe this got flipped around during cherry-picking.
I can flip it around when I pull this into an mstar dts for 5.15
branch so you don't need to fix it and send a v3 assuming everything
else is ok.

Thanks,

Daniel
