Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8CD41B0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbhI1Ni2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241265AbhI1NiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:38:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A03C061775
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:35:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z2so3523510wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+HKRLx1qfRAGEaEJ+dH+2Jga7eTetiBWo1FhI8Xv+L0=;
        b=dbG1rUMlJAjo9116A7poZnsvFtd+EEbkBeztu6vNU5OqO/LsBMOWAbQXI9hazHLZD1
         AGIR2k55ld9daL7Pd7grb9cH9H2GZDLYkx+QYMkU19bJUE8r2BVcBchVORb8VOD8XeoM
         juTSSlEkEch8GXZscE5vEdnfUuyUlF3Dp0+qBjxkWxWg3dcQZFKK8fT9j7Ba5SH72Cqh
         JHUxNEbFMDzGMQZ1Q0PDzz//v0x38+Jt/BVXTWvqUpxZUQkU0kwdz6nFG6wjsIPfrjx4
         fzxfWTo4XtwxDz1Mc2kSH84Jh7GmP/FXbMDKglHSqI3cdjwHVS9aqyLhdGx0S15gkVN1
         d8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+HKRLx1qfRAGEaEJ+dH+2Jga7eTetiBWo1FhI8Xv+L0=;
        b=mstJ/AUw3ZSD0h6vUpKZLLMBPQPAQU6wmybVkBY+a8k9YibwAI4MNUwrxWCoFw7CCA
         aM12C2KjWy54AfAzcIMHQiDTVbbZ6jXlyzVGfBIts7VeVtOXcDitulJgp+CvGRyXk4mn
         Q7sM4WEeSGAI6HWxsy3Kk5q11gjwLzwn762mVClebwV6PEyL3tLS/JrkoNeCLBDvm37a
         LmSXYylfmc2gwUWbgjacinAHRMDWFxj5v0DcAhzDJt0AUoTrsu03+DO3oC+kOY7LuwhJ
         vtAnELr9HFXAOhavlijQJA32t/hVeAP1k3NRA+O86oPBBiM5o8gSBGyvz7zT4txMf16F
         8QdA==
X-Gm-Message-State: AOAM533hKd5QA+FZbTNJ2psoe2sTaARkjQpb8iL8dI4bbrMm4z/r194D
        7dbmOXD4rQAY8aL5Ky140wCumA==
X-Google-Smtp-Source: ABdhPJwIUi8c1xv/o+nz3AByLJ3UUbR7IsdiH7YsKeP5cp8/f2SmECSlZv/3bF14eANJTl0fKUTivg==
X-Received: by 2002:a05:600c:1d05:: with SMTP id l5mr4783590wms.119.1632836132151;
        Tue, 28 Sep 2021 06:35:32 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:269:e210:8445:bcf4:c79d:3156? ([2a01:e0a:269:e210:8445:bcf4:c79d:3156])
        by smtp.gmail.com with ESMTPSA id r2sm3077677wmq.28.2021.09.28.06.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 06:35:31 -0700 (PDT)
Subject: Re: optee: regression with kernel v5.14 (virtualization)
To:     Volodymyr Babchuk <vlad.babchuk@gmail.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
References: <a0e1c245-8209-a173-18c4-d21433bf46bf@forissier.org>
 <CAOcqxo339CS63i5sMdweqx3MO7ME9TxFPJe-p-ESWME=vSzLwg@mail.gmail.com>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <cbcae077-3ebe-42b0-cbfe-cf5491f9ee0e@forissier.org>
Date:   Tue, 28 Sep 2021 15:35:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAOcqxo339CS63i5sMdweqx3MO7ME9TxFPJe-p-ESWME=vSzLwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/21 3:15 PM, Volodymyr Babchuk wrote:
> Hi Jerome,
> 
> On Tue, 28 Sept 2021 at 16:08, Jerome Forissier <jerome@forissier.org> wrote:
>>
>> Hi,
>>
>> I met an issue when testing OP-TEE with the latest released kernel
>> (v5.14). The kernel won't boot when virtualization is enabled. More
>> precisely, the boot hangs as the optee driver is probed. The last line
>> on the console is:
>>
>> [xxx] optee: probing for conduit method.
>>
>> The issue can easily be reproduced in the QEMU OP-TEE environment as
>> documented in [1]:
>>
>> $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
>> $ repo sync -j10
>> $ cd linux
>> $ git fetch github --unshallow
>> $ git checkout v5.14
>> $ cd ../build
>> $ make -j2 toolchains
>> $ make -j10 XEN_BOOT=y run
>>
>> [Note, if you switch between XEN_BOOT=y and the default build, you need
>> to "make arm-tf-clean"]
>>
>> git bisect points at commit b5c10dd04b74 ("optee: Clear stale cache
>> entries during initialization") and reverting this commit on top of
>> v5.14 does resolve the issue.
>>
>> Any idea what's wrong?
> 
> Yes, there was a small mistake in the mediator. My colleague already
> pushed the patch. It is at staging now:
> 
> http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=1c3ed9c908732d19660fbe83580674d585464d4c
> 
> And will be backported to Xen 4.13+

Awesome :) Thanks Vlad!

-- 
Jerome
