Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51FC358558
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhDHNzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhDHNzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:55:47 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF5C061760;
        Thu,  8 Apr 2021 06:55:36 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id a8so2216340oic.11;
        Thu, 08 Apr 2021 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3re1I37r87aFxYxrphUDCko+e4HXCuExsB7EJxVTJnI=;
        b=W8+tb1VAjTGGsCsrydoFCGprnchoPpDKykCAZnHlGp8qkYvnTBKcgPMcXQpqPKG8rE
         9X46jyV7F3k+utBJLmktBLgwy6x5RWRp255gAy5vZn6agDUisXyUdYX2TH9eVOLwu67G
         r8R4VgpGNFexoG5z8ozGCJYuDB5KXHvrrGUvx59jtpYwB592CwiTJDtKHeAnvJ+TXeB6
         uOR8ICtWt1Lx9p1p2MCgnYYT5gTi97A00mT84BLhl/BkExPSRH9qeQJEp7qg5lZgYMxM
         nOJwd2DnUSAOj8RMWpUrud5nhjKCNYTvXA4j757BTB0WCCNW5rAemlhq1vPpAWb0YxvG
         xYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3re1I37r87aFxYxrphUDCko+e4HXCuExsB7EJxVTJnI=;
        b=B7xyz3rJDmSVUJ9mmNM5XAIz291GgMDwA7v4PxgqFaFjME9LyAtZygtHBsBSo7piTC
         JoA+yp2/8YgEt5vXRzTTL5KQSxey+2XLALIKADFfCYu5OZCFCuz6nv0BMvKThihaUub/
         uzHky7TkO8Z/UP5gwFxcBX6J+UyuH+Qnbk9HCvHLNMyVedQJyiLJaq3K54fglDw4C/11
         PthU50Y3hCSoFACpXhOxCCGt4G7bXSbjkQWc/0bq+MIvKTKwykdqqBmiAypLn+Qv9o0B
         IsOBJKg2QbBH3mkD8C/Ij0uryUcWARfiWLfhDAFcO9+1IP4iduecUQpC6Fz9p6//1Iwg
         K9JQ==
X-Gm-Message-State: AOAM533Rrms01NxOmxtdcorheTiB97OLp+GwfKN7qBNxK1LN2fdX/dw+
        gBabUGaVgDbmOW9aO+4r0Z8=
X-Google-Smtp-Source: ABdhPJzinviwwF6999L2Dnv+sb+hlBFL/6MAbJXTiQjVwuMJZBdU7yyiYQGxrm+Ot9Adn4EnFOzyiw==
X-Received: by 2002:aca:ac09:: with SMTP id v9mr1319324oie.139.1617890135437;
        Thu, 08 Apr 2021 06:55:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3sm5526175ood.46.2021.04.08.06.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 06:55:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/1] usb: typec: tcpm: remove unused static variable
 'tcpm_altmode_ops'
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <20210407091540.2815-1-thunder.leizhen@huawei.com>
 <YG6+mfqIc15rc9H1@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <aa30675b-a487-a605-7dae-4b9c18ad11e0@roeck-us.net>
Date:   Thu, 8 Apr 2021 06:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YG6+mfqIc15rc9H1@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 1:28 AM, Heikki Krogerus wrote:
> On Wed, Apr 07, 2021 at 05:15:40PM +0800, Zhen Lei wrote:
>> Fixes the following W=1 kernel build warning:
>>
>> drivers/usb/typec/tcpm/tcpm.c:2107:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
>>
>> The reference to the variable 'tcpm_altmode_ops' is deleted by the
>> commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration
>> mechanism").
>>
>> By the way, the static functions referenced only by the variable
>> 'tcpm_altmode_ops' are deleted accordingly.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Oh, I thought this was already fixed. Should this go into the stable
> trees as well?
> 

I thought there was some code supposed to be coming which would make use of it,
but my memory may defeat me. Either case, it is getting old. It it is ever needed,
it can be reintroduced.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
>> ---
>>  drivers/usb/typec/tcpm/tcpm.c | 60 -------------------------------------------
>>  1 file changed, 60 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index ce7af398c7c1c1f..2f89bae29c0c297 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -1365,14 +1365,6 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
>>  	mod_vdm_delayed_work(port, 0);
>>  }
>>  
>> -static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
>> -				    const u32 *data, int cnt)
>> -{
>> -	mutex_lock(&port->lock);
>> -	tcpm_queue_vdm(port, header, data, cnt);
>> -	mutex_unlock(&port->lock);
>> -}
>> -
>>  static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
>>  {
>>  	u32 vdo = p[VDO_INDEX_IDH];
>> @@ -1705,8 +1697,6 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>>  	 *
>>  	 * And we also have this ordering:
>>  	 * 1. alt-mode driver takes the alt-mode's lock
>> -	 * 2. alt-mode driver calls tcpm_altmode_enter which takes the
>> -	 *    tcpm port lock
>>  	 *
>>  	 * Dropping our lock here avoids this.
>>  	 */
>> @@ -2060,56 +2050,6 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
>>  	return 0;
>>  }
>>  
>> -static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
>> -{
>> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>> -	int svdm_version;
>> -	u32 header;
>> -
>> -	svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
>> -	if (svdm_version < 0)
>> -		return svdm_version;
>> -
>> -	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
>> -	header |= VDO_OPOS(altmode->mode);
>> -
>> -	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
>> -	return 0;
>> -}
>> -
>> -static int tcpm_altmode_exit(struct typec_altmode *altmode)
>> -{
>> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>> -	int svdm_version;
>> -	u32 header;
>> -
>> -	svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
>> -	if (svdm_version < 0)
>> -		return svdm_version;
>> -
>> -	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
>> -	header |= VDO_OPOS(altmode->mode);
>> -
>> -	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
>> -	return 0;
>> -}
>> -
>> -static int tcpm_altmode_vdm(struct typec_altmode *altmode,
>> -			    u32 header, const u32 *data, int count)
>> -{
>> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>> -
>> -	tcpm_queue_vdm_unlocked(port, header, data, count - 1);
>> -
>> -	return 0;
>> -}
>> -
>> -static const struct typec_altmode_ops tcpm_altmode_ops = {
>> -	.enter = tcpm_altmode_enter,
>> -	.exit = tcpm_altmode_exit,
>> -	.vdm = tcpm_altmode_vdm,
>> -};
>> -
>>  /*
>>   * PD (data, control) command handling functions
>>   */
>> -- 
>> 1.8.3
>>
> 

