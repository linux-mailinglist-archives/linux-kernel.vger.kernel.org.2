Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994FD34D302
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhC2PAB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Mar 2021 11:00:01 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51187 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhC2O7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:59:41 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 01760E000D;
        Mon, 29 Mar 2021 14:59:35 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?utf-8?Q?G=C3=A9rald?= Kerma <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH mvebu v3 08/10] cpufreq: armada-37xx: Fix determining
 base CPU frequency
In-Reply-To: <20210222194158.12342-9-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210222194158.12342-1-pali@kernel.org>
 <20210222194158.12342-9-pali@kernel.org>
Date:   Mon, 29 Mar 2021 16:59:35 +0200
Message-ID: <87pmzidmzs.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

> When current CPU load is not L0 then loading armada-37xx-cpufreq.ko driver
> fails with following error:
>
>     # modprobe armada-37xx-cpufreq
>     [  502.702097] Unsupported CPU frequency 250 MHz
>
> This issue was partially fixed by commit 8db82563451f ("cpufreq:
> armada-37xx: fix frequency calculation for opp"), but only for calculating
> CPU frequency for opp.
>
> Fix this also for determination of base CPU frequency.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
> Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
> Tested-by: Philip Soares <philips@netisense.com>
> Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> Cc: stable@vger.kernel.org # 8db82563451f ("cpufreq: armada-37xx: fix
> frequency calculation for opp")

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index 1ab2113daef5..e4782f562e7a 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -469,7 +469,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
>  		return -EINVAL;
>  	}
>  
> -	dvfs = armada_37xx_cpu_freq_info_get(cur_frequency);
> +	dvfs = armada_37xx_cpu_freq_info_get(base_frequency);
>  	if (!dvfs) {
>  		clk_put(clk);
>  		return -EINVAL;
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
