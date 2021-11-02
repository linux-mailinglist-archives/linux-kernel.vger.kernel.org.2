Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8384F4437F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhKBVmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhKBVmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:42:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B5576109F;
        Tue,  2 Nov 2021 21:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635889207;
        bh=6QId1tCDmNcyi+jWRu55si8BIMYCJ8/u74FP7DpWxfo=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Bzku4hIlcT4z2WIrcHv1YlS/Fh6BLuZDWrAkiuspnlQAWSkjEHPrpzI6LTk9wypwm
         t9ootAqoQfLFLn4bYw1nhN9wCESuPo3vcwKPB6quUDTBykyWgfH6xwHgFj2yh08apI
         oIzrfbxylxylqkWfQQJKrurqtiYVhUUDraJPNY72mqNxsL6kPJ8TbbLb/ENGLdnh97
         vqfi9HZPt0wZq60WoIZ6UubO3+ww1l+ws4dCah5ji0jqobFRviCpBm0SeAd0eKyWYJ
         HTwshRiKgCmXy7TMN56WRVvhfvwCiu/gcddeXO9IJa0P0BKSwxU0gPG3kJTNl9uPN7
         aoThSWXmpSEjw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210920144944.162431-1-krzysztof.kozlowski@canonical.com>
References: <20210920144944.162431-1-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] dt-bindings: clock: fu740-prci: add reset-cells
From:   Stephen Boyd <sboyd@kernel.org>
To:     Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Zong Li <zong.li@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Tue, 02 Nov 2021 14:40:05 -0700
Message-ID: <163588920589.2993099.2787121696105187714@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2021-09-20 07:49:44)
> The SiFive FU740 Power Reset Clock Interrupt Controller is a reset line
> provider so add respective reset-cells property to fix:
>=20
>   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml: clock-controll=
er@10000000:
>     '#reset-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Applied to clk-next
