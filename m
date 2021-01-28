Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01123076B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhA1ND6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:03:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231679AbhA1ND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611838950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2ph27LsnJWE/vNqq5QXePd70W1JBZ6Ej3HYrxh7gn8=;
        b=M9TXj9U+1UZAY5qTN6/49xIGltom7WCNzVb/UggURLiQVDelJCwVx/pR7r0F02ArpB+kKx
        +F3KsEpq0DzN6oQFnkgqHO4NrzNP6hggSKKWJlhk964kuxtfgTPuAEkvUHnMQQ5fHdeM3G
        0lbLTdf3riqMTEZtqLigR9v/K+5mpGQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-wypQ61oNMB-xJXmwS99e-g-1; Thu, 28 Jan 2021 08:02:28 -0500
X-MC-Unique: wypQ61oNMB-xJXmwS99e-g-1
Received: by mail-ed1-f70.google.com with SMTP id v19so3125461edx.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R2ph27LsnJWE/vNqq5QXePd70W1JBZ6Ej3HYrxh7gn8=;
        b=WSVeIdO2fiw0GbqoFedv+x0KVYlXlYhDz7V5+NGUYnLFUkGH9VXmCjfc2S5z+Ix/zK
         paEquHe55sP3CrKQWQiQ0F/041/7ewFVk5+hrax4BPXttXyshquWFWY4QOIEjG8CEYz9
         6mRgCpLpqzuvQljWhuE6lh/FhEOJSSE+OFKHi2pDRoC1lLAljK4ZArqnhmRxq2o6fmDM
         nDY31LtXH2FD2EeI9zQNyhnABtJ6ZCyIGuGuLiDSMP4Em5/+wXKJDgvjpq8qp8v1Ry9e
         JL1qTyQ+6HvHjhjS5XD6gZup4N4CDtmSO0wVLGwkaAIMLWsAG/F0YIP/E/Dmb1mj/IS0
         +/Uw==
X-Gm-Message-State: AOAM530v93IMzT9sdAlHO0DzFegd3lHu8c51lIXUv2LELQ3e5yrWMQjL
        2rnNsWAevHEiMT3qo8yZ9jYA1N07VcbvNb8BIi7aG1Gnm+pxYlkeVOMToliVohHojDJlscViyph
        1m709ypMQfsik6rYwqeLbn7a3ehInnCUEux3pyE0XFYMIIMvKGN0OfgvPNVivw/Rcsq1wtdaYj2
        fg
X-Received: by 2002:a05:6402:1383:: with SMTP id b3mr6832499edv.131.1611838947351;
        Thu, 28 Jan 2021 05:02:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz56w8vVCEHtOHUL50ezdOWF0eUZrlkOctieZfcvY9MRquWig4nHRkLqOdFIXP388lr7rSpIg==
X-Received: by 2002:a05:6402:1383:: with SMTP id b3mr6832469edv.131.1611838947126;
        Thu, 28 Jan 2021 05:02:27 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id t11sm2842107edd.1.2021.01.28.05.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 05:02:26 -0800 (PST)
Subject: Re: 5.11 new lockdep warning related to led-class code (also may
 involve ata / piix controller)
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Dan Murphy <dmurphy@ti.com>,
        linux-ide@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b204637d-3b72-8320-8a62-f075467d8681@redhat.com>
 <20210112223015.GB28214@duo.ucw.cz>
 <f344f1db-1a7a-0a80-1cb1-f9c3fbf83abd@redhat.com>
 <0ec34bca-f7e0-8954-c253-d07ed6b71b80@redhat.com>
 <20210127220134.GC23419@amd>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cc1cac99-e3de-9585-bfa0-db7b013e8a80@redhat.com>
Date:   Thu, 28 Jan 2021 14:02:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210127220134.GC23419@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/27/21 11:01 PM, Pavel Machek wrote:
> Hi!
> 
>>>>> Booting a 5.11-rc2 kernel with lockdep enabled inside a virtualbox vm (which still
>>>>> emulates good old piix ATA controllers) I get the below lockdep splat early on during boot:
>>>>>
>>>>> This seems to be led-class related but also seems to have a (P)ATA
>>>>> part to it. To the best of my knowledge this is a new problem in
>>>>> 5.11 .
>>>>
>>>> This is on my for-next branch:
>>>>
>>>> commit 9a5ad5c5b2d25508996f10ee6b428d5df91d9160 (HEAD -> for-next, origin/for-next)
>>>>
>>>>     leds: trigger: fix potential deadlock with libata
>>>>     
>>>>     We have the following potential deadlock condition:
>>>>     
>>>>      ========================================================
>>>>      WARNING: possible irq lock inversion dependency detected
>>>>      5.10.0-rc2+ #25 Not tainted
>>>>      --------------------------------------------------------
>>>>      swapper/3/0 just changed the state of lock:
>>>>      ffff8880063bd618 (&host->lock){-...}-{2:2}, at: ata_bmdma_interrupt+0x27/0x200
>>>>      but this lock took another, HARDIRQ-READ-unsafe lock in the past:
>>>>       (&trig->leddev_list_lock){.+.?}-{2:2}
>>>>
>>>> If I'm not mistaken, that should fix your issue.
>>>
>>> I can confirm that this fixes things, thanks.
>>>
>>> I assume that this will be part of some future 5.11 fixes pull-req?
>>
>> This *regression* fix seems to still have not landed in 5.11-rc5, can
>> we please get this on its way to Linus ?
> 
> Is it a regression? AFAIK it is a bug that has been there
> forever... My original plan was to simply wait for 5.12, so it gets
> full release of testing...

It may have been a pre-existing bug which got triggered by libata changes?

I don't know. I almost always run all my locally build kernels with lockdep
enabled and as the maintainer of the vboxvideo, vboxguest and vboxsf guest
drivers in the mainline kernel I quite often boot local build kernels inside
a vm.

So I believe that lockdep tripping over this is new in 5.11, which is why
I called it a regression.

And the fix seems very safe and simple, so IMHO it would be good to get
this into 5.11

Regards,

Hans

