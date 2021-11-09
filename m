Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F3A44B30C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbhKITNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242976AbhKITNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:13:47 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A7C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:11:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b40so17297919lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 11:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3dMD3vZvuDQ0djbS/4DFZZATwHikZqOYB51ibGROWgE=;
        b=WZnw2LVDP46V8ABuEjQbkx8VXEUd+AUF15RZuTUgRDIWNfD8OSFgjliunOIJEeJ3CF
         Bdek8f0KNElDnvmdjMzgscwv+s54EdcjbdCUFn/79kNcw3CWVYT0FRaFm4y1UAkjjQMm
         qPs4JP5xU5paxHaNQQzTtsnLskG3SYOADbWyklcOnnyo2Zi8HlZCMSyoGJuPmofrLeg3
         Z8BQ680BFdHjjisWAOFggX51+OOsEpJAB/s4zn8cuiuQT2xBQql/5aNfX6/H6BPATvfR
         EI8Drq8yiX1s3W2IqVm/Y4tPTpESRM1wLhiODSuYaNyz5pOcieL8hmxTgTsftp9f6DIk
         qoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3dMD3vZvuDQ0djbS/4DFZZATwHikZqOYB51ibGROWgE=;
        b=BIxBlWwyGsWBJhN2n/aenxYgYkVaEQqbx/YPc8IPIbpXrcP9RNpbnNgb612Wy/88Ov
         Zv4iB5uIcHfiiVRjsOY7lh2AMc6xC0wV8Ryh79r/EFoFPJiHJ+TfAAkiQvLdUoV/61XD
         1jZRXlW5VdDsLQdzBsb+ose2Y9jJpnnNpM7amXoXF3axOG96Lo2DMz/9UT1RoOyUw+ev
         Q9Xo5nSBFfmbeVbNGC2geG4k0MO6mw4eY7L2MKc5CoiEmeaJ+N9jRPEUYBxEaiHBxjWE
         mCHCq+SvxYEDvw2t7SHIy1CSkRS9uQr1mVzvsP3VXVMab3E5qf3KIDSoGZepyY0h1Y8y
         AlQA==
X-Gm-Message-State: AOAM531mpCLANqsCcbMj3Zq8jKBzYsa8qljw0Qot7F4UKb0IThOPlFtM
        pokMuin7wktd98tOBe86942nkoEG2R0=
X-Google-Smtp-Source: ABdhPJwcIHjK6uFUm3bw5CfBEp4fjqEqWG4tbbRj03/gGxQ/SYN2hVIC1KkILC67QHe+OpYYZVT4MA==
X-Received: by 2002:a05:6512:220d:: with SMTP id h13mr4399858lfu.593.1636485058446;
        Tue, 09 Nov 2021 11:10:58 -0800 (PST)
Received: from [192.168.1.11] ([94.103.224.112])
        by smtp.gmail.com with ESMTPSA id be30sm276228lfb.3.2021.11.09.11.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 11:10:57 -0800 (PST)
Message-ID: <d047dc51-1259-6885-fba7-0d72a375d799@gmail.com>
Date:   Tue, 9 Nov 2021 22:10:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] tty: n_gsm: add missing tty_kref_put
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
        hdanton@sina.com
Cc:     linux-kernel@vger.kernel.org
References: <20211109103930.27494-1-paskripkin@gmail.com>
 <8e7d4214-01b8-d1a7-adaf-f2135cb6431a@kernel.org>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <8e7d4214-01b8-d1a7-adaf-f2135cb6431a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/21 20:33, Jiri Slaby wrote:
> On 09. 11. 21, 11:39, Pavel Skripkin wrote:
>> My local syzbot instance hit memory leak in gsmld_attach_gsm(). The
>> reproducer injects allocation failure in tty_register_device(). After
>> this error only previous tty_register_device() calls unwinded, but not
>> tty_kref_get().
>> 
>> It leads to tty_struct leak, because ->close() won't be called in case
>> of ->open() failure and nothing puts tty reference.
> 
> I don't have time to check the n_gsm case now (like: are you talking
> about tty->open/close or file_ops->open/close -- they behave
> differently), but tty definitely calls close even if open fails.
> 

Oh, I see now. I wasn't aware about this difference. Will do more 
detailed analysis of reported leak. Thank you for pointing it out!




With regards,
Pavel Skripkin
