Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC43E3E3DC5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhHIBnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232678AbhHIBnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628473370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rTF4KN0UK9//z3ziSnguQwQKDmEwhKYc9DW20kNcmw=;
        b=OHkDR2tzz7F0F+sx4abl4o/dnpCf0gC7ledLKd46AWoGfCnzcO/Ff/zXMUmTItxo7rakU3
        d4g1lTSnd6bkDUBsy9Vbh++KXxQDZ9ua8CPqHBxJAf187EcuzFPGcr0mI3mm5NJZkKXS/t
        Xfcei89VGYziu9bFaWK1sB/H/+A8AbM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-QWHXAH6IN3KxeGBKG0Do1Q-1; Sun, 08 Aug 2021 21:42:49 -0400
X-MC-Unique: QWHXAH6IN3KxeGBKG0Do1Q-1
Received: by mail-qt1-f197.google.com with SMTP id k2-20020ac847820000b029024ea3acef5bso6934909qtq.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 18:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9rTF4KN0UK9//z3ziSnguQwQKDmEwhKYc9DW20kNcmw=;
        b=NZTD1zAsFhoIsA3Jaf9CutAxF7YYI6X5LriAVxElHH8TzVRL7DlP6e9oi2AmVFx+jm
         MEitgRPm4XqdneCiapSe8gg3lj3TPedo8rETPhzlbfXyrecILpSiUD13iLyKwa8qEvhz
         eoDCwAndiXmZyaNdfQBMuF0+oHRoFgcU28c79VMlkEzG+r9HSTIRzZ+oUwbHuGsx4XKb
         E5aalqFM2rlrNyVQ2c1poFh2ZqrDOEzL39pGzk1snAgczm2lWKhcleX6MlaCvuTaFbd4
         Q29ml68JAFl5uhZUaQnQonAxusZI3FmLcoObp2imONmnQNB+NzTyH6WkHN9r0BT519kp
         jkuQ==
X-Gm-Message-State: AOAM531It6aMYn3+fg9/ldEcjctzAUkJcJ2wHbAyeOMblTm/BcxQPtg+
        563ZSvxhJJ/BmbXjcYTXz5auQWUpzHVnXocFUAAz/l8AbGJfPTBhH3VOnuuTXeP9DkB3d9x07uD
        Nmn7d4/XrH3o6F8Cru4bE/PdzWvqo5nokukEB567FqMJQLc2GlHYDV39j3cf/cxkTPv4SyWc1ag
        vv
X-Received: by 2002:a05:6214:c23:: with SMTP id a3mr4360929qvd.46.1628473368325;
        Sun, 08 Aug 2021 18:42:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNOCH1+/DEVeooTgguT1SmXYJYQW6XatXCh3aIwd0KlOIOQsDS7Y37EpaJV9y17WfaB9tOCQ==
X-Received: by 2002:a05:6214:c23:: with SMTP id a3mr4360910qvd.46.1628473368162;
        Sun, 08 Aug 2021 18:42:48 -0700 (PDT)
Received: from jtoppins.rdu.csb ([107.15.110.69])
        by smtp.gmail.com with ESMTPSA id r29sm8463927qkm.43.2021.08.08.18.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:42:47 -0700 (PDT)
Subject: Re: [PATCH net-next 2/2] bonding: combine netlink and console error
 messages
To:     Leon Romanovsky <leon@kernel.org>
Cc:     netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1628306392.git.jtoppins@redhat.com>
 <a36c7639a13963883f49c272ed7993c9625a712a.1628306392.git.jtoppins@redhat.com>
 <YQ+vDtXPV5DHqruU@unreal>
From:   Jonathan Toppins <jtoppins@redhat.com>
Message-ID: <14b506c3-7e8d-f313-b585-4e7ff1a542cf@redhat.com>
Date:   Sun, 8 Aug 2021 21:42:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQ+vDtXPV5DHqruU@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/21 6:16 AM, Leon Romanovsky wrote:
> On Fri, Aug 06, 2021 at 11:30:55PM -0400, Jonathan Toppins wrote:
>> There seems to be no reason to have different error messages between
>> netlink and printk. It also cleans up the function slightly.
>>
>> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
>> ---
>>   drivers/net/bonding/bond_main.c | 45 ++++++++++++++++++---------------
>>   1 file changed, 25 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index 3ba5f4871162..46b95175690b 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1712,6 +1712,16 @@ void bond_lower_state_changed(struct slave *slave)
>>   	netdev_lower_state_changed(slave->dev, &info);
>>   }
>>   
>> +#define BOND_NL_ERR(bond_dev, extack, errmsg) do {		\
>> +	NL_SET_ERR_MSG(extack, errmsg);				\
>> +	netdev_err(bond_dev, "Error: " errmsg "\n");		\
>> +} while (0)
>> +
>> +#define SLAVE_NL_ERR(bond_dev, slave_dev, extack, errmsg) do {	\
>> +	NL_SET_ERR_MSG(extack, errmsg);				\
>> +	slave_err(bond_dev, slave_dev, "Error: " errmsg "\n");	\
>> +} while (0)
> 
> I don't think that both extack messages and dmesg prints are needed.
> 
> They both will be caused by the same source, and both will be seen by
> the caller, but duplicated.
> 
> IMHO, errors that came from the netlink, should be printed with NL_SET_ERR_MSG(),
> other errors should use netdev_err/slave_err prints.
> 

bond_enslave can be called from two places sysfs and netlink so 
reporting both a console message and netlink message makes sense to me. 
So I have to disagree in this case. I am simply making the two paths 
report the same error in the function so that when using sysfs the same 
information is reported. In the netlink case the information will be 
reported twice, once an an error response over netlink and once via printk.

-Jon

