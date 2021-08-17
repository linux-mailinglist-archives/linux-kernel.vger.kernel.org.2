Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EAF3EEEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbhHQPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbhHQPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:14:05 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686C6C061764;
        Tue, 17 Aug 2021 08:13:32 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id s21-20020a4ae5550000b02902667598672bso5989644oot.12;
        Tue, 17 Aug 2021 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jPbqByzTm8MXGyaQ1QC2qzWAEW9nZn7Ccx15UsL0t/A=;
        b=ISa12CYRPeVW2UgDuHHF4aifAy3qP6wGWcw9iPYZTdAOQABarK6a3u4p2dsVxUQSb/
         u6rPribtafsqULWLT2Hb8dwqMrQnuflU/uItdu4d8iLme4/ilwY+s2L5hxudXbJKWAHq
         L1WxqVkU0+pfGxmffpHuCdT59zL48O2VkgJrYiaF5RONnz4/CndIrSzZG1eBNuT8IolS
         xtARGtCTM7E/YM0QD4k4Gmt3uJh7OKr3lGxND3kQniwrHjnW3AI0m5uhnZd0v4cnvuoZ
         aGInx0i1bw3askxl+XscNoqDhUSQvfhd+Gks9K56bZGUU6y5KKHJLBUfptOpViuucRUm
         HFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPbqByzTm8MXGyaQ1QC2qzWAEW9nZn7Ccx15UsL0t/A=;
        b=LDyMFiNWdWLgdD8GDm47TbFP4LKq+dYG+lNh4HBK+Cc84cGHP9DMtP3K75RyaDxPZp
         D/aHe/q7ZoUmrik46VgQqZCM8OaitXuiItJQiJCdlheuNYn3hCj+SmrvoZIapEgxbs2j
         oCn4YDl0ZXrKru31jsy2J+rFc/UGONOtwD473g84KCqXLp1RxuoAwxpX111oAkdo65Gr
         bFGuQJcQ1+gOqU43NW93FVcilpLEnwvj5WMZ92M5kAZPpnlff4jD5DbV2LzfImqHjfTP
         ZR1f4kpk8vM6jjRpaT+ru3AvF3Wkz1EJJwSvj20ZXFR4/MNfBsybq81kMAwIv9SzHiKB
         KYCQ==
X-Gm-Message-State: AOAM532ORiKe5BPhglYN07vheWjZZl3++b73mO4pTPGgz/K/xy4Vzj49
        lMSgzViL9gygzYQ0k5ECFA77ivYBgPo=
X-Google-Smtp-Source: ABdhPJzGDdwLP/l5iYVLft878ghWnuq/Xl8SyNd/vNJxmUzbJ6UYXEXPJ8dmL+HkeMWEqMJFhQMkWg==
X-Received: by 2002:a4a:9bc1:: with SMTP id b1mr2971340ook.69.1629213211443;
        Tue, 17 Aug 2021 08:13:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q7sm429669otl.45.2021.08.17.08.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 08:13:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210813043131.833006-1-icenowy@aosc.io>
 <YRuDG78N2mB5w37p@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <58034df4-f18c-ab3e-1fcc-dc85fc35320f@roeck-us.net>
Date:   Tue, 17 Aug 2021 08:13:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRuDG78N2mB5w37p@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 2:36 AM, Heikki Krogerus wrote:
> On Fri, Aug 13, 2021 at 12:31:31PM +0800, Icenowy Zheng wrote:
>> Currently, TCPM code omits discover when swapping to gadget, and assume
>> that no altmodes are available when swapping from gadget. However, we do
>> send discover when we get attached as gadget -- this leads to modes to be
>> discovered twice when attached as gadget and then swap to host.
>>
>> Always re-send discover when swapping DR, regardless of what change is
>> being made; and because of this, the assumption that no altmodes are
>> registered with gadget role is broken, and altmodes de-registeration is
>> always needed now.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index b9bb63d749ec..ab6d0d51ee1c 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -4495,15 +4495,14 @@ static void run_state_machine(struct tcpm_port *port)
>>   		tcpm_set_state(port, ready_state(port), 0);
>>   		break;
>>   	case DR_SWAP_CHANGE_DR:
>> -		if (port->data_role == TYPEC_HOST) {
>> -			tcpm_unregister_altmodes(port);
>> +		tcpm_unregister_altmodes(port);
>> +		if (port->data_role == TYPEC_HOST)
>>   			tcpm_set_roles(port, true, port->pwr_role,
>>   				       TYPEC_DEVICE);
>> -		} else {
>> +		else
>>   			tcpm_set_roles(port, true, port->pwr_role,
>>   				       TYPEC_HOST);
>> -			port->send_discover = true;
>> -		}
>> +		port->send_discover = true;
>>   		tcpm_ams_finish(port);
>>   		tcpm_set_state(port, ready_state(port), 0);
>>   		break;
> 
> Why is it necessary to do discovery with data role swap in general?
> 
> thanks,
> 

Additional question: There are two patches pending related to DR_SWAP
and discovery. Are they both needed, or do they both solve the same
problem ?

Thanks,
Guenter
