Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC5F41106A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhITHpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:45:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36798 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235158AbhITHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:45:15 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18K098xl022500;
        Mon, 20 Sep 2021 09:43:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=oH4D/HPpaxuvzZMHzMZBaGtDooA6Q+t7sSJkEid2Q98=;
 b=nYJy/MWmrk2/0hZdrqkhcXqWUw4Go8I084uP5DybUyZxoMp8DpKHNr0sEjmO7Sib9tow
 PID399KTk0tKbfyr3GAWJtaZojcaup8EYUdyeKoao+rUFoDhsuMpNs7/rAxZu/bCilxP
 Xmir32mFK2WqizgICJaAhehcMI3tWCwE4klb0mTr9KkG+6xZcYwkTs3MfWwNgDXjrWzu
 UxxJRwCKCZ1csUcn9LvZNtBGMzf6PuoHq26esV7FGk6qx8jsKiMV0RLQ2h2PB2O389eB
 A8FM7xHzAsCIYBgGvDYE4ychRUA6HCYYP+6qVCXBAaW4kJhTjHCMugbQ10sPIllVxwyu Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b6fgqhhv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 09:43:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 942FF10002A;
        Mon, 20 Sep 2021 09:43:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8AD822128D5;
        Mon, 20 Sep 2021 09:43:26 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 20 Sep
 2021 09:43:26 +0200
Subject: Re: [PATCH] ARM: dts: stm32: set the DCMI pins on stm32mp157c-odyssey
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <YSepFyt8o+5lAsrA@nx64de-df6d00>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <0ac8725b-b3b9-7c9b-bb88-70e586092c09@foss.st.com>
Date:   Mon, 20 Sep 2021 09:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSepFyt8o+5lAsrA@nx64de-df6d00>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_03,2021-09-17_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 8/26/21 4:45 PM, Grzegorz Szymaszek wrote:
> The Seeed Odyssey-STM32MP157C board has a 20-pin DVP camera output. The
> DCMI pins used on this output are defined in the pin state definition
> &pinctrl/dcmi-1, AKA &dcmi_pins_b (added in mainline commit
> 02814a41529a55dbfb9fbb2a3728e78e70646ea6). Set these pins as the default
> pinctrl of the DCMI peripheral in the board device tree.
> 
> The pins are not used for any other purpose, so it seems safe to assume
> most users will not need to override (delete) what this patch provides.
> status defaults to "disabled", so the peripheral will not be
> unnecessarily started. And the users who actually intend to make use of
> a camera on the DVP port will have this little part of the configuration
> ready.
> 
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>   arch/arm/boot/dts/stm32mp157c-odyssey.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> index be1dd5e9e744..554f5d3bcdc3 100644
> --- a/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> @@ -22,6 +22,12 @@ chosen {
>   	};
>   };
>   
> +&dcmi {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&dcmi_pins_b>;
> +	pinctrl-1 = <&dcmi_sleep_pins_b>;
> +};
> +
>   &ethernet0 {
>   	status = "okay";
>   	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
> 

Applied on stm32-next.

Thanks
Alex
