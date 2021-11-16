Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3FC453007
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhKPLQf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Nov 2021 06:16:35 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49022 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234742AbhKPLQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:16:33 -0500
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mmwOu-0003c8-H6; Tue, 16 Nov 2021 12:13:20 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Yash Shah <yash.shah@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Expose the FU740 core supply regulator.
Date:   Tue, 16 Nov 2021 12:13:18 +0100
Message-ID: <1856369.5VkklvvnQl@diego>
In-Reply-To: <202f0fd8-1208-b17d-5ee5-e776e45cb065@canonical.com>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com> <2266648.AD6qrfpaa2@diego> <202f0fd8-1208-b17d-5ee5-e776e45cb065@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. November 2021, 12:08:01 CET schrieb Krzysztof Kozlowski:
> On 16/11/2021 10:53, Heiko Stübner wrote:
> > Hi Vincent,
> > 
> > Am Dienstag, 16. November 2021, 01:52:59 CET schrieb Vincent Pelletier:
> >> Provides monitoring of core voltage and current:
> >> tps544b20-i2c-0-1e
> >> Adapter: i2c-ocores
> >> vout1:       906.00 mV
> >> temp1:        -40.0°C  (high = +125.0°C, crit = +150.0°C)
> >> iout1:         5.06 A  (max = +20.00 A, crit max = +26.00 A)
> >>
> >> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> >>
> >> --
> >> Note for review: this patch has one warning from checkpatch.pl:
> >>   WARNING: DT compatible string "tps544b20" appears un-documented -- check ./Documentation/devicetree/bindings/
> >>   #32: FILE: arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts:55:
> >>   +               compatible = "tps544b20";
> >> This chip is handled by the existing pmbus module, and there is indeed no
> >> matching entry in Documentation/devicetree/bindings/hwmon/pmbus. I am not
> >> especially knowledgeable about this chip, I only know it is used by this
> >> board, so I am not sure I can do the best job in putting such a file
> >> together.
> >> If needed I can git it a try.
> > 
> > Devicetree bindings are supposed to be stable into the future, so an actually
> > reviewed binding is quite necessary ;-) .
> > 
> > In the case of your tps544b20 it should also be pretty easy to do, as
> > 
> > 	Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
> > 
> > is probably a pretty good match to what you need in terms of Yaml notation.
> > Just need to replace the naming in your copy and drop in the correct
> > description from
> > 
> > 	https://www.ti.com/lit/ds/symlink/tps544b20.pdf?ts=1637055780278
> > 
> > and you have a working binding.
> > 
> > Then just add another patch to your series that mimics
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a36e38d8b0fbb92609e837a67f919202ec7ec51
> > 
> > and include the relevant maintainers that scripts/get_maintainer.pl will
> > give you, and you're all set :-)
> > 
> 
> Hi Heiko,
> 
> In current form the bindings would be close to trivial and we actually
> do not know how proper bindings would look like (the device is not
> trivial). Therefore based on Rob's recent comments - better to have
> trivial schema than nothing - I sent a patch adding them to trivial-devices:
> 
> https://lore.kernel.org/linux-devicetree/20211116110207.68494-1-krzysztof.kozlowski@canonical.com/T/#u

Though I guess there isn't anything hindering additions to a individual
simpler binding.

But yeah, just adding it to trivial devices will also just work for now, as there
really are no additional properties right now and might make the process
a tad shorter ;-)


Heiko



