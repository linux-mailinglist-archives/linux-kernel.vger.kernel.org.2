Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666BD406832
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 10:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhIJIOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 04:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhIJIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 04:13:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74CEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 01:12:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me10so2537611ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EOKvDtzwjunGPuQOGKDW/L4dAb4gmvdSgTdv7lJgq8U=;
        b=cfGNT3rSDcav3gXps0yYky3dlzG79x2l0eTNFRhtglIdinRYqMcRUJzeWXcWkNNFGt
         W0jIpB0/6nldv7GCEP3ghRjpKimYurlWywsstZHnOHSGfgX71b2w/o8MFg3x39kNvb5Y
         ooHMORkog7C3K3clgHMtegyRV1TWjfXyx2vL746t4tGIUc0gtWtF+OAibt8GlUihNaXJ
         rNR1Lad7/fmw0nuuLQ4ULnKQDZOmcQgWCu7d309G2MvtlO8ZrfO1EwqJe2pk2fT8SsAN
         zJTZk5xJZ6ehSt69FsVegcgtPzlR3WL2qdpBjNi96YU4l7Ggs8+Lyl0mm5xcgTQkIAhI
         WYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EOKvDtzwjunGPuQOGKDW/L4dAb4gmvdSgTdv7lJgq8U=;
        b=c5glvLQJ9npNZOqilizDzcOmjagN4MaLIrnDsAWKjdIJ/XJnnDK/0JHLLWK0xHaUID
         bEgJVzcXxR+A8kh1jgfxn+SDO3TI7rhBVcZr+GLLhKZFLMaoNR4BPSVt9yFAVLr0oyKS
         N/MLfn15nAKcbnVvKLtxhN3ArfgBS1AZ1cr/YFU3ntgqP7N+vQ3wfufCq6nzmyNJcIyx
         7+WHcvtwid1kk9SyPFwDelDUHkLyXZk6MKQ8kGvCBXTLX1psy02N7Y0dxZofCVIMG/UJ
         PkWYuIH6OtiEBaTkLA1+EaCaQVnMFJEiYJkv2RD4/teStbu722rmFODDYATSQg8VYTV0
         ZZlA==
X-Gm-Message-State: AOAM531G2J2MAFHImb5spk7qQTVtwr52IaRKGxBvK1VmGlPyVjTMWxZk
        snwCgSVpDrELxF/tW38k51g=
X-Google-Smtp-Source: ABdhPJzQFKhN+QGRZXluYqzge96WMM/7oQmvVkkK52I3OdFCd0Wo8OM5Dlncb8dAzQ5luCA3Eo+/QQ==
X-Received: by 2002:a17:906:d045:: with SMTP id bo5mr8045221ejb.461.1631261567476;
        Fri, 10 Sep 2021 01:12:47 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::1db2? ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id x15sm2071613ejc.59.2021.09.10.01.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 01:12:47 -0700 (PDT)
Message-ID: <658d7835-810e-19bd-30fa-a54fb0954592@gmail.com>
Date:   Fri, 10 Sep 2021 10:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] staging: rtl8723bs: remove unused macros from
 ioctl_linux.c
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210909211922.24872-1-straube.linux@gmail.com>
 <d39f410e-ac89-54e1-5c54-a17bdc5ebc49@redhat.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <d39f410e-ac89-54e1-5c54-a17bdc5ebc49@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/10/21 08:24, Hans de Goede wrote:
> Hi,
> 
> On 9/9/21 11:19 PM, Michael Straube wrote:
>> These macros are not used in the driver, remove them.
>> Found with GCC -Wunused-macros.
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 

Thanks for reviewing.

Regards,

Michael
