Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527CE452E77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhKPJ4g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Nov 2021 04:56:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48172 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233603AbhKPJ4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:56:31 -0500
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mmv9b-0003E0-Fd; Tue, 16 Nov 2021 10:53:27 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Yash Shah <yash.shah@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Cc:     Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Expose the FU740 core supply regulator.
Date:   Tue, 16 Nov 2021 10:53:26 +0100
Message-ID: <2266648.AD6qrfpaa2@diego>
In-Reply-To: <0879c5b0c72b9bf6bf71f880def166f8804f41c7.1637023980.git.plr.vincent@gmail.com>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com> <0879c5b0c72b9bf6bf71f880def166f8804f41c7.1637023980.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Am Dienstag, 16. November 2021, 01:52:59 CET schrieb Vincent Pelletier:
> Provides monitoring of core voltage and current:
> tps544b20-i2c-0-1e
> Adapter: i2c-ocores
> vout1:       906.00 mV
> temp1:        -40.0°C  (high = +125.0°C, crit = +150.0°C)
> iout1:         5.06 A  (max = +20.00 A, crit max = +26.00 A)
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> 
> --
> Note for review: this patch has one warning from checkpatch.pl:
>   WARNING: DT compatible string "tps544b20" appears un-documented -- check ./Documentation/devicetree/bindings/
>   #32: FILE: arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts:55:
>   +               compatible = "tps544b20";
> This chip is handled by the existing pmbus module, and there is indeed no
> matching entry in Documentation/devicetree/bindings/hwmon/pmbus. I am not
> especially knowledgeable about this chip, I only know it is used by this
> board, so I am not sure I can do the best job in putting such a file
> together.
> If needed I can git it a try.

Devicetree bindings are supposed to be stable into the future, so an actually
reviewed binding is quite necessary ;-) .

In the case of your tps544b20 it should also be pretty easy to do, as

	Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml

is probably a pretty good match to what you need in terms of Yaml notation.
Just need to replace the naming in your copy and drop in the correct
description from

	https://www.ti.com/lit/ds/symlink/tps544b20.pdf?ts=1637055780278

and you have a working binding.

Then just add another patch to your series that mimics

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a36e38d8b0fbb92609e837a67f919202ec7ec51

and include the relevant maintainers that scripts/get_maintainer.pl will
give you, and you're all set :-)


> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 270360b258b7..e327831d0d48 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -51,6 +51,11 @@ &uart1 {
>  &i2c0 {
>  	status = "okay";
>  
> +	tps544b20@1e {
> +		compatible = "tps544b20";

This should definitly be
		compatible = "ti,tps544b20";

i.e. include the ti vendor-prefix. The i2c-core will automatically
remove this when matching against the i2c devices.

Heiko


> +		reg = <0x1e>;
> +	};
> +
>  	temperature-sensor@4c {
>  		compatible = "ti,tmp451";
>  		reg = <0x4c>;
> 




