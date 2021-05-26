Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77C1391D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 19:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhEZRIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 13:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233955AbhEZRIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 13:08:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A7C7610C7;
        Wed, 26 May 2021 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622048820;
        bh=/5VcugHL+khw1Av9i1+1PVNFmsOZEl8NjLawBSDlP1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tMCAv5GB8iRm4614PMmrFM1IoCApZYYaeD/MTjCh29QUg0x4+aMhStkPw/fN5PL7a
         shV1VOqn7/6Fvcy3fzlBfEQozso+6pj1iqfUheAxHfR/foyfJQnZlA5E0EyKf7P4Ai
         hWj1brbW45r2rvlX4prHumHDE/MwgY/7sS82WCOdmurmfwqAd2uhY4dPhoaXrnV36L
         T2NPzXhXyuC0yTh3xUcBcTQr9G2HMuhmPrconfmU/rKZHDHRHKr/5VFslDm7aRfQ2+
         782yq/l+yluqhk7TWtbrkJv3FOXFpkVBYTSlKTA5inzykmphJtM17DDeqNPK4jpApx
         /c8DKtm4cr0cw==
Received: by mail-ej1-f51.google.com with SMTP id gb17so3583801ejc.8;
        Wed, 26 May 2021 10:07:00 -0700 (PDT)
X-Gm-Message-State: AOAM5321KUYZMO6ZJUh5QxXoWhXZzTUYp1hcumMIvs79WbmdiZDoRxgk
        +bKBWBV794NRlEAvGeDWnLtKjilrfE4T190ZuQ==
X-Google-Smtp-Source: ABdhPJz3Jbsd1cOqT2X7jLaJjATFBV3pu5bwrmQMpaYUSzS2CBAkIMRdaFg1XM6t6d5d2zMUOVInFjwnl57lNPU/3fw=
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr34245127ejc.108.1622048818978;
 Wed, 26 May 2021 10:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210518232858.1535403-1-robh@kernel.org> <20210518232858.1535403-3-robh@kernel.org>
 <YK1rzHSXC7rNpCpC@piout.net>
In-Reply-To: <YK1rzHSXC7rNpCpC@piout.net>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 May 2021 12:06:47 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ws5RYcz3AFuc2JgDHx=VL6g5U_HAv8Vwa5nZh_PyO_g@mail.gmail.com>
Message-ID: <CAL_Jsq+ws5RYcz3AFuc2JgDHx=VL6g5U_HAv8Vwa5nZh_PyO_g@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: rtc: nxp,pcf8563: Convert to DT schema
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 4:27 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 18/05/2021 18:28:54-0500, Rob Herring wrote:
> > Convert the Philips PCF8563/Epson RTC8564 binding to DT schema format.
> >
> > Add 'interrupts' as this device has an interrupt which was not
> > documented, but in use.
> >
>
> It also supports start-year from rtc.yaml.

And wakeup-source. I've added both.

Rob
