Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8B0430732
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 10:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245063AbhJQI3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 04:29:21 -0400
Received: from mail-m963.mail.126.com ([123.126.96.3]:50978 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245032AbhJQI3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 04:29:16 -0400
X-Greylist: delayed 1870 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Oct 2021 04:29:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Message-ID:Subject:From:Date:MIME-Version; bh=kfvAx
        b6atL/vWwpV/RLDdStnL8qUxjQfmKzvVV1svv0=; b=a6WZOqw4G5xuXe+lnsjqw
        1tv72V3TVFYyiXayQp40lpcELhhLTFG69o+Hn+J2zk+Hvz2D0XtBhEwcpIXF+Lo+
        ZOdnVZ98mxj+Z/v+oomb5gG69+Qi3HjIdmKktDxJ6hc0QWdO6KsEOGnG8TJbUHRg
        020vdYf0T1kAst/lKAGaxM=
Received: from [127.0.0.1] (unknown [153.99.123.184])
        by smtp8 (Coremail) with SMTP id NORpCgBnbrK+1mthlSZQAQ--.27969S2;
        Sun, 17 Oct 2021 15:54:40 +0800 (CST)
Message-ID: <2cca0c29a56fd8be0dc9b25f68f5c308484d093b.camel@126.com>
Subject: Re: [PATCH 1/1] dt-bindings: reg-io-width for SiFive CLINT
From:   Xiang W <wxjstz@126.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Guo Ren <guoren@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        opensbi@lists.infradead.org
Date:   Sun, 17 Oct 2021 15:54:38 +0800
In-Reply-To: <20211015100941.17621-1-heinrich.schuchardt@canonical.com>
References: <20211015100941.17621-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBnbrK+1mthlSZQAQ--.27969S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyDGr15Ar18Wr4ftFWUJwb_yoW8CrW7pa
        yxCFnFga1Iga4xWayxXa1kCrW5XrWkJw4293WDt347Gr4DWa4FqayagrnrX3W7A3Wv9FZF
        qa409r15Ga12vr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4yIbUUUUU=
X-Originating-IP: [153.99.123.184]
X-CM-SenderInfo: pz0m23b26rjloofrz/1tbiIQAvOlpECkDIvgAAsW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021-10-15星期五的 12:09 +0200，Heinrich Schuchardt写道：
> The CLINT in the T-HEAD 9xx processors do not support 64bit mmio
> access to
> the MTIMER device. The current schema does not allow to specify this.
> 
> OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to
> indicate the
> restriction. Samuael Holland suggested in
> lib: utils/timer: Use standard property to specify 32-bit I/O
> https://github.com/smaeul/opensbi/commit/b95e9cf7cf93b0af16fc89204378bc59ff30008e
> to use "reg-io-width = <4>;" as the reg-io-width property is
> generally used
> in the devicetree schema for such a condition.
> 
> A release candidate of the ACLINT specification is available at
> https://github.com/riscv/riscv-aclint/releases
> 
> Add reg-io-width as optional property to the SiFive Core Local
> Interruptor.
> 
> Signed-off-by: Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 7
> +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index a35952f48742..266012d887b5 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -41,6 +41,13 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  reg-io-width:
> +    description: |
> +      Some CLINT implementations, e.g. on the T-HEAD 9xx, only
> support
> +      32bit access for MTIMER.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    const: 4
> +
>    interrupts-extended:
>      minItems: 1
>  
I think we can move has_64bit_mmio to fdt_match->data.This way we no
longer rely on 'clint, has-no-64bit-mmio' or 'reg-io-width'

Regards,
Xiang W


