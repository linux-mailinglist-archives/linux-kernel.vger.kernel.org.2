Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D063F13D4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhHSGxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:53:45 -0400
Received: from out28-194.mail.aliyun.com ([115.124.28.194]:39806 "EHLO
        out28-194.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhHSGxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:53:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3475978|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00612132-0.000575849-0.993303;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.L2nsPIr_1629355984;
Received: from 192.168.88.131(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.L2nsPIr_1629355984)
          by smtp.aliyun-inc.com(10.147.42.197);
          Thu, 19 Aug 2021 14:53:05 +0800
Subject: Re: [PATCH] dt-bindings: timer: Add ABIs for new Ingenic SoCs.
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
To:     robh+dt@kernel.org, daniel.lezcano@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sihui.liu@ingenic.com,
        jun.jiang@ingenic.com, sernia.zhou@foxmail.com
References: <1626370605-120775-1-git-send-email-zhouyanjie@wanyeetech.com>
Message-ID: <fbc02405-67be-3256-2b3e-51c052cb06e2@wanyeetech.com>
Date:   Thu, 19 Aug 2021 14:53:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1626370605-120775-1-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


A gentle ping :)


On 2021/7/16 上午1:36, 周琰杰 (Zhou Yanjie) wrote:
> 1.Add OST_CLK_EVENT_TIMER for new XBurst®1 SoCs.
> 2.Add OST_CLK_EVENT_TIMER0 to OST_CLK_EVENT_TIMER15 for new XBurst®2 SoCs.
>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>   include/dt-bindings/clock/ingenic,sysost.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings/clock/ingenic,sysost.h
> index 063791b..d7aa42c 100644
> --- a/include/dt-bindings/clock/ingenic,sysost.h
> +++ b/include/dt-bindings/clock/ingenic,sysost.h
> @@ -13,4 +13,23 @@
>   #define OST_CLK_PERCPU_TIMER2	3
>   #define OST_CLK_PERCPU_TIMER3	4
>   
> +#define OST_CLK_EVENT_TIMER		1
> +
> +#define OST_CLK_EVENT_TIMER0	0
> +#define OST_CLK_EVENT_TIMER1	1
> +#define OST_CLK_EVENT_TIMER2	2
> +#define OST_CLK_EVENT_TIMER3	3
> +#define OST_CLK_EVENT_TIMER4	4
> +#define OST_CLK_EVENT_TIMER5	5
> +#define OST_CLK_EVENT_TIMER6	6
> +#define OST_CLK_EVENT_TIMER7	7
> +#define OST_CLK_EVENT_TIMER8	8
> +#define OST_CLK_EVENT_TIMER9	9
> +#define OST_CLK_EVENT_TIMER10	10
> +#define OST_CLK_EVENT_TIMER11	11
> +#define OST_CLK_EVENT_TIMER12	12
> +#define OST_CLK_EVENT_TIMER13	13
> +#define OST_CLK_EVENT_TIMER14	14
> +#define OST_CLK_EVENT_TIMER15	15
> +
>   #endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
