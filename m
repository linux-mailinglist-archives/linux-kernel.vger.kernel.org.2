Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2245840C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 15:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhKUOY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 09:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhKUOYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 09:24:25 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C8DC061574;
        Sun, 21 Nov 2021 06:21:20 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id az37so31191083uab.13;
        Sun, 21 Nov 2021 06:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwuwEheueqJDq8ge9CRsITwWPfBpC9vA8U9g8O5Iw/c=;
        b=P5GXPjb/NbvN7BQjLiP3quKUmWVf2UHwuNClrBYZVoq5gBIXSLVZrL0ZBoM1HOfRwV
         j2wjlJZgVAyeR0b+8CkftbF8yz40eY8S9oZ0WGHZECZ4FHFIiF0bRLV1SthWK/ffNCv7
         zNK6OtOa4ilpi36Q2K5KEpz6n4IwscF7ZDOktfAJSS6x3BOuCX1L+GO7JUVonXo0HFJB
         PH/yFSvoh6URbFUj39DIoEKvY+dMh+zBW7yR5R93WHw92PfBlGkYTGtqhBun9nqzNkZ/
         5mn7N7aPntWwMxwoDSt9UiNEL7sFw3pR+rdTCSVtFiIdRFSQgmquvoTbV18EkEh5aH+B
         sP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwuwEheueqJDq8ge9CRsITwWPfBpC9vA8U9g8O5Iw/c=;
        b=7ZohHz+Fknhe8bds9W/RNzbIsV7xXgR2NZqdWFE6FSaYpCeTp4kOyZQtajOWPPZAhT
         L+i92Cza0T/hL9elqp+zGx9tEvnmen6h2a1EQ1+tQ+wR6aisdyKaHTghf3x57/rUnCh5
         IORNalGF2DjGvW0n9imWuEkjzOSmu8qH0gErhRTH/nmGIzGOtCtr1jl8h600WvSnXU/v
         ebrhC/qBnpM2BAdJGdXqWUEHctm7PBU4oReuQ7JHSAWBR5dDFARGKj8p7jFKCr0F4qrH
         yK8KIYinC8a3s0TJvkkVbA7CgNyOotmM7spxxNXdlunZMJXyuPAx4OkSOJQ+73cbjugf
         gdGw==
X-Gm-Message-State: AOAM532lH4+R3k8j7PAJRZ5n9SYOeZp5YcmVV+bb+uf14YyJyyNKXQ5u
        3hGfw/hl3PpIHBHOpf8dr4S+8tHq+vyeYXCkFuM=
X-Google-Smtp-Source: ABdhPJyhOT6OMErKMRcLfgo4DYC3ludPCveDgR+Oi9vgSf5my5Hatp5pjXY5SgvN8WEDYWU2K7aIi63SromCnsDSsrY=
X-Received: by 2002:a67:f988:: with SMTP id b8mr116469116vsq.51.1637504479247;
 Sun, 21 Nov 2021 06:21:19 -0800 (PST)
MIME-Version: 1.0
References: <20211104161804.587250-1-aford173@gmail.com> <CAJ+vNU2jcWyCm3UyiOnvknS0t+mSdpaB+CgGWYO3jxXTa3LhRA@mail.gmail.com>
 <CAHCN7xJrnZMQgXVMJg7MZdFMWyesf6Ph7HnfMH7-9bm1qODHFw@mail.gmail.com>
 <CAJ+vNU32GXtbKWGQXoE7pkXU8FcKh+HQJJduwRbRJ0tC-d6GoA@mail.gmail.com>
 <CAHCN7xLAm21zUJQ8s4s--+ygmeVY0qyo0WSLp7ZM9bT9R3sjxw@mail.gmail.com>
 <CAOMZO5Am4P17mOXWrPs0ns9AwOXM_ZpBdzbYTYJfv_48Ea=BHg@mail.gmail.com> <CAHCN7xLzR5LqqydC7uydsXQPFVn=nyqKD8ZEH3EjcPuwQky5WA@mail.gmail.com>
In-Reply-To: <CAHCN7xLzR5LqqydC7uydsXQPFVn=nyqKD8ZEH3EjcPuwQky5WA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 21 Nov 2021 11:21:08 -0300
Message-ID: <CAOMZO5AnXDV3jdR6hP_+uqyss4KftzjahcrGq1XA37nGsfQedw@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
To:     Adam Ford <aford173@gmail.com>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Sun, Nov 21, 2021 at 11:17 AM Adam Ford <aford173@gmail.com> wrote:

> I am using https://source.codeaurora.org/external/imx/imx-atf/log/?h=lf_v2.4
>
> Since the driver sending SMCC commands to ATF isn't doing that, I
> assume it's safe to use the linux power-domain drivers with the ATF
> from NXP's kernel.
>
> If you can point me to the repo you think I should be using, I'll give it a try.

Do you know if the mainline TF-A repo v2.5 works too?
https://github.com/ARM-software/arm-trusted-firmware/tree/v2.5

Thanks
