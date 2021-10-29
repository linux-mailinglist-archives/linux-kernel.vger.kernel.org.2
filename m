Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B82943F4CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 04:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhJ2CKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 22:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231348AbhJ2CKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 22:10:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68FE860F02;
        Fri, 29 Oct 2021 02:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635473269;
        bh=UXO2jb8+ezJ2SMUULWwSCcFcl++e/vE5BJFAyMyQ2Aw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ThnLp6yx0xW5I7VY5LlJFd3PKGHYRZe0BWw/1tIAdjTlcCUCE6Y0GulHHnJA9tIv6
         GCkUSqgt5IaEXV3rvs8N+DmrntWvzc4VpDgVe0RsQxfYDUUGrRZ4L6nZTn5LqoINqJ
         hLUM+bligfS1MqHMTG/D5UxOp/gsRnPAZmw5f3Xw+jiihAsmPUXG9GtJI/srMZlaQ2
         MKcrsYhBUwdYZwVArqqOsR1zCpCwBKduCHlXvtG4u73fuGmfTtPhiSTTinR8wv6YCP
         Vul0eTur+0hekddrdVoYjLjdZTvCyY5VkyMTGKdgQIPf7q+L2oenjpI5ugYK42M9yh
         QP8z2+gbUVE3A==
Received: by mail-ed1-f45.google.com with SMTP id z20so33150791edc.13;
        Thu, 28 Oct 2021 19:07:49 -0700 (PDT)
X-Gm-Message-State: AOAM531iLJqFYmPxFbPuafEKMEkiI3sY/6XinOTk4wLwcGdy74Gs2llf
        YUWLRfPdXGVE0yxf0/BZU/gI/v7Hdc+fJ0QVvQ==
X-Google-Smtp-Source: ABdhPJx/ocNQD9wn9e7w/52aPfNEKWBmdZr077TMGcH/Bt9fSDjCzMLgvaDlX++E853RZ9o/CcAYDsPVn4BZRONPi7Q=
X-Received: by 2002:a05:6402:206b:: with SMTP id bd11mr11428236edb.145.1635473267940;
 Thu, 28 Oct 2021 19:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211029005802.2047081-1-frowand.list@gmail.com>
In-Reply-To: <20211029005802.2047081-1-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Oct 2021 21:07:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJujq0K9tF+m3qQ5GhC-yo7-vj9HRhF69UmrWA7tZv7DA@mail.gmail.com>
Message-ID: <CAL_JsqJujq0K9tF+m3qQ5GhC-yo7-vj9HRhF69UmrWA7tZv7DA@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: fix dts for interrupt-map provider
 build warning
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 7:58 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Fix kernel build warning:
> drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider
>
> A recently implemented dtc compiler warning reported the dts problem.
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest-data/tests-interrupts.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
> index 9b60a549f502..8c2b91b998aa 100644
> --- a/drivers/of/unittest-data/tests-interrupts.dtsi
> +++ b/drivers/of/unittest-data/tests-interrupts.dtsi
> @@ -31,6 +31,7 @@ test_intmap0: intmap0 {
>
>                         test_intmap1: intmap1 {
>                                 #interrupt-cells = <2>;
> +                               #address-cells = <1>;

Notice that we have 2 nodes with interrupt-map here. One has
'#address-cells' and one doesn't. Why? Because we need to test that
the code can handle both cases.

The dtc warnings are more what should 'new' users do. I don't know
what DTs don't have #address-cells, but my guess is ancient ones.

Rob
