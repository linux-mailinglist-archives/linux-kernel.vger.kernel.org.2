Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D04358B0F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhDHROT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231566AbhDHROS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617902046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUZzUJw8cVcOuQoVR0vrCfkOIuGoj1x1NYjVpOjErqg=;
        b=DaCde2pluK4Ki8Rdxccdc7q31AXinP1uWCXDLZBnPFBVd+w7j4KX2wGb1iVRLMK6iv/+M3
        PEhshHahuIeIHKVfBDWJ9WUqoiJITmJ0t1CWm3JPfExMKugD39x16bShKyAcbbgMMj16P2
        dL16t4wMiiibPWbw1rBVtIz8aBIzvu0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-T5tl5BkEPBqDqUKuzopl9A-1; Thu, 08 Apr 2021 13:14:05 -0400
X-MC-Unique: T5tl5BkEPBqDqUKuzopl9A-1
Received: by mail-ed1-f70.google.com with SMTP id i1so4636edf.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KUZzUJw8cVcOuQoVR0vrCfkOIuGoj1x1NYjVpOjErqg=;
        b=XqQ5H6JfGqNl1GvdeQkX4QAXN/mSYVZ0+9Vl/4C4aTkdk8rHNRbKpY+w8eBsnYtoSh
         ov/p2dP0xfgPz0w8BbCwypMrjYQCw9lPjAW1alHKPgKTSwQDo7oL5zQYtFibuRMambWt
         bGPcU1GYRuPaQjNqBzIdLDTLLgwoeC6Q55UCfkpHtpcbb0rfte+vKLQL3+NYzKRbkm2y
         FiPB2YFKEaHv0cf+66uLGcFnSJ0EtZjv4TcqWF8NRbp5aW8EEdVfVRbJ7WkGELEeV3E0
         y0wgQbhi1j90XTTSB1rUvMzSxf7vqzosXNG4u0A4OfC6x6jFn41RzKtTNoq04BFdild4
         Sq6Q==
X-Gm-Message-State: AOAM533e8CLHj2R+k5WfSfks+1f/BU9lMnrmOG5unYTLLmFDakUKxk4X
        NxO+xIpjtjmxwl/iyEcrYj6WBu4gKExa2oTtu3OTJOecKWIDW1T83UwHoNF8UL/zRBaNQFRAppt
        6jAOUy6vFnr/oWO/c8XsOq4bAJLIxfz5yd2xux7FlhCtjcji+kvqTCSkB+Rwhmh6xZeI998/N5D
        wG
X-Received: by 2002:a17:906:1408:: with SMTP id p8mr11564739ejc.89.1617902043361;
        Thu, 08 Apr 2021 10:14:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZMV8wr4q2RutqkZs9uxRr7Wx3PDsx+PLq+1xUrYkBTv5/1jYiwCaF91de078N5M1yoJrRng==
X-Received: by 2002:a17:906:1408:: with SMTP id p8mr11564703ejc.89.1617902043083;
        Thu, 08 Apr 2021 10:14:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id a9sm17867129eds.33.2021.04.08.10.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 10:14:02 -0700 (PDT)
Subject: Re: [PATCH 1/1] usb: typec: tcpm: remove unused static variable
 'tcpm_altmode_ops'
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210407091540.2815-1-thunder.leizhen@huawei.com>
 <YG6+mfqIc15rc9H1@kuha.fi.intel.com>
 <aa30675b-a487-a605-7dae-4b9c18ad11e0@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8e3ae637-dc52-3285-2862-bee36e1dca14@redhat.com>
Date:   Thu, 8 Apr 2021 19:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <aa30675b-a487-a605-7dae-4b9c18ad11e0@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/8/21 3:55 PM, Guenter Roeck wrote:
> On 4/8/21 1:28 AM, Heikki Krogerus wrote:
>> On Wed, Apr 07, 2021 at 05:15:40PM +0800, Zhen Lei wrote:
>>> Fixes the following W=1 kernel build warning:
>>>
>>> drivers/usb/typec/tcpm/tcpm.c:2107:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
>>>
>>> The reference to the variable 'tcpm_altmode_ops' is deleted by the
>>> commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration
>>> mechanism").
>>>
>>> By the way, the static functions referenced only by the variable
>>> 'tcpm_altmode_ops' are deleted accordingly.
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Oh, I thought this was already fixed. Should this go into the stable
>> trees as well?
>>
> 
> I thought there was some code supposed to be coming which would make use of it,
> but my memory may defeat me.

There is code coming which uses this; and this is necessary to make
DP altmode work on some devices.

I have dropped the ball a bit on posting a v2 of my series using this.

I'll prepare a v2 of my series, addressing Heikki's review comments
to my v1 right away. I'll post a v2 at the latest tomorrow.

This is something which is on my TODO list anyways and this way we will
save some churn with these functions going away only to be re-introduced
again relatively soon after they were removed.

Regards,

Hans


> Either case, it is getting old. It it is ever needed,
> it can be reintroduced.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Guenter
> 
>> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>>> ---
>>>  drivers/usb/typec/tcpm/tcpm.c | 60 -------------------------------------------
>>>  1 file changed, 60 deletions(-)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>>> index ce7af398c7c1c1f..2f89bae29c0c297 100644
>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>> @@ -1365,14 +1365,6 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
>>>  	mod_vdm_delayed_work(port, 0);
>>>  }
>>>  
>>> -static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
>>> -				    const u32 *data, int cnt)
>>> -{
>>> -	mutex_lock(&port->lock);
>>> -	tcpm_queue_vdm(port, header, data, cnt);
>>> -	mutex_unlock(&port->lock);
>>> -}
>>> -
>>>  static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
>>>  {
>>>  	u32 vdo = p[VDO_INDEX_IDH];
>>> @@ -1705,8 +1697,6 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>>>  	 *
>>>  	 * And we also have this ordering:
>>>  	 * 1. alt-mode driver takes the alt-mode's lock
>>> -	 * 2. alt-mode driver calls tcpm_altmode_enter which takes the
>>> -	 *    tcpm port lock
>>>  	 *
>>>  	 * Dropping our lock here avoids this.
>>>  	 */
>>> @@ -2060,56 +2050,6 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
>>>  	return 0;
>>>  }
>>>  
>>> -static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
>>> -{
>>> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>>> -	int svdm_version;
>>> -	u32 header;
>>> -
>>> -	svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
>>> -	if (svdm_version < 0)
>>> -		return svdm_version;
>>> -
>>> -	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
>>> -	header |= VDO_OPOS(altmode->mode);
>>> -
>>> -	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
>>> -	return 0;
>>> -}
>>> -
>>> -static int tcpm_altmode_exit(struct typec_altmode *altmode)
>>> -{
>>> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>>> -	int svdm_version;
>>> -	u32 header;
>>> -
>>> -	svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
>>> -	if (svdm_version < 0)
>>> -		return svdm_version;
>>> -
>>> -	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
>>> -	header |= VDO_OPOS(altmode->mode);
>>> -
>>> -	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
>>> -	return 0;
>>> -}
>>> -
>>> -static int tcpm_altmode_vdm(struct typec_altmode *altmode,
>>> -			    u32 header, const u32 *data, int count)
>>> -{
>>> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>>> -
>>> -	tcpm_queue_vdm_unlocked(port, header, data, count - 1);
>>> -
>>> -	return 0;
>>> -}
>>> -
>>> -static const struct typec_altmode_ops tcpm_altmode_ops = {
>>> -	.enter = tcpm_altmode_enter,
>>> -	.exit = tcpm_altmode_exit,
>>> -	.vdm = tcpm_altmode_vdm,
>>> -};
>>> -
>>>  /*
>>>   * PD (data, control) command handling functions
>>>   */
>>> -- 
>>> 1.8.3
>>>
>>
> 
> 

