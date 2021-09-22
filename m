Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E24413FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhIVC7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhIVC7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:59:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59036C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 19:57:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z14-20020a17090a8b8e00b0019cc29ceef1so3480591pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 19:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SliVJPZt2b3dJnLTZ6YsWgFb3zQafl+TYC6vZjNtaQU=;
        b=SvINqgjec0iZ/Ok1+nrm4TPKBWBIaYsvLFtrF345dI60t2AqZr6MXVdsJY5S4nXV1S
         24eF3zA1lwJu7kgBDQghBKDCUXBBPwPKmv0TLdz/fo4QQq4cKCyjz0GEQZwdcdDc17cx
         LZDVPz8ijgQZb4GgaEKKyufL9QDy9SFI9vSxoCgH6JHfxi3Fnv3iHai/bd8sX0QesTJk
         Zc6Tv6Box+VJgEPUUUrU+izX9j1A8dofZ8oU8JCLGAbkdKnWoM4qF9HoXlTE9V3jSbYy
         yBpK0zKxeDz0lnJpE67DBHRF0jqPjRY2gkr0+B1ERSOh20pIEqUSg7a2BjXoUZlX8I8R
         G8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SliVJPZt2b3dJnLTZ6YsWgFb3zQafl+TYC6vZjNtaQU=;
        b=NeYYiNK+rtQYRVceIVsXHiZM5VO3UH+Q4lB7QomCMJB2+3hV1RVP3un5BsweR6hivQ
         yiTqK74XNIlunifS0WFdI90hVmuGjNEqW4F7feEJwJWLWmZnGrR5GREguo6dYb+6Rz1G
         hHtwgOjq9QfgFKjsNnCnPUASp1SVCx6N5Nooowkb27eexFnSdWxVIKXziHwcJCvOMkxc
         IROqWOYHpHVzGwMaY3JWQYHyfSe3H3UddeYV+s83EP0fmXjMo9QzxDy5eWiAMmyWvTKB
         /o5S3iOwtWJ2n456EWDmLzdOnOdKQq86MCPE7dJ7eonz3GZ/GUFK1vxsmjvyCC2WDhsU
         JF0g==
X-Gm-Message-State: AOAM532VOe2jr/Ks05UIwLPGwJZdu4K6+JLAXoiBMKU6Zv7WkTiK1ob2
        dh+I5kUXa3H2BQlr50SvZ9flMI7latI=
X-Google-Smtp-Source: ABdhPJxrsVWeQ0Qomw0S4n+YgNSH9IYgVxa933+ey+i3PMdzy27PEXfucLysVyYtDUE0s9IyHWNVgA==
X-Received: by 2002:a17:90a:db17:: with SMTP id g23mr8764791pjv.193.1632279472748;
        Tue, 21 Sep 2021 19:57:52 -0700 (PDT)
Received: from [192.168.1.121] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id v8sm3709063pjh.24.2021.09.21.19.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 19:57:52 -0700 (PDT)
Message-ID: <01b708d2-f211-8217-f686-0f7bf9fc8129@gmail.com>
Date:   Tue, 21 Sep 2021 19:57:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] ARM: imx6: mask all interrupts before calling
 stby-poweroff sequence
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com
References: <20210817122500.31953-1-o.rempel@pengutronix.de>
 <20210922023740.GD10217@dragon>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210922023740.GD10217@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/2021 7:37 PM, Shawn Guo wrote:
> On Tue, Aug 17, 2021 at 02:25:00PM +0200, Oleksij Rempel wrote:
>> Any pending interrupt can prevent entering standby based power off state.
>> To avoid it, mask all interrupts.
>>
>> Fixes: 8148d2136002 ("ARM: imx6: register pm_power_off handler if "fsl,pmic-stby-poweroff" is set")
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>   arch/arm/mach-imx/pm-imx6.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
>> index 9244437cb1b9..63887ade411a 100644
>> --- a/arch/arm/mach-imx/pm-imx6.c
>> +++ b/arch/arm/mach-imx/pm-imx6.c
>> @@ -59,8 +59,11 @@
>>   #define MX6Q_SUSPEND_OCRAM_SIZE		0x1000
>>   #define MX6_MAX_MMDC_IO_NUM		33
>>   
>> +#define GIC_DIST_ENABLE_CLEAR		0x180
>> +
>>   static void __iomem *ccm_base;
>>   static void __iomem *suspend_ocram_base;
>> +static void __iomem *gic_raw_dist_base;
>>   static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
>>   
>>   /*
>> @@ -592,6 +595,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
>>   static void __init imx6_pm_common_init(const struct imx6_pm_socdata
>>   					*socdata)
>>   {
>> +	struct device_node *np;
>>   	struct regmap *gpr;
>>   	int ret;
>>   
>> @@ -615,10 +619,29 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
>>   	if (!IS_ERR(gpr))
>>   		regmap_update_bits(gpr, IOMUXC_GPR1, IMX6Q_GPR1_GINT,
>>   				   IMX6Q_GPR1_GINT);
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
>> +	gic_raw_dist_base = of_iomap(np, 0);
>> +}
>> +
>> +static void imx_gic_mask_all(void)
>> +{
>> +	int i;
>> +
>> +	if (WARN_ON(!gic_raw_dist_base))
>> +		return;
>> +
>> +	for (i = 0; i < 4; i++)
>> +		writel_relaxed(~0, gic_raw_dist_base + GIC_DIST_ENABLE_CLEAR + 4 * i);
> 
> Is it possible to have a helper function in GIC driver, that we can
> simply call into?

Cannot you call gic_cpu_if_down(0) which would presumably have the same 
effect?
-- 
Florian
