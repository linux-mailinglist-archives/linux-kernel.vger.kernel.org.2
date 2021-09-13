Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F01409730
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhIMPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbhIMPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:23:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7AC03D407
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 07:19:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so15026259wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ytXVZnLtJgffA6E+knLxonRBBqEa/z1RW3VmEf1H/BM=;
        b=R/e7bVwlQDyAu8ERJTLDaSL5oxZzSYbsJbHA7YBMGKI8uQ9S9lHf/04Fg96SRxGDEP
         V+ytGVTtr12T7R5SKcSssqRY9AxBjDxfq4rElj4G4PEdK8qk3r7oYjMUPKC4cb6fCCHn
         woJoK4B9w723C/TW0wNoK6qtMoRtQq7FMO+P8pUBzTMn3ToWzz/JGRktbhAQghBh7HUL
         MCfc1a6Vu2PoedqUozywdMHarGYZSvxDaASb2tgPIEyeW/7vvDc01kQoir9YqpaT0YUv
         G+Ey+yhkQ0bAWhmt7JppitEHDYJjyHL0UfF8vUi5O4X6kzmiGVI56S2QpQMi+JPZ+M2n
         sVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytXVZnLtJgffA6E+knLxonRBBqEa/z1RW3VmEf1H/BM=;
        b=tGcIrVst5Yq2+l5ysDvv+uyErOJ0cSSp9OqA9RM/stijYCT8biijy9Xxf3/ZAb9X3f
         t0UvG7hd3d4dKbzxRbQF6pzibC3qdj8IPPPWcJOy9E/DKmeJkL0pPmGQZWciyuFUKI8u
         hLZ3Im0sLFG1h8Zjvwz0TzTcI3e1JomodjfyFKW1agZ26bYc/uS3RM9d6mTSPdInHWWv
         NJHtvZFrN/BoP0UQqO9kq2AZ0Ena+xPYANnX/zN8ONByWNdxnAr9P8KKPKfsXWCkBSrg
         aEYjB5ZHlHABlefLR8XDTTVYmr68TlG9VO1GOCnx+AhTIWG0hTpIfe5N5EgH3Tim+uuk
         FkIA==
X-Gm-Message-State: AOAM530Bpn7DMoFEcLjmMQmdUp5xA02gF+1wiyg4BeMJQo6L6n7vkDQE
        WgnxJYGJWM23LvSAY87zqlxozg==
X-Google-Smtp-Source: ABdhPJzFZoxj0dmZbPep0/mcS2/VY6exL7fL10EibHaVajYyd7Z4lsOaueDqKfNoM3BbT2x6LbCaZA==
X-Received: by 2002:a5d:5408:: with SMTP id g8mr13039577wrv.34.1631542794596;
        Mon, 13 Sep 2021 07:19:54 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l10sm8181238wrg.50.2021.09.13.07.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 07:19:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
 <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
 <20210616123356.GA9951@plvision.eu>
 <fea907ed-06ce-5c82-667d-d11f3e902616@linaro.org>
 <vrcxh2zgsnl841.fsf@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7e6d75ed-cebc-597f-7062-34261d184968@linaro.org>
Date:   Mon, 13 Sep 2021 15:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <vrcxh2zgsnl841.fsf@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadym,


On 08/09/2021 10:38, Vadym Kochan wrote:
> 
> Hi Srini,
> 
> Sorry for such delay in replies, I am still confused how to
> implement it properly, let me please explain the issues
> which I faced with:

> 
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
> 
>> On 16/06/2021 13:33, Vadym Kochan wrote:
>>>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>>>> index bca671ff4e54..648373ced6d4 100644
>>>>> --- a/drivers/nvmem/core.c
>>>>> +++ b/drivers/nvmem/core.c
>>>>> @@ -39,6 +39,7 @@ struct nvmem_device {
>>>>>     	nvmem_reg_read_t	reg_read;
>>>>>     	nvmem_reg_write_t	reg_write;
>>>>>     	struct gpio_desc	*wp_gpio;
>>>>> +	struct nvmem_parser_data *parser_data;
>>>> This should be renamed to nvmem_cell_info_parser or something on those lines
>>>> to avoid any misunderstanding on what exactly this parser is about.
>>>>
>>>> May be can totally avoid this by using parser name only during register.
>>>>
>>> I added this to keep parsed cells particulary for this nvmem in case
>>> same parser is used for several nvmem's and mostly because of using also
>>> cell lookup info. I will try to also answer your below question why do I need
>>> lookups ?
>>>
>>> I use of_get_mac_address() func to fetch mac-address from nvmem cell.
>>> Eventually this func calls of_get_mac_addr_nvmem() which (as I understand it
>>> correctly) can find cells via DT by parsing "nvmem-cell-names" or via cell lookup
>>> info of platform_device. I use the 2nd option with the following sample
>>> solution:
>>>
>>> 	## DT ##
>>> 	eeprom_at24: at24@56 {
>>> 		compatible = "atmel,24c32";
>>> 		nvmem-cell-parser-name = "onie-tlv-cells";
>>> 		reg = <0x56>;
>>> 	};
>>>
>>> 	onie_tlv_parser: onie-tlv-cells {
>>> 		compatible = "nvmem-cell-parser";
>>> 		status = "okay";
>>>
>>> ---> add ability here to map cell con_id to cell_name ?
>>>
>>> 	};
>>>
>>> 	some_dev_node {
>>> 		compatible = "xxx";
>>> 		base-mac-provider = <&onie_tlv_parser>;
>>
>> Real nvmem provider is eeprom_at24, why do you use onie_tlv_parse as
>> your mac provider?
>> If you use eeprom_at24 then of_get_mac_address() should get mac-address
>> directly from cell info.
> 
> 1) This DT node is a trick to register it as a platform_device because of:
> 
> static int of_get_mac_addr_nvmem(struct device_node *np, u8 *addr)
> {
>          struct platform_device *pdev = of_find_device_by_node(np);
>          struct nvmem_cell *cell;
>          const void *mac;
>          size_t len;
>          int ret;
>   
>          /* Try lookup by device first, there might be a nvmem_cell_lookup
>           * associated with a given device.
>           */
>          if (pdev) {
>                  ret = nvmem_get_mac_address(&pdev->dev, addr);
>                  put_device(&pdev->dev);
>                  return ret;
>          }
>   
>          cell = of_nvmem_cell_get(np, "mac-address");
>          if (IS_ERR(cell))
>                  return PTR_ERR(cell);
>   
>          ...
> }
> 
> I tried to use at24_eeprom as ref in DTS file, but this device is not a
> platform device but a nvmem bus device, so it fails on:
> 
>          ...
> 
>          struct platform_device *pdev = of_find_device_by_node(np);
> 
>          ...
> 
>          /* Try lookup by device first, there might be a nvmem_cell_lookup
>           * associated with a given device.
>           */
>          if (pdev) {
>                  ret = nvmem_get_mac_address(&pdev->dev, addr);
>                  put_device(&pdev->dev);
>                  return ret;
>          }
> 
>          ...
> 
> Probably this might be fixed by lookup nvmem device too ?

Honestly, this approach is a total hack to get it working.

This is what Am thinking which should look like:

## DT ##
eeprom_at24: at24@56 {
	compatible = "atmel,24c32";
	/* Some way to identify that this is a TLV data */
	nvmem-cell-parser-name = "onie-tlv-cells";
	reg = <0x56>;

	mac_address: mac-address {
		/* THIS REG is updated once TLV is parsed */
		reg = <0 0x6>
	};
};

some_dev_node {
	compatible = "xxx";
	nvmem-cells = <&mac_address>;
	nvmem-cell-names = "mac-address";
};

== CODE ==
ret = of_get_mac_address(dev->of_node, base_mac);
==========


If you notice the mac_address node reg is 0.
This node "reg" property should be updated ( using of_update_property()) 
by nvmem-provider driver while tlv parsing and by matching the node name 
with tlv name.

That way rest of the code will work as usual.

If this work for you then we can ask Rob if he foresee any issues in 
this approach. I already see similar usage in reserved-memory case.


--srini

> 
> 2) Regarding cell lookups registration, I had to use it because
> of_nvmem_cell_get() will not find parser cells via OF.
> 
>>
>>
>>> 		status = "okay";
>>> 	};
>>> 	########
>>>
>>> 	== CODE ==
>>> 	base_mac_np = of_parse_phandle(np, "base-mac-provider", 0);
>>> 	ret = of_get_mac_address(base_mac_np, base_mac);
>>> 	==========
>>>
>>>
>>> And it works with this implementation because onie-tlv-cells is
>>> registered as platform_device which name is the same as parser's name.
>>> So the really tricky part for me is to make this cells lookup work.
>>
>> cell lookups are more of intended for board files, adding them in this
>> case is really not correct.  The whole purpose of this driver is to
>> parse the tlv cell infos into nvmem cell info.
>>
>>
>> --srini
>>
>>
>>>
>>> Of course would be great if you can point a way/idea to get rid the need of
>>> lookups.
>>>
> 
