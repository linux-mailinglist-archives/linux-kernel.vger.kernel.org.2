Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37F133AFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhCOKUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhCOKT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615803568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4H0t9R5LNgdt6oohPgmQ6W+xH6IrAfJheLo0PRTerkM=;
        b=NAlT7673/RJiaRq3KvHTl3eBDdhTP7qPSFfbablBGB9Jpp0iMoehlMxmKwuDiyPLDniSwM
        pQQI3LsExI7ycMaVjqlHIAnL8EiCEKLvgGpth0c3PRw/V6fG9Kavo+6WLs4lRgtyMqYaCy
        psQ8ePCDDCgjyDXULfsopzElhB4+GwU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-AfI1DH6GNL6UIiGw4_5QSA-1; Mon, 15 Mar 2021 06:19:27 -0400
X-MC-Unique: AfI1DH6GNL6UIiGw4_5QSA-1
Received: by mail-ed1-f69.google.com with SMTP id o24so15672008edt.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4H0t9R5LNgdt6oohPgmQ6W+xH6IrAfJheLo0PRTerkM=;
        b=fgRmrxWGrRu2nBDyz0TrngEo/B6Dnhr9nUV0pcpH1ECdaQsvz9CHJ1jJRjFat80/a2
         iyJSsy4jm5SyuYsioWRSeXzhAQ0nwjGj434sTBEHsarIDD0zVcIhG2H8cXLAVl/5w8J4
         riUSZGhW/fCDQOFY03EgK4zqntXfrdW2avpnXE2aIBQqW7iAIUjqcsnWwDgpHJ77hqYC
         VvcCQeBv2y0N+jiblvI3FaJDvWViIf3fM+ZGZ7h0V9maKPBQaa22F8Ev996Q3BaPWujF
         lmPdZQAIz0Tpnr8ZbrWhPS/mKE5/fA0Msq+ZNM4qmzu5+clsUZ87aYCRLtCSOubKHJ5s
         X25A==
X-Gm-Message-State: AOAM533kdBzTM8+SR0iLgg4B44nFTUoq+BWfsgrL1fDS0hyjjrIjlO6S
        IuKvxzAxAr8fs/F65fppXwANT7ZYhn1JeH/4u4BBGPktj6ms/OnPUtKklzDFmInOU7sFsUFhm3t
        kCTc45Zdliw6BaBhZGezgdZUN
X-Received: by 2002:a05:6402:304b:: with SMTP id bu11mr28119347edb.157.1615803566154;
        Mon, 15 Mar 2021 03:19:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKU1fbWoKqnF953DlzDBdbMwkCPOiePU1adCsKRZqOcav3wtyGBKCQsBBzqea6uLH9+r+/Yg==
X-Received: by 2002:a05:6402:304b:: with SMTP id bu11mr28119331edb.157.1615803565998;
        Mon, 15 Mar 2021 03:19:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n6sm2530343eji.37.2021.03.15.03.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 03:19:25 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] platform/x86: pmc_atom: improve critclk_systems
 matching for Siemens PCs
To:     Henning Schild <henning.schild@siemens.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Haener <michael.haener@siemens.com>
References: <20210315095710.7140-1-henning.schild@siemens.com>
 <20210315095710.7140-5-henning.schild@siemens.com>
 <20210315111434.413137b5@md1za8fc.ad001.siemens.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ef5fe493-285d-145c-8d05-7f9bd0cb47c5@redhat.com>
Date:   Mon, 15 Mar 2021 11:19:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210315111434.413137b5@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/15/21 11:14 AM, Henning Schild wrote:
> Am Mon, 15 Mar 2021 10:57:10 +0100
> schrieb Henning Schild <henning.schild@siemens.com>:
> 
>> Siemens industrial PCs unfortunately can not always be properly
>> identified the way we used to. An earlier commit introduced code that
>> allows proper identification without looking at DMI strings that could
>> differ based on product branding.
>> Switch over to that proper way and revert commits that used to collect
>> the machines based on unstable strings.
>>
>> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as
>> CLK_IS_CRITICAL") Fixes: e8796c6c69d1 ("platform/x86: pmc_atom: Add
>> Siemens CONNECT ...") Fixes: f110d252ae79 ("platform/x86: pmc_atom:
>> Add Siemens SIMATIC ...") Fixes: ad0d315b4d4e ("platform/x86:
>> pmc_atom: Add Siemens SIMATIC ...") Tested-by: Michael Haener
>> <michael.haener@siemens.com> Signed-off-by: Henning Schild
>> <henning.schild@siemens.com> ---
>>  drivers/platform/x86/pmc_atom.c | 47
>> +++++++++++++++++++-------------- 1 file changed, 27 insertions(+),
>> 20 deletions(-)
>>
>> diff --git a/drivers/platform/x86/pmc_atom.c
>> b/drivers/platform/x86/pmc_atom.c index ca684ed760d1..38542d547f29
>> 100644 --- a/drivers/platform/x86/pmc_atom.c
>> +++ b/drivers/platform/x86/pmc_atom.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/io.h>
>>  #include <linux/platform_data/x86/clk-pmc-atom.h>
>>  #include <linux/platform_data/x86/pmc_atom.h>
>> +#include <linux/platform_data/x86/simatic-ipc.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pci.h>
>>  #include <linux/seq_file.h>
>> @@ -362,6 +363,23 @@ static void pmc_dbgfs_register(struct pmc_dev
>> *pmc) }
>>  #endif /* CONFIG_DEBUG_FS */
>>  
>> +static bool pmc_clk_is_critical = true;
>> +
>> +static int siemens_clk_is_critical(const struct dmi_system_id *d)
>> +{
>> +	u32 st_id;
>> +
>> +	if (dmi_walk(simatic_ipc_find_dmi_entry_helper, &st_id))
>> +		goto out;
>> +
>> +	if (st_id == SIMATIC_IPC_IPC227E || st_id ==
>> SIMATIC_IPC_IPC277E)
>> +		return 1;
>> +
>> +out:
>> +	pmc_clk_is_critical = false;
>> +	return 1;
>> +}
>> +
>>  /*
>>   * Some systems need one or more of their pmc_plt_clks to be
>>   * marked as critical.
>> @@ -424,24 +442,10 @@ static const struct dmi_system_id
>> critclk_systems[] = { },
>>  	},
>>  	{
>> -		.ident = "SIMATIC IPC227E",
>> -		.matches = {
>> -			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
>> -			DMI_MATCH(DMI_PRODUCT_VERSION, "6ES7647-8B"),
>> -		},
>> -	},
>> -	{
>> -		.ident = "SIMATIC IPC277E",
>> -		.matches = {
>> -			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
>> -			DMI_MATCH(DMI_PRODUCT_VERSION, "6AV7882-0"),
>> -		},
>> -	},
>> -	{
>> -		.ident = "CONNECT X300",
>> +		.callback = siemens_clk_is_critical,
>> +		.ident = "SIEMENS AG",
>>  		.matches = {
>>  			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
>> -			DMI_MATCH(DMI_PRODUCT_VERSION,
>> "A5E45074588"), },
>>  	},
>>  
>> @@ -453,7 +457,7 @@ static int pmc_setup_clks(struct pci_dev *pdev,
>> void __iomem *pmc_regmap, {
>>  	struct platform_device *clkdev;
>>  	struct pmc_clk_data *clk_data;
>> -	const struct dmi_system_id *d =
>> dmi_first_match(critclk_systems);
>> +	const struct dmi_system_id *d;
>>  
>>  	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
>>  	if (!clk_data)
>> @@ -461,9 +465,12 @@ static int pmc_setup_clks(struct pci_dev *pdev,
>> void __iomem *pmc_regmap, 
>>  	clk_data->base = pmc_regmap; /* offset is added by client */
>>  	clk_data->clks = pmc_data->clks;
>> -	if (d) {
>> -		clk_data->critical = true;
>> -		pr_info("%s critclks quirk enabled\n", d->ident);
>> +	if (dmi_check_system(critclk_systems)) {
> 
> Had to switch to check_system to get the callback to work.
> 
>> +		clk_data->critical = pmc_clk_is_critical;
>> +		if (clk_data->critical) {
>> +			d = dmi_first_match(critclk_systems);
>> +			pr_info("%s critclks quirk enabled\n",
>> d->ident);
> 
> Now need a double match here just to print the ident. Not too happy
> with that but proposing it like this to keep the ident printing.
> 
> I guess it could be improved by not printing the ident or having a
> global variable and global callback to remember the ident to print
> later. I would propose to not print the ident if the double-match does
> not find traction.

IMHO it would be best to add another callback for the non Siemens
entries which just prints the ideent and returns 1 to avoid needsly
looping over the rest of the array.

And then just set the callback member of all the non Siemens entries
to this new callback. The space for the callback pointer is already
reserved in the struct anyways, so actually setting it does not take
up any space.

Regards,

Hans

