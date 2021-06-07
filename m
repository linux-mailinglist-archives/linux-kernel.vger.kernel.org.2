Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119EB39D8D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFGJdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230382AbhFGJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623058313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHD0Geg6PY8ubcouSBs9vdWbJxbFB69CphmPr5caBHo=;
        b=DFDL7B6MQst9HB8coqtjGJtTu6TpmoFxD27XuZ7n1Xt2F5mA8cR/ay9fQMq8Q6L69cuoqZ
        UjIKUXyKpVtXYIpZSZrzvCxqU49k8q+byyf1kYkhdV1MbQB2mI4lELbs5BoEQkjTgpnQy7
        L7VOCIooXBXiiuEkcmtKwan0TPgL7yg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-LN0N43BeOS6aHVHtjaYY9A-1; Mon, 07 Jun 2021 05:31:51 -0400
X-MC-Unique: LN0N43BeOS6aHVHtjaYY9A-1
Received: by mail-ed1-f72.google.com with SMTP id j13-20020aa7de8d0000b029038fc8e57037so9020413edv.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 02:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tHD0Geg6PY8ubcouSBs9vdWbJxbFB69CphmPr5caBHo=;
        b=aZz3DZqbmfXpDrxMD/DrEaOFXU37v4qsM4EEN99L9Jz2sTJx0CKsrAgGXGiHp3+e70
         mRsuWchfaf3if857fLdkMLRyp9UADERW6xr5wTtQB7jFkuGfUFH66oibr5/je4QZA3QF
         sbrMrjOxvl+lS99AEcUaYBn4Q+fuonUZB6PL0hGWEDSZW7yx20SgH+R7ECYjq+qXbXrD
         cUSdyOrorsi7DcJFGLfhkkjZH6Yb4OLLgKAkV3vFPjQsY2nBmENBwlkNIAX4zIG4T5GH
         sAINfbq62i2S1JmDCWfuBexQ1lcFBWZCY6jk9CrhJW+rh15p+Jbcn9MvfIuoBTKBNfKN
         Xj5g==
X-Gm-Message-State: AOAM533/jg0jBC6gaiArdCTW1xNC/hjFbaUNZoyTAXAyoSaPql4g89fI
        R/uJ6oes7u18/skYKKjHZ3qN6qvqtK4yBHRvomgt7IP2BoHjZEGUQd3MwG4nJYiH4nVaou8lA0J
        1tMkBo72gbP8qg5Dn40cvGM2fg/AK/xOLZqWuzrgpLff5M4t8S6SBnKfGbP5k26LhTt9olrZUUl
        SH
X-Received: by 2002:a17:906:4e91:: with SMTP id v17mr17320106eju.119.1623058310340;
        Mon, 07 Jun 2021 02:31:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmmxVAzYUtrmbi1btwBl25An+a/ioM1AYpSZjef+xp36C5YJG3/w5tSRVdRAS1P7kwelwGLQ==
X-Received: by 2002:a17:906:4e91:: with SMTP id v17mr17320078eju.119.1623058310090;
        Mon, 07 Jun 2021 02:31:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r19sm7430288eds.75.2021.06.07.02.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 02:31:49 -0700 (PDT)
Subject: Re: [PATCH 19/34] docs: driver-api: surface_aggregator: avoid using
 ReSt :doc:`foo` markup
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
 <c42fe427e6538ce7914645468ef63f83254c26d7.1622898327.git.mchehab+huawei@kernel.org>
 <91d72412-3bba-8a50-4527-7c8fb9fa54c4@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1663da2c-571f-cf7d-a0ca-ea7031515b40@redhat.com>
Date:   Mon, 7 Jun 2021 11:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <91d72412-3bba-8a50-4527-7c8fb9fa54c4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/5/21 4:14 PM, Maximilian Luz wrote:
> On 6/5/21 3:18 PM, Mauro Carvalho Chehab wrote:
>> The :doc:`foo` tag is auto-generated via automarkup.py.
>> So, use the filename at the sources, instead of :doc:`foo`.
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

Mauro, I assume that you are going to take care of sending this
to Linus, or do you want me to merge this patch into the pdx86 tree?

Regards,

Hans


> 
>> ---
>>   .../surface_aggregator/clients/index.rst          |  3 ++-
>>   .../driver-api/surface_aggregator/internal.rst    | 15 ++++++++-------
>>   .../driver-api/surface_aggregator/overview.rst    |  6 ++++--
>>   3 files changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/driver-api/surface_aggregator/clients/index.rst b/Documentation/driver-api/surface_aggregator/clients/index.rst
>> index 98ea9946b8a2..30160513afa5 100644
>> --- a/Documentation/driver-api/surface_aggregator/clients/index.rst
>> +++ b/Documentation/driver-api/surface_aggregator/clients/index.rst
>> @@ -5,7 +5,8 @@ Client Driver Documentation
>>   ===========================
>>     This is the documentation for client drivers themselves. Refer to
>> -:doc:`../client` for documentation on how to write client drivers.
>> +Documentation/driver-api/surface_aggregator/client.rst for documentation
>> +on how to write client drivers.
>>     .. toctree::
>>      :maxdepth: 1
>> diff --git a/Documentation/driver-api/surface_aggregator/internal.rst b/Documentation/driver-api/surface_aggregator/internal.rst
>> index 72704734982a..8c7c80c9f418 100644
>> --- a/Documentation/driver-api/surface_aggregator/internal.rst
>> +++ b/Documentation/driver-api/surface_aggregator/internal.rst
>> @@ -87,10 +87,11 @@ native SSAM devices, i.e. devices that are not defined in ACPI and not
>>   implemented as platform devices, via |ssam_device| and |ssam_device_driver|
>>   simplify management of client devices and client drivers.
>>   -Refer to :doc:`client` for documentation regarding the client device/driver
>> -API and interface options for other kernel drivers. It is recommended to
>> -familiarize oneself with that chapter and the :doc:`ssh` before continuing
>> -with the architectural overview below.
>> +Refer to Documentation/driver-api/surface_aggregator/client.rst for
>> +documentation regarding the client device/driver API and interface options
>> +for other kernel drivers. It is recommended to familiarize oneself with
>> +that chapter and the Documentation/driver-api/surface_aggregator/ssh.rst
>> +before continuing with the architectural overview below.
>>       Packet Transport Layer
>> @@ -190,9 +191,9 @@ with success on the transmitter thread.
>>     Transmission of sequenced packets is limited by the number of concurrently
>>   pending packets, i.e. a limit on how many packets may be waiting for an ACK
>> -from the EC in parallel. This limit is currently set to one (see :doc:`ssh`
>> -for the reasoning behind this). Control packets (i.e. ACK and NAK) can
>> -always be transmitted.
>> +from the EC in parallel. This limit is currently set to one (see
>> +Documentation/driver-api/surface_aggregator/ssh.rst for the reasoning behind
>> +this). Control packets (i.e. ACK and NAK) can always be transmitted.
>>     Receiver Thread
>>   ---------------
>> diff --git a/Documentation/driver-api/surface_aggregator/overview.rst b/Documentation/driver-api/surface_aggregator/overview.rst
>> index 1e9d57e50063..26415e1ab7da 100644
>> --- a/Documentation/driver-api/surface_aggregator/overview.rst
>> +++ b/Documentation/driver-api/surface_aggregator/overview.rst
>> @@ -73,5 +73,7 @@ being a direct response to a previous request. We may also refer to requests
>>   without response as commands. In general, events need to be enabled via one
>>   of multiple dedicated requests before they are sent by the EC.
>>   -See :doc:`ssh` for a more technical protocol documentation and
>> -:doc:`internal` for an overview of the internal driver architecture.
>> +See Documentation/driver-api/surface_aggregator/ssh.rst for a
>> +more technical protocol documentation and
>> +Documentation/driver-api/surface_aggregator/internal.rst for an
>> +overview of the internal driver architecture.
>>
> 

