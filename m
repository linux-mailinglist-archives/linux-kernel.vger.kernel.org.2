Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776F53AC9BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhFRLZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231240AbhFRLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624015414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaKo1mrmMJtUIlZg1JMv5hfVSdfXZesaUam0Bk5hUBc=;
        b=N4zIH5t+HjixjYlQ0W6LBYAF1ZPeZBbRI0M0MRYAAe3vLP/KRKY4gidyL8027XpfDdVigD
        tkPwYlMz9eODq5Z8qowV7g25hNsESjvlYy1D5eCD0r/qbqbYRj72rXB16KqsT4g0xUJKuM
        jQDg+Mph60bX4LYk2WrSg/iTk/Tu6jY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-Cabmns4uPkSnBYeAzxsUAQ-1; Fri, 18 Jun 2021 07:23:33 -0400
X-MC-Unique: Cabmns4uPkSnBYeAzxsUAQ-1
Received: by mail-ej1-f71.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso3800484ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CaKo1mrmMJtUIlZg1JMv5hfVSdfXZesaUam0Bk5hUBc=;
        b=lYwF8ZlJugy3z2XHzI50hfCuQh9jk1NPJidTEjIjFsYMjy/2n9U91J9xlyYX6I/2bj
         Dsuw6x7f+buWwvzLmygpTJhmR4Cp6P2LzZICjB0G1rqBFzeNMK1SJ5I3eGM02//XrOxM
         J0Pjxv7BSlfJJmOE97xKH5+orNyGN/dJkzzRkbrfSokkMsjmfh3YYccvUx3xYFaThr16
         KImpahmBlfphlJch/Q1LVRwiicV2U1QUlEAGQQ0k4/uWPdhP8d8ssHbkc37h5/0rF6cR
         0DEAwi4h1fu3zilB99YfWZmcRIDCSzKYUyerMSO922XP0/J89ZOG2xVe8X8r+pGF0zpL
         ChIA==
X-Gm-Message-State: AOAM532ITUpnaSk93Dy5w8cYrLjYchrUFcZeJXXj9iLb+T9/SKEmsRbd
        gTICxXm2wuLuJx5zZatQp/JeTPl0bU32w+ArhF/YOoE4LmjbzqjaNb+GRElT43XjVZO9dIvmq4b
        XUMHfzNXbsD6aq+kMv2zIetk2vFiC7qwLgrLj/kfLRCAED6/2uhptzes3F4rGJ2Nex5du87PjdG
        F7
X-Received: by 2002:a05:6402:51cf:: with SMTP id r15mr4203632edd.263.1624015411735;
        Fri, 18 Jun 2021 04:23:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBCZ3MT8wZ1z2RiBuPHONZucYHG2kQITyGncjCaLfOKetllVSe9SUBYwsGGkV6IDKgGwg/Vg==
X-Received: by 2002:a05:6402:51cf:: with SMTP id r15mr4203616edd.263.1624015411586;
        Fri, 18 Jun 2021 04:23:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e6sm909373ejm.35.2021.06.18.04.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 04:23:30 -0700 (PDT)
Subject: Re: [GIT PULL] Immutable branch between drivers/platform/x86 and
 drivers/extcon due for the v5.14 merge window
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CGME20210617140425epcas1p146979efb16135032d9c2bc7666ecd825@epcas1p1.samsung.com>
 <667247a0-e40a-84d9-889b-8ecf51e5d453@redhat.com>
 <cde62fb0-835b-11a4-871b-e140019a2f58@samsung.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bf19a601-426e-4814-e820-dde6e58876e3@redhat.com>
Date:   Fri, 18 Jun 2021 13:23:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cde62fb0-835b-11a4-871b-e140019a2f58@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/18/21 4:30 AM, Chanwoo Choi wrote:
> Hi Hans,
> 
> Thanks for immutable branch.
> I think again that you better apply them via your tree
> for merging them to linus tree finally without extcon tree.
> I'm sorry about change of my opinion.

That is fine, I've already merged the branch into my tree.

If you end up needing it for some changes for 5.14 after all
feel free to also merge it into your tree.

Regards,

Hans



> On 6/17/21 11:04 PM, Hans de Goede wrote:
>> Hi Chanwoo,
>>
>> As discussed here is a pull-req from an immutable branch with the
>> devm-helper changes from Matti for you to merge into the extcon tree.
>>
>> I have already merged this into my review-hans branch and once the
>> builders had a chance to play with this I will push this
>> branch to platform-drivers-x86/for-next.
>>
>> Regards,
>>
>> Hans
>>
>>
>> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
>>
>>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/devm-helpers-v5.14-1
>>
>> for you to fetch changes up to 87ee8de23c9df3a368504f34cf3d7f9be9207717:
>>
>>   extcon: extcon-max8997: Simplify driver using devm (2021-06-17 13:22:27 +0200)
>>
>> ----------------------------------------------------------------
>> Signed tag for the immutable devm-helpers branch for merging
>> into the extcon and pdx86 trees.
>>
>> ----------------------------------------------------------------
>> Matti Vaittinen (5):
>>       devm-helpers: Add resource managed version of work init
>>       extcon: extcon-max14577: Fix potential work-queue cancellation race
>>       extcon: extcon-max77693.c: Fix potential work-queue cancellation race
>>       extcon: extcon-max8997: Fix IRQ freeing at error path
>>       extcon: extcon-max8997: Simplify driver using devm
>>
>>  drivers/extcon/extcon-max14577.c | 16 +++++---------
>>  drivers/extcon/extcon-max77693.c | 17 +++++----------
>>  drivers/extcon/extcon-max8997.c  | 45 ++++++++++++++--------------------------
>>  include/linux/devm-helpers.h     | 25 ++++++++++++++++++++++
>>  4 files changed, 50 insertions(+), 53 deletions(-)
>>
>>
>>
> 

