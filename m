Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45E45E80A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358805AbhKZGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:48:59 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:21406 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbhKZGqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637909020; x=1669445020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=81djdkdc47FUE/EYNJG317LoWautFHfqHIKQVdWFeYk=;
  b=coej0gHke1wfPl1YqGTGKQjxAnUE1GxwoctM/iqdmVQbYEv8nyMhJgAb
   9eUOCR2X1kJVQpjVbal3MiPjzG3lEgAf1dnpK3EZ7j1F+lrDM/aK5Ilk4
   ePnhw2WPc6byYSYhLsczUQgxMIBzLiKJabVdu1MGQax8R/T8wtLuk4sC0
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Nov 2021 22:43:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:43:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 22:43:38 -0800
Received: from [10.50.30.35] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 25 Nov
 2021 22:43:36 -0800
Message-ID: <4b7aae44-8287-5a5a-7d78-0d4fcbfd2c65@quicinc.com>
Date:   Fri, 26 Nov 2021 12:13:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2] of: base: Skip CPU nodes with "fail"/"fail-..." status
Content-Language: en-US
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211122114536.2981-1-matthias.schiffer@ew.tq-group.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20211122114536.2981-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/2021 5:15 PM, Matthias Schiffer wrote:
> Allow fully disabling CPU nodes using status = "fail".
>
> This allows a bootloader to change the number of available CPUs (for
> example when a common DTS is used for SoC variants with different numbers
> of cores) without deleting the nodes altogether, which could require
> additional fixups to avoid dangling phandle references.
>
> Unknown status values (everything that is not "okay"/"ok", "disabled" or
> "fail"/"fail-...") will continue to be interpreted like "disabled",
> meaning that the CPU can be enabled during boot.
>
> References:
> - https://www.lkml.org/lkml/2020/8/26/1237
> - https://www.spinics.net/lists/devicetree-spec/msg01007.html
> - https://github.com/devicetree-org/dt-schema/pull/61
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>
> v2: Treat unknown status values like "disabled", not like "fail"
>
>
>   drivers/of/base.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 61de453b885c..5b907600f5b0 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -650,6 +650,28 @@ bool of_device_is_available(const struct device_node *device)
>   }
>   EXPORT_SYMBOL(of_device_is_available);
>   
> +/**
> + *  __of_device_is_fail - check if a device has status "fail" or "fail-..."
> + *
> + *  @device: Node to check status for, with locks already held
> + *
> + *  Return: True if the status property is set to "fail" or "fail-..." (for any
> + *  error code suffix), false otherwise
> + */
> +static bool __of_device_is_fail(const struct device_node *device)
> +{
> +	const char *status;
> +
> +	if (!device)
> +		return false;
> +
> +	status = __of_get_property(device, "status", NULL);
> +	if (status == NULL)
> +		return false;
> +
> +	return !strcmp(status, "fail") || !strncmp(status, "fail-", 5);
> +}
> +
>   /**
>    *  of_device_is_big_endian - check if a device has BE registers
>    *
> @@ -796,6 +818,9 @@ EXPORT_SYMBOL(of_get_next_available_child);
>    * of_get_next_cpu_node - Iterate on cpu nodes
>    * @prev:	previous child of the /cpus node, or NULL to get first
>    *
> + * Unusable CPUs (those with the status property set to "fail" or "fail-...")
> + * will be skipped.
> + *
>    * Return: A cpu node pointer with refcount incremented, use of_node_put()
>    * on it when done. Returns NULL when prev is the last child. Decrements
>    * the refcount of prev.
> @@ -817,6 +842,8 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
>   		of_node_put(node);
>   	}
>   	for (; next; next = next->sibling) {
> +		if (__of_device_is_fail(next))
> +			continue;
>   		if (!(of_node_name_eq(next, "cpu") ||
>   		      __of_node_is_type(next, "cpu")))
>   			continue;

Thanks for the patch, we have a similar usecase coming up and this is 
very useful than fixing up phandles.

Tested-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

-Sai
