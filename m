Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC5401DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbhIFP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 11:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhIFP6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 11:58:04 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1DEC061575;
        Mon,  6 Sep 2021 08:56:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s12so12096131ljg.0;
        Mon, 06 Sep 2021 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WAFFW6/E8EkAvweZY81x+iHepjZ6KxIjBe1d7SWBGig=;
        b=m6IHXg16nPUehvniIXt2wEQRG7xJNr3Iq8VmXeQ5N4LnmQBlePMkh9ygL/w16WFTg2
         I1VTMCs9FvKpZfpPOi08YaWrzkbYkyy06nbNv7ddEhph2rgypaKyN9cdWGZxa/rTPBFe
         FjxFIKrCxlL4XOe14SbElHfAuGguueunOInzhx9vXtUdBrRt1tUPtnbEIhYAKEZkQiUy
         LcYiy/wTB358MUWsT4e1zLu01TDGPmLcmrIePHqFALnd3OMBdMmDlCU8i6cIr1xPlIRY
         1Vz17xwsPOPGLtTKHStpXboYsz7UTOUY9rVFYjTaOh8YubCHjb2lHoDak3Qz0XEiuKj1
         qWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WAFFW6/E8EkAvweZY81x+iHepjZ6KxIjBe1d7SWBGig=;
        b=l9sEv/uezipQqZcj710L50bwTURpM2H9lQZDK/PIkTsQ+ZK+PhvinnAi9h9718CH06
         mdDkn0KEk38o3WYx5IlsBR5+3RiIHnPD4zeSx3gPzxiHUX0TfkE0zgKt/duj6R40qMqK
         aVz2COxONq1uTDev861YLULQhRTvQn21zAE02iF2me4/W7a9aHeEXgwoYHrXWBNdDF3l
         4lyJ/IkoY9lYdR8gnm5kqzADImb5/oDKhvLUyiEs4cP2+k6S67afs0xZI5V3a4ek0euY
         xf9wdowOE1QDxUiTO/EhnBosS0UUODeHkhZTstrgzU/Ak2SoQ6RkHT1nySBNhrfwJa9B
         q8QQ==
X-Gm-Message-State: AOAM5335Trr7isXLIWJ2BxwUBxvnDSPn5LVSVNc2p9jpKcfQKxYy1SyB
        RNTBif0qzcGcjXgoXS6HcHy1W+9ONAP99xLb
X-Google-Smtp-Source: ABdhPJzAsHE50IUNcv8F4R2c/MEKF3PdVGA+YyMZKO2xleqFLceGAoautRqiL48HCki7E75mzEo7Yg==
X-Received: by 2002:a05:651c:3d9:: with SMTP id f25mr11128682ljp.334.1630943818118;
        Mon, 06 Sep 2021 08:56:58 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.70])
        by smtp.gmail.com with UTF8SMTPSA id m20sm1094587ljc.20.2021.09.06.08.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 08:56:57 -0700 (PDT)
Message-ID: <aa2fb8c6-ef6b-a1ca-d598-b0814529a31d@gmail.com>
Date:   Mon, 6 Sep 2021 18:56:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] nilfs2: fix memory leak in
 nilfs_sysfs_create_device_group
Content-Language: en-US
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210906041330.2065214-1-mudongliangabcd@gmail.com>
 <CAD-N9QUHfoqOOxDuKniMi8VGLR2j6g50BBy45eAL0kPRrntmgA@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAD-N9QUHfoqOOxDuKniMi8VGLR2j6g50BBy45eAL0kPRrntmgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 08:43, Dongliang Mu wrote:
> On Mon, Sep 6, 2021 at 12:13 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>>
>> The commit 8fd0c1b0647a ("nilfs2: fix memory leak in
>> nilfs_sysfs_delete_device_group") adds a kobject_put to free the leaking
>> object name. However, it is incomplete to only add kobject_put in the
>> nilfs_sysfs_delete_device_group. The function
>> nilfs_sysfs_create_device_group also needs the kobject_put to
>> free the object name in the error handling part.
>>
>> Fix this by adding kobject_put in the error handling code of
>> nilfs_sysfs_create_device_group.
> 
> Even after I add this patch, my local syzkaller still reports this
> memory leak one hour later. Therefore, there are some other paths or
> magics which can trigger the memory leak. I need to dig deeper.
> 
> Pavel, do you have any idea about this crash report?
> 
> BUG: memory leak
> unreferenced object 0xffff88804a1a8a60 (size 32):
>    comm "syz-executor", pid 14551, jiffies 4294960586 (age 14.780s)
>    hex dump (first 32 bytes):
>      6c 6f 6f 70 35 00 00 00 00 00 00 00 00 00 00 00  loop5...........
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff814750c6>] kstrdup+0x36/0x70
>      [<ffffffff81475153>] kstrdup_const+0x53/0x80
>      [<ffffffff822773a2>] kvasprintf_const+0xc2/0x110
>      [<ffffffff82337c5b>] kobject_set_name_vargs+0x3b/0xe0
>      [<ffffffff823385ed>] kobject_init_and_add+0x6d/0xc0
>      [<ffffffff81d2bd08>] nilfs_sysfs_create_device_group+0x98/0x3a0
>      [<ffffffff81d14fc4>] init_nilfs+0x424/0x580
>      [<ffffffff81d02962>] nilfs_mount+0x532/0x8c0
>      [<ffffffff815c754b>] legacy_get_tree+0x2b/0x90
>      [<ffffffff81565158>] vfs_get_tree+0x28/0x100
>      [<ffffffff815a3a82>] path_mount+0xb92/0xfe0
>      [<ffffffff815a3f71>] do_mount+0xa1/0xc0
>      [<ffffffff815a4584>] __x64_sys_mount+0xf4/0x160
>      [<ffffffff8433fd35>] do_syscall_64+0x35/0xb0
>      [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> 

Hi, Dongliang!


This report says nothing to me... It shows, that there is missing 
kobject_put() somewhere. I think, we need a reproducer for this leak, 
otherwise only code review can help :(



With regards,
Pavel Skripkin
