Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA3431228
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhJRIcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230439AbhJRIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634545808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lR6lHYfqRurTTNb2hz8P0iYHasRUVyst8KmFnIo9LRo=;
        b=KsQUqau4JshIEk29QH2az6xsdJ+EvM8hAz22BwLMXzDgC72EV0YnqU3XiRuB5CzEJrYh8c
        U2VoLTcgdK372KtPzQm9Wgjg3u0ClF/dxP+xMukRWp0OP0ZDUX26oe/FExSqVkENJyJFKx
        bHtdeG5TlrFaeThwVVh6ne3oOVmB9FI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-h26DcC2QNmS5tH6FnD_YiA-1; Mon, 18 Oct 2021 04:30:06 -0400
X-MC-Unique: h26DcC2QNmS5tH6FnD_YiA-1
Received: by mail-ed1-f71.google.com with SMTP id z23-20020aa7cf97000000b003db7be405e1so13703296edx.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lR6lHYfqRurTTNb2hz8P0iYHasRUVyst8KmFnIo9LRo=;
        b=DV+G8mAFFsU7FSz1mf2P3PofBkRU/VfjOQoNLwVv0z5JId7P2oRQINFC9/ah30tbHt
         Dx608Wm5NWpTqjg6XV2UPLkdR2tpf6WdmJ9kuYmLV20rjf6jHsGL7Ak4f+0+9EYqMHwg
         NfvaiM//Jlx1aObZ2PvoenoCV2UQKBnW+uvpJmg8k0gK7hS430Pfyem3pdrddEjlvPcK
         Psxa7T6Mdu6Lg0RF3OqN/aVgCdcRZaC/xQ6vn6tuAl1ZorMVkzja9QG/miDdirSJi4jc
         Obv2GsYetH8h5FiKFihjpktbqm7Bg/So2aJOvoBmxxki7adtRjS/x/sw+DfZX2yxx1oO
         ZUkQ==
X-Gm-Message-State: AOAM531xWqoCthGqraNKKjk8vbJxQ/54zRFSKigBuj9sZCD7KqIjfYmo
        GtKAZ6Ez7uPo4DPdT2bgqpe9PumxNjfPfgwqyybEwUqpKH+FOQIsNxyBImdSFe4d5yeVS1koJR9
        1H1sZVPH88tghHy5Du536tRL0
X-Received: by 2002:a50:fc17:: with SMTP id i23mr41133539edr.213.1634545805608;
        Mon, 18 Oct 2021 01:30:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrMhc7vcU2jV67qg01VSMajYU77IH44uhxXbXszh8rSXTGCseftvgmQJ1sKU52iD4gsvpnIg==
X-Received: by 2002:a50:fc17:: with SMTP id i23mr41133507edr.213.1634545805463;
        Mon, 18 Oct 2021 01:30:05 -0700 (PDT)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id q23sm8925974ejr.0.2021.10.18.01.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 01:30:05 -0700 (PDT)
Message-ID: <103b5438-9f7c-7e89-28b9-29fe11eb818c@redhat.com>
Date:   Mon, 18 Oct 2021 10:30:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [BUG 5/5] [BUG] media: atomisp: atomisp causes touchscreen to
 stop working on Microsoft Surface 3
Content-Language: en-US
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Patrik Gfeller <patrik.gfeller@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211017162337.44860-1-kitakar@gmail.com>
 <20211017162337.44860-6-kitakar@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211017162337.44860-6-kitakar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/17/21 18:23, Tsuchiya Yuto wrote:
> Touchscreen input works fine before loading atomisp driver on Surface 3.
> 
> However, after loading atomisp driver, touchscreen works only when
> capturing images. This sounds like atomisp turns off something needed
> for touchscreen when atomisp is idle.
> 
> There is no useful kernel log. Just the touchscreen stops working
> with no log.
> 
> I'll update if I find something further. First of all, can someone
> reproduce this issue on the other devices?

My first bet would be some regulator getting turned off.

What you can do is:

1. ls -l /dev/bus/i2c/devices

And then write down the number of the i2c-bus to which the
CRC PMIC is connected, lets say it is number "4". Then:

2. Before loading the atomisp drivers run:
   "sudo i2cdump -y -f 4 0x6e > crc-regs-good"

3. After loading the atomisp drivers run:
   "sudo i2cdump -y -f 4 0x6e > crc-regs-bad

4. "diff -u crc-regs-good crc-regs-bad"

And see what changed.

There are 2 possible root causes here:

1. Some regulator is shared between the cameras and
touchscreen

2. The crc code in atomisp which you are using is
poking registers assuming the Bay Trail version of
the Crystal Cove PMIC (aka CRC PMIC) but your
Surface 3 has the Cherry Trail version and we know
that the regulators are add different register
addresses there, see the comment in:
drivers/acpi/pmic/intel_pmic_chtcrc.c
so it is possible that the atomisp code is simply
poking the wrong register for one of the regulators

I also wonder if this goes away if you do the

	hrv = 0x03;

Hack inside drivers/mfd/intel_soc_pmic_core.c ?

Without that we end up using the wrong PMIC
OpRegion driver which also uses the wrong
regulator addresses.

Regards,

Hans


p.s.

Here are the 2 different regulator drivers the
comment in drivers/acpi/pmic/intel_pmic_chtcrc.c
refers to:

https://github.com/Zenfone2-Dev/android_kernel_asus_moorefield-1/blob/stock/drivers/regulator/pmic_crystal_cove.c
https://github.com/Zenfone2-Dev/android_kernel_asus_moorefield-1/blob/stock/drivers/regulator/pmic_crystal_cove_plus.c

