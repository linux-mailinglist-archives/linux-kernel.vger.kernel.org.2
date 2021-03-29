Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A03334CF29
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhC2Ldb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhC2LdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:33:16 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AEFC061574;
        Mon, 29 Mar 2021 04:33:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z8so15449975ljm.12;
        Mon, 29 Mar 2021 04:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8ATlugdUKHKEB9wJ7F1PnANsFFKdh699zUWIyxPztU=;
        b=OR8qtqRV4a+IW1FCVWOkV3na+4Y6egNU6k9igZtgw1+FyEESDCAadpQptmxXr33lUl
         UWq0gN58wQqQlXpzfRg7HKimXvXLDlzZ20sWtRqjlob23py4LwtSu2ItYZL6N2AMBMX2
         Ptgpp55oInk7d7vzmFdZjEsANdUUyUtRZVRHaDPYpw0s6YzLAX5vJWRwjlBUydgsYBOA
         5McIr34DfHjDgekpB4Wfqj6b5MkIsSBHfRdDcWvEm/ggDPR1zFtkLDN6D/2v8Dr3g0kf
         5E+k/8QbBjUYxN15NkNlbPFluyOU3mvOKi6it8VYZrl/MyQ7bwtxUtH/9xHO5vVQLhAu
         rpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8ATlugdUKHKEB9wJ7F1PnANsFFKdh699zUWIyxPztU=;
        b=p5/q3iCjfVh6aCKVAth37nTPoY8V1c70LeVhuvuHmZIvDcm0LvWA+PMrj5gYTSi2Pa
         V8jVBC2zI6D61aN+P3CZUlF4YOuVf8xYelHpUcMYpYXS31JXLtIfswUanNlAjuQjNpEW
         Fn/bwv3LnYWqNNl8vMo9yP4ooHrYhbugoWoifN5xtutoa4GtcUt085bstNnTvxw/bk2d
         Pl/GNGOU/HteQw144bfDPi2bjq7w2UiJbOKEcbE0Nhi7pohjzYI+n8J2MCTBU5ql9WUd
         Hm3t878JdZEwCBXzIb5kSLNlL+o9QrA524OceDGcc6jZhpuxryhIaV5+odHYbzcJkLf9
         AsUw==
X-Gm-Message-State: AOAM530D4lMJOaBAk8/LBlPt1ZxFinqb12FUobMr0PTYqfhWP/p7D3U+
        r7xql0EqTqn3IyyNh6tmchPp8YqRMBVMAYa2t84=
X-Google-Smtp-Source: ABdhPJzVzu5EgEK4lO1S/FQgcXTQJf0jJcXHehvP4HGvREOs1yeJjfz6iSsqWBowmWQ6ZQ4PNlLrBFKfhDHM1nakjDU=
X-Received: by 2002:a2e:6f15:: with SMTP id k21mr18083545ljc.444.1617017593652;
 Mon, 29 Mar 2021 04:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210329112819.64043-1-s.riedmueller@phytec.de> <20210329112819.64043-2-s.riedmueller@phytec.de>
In-Reply-To: <20210329112819.64043-2-s.riedmueller@phytec.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Mar 2021 08:33:02 -0300
Message-ID: <CAOMZO5DBGraT1_r8k7_-pp_w8yMR-32N8QYRkt9V88PXAcAdGw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx6: pbab01: Set USB OTG port to peripheral
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 8:28 AM Stefan Riedmueller
<s.riedmueller@phytec.de> wrote:
>
> Due to a hardware bug preventing the correct detection if the ID pin
> the USB OTG port cannot be used in otg mode. It can either be set to
> host or peripheral. Set it to peripheral so vbus is disabled by default.
>
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
