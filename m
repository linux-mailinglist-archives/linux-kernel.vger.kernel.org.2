Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5B239D94A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFGKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230193AbhFGKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623060479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4DJcwRNKgr1OBDo4WX+IJbKHUeQSd/tstLULEr3UeRI=;
        b=RXS72OtPnrY9feFrmbvZI24q9orC3IscnjaQ3EP1rvx5YaGNSu5yHj70THM3Vnuayl2aDp
        RjKGrx0fwq9MXWuGT92S+u9sNnkXDYH8yVlSEHKN6PjpfY1alfLh8IYwhWRJEJI9HMo2Ib
        qvqZ1YGYr7/ld7m+tdEra+0P7V/9ogM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-KfbPzzGTPfO7xqtHmJs9Zw-1; Mon, 07 Jun 2021 06:07:57 -0400
X-MC-Unique: KfbPzzGTPfO7xqtHmJs9Zw-1
Received: by mail-ej1-f70.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso5085307ejo.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 03:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4DJcwRNKgr1OBDo4WX+IJbKHUeQSd/tstLULEr3UeRI=;
        b=XqfqyxtnFg5WXGVMbHpnzuUuIDHhDJfutICLMeA8eTtAHDIMTXZZcaRhh+Iy+Wn0n2
         /19Sp67g8a2iWJph/BHCGlhYKeovw/WIkde4/78Lz7Y6l8UZf3cam4iBf/hHF2VVKqzI
         pwzT7nRlNCD/2GxP9PiqbAkHVtCRPBtf/q4HeS7FCfWOna4Jp1V5YfcXk7zQDSqWs+9L
         1O9w5BA1cRXsI6o/IpkuuWa9WEbGGJAqTR4d+XDQfB71BP6kc6afUTxlNCagMCLB6121
         DtDqlecxaHrDJVdQ44FcNc33GSWagTi+d/Qm+oKaCd5poWPbD3JMsQzduLUN41gzeWnD
         nPYA==
X-Gm-Message-State: AOAM531te/bJxW9LbL9/LbjGQ8vqerQsoOyQBDie2A7TPfxqikxxVQ80
        kazAA4l4LcCB58zY6XsT6wxlCp549clRd/zHoGcObqTwSCID9836Kx1KmJ+EgqaJP8kgOipSf7B
        LSoOLVqfvaO4o5LMIS9gd1bfIRg6dLujPszzA1d7QnaljE96or3/edMKGn+d4p+j8ME4N7VQ4Kz
        ze
X-Received: by 2002:aa7:c4d0:: with SMTP id p16mr19752206edr.150.1623060476244;
        Mon, 07 Jun 2021 03:07:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj4Vq4xUy4Dtd0hVocAhAt3wVsI2rZmbsL8IEfrCWhphyW+TcptupAZdlm8P3Gc3nncXAvHQ==
X-Received: by 2002:aa7:c4d0:: with SMTP id p16mr19752190edr.150.1623060476115;
        Mon, 07 Jun 2021 03:07:56 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f18sm6324272ejz.119.2021.06.07.03.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 03:07:55 -0700 (PDT)
Subject: Re: [PATCH 19/34] docs: driver-api: surface_aggregator: avoid using
 ReSt :doc:`foo` markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
 <c42fe427e6538ce7914645468ef63f83254c26d7.1622898327.git.mchehab+huawei@kernel.org>
 <91d72412-3bba-8a50-4527-7c8fb9fa54c4@gmail.com>
 <1663da2c-571f-cf7d-a0ca-ea7031515b40@redhat.com>
 <20210607115535.0181e679@coco.lan>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <28662dee-dd1b-761a-488a-e4af92a8ddfc@redhat.com>
Date:   Mon, 7 Jun 2021 12:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607115535.0181e679@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/7/21 11:55 AM, Mauro Carvalho Chehab wrote:
> Hi Hans,
> 
> Em Mon, 7 Jun 2021 11:31:49 +0200
> Hans de Goede <hdegoede@redhat.com> escreveu:
> 
>> Hi,
>>
>> On 6/5/21 4:14 PM, Maximilian Luz wrote:
>>> On 6/5/21 3:18 PM, Mauro Carvalho Chehab wrote:  
>>>> The :doc:`foo` tag is auto-generated via automarkup.py.
>>>> So, use the filename at the sources, instead of :doc:`foo`.
>>>>
>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
>>>
>>> Acked-by: Maximilian Luz <luzmaximilian@gmail.com>  
>>
>> Mauro, I assume that you are going to take care of sending this
>> to Linus, or do you want me to merge this patch into the pdx86 tree?
> 
> Whatever works best for you and Jon, as it should either be merged
> via each maintainers' tree or at the docs tree ;-)

I think it is probably easiest if Jon just picks up the entire series.

Jon, please let me know if you want me to merge this patch.

Regards,

Hans

