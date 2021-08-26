Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55A53F8C32
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbhHZQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 12:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbhHZQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:30:58 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559A0C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:30:11 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w19so5337871oik.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PR6KS+LXmrB0wt1ro7MtuwxKA0BwjesWn81kF/Hh73o=;
        b=AM52ANEjB1wjDtg5u0w3dUVHlvaCeFU7zNFXBKAVADkcLRaXOr8R35HZxRA+DHfSPA
         c4QNHowNEkY5Jk4K5di1VpK4wftb/9RT+8AaGKEzRqNYLLKdauZ5ooEa6BjGR5ryDeeU
         VKAH5WXXxFEcyTnSoQKJFW/RSbY82pXn/fpDzyM/CtjhjuonFoznoMz4utCqb1fsOByh
         sbswO5g1BItyRP1OuENauus5ZL4303PTCXC6L/MjDHN1bTHUOrabmyWiHeDZLz4ePif2
         ln5jV4k0b71nDR0m3Wc/GdjCei0R7FT74eRymBiM12w0VgxYbO9YApLrM/mHCdUXF0FJ
         qDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PR6KS+LXmrB0wt1ro7MtuwxKA0BwjesWn81kF/Hh73o=;
        b=RDz6HJBONYACxO/x436e/WpuR3OulHPM3HrvHheD/bQRuhf6yXwVwZx+GJf0Jgw6b/
         ax+4al1RjKA5CeNIMSgy07LVoE31vFVVOFAN8W4RjVAi9kENjmoe/N1zeaQJyxxRWYI3
         kPn/gGyta8GsvaO98lSAeDL0wXJmY4oRnGYev2E/sfAgrifpmVsd8CHczepGRy9EcF2S
         MFOQX7fDBmX9NNrBnRVXUq3FrXbtyeJmwAq97Vn3nVnuaHa7XERL11xuFuY2zvuU78IS
         29PbLnq4gwQWTW5mq5FgvsytHt/Ld2MrDN/ZQ2vlE4z1aJJRa6V6cRUujXFm6OFI9EIh
         +OKQ==
X-Gm-Message-State: AOAM532MSo3FHIUDnFX/GcaHdqEwOK4mjW/24zVfr15/5P7PBQ61N/Io
        H7yZjBabLFbyUd1x3Qb16mxDF/xQeF0=
X-Google-Smtp-Source: ABdhPJyVBNWuH5oIxvYrXIJ0pd7Q1tY/uP5Ha/WLE2hcf3L3xPtuzoee7t2YXz3RHvfP3qr2+QNapA==
X-Received: by 2002:aca:df88:: with SMTP id w130mr3113319oig.82.1629995410455;
        Thu, 26 Aug 2021 09:30:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a23sm671483otp.44.2021.08.26.09.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 09:30:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] coresight: syscfg: fix compiler warnings
To:     Doug Anderson <dianders@chromium.org>,
        Jian Cai <jiancai@google.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>, coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210825222514.2107728-1-jiancai@google.com>
 <CAD=FV=VAkWz0QSN7GivNrkv9uv3JKisush4C+Tb-PMpNokt8Wg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a9aa266a-7481-a991-508b-8c32cd03f519@roeck-us.net>
Date:   Thu, 26 Aug 2021 09:30:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VAkWz0QSN7GivNrkv9uv3JKisush4C+Tb-PMpNokt8Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 9:19 AM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Aug 25, 2021 at 3:25 PM Jian Cai <jiancai@google.com> wrote:
>>
>> This fixes warnings with -Wimplicit-function-declaration, e.g.
>>
>> ^[[1m/mnt/host/source/src/third_party/kernel/v5.4/drivers/hwtracing/coresight/coresight-syscfg.c:455:15: ^[[0m^[[0;1;31merror: ^[[0m^[[1mimplicit declaration of function 'kzalloc' [-Werror,-Wimplicit-function-declaration]^[[0m
>>          csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev), GFP_KERNEL);
>> ^[[0;1;32m                     ^
>>
>> Signed-off-by: Jian Cai <jiancai@google.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Can you figure out which patch introduced these warnings and add a "Fixes" tag?
> 

Assuming the SHA is stable, that would be commit 85e2414c518a
("coresight: syscfg: Initial coresight system configuration")

Guenter
