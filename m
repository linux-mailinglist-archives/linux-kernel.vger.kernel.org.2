Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B14E3CD68E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbhGSNoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241087AbhGSNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:44:08 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B776C061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:50:47 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so18348226otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7/qq3wyUV7N73BKpIHcRfvtIpGGk0m3CwLVAIa8erWo=;
        b=i+k6lzbQu/gYTazdC+tDJ+VqdJU6OFUmm3rB+LR3/2M/9mHGl/O662JrlUjlhCJc7e
         ZiJYreKouyfxkeiODkVVMvE41hTmVEAlG29kukXUrZ8czMj1LYShWI6tH+UNJvVMN3CT
         aJyhBcrwvQfiOI+nlPUAk9g0yq6Vpa3U7S/PHgQuO5sd9Gi4dD+ECGAZAwq1Xjdksqcs
         G2LR1m+G4OH60VqMYPePCoYzWde4SJdY/C+zBkr08pfbXPtpyWzEcENPmN8FnOyCClGF
         OcNw1i6IQbEKmoKfsGdXCPJYdJ8t/SPX1T7m3MADjcJwpocz2qmqSMQx7V/MnXUD5p1X
         leSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/qq3wyUV7N73BKpIHcRfvtIpGGk0m3CwLVAIa8erWo=;
        b=cvRcNVhaj2TXltBXUIoL9OWaO6lUI8eXMphlyK7y/cmYbN3J6Mf0QjkTZhy6laTSOr
         RU9EzV/K5jpT9PIBosqIrvQ+a56Tvx6eLv3dFvHynud3eLhWPXlfduRBZkMHoKp0gjlq
         WZBT0OywQnss6w6ONgXaAHeav1JFXR+n5hg1qS2rxR5E72S5hTLfvXVzp03FHeoYW1Dr
         OCGJ6mtNlofyWuybciYJffKK6Qptz7IeHacZc7YvPdJLfdRcPaktbXKXpO1ghdMGjNib
         il9VaISbhqG5A2BmfRth+pM3jT8qqrrtjKFk6FKEaTzw9yDQhGytpcbctG8xGxtTdRca
         Zi1A==
X-Gm-Message-State: AOAM530zk9LUh6aF0TdpDG0YZM7SkP7Do0LFbvVPwOW+Wun0sGxIQ460
        /rdeg9n+66RcRnEKK2Js4N/cuK7d9yA=
X-Google-Smtp-Source: ABdhPJx+VI2LTCuw35AamWFKyfBdlpvyzZmsV1/KxXQqjbQo5sFs3G6o6Fdv92eq+ScsT3IPzd7ANQ==
X-Received: by 2002:a9d:638f:: with SMTP id w15mr470201otk.148.1626704686753;
        Mon, 19 Jul 2021 07:24:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 48sm3584391otf.13.2021.07.19.07.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 07:24:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <a7a801d2-13d2-7b5b-66a5-98e7c95b00cc@gmail.com>
 <5e1b5d90-5a1e-5e9f-7b92-6c53b8589c2a@gmail.com>
 <cd14a8b0-0a27-77a8-6dc2-3268f9f09922@roeck-us.net>
 <e1bb4768-5517-8ef3-eaf3-bbfc103fa918@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
Message-ID: <9a2bf544-2aaa-d175-bc0a-c8bcefd8141a@roeck-us.net>
Date:   Mon, 19 Jul 2021 07:24:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e1bb4768-5517-8ef3-eaf3-bbfc103fa918@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 7:00 AM, Akira Tsukamoto wrote:
> 
> On 7/19/2021 10:51 PM, Guenter Roeck wrote:
>> Hi,
>>
>> On 7/19/21 5:53 AM, Akira Tsukamoto wrote:
>>>
>>> This patch will reduce cpu usage dramatically in kernel space especially
>>> for application which use sys-call with large buffer size, such as
>>> network applications. The main reason behind this is that every
>>> unaligned memory access will raise exceptions and switch between s-mode
>>> and m-mode causing large overhead.
>>>
>>
>> I had to revert the original patch from the mainline kernel prior to applying
>> this patch. Obviously that means that there may be other changes affecting the
>> outcome.
>>
>> riscv64 images work, but riscv32 images still fail with this patch applied.
>> The error is a bit different than before, though.
>>
>> ...
>> [   11.899979] Run /sbin/init as init process
>> [   12.152666] random: fast init done
>> moun: applet not found
>> "�����V�t: applet not found
>> /bi�����V�F-: applet not found
>> moun: applet not found
>> swaon: applet not found
>> hostname-F: applet not found
>>
>> After this, the image hangs.
>>
>> For comparison, the mainline kernel (v5.14-rc2) fails as follows.
>>
>> [   10.788105] Run /sbin/init as init process
>> Starting syslogd: OK
>> Starting klogd: OK
>> /etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
>> /etc/init.d/S20urandom: line 1: syntax error: unterminated quoted string
>> Starting network: /bin/sh: syntax error: unterminated quoted string
>> sed: unmatched '/'
>> /bin/sh: syntax error: unterminated quoted string
>> FAIL
>> /etc/init.d/S55runtest: line 48: syntax error: EOF in backquote substitution
>>
>> I'll be happy to provide information on how to reproduce the problem
>> if needed. Please let me know.
> 
> Yes, I do would like to know the procedure of build instruction of your rv32 image.
> Then I would reproduce the error and look into how to fix it.
> 
Please have a look at http://server.roeck-us.net/qemu/riscv32/
and let me know if you need anything else.

Thanks,
Guenter
