Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACF73B04E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhFVMow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229501AbhFVMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624365699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWJF0SVJbQtyeSC44KfBX8GVj4wZXV/+dpwdOEA0+9E=;
        b=PPhhQqhdT8V+tkUUBeYgVgL9EcllCnW0CF/WTl0P7bvRMZpe+kUVHrmtbiduUOMB5rt+Nd
        mDMmimNN14CV39BPkeRHZjBca8bYIhl+04YBmt5m4WezRtv+ZepeeJanzMn3hFStBqqJuw
        6RMA0Gd+kOzSa1wn5pnouKre1hmOkz8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-jZ_opwZ0O4u67Ns98chSUw-1; Tue, 22 Jun 2021 08:41:38 -0400
X-MC-Unique: jZ_opwZ0O4u67Ns98chSUw-1
Received: by mail-ej1-f69.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso7539200ejn.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uWJF0SVJbQtyeSC44KfBX8GVj4wZXV/+dpwdOEA0+9E=;
        b=RGVSoOEaKc0JW9fa3n8FdQYNEG63VKLIMkTPrqIAI+k1ITLthefUxzfwSLb7ry1zOo
         FKrW8NZIXgqIHagFGUA6a7TG0Oh4P8wD/n6doLTfmxUST0HPQ9UNn0txbq1gB4ep2YtG
         HDWnLuQJB4wGVbcKB9rGMjjn1s3KD94kxeqtqWUECJtH0iMcGbEKgXTLFYKKIcGGHd/6
         o8dCMRNEDYyQkwOrKi2OLYmNSFz274estsXL6xkiOux0r1BhoKmHMf8zv4rO1tyx5HtS
         0qmxUtv5q8O+jZszlRSJlHip0bKdP/j9h6T5VHyqgI6qBWOy4dtCky8YJnfw6Wdb//bp
         jMnw==
X-Gm-Message-State: AOAM5325jmXJDih4AYp3BAbvUUmIK3hinyX/bwtqbO0tweZYETrspev2
        +/xhiXA0S6/fEnKRcJgG2vCjXjT34TGk7UwCjg6KyZu1oUncXjc7wErqhpsEjVOHUgx4IuCymOY
        sMGV1Pze7kOtr1xbgct7ssyVPTowvxbQ419rzNabogxhxcYoFucqvPgiB/ZvlEgmaX09s8nCPqF
        6c
X-Received: by 2002:a17:907:7254:: with SMTP id ds20mr3859673ejc.145.1624365697050;
        Tue, 22 Jun 2021 05:41:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws7CouHgBObXZqkgMqL/oOt1pqH634a4i3h6RU5ah+TxaSyKLPy4zgRYTuF7RxAnyRvwUHnA==
X-Received: by 2002:a17:907:7254:: with SMTP id ds20mr3859653ejc.145.1624365696837;
        Tue, 22 Jun 2021 05:41:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m26sm6025236ejl.26.2021.06.22.05.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 05:41:36 -0700 (PDT)
Subject: Re: [PATCH v2 01/17] staging: rtl8723bs: remove all 5Ghz network
 types
From:   Hans de Goede <hdegoede@redhat.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
 <96b241e97e425a3115305b3d6658037e1e4c862c.1624364582.git.fabioaiuto83@gmail.com>
 <56ec67b9-a4a3-48ec-efe0-493ddc30365d@redhat.com>
Message-ID: <5af94a0d-af54-818f-d2ae-62f099db3dea@redhat.com>
Date:   Tue, 22 Jun 2021 14:41:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <56ec67b9-a4a3-48ec-efe0-493ddc30365d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/22/21 2:41 PM, Hans de Goede wrote:
> Hi,
> 
> On 6/22/21 2:29 PM, Fabio Aiuto wrote:
>> remove all 5Ghz network types. rtl8723bs works on
>> 802.11bgn standards and on 2.4Ghz band.
>>
>> So remove all code related to 802.11a and 802.11ac
>> standards, which the device doesn't support.
>>
>> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
>> ---
>>  drivers/staging/rtl8723bs/core/rtw_ap.c       | 10 +---
>>  .../staging/rtl8723bs/core/rtw_ieee80211.c    | 22 ++------
>>  drivers/staging/rtl8723bs/core/rtw_mlme.c     | 10 ----
>>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 55 -------------------
>>  .../staging/rtl8723bs/core/rtw_wlan_util.c    | 14 +----
>>  drivers/staging/rtl8723bs/hal/odm.c           | 30 ----------
>>  drivers/staging/rtl8723bs/hal/odm.h           |  3 -
>>  .../rtl8723bs/hal/odm_EdcaTurboCheck.c        |  4 +-
>>  drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  5 --
>>  drivers/staging/rtl8723bs/include/hal_phy.h   |  3 -
>>  drivers/staging/rtl8723bs/include/ieee80211.h | 22 +-------
>>  drivers/staging/rtl8723bs/include/wifi.h      |  1 -
>>  drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  2 +-
>>  13 files changed, 14 insertions(+), 167 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
>> index 23bbdf084631..b0abadd4b4dd 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
>> @@ -343,10 +343,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
>>  
>>  	if (pcur_network->Configuration.DSConfig > 14) {
>>  		if (tx_ra_bitmap & 0xffff000)
>> -			sta_band |= WIRELESS_11_5N;
>> -
>> -		if (tx_ra_bitmap & 0xff0)
>> -			sta_band |= WIRELESS_11A;
>> +			sta_band |= WIRELESS_INVALID;
> 
> sta_band will now not be touched if tx_ra_bitmap is say 0x20, where as
> before it would be ore-d with WIRELESS_11A. Please make the or-ing with
> WIRELESS_INVALID unconditional (removing both "if (tx_ra_bitmap & 0x...)"
> checks). Also make sure to reduce the indentation level of the
> sta_band |= WIRELESS_INVALID; by 1 tab when dropping the if.

p.s.

The rest of the set looks ok to me.

Regards,

Hans

