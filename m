Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91007389264
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354495AbhESPUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354419AbhESPUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:20:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F9516135A;
        Wed, 19 May 2021 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621437558;
        bh=ek7ca1h69ksdnof3kTbnE34ns9CTK6Kd0/3Q9dV7oCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=caGHyOlML+2gJz5Fw3FWG2LVBgVVPhdq+fQJO8AIVBzHI9CeoxCxtzQnbwDzRVtCX
         H1+0+aeNGnPqNt1eZ9cci+AzZv0P+jxmy0Yk5wjH+3/2nyKk+BfoaWaIkh1bYa6F6s
         g6ghXC8e9UXw5IjlGtjZVmzy5q/UdrS0gOP+s6qsd/8Avjq9o5kcyHzjgsym9cwrzD
         +j4NRhxg0pp58AGt15DGVqjhPa2eT/8Tr99gKcffkOzevJ29nXjOQ6FMRX36x/qbyS
         jiOY4O5Q5sdf9lgIopIWVj8h2fUHCcEfT7SNYvIKGLxe4j8EmxZLVPfvDOttstD4qr
         /KbpvzrYyhkew==
Received: by mail-ej1-f51.google.com with SMTP id u21so20462904ejo.13;
        Wed, 19 May 2021 08:19:17 -0700 (PDT)
X-Gm-Message-State: AOAM533bSK4sxN5vgGZBSk8qVYe7deyEMjFnVvOeN7cJsbyZEHbKBslo
        t+1xqIrWRPGW4r4N1PazhIhtETbjqc0hEsGtxQ==
X-Google-Smtp-Source: ABdhPJzEPDsTeXH9wfUOGmX1QdjLMS8b6BNkCsHTvdukqPqic12xvjdutFYNRM0Nm5ZWgqy3SvkT0ZR9ivjct617yrU=
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr2971920ejc.108.1621437556674;
 Wed, 19 May 2021 08:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210518165658.12764-1-jbx6244@gmail.com> <20210518165658.12764-2-jbx6244@gmail.com>
In-Reply-To: <20210518165658.12764-2-jbx6244@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 19 May 2021 10:19:05 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Re978VJ8-2FV0zM6A0dS-jmsR8hUAV+gQWXgW7BoJtg@mail.gmail.com>
Message-ID: <CAL_Jsq+Re978VJ8-2FV0zM6A0dS-jmsR8hUAV+gQWXgW7BoJtg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: phy: convert rockchip-usb-phy.txt to YAML
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     "heiko@sntech.de" <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:57 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Current dts files with Rockchip 'usbphy' nodes are manually verified.
> In order to automate this process rockchip-usb-phy.txt has to be
> converted to YAML.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>
> Changed V6
>   remove some #phy-cells
> ---
>  .../devicetree/bindings/phy/rockchip-usb-phy.txt   | 52 --------------
>  .../devicetree/bindings/phy/rockchip-usb-phy.yaml  | 81 ++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
