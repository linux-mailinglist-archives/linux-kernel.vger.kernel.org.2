Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F3411715
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbhITOcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbhITOch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:32:37 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FFDC061760
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:31:10 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y197so8690864iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nUGscvNM/zLUz+jkukR9/occjIw2xuBxW4X/OtBJO/U=;
        b=P7900Cu1CnwgwPkODPlKtrVH1QR1/GWWa8h6dFTyv5C3xaAUITE1hVLPFpWLXH6EVy
         NvjKJwJEA5eczumWplTeDYTSEfAjm9Uy2+sGnaqQjf5lLs815h7pS55PFFXvh+BqLLI3
         2GYDseqbdW9xI7XqKcpnnzbJHi4l/DwUwKkx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nUGscvNM/zLUz+jkukR9/occjIw2xuBxW4X/OtBJO/U=;
        b=20PQfFVpdeJ4pcTcdEjLoCUIIkgcQNd+SuzH17FnAtPvcfh+YmC4npDY2GX+Ti3JcV
         1Ky/AdG8TDL8VSLrlE3ApW38qcFNt70A7OfIMHESJdNWtmK90X8pU301K7eLX/9P+4xd
         yIhUvPnzQt5hoGIfjcycbp3E2WpJ+hE02/ee9n5xmTcjcvjcRXSsnf9e9ItMnmifImq/
         Lx1G0P9z3FVGgoLyhhWeTw1jrV9ffgg1+z0rCi/r4a9M9FLEoyp8YslcPmI39YP+cHHf
         FyWFqtFEyOMA5Ycu3H2Y7pms/mNzIs0LVEf5wCaeP5WWtjWFdF5ZPf6eC3SdkaewLvg+
         fnqw==
X-Gm-Message-State: AOAM533BYH72jMroQE8UaUQF7RgyKWSJrGtmzJlcM9gFWuQ+Z6zY5Gol
        G/eAKn1BA5AlSME1mm4Sei4A1w==
X-Google-Smtp-Source: ABdhPJw0Q8/jKc+JjPIS2JzLJJMcIzIKbYNooXTm/QAPzav03FkXbnmRSPQwC3h9b8/zzOJoKIwjPg==
X-Received: by 2002:a6b:b4d3:: with SMTP id d202mr18895924iof.8.1632148270222;
        Mon, 20 Sep 2021 07:31:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b19sm8421040ilc.41.2021.09.20.07.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 07:31:09 -0700 (PDT)
Subject: Re: INFO: task hung in hub_port_init
To:     Alan Stern <stern@rowland.harvard.edu>,
        Hao Sun <sunhao.th@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        a.darwish@linutronix.de, johan@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        oneukum@suse.com, Shuah Khan <skhan@linuxfoundation.org>
References: <CACkBjsYQxQxGQwb3YS4obVWH3EODzqky5=nM3ADP7+13hBYgAA@mail.gmail.com>
 <20210913135459.GA120302@rowland.harvard.edu>
 <CACkBjsZcg0B=tF8cr54VqaJMVURD9R463epZqRQfesnoY=+L8g@mail.gmail.com>
 <20210918020245.GA69263@rowland.harvard.edu>
 <CACkBjsZPjO96NzLjKR2N7bYzBJRN6sPuaDpK6cvmGqKTd=Byow@mail.gmail.com>
 <20210918135301.GA79656@rowland.harvard.edu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2d776f5b-c6b5-1c05-de37-493fc10a97af@linuxfoundation.org>
Date:   Mon, 20 Sep 2021 08:31:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210918135301.GA79656@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/21 7:53 AM, Alan Stern wrote:
> On Sat, Sep 18, 2021 at 10:17:26AM +0800, Hao Sun wrote:
>> Alan Stern <stern@rowland.harvard.edu> 于2021年9月18日周六 上午10:02写道：
>>>
>>> On Sat, Sep 18, 2021 at 09:56:52AM +0800, Hao Sun wrote:
>>>> Hi Alan,
>>>>
>>>> Alan Stern <stern@rowland.harvard.edu> 于2021年9月13日周一 下午9:55写道：
>>>>>
>>>>> On Mon, Sep 13, 2021 at 11:13:15AM +0800, Hao Sun wrote:
>>>>>> Hello,
>>>>>>
>>>>>> When using Healer to fuzz the Linux kernel, the following crash was triggered.
>>>>>>
>>>>>> HEAD commit: ac08b1c68d1b Merge tag 'pci-v5.15-changes'
>>>>>> git tree: upstream
>>>>>> console output:
>>>>>> https://drive.google.com/file/d/1ZeDIMe-DoY3fB32j2p5ifgpq-Lc5N74I/view?usp=sharing
>>>>>> kernel config: https://drive.google.com/file/d/1qrJUXD8ZIeAkg-xojzDpp04v9MtQ8RR6/view?usp=sharing
>>>>>> Syzlang reproducer:
>>>>>> https://drive.google.com/file/d/1tZe8VmXfxoPqlNpzpGOd-e5WCSWgbkxB/view?usp=sharing
>>>>>> Similar report:
>>>>>> https://groups.google.com/g/syzkaller-bugs/c/zX55CUzjBOY/m/uf91r0XqAgAJ
>>>>>>
>>>>>> Sorry, I don't have a C reproducer for this crash but have a Syzlang
>>>>>> reproducer. Also, hope the symbolized report can help.
>>>>>> Here are the instructions on how to execute Syzlang prog:
>>>>>> https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md
>>>>>>
>>>>>> If you fix this issue, please add the following tag to the commit:
>>>>>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>>>>>
>>>>> There's not much hope of finding the cause of a problem like this
>>>>> without seeing the kernel log.
>>>>>
>>>>
>>>> Healer found another Syzlang prog to reproduce this task hang:
>>>> https://paste.ubuntu.com/p/HCNYbKJYtx/
>>>>
>>>> Also here is a very simple script to execute the reproducer:
>>>> https://paste.ubuntu.com/p/ZTGmvFSP6d/
>>>>
>>>> The `syz-execprog` and `syz-executor` are needed, so please build
>>>> Syzkaller first before running the script.
>>>> Hope this can help to find the root cause of the problem.
>>>
>>> I don't have time to install and figure out how to use Healer and
>>> Syzkaller.  But if you run the reproducer and post the kernel log,
>>> I'll take a look at it.
>>>
>>
>> Just executed the reproducer, here is the full log:
>> https://paste.ubuntu.com/p/x43SqQy8PX/
> 
> The log indicates that the problem is related to the vhci-hcd driver
> somehow.  I don't know why those "Module has invalid ELF structures"
> errors keep appearing, starting in line 1946 of the log.
> 
> Alan Stern
> 

Thank you. I will take a look.

thanks,
-- Shuah
