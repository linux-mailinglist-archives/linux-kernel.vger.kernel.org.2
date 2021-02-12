Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D88B319801
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 02:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhBLBfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 20:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBLBe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 20:34:57 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9B1C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 17:34:17 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id m17so7782917ioy.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 17:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nLSVT/3K/d+V6LmzIJ4zu7aoXAT7SsfZZAWVq1kvt2s=;
        b=Z9nw1SFqr60JaKtmLsmbkYseFquzMC7ZbY4bUEaWB4g6FE8Bhr2UkNpSkhaed6Ikn2
         7Nt19MZv407n1joagUG5LR4MdSWmTIeSlxvnoDhEpiLWjtvWHpdMZqdTvyYojvtX9x2N
         iuGGGpR1UPyFUKbU/DiVh/65g2hk7bS/oJB3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nLSVT/3K/d+V6LmzIJ4zu7aoXAT7SsfZZAWVq1kvt2s=;
        b=QmkAvBlO96iygY4Z2BTJJjF+lTe6Ps4qiUYjijEMrtF32ejPXw2NwvUFk6oC+w1f3B
         F8e4aRXhZ5LqTXiYMg0NbmaUEe3YTvxVFy1pyxBHB/NDmtkhwAnR4xIItmYgp9RTYdwa
         XoyHQIlPlbUH1KunOo9peu9xrl4pB0jDXOzov1hezQIH7W8DBmW8HkpQ4SkBZCrMb67m
         La2DIEyFhJ0qlt0ZoGM/wdaNlfBi013t2ZtZaX2y6Sz2X6cdMmPR0ZImObL+e3WGwWlS
         EXJcIrdYHrmraFITqqVXFcJgwEEgzDHzbIbh7/Ti6uiFsO3Bd04m57TqfTAigwATfsKs
         JeUQ==
X-Gm-Message-State: AOAM530rBonlw07LuRvZ/iHj0pTOXkBjSynj3Qiyg68Nmuv/8/Hnl5Py
        TBLMpvELuzc8qImdhQrFEc5QAg==
X-Google-Smtp-Source: ABdhPJx8mp26QsR37q/b32UWc/QlbqKBQzQsK2LoytxrvGOffNIi60YelPpWvyuoDsbXSbhf2pXLyw==
X-Received: by 2002:a05:6602:1541:: with SMTP id h1mr416890iow.171.1613093656164;
        Thu, 11 Feb 2021 17:34:16 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k8sm3331046ilu.4.2021.02.11.17.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 17:34:15 -0800 (PST)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <000000000000647eff05b3f7e0d4@google.com>
 <20201113120055.11748-1-hdanton@sina.com>
 <5f71e0c1-d387-6d72-d8e4-edb11cf57f72@linuxfoundation.org>
 <ea4028b7-53f2-aeaf-76e7-69874efcdec5@I-love.SAKURA.ne.jp>
 <2b70d360-a293-4acb-ea6c-2badda5e8b8b@linuxfoundation.org>
 <9bdd3f10-bddb-bd87-d7ad-b4b706477006@i-love.sakura.ne.jp>
 <6b8da36f-a994-7604-77f4-52e29434605f@linuxfoundation.org>
 <5f9ec159-77d8-ffba-21d1-2810e059f998@i-love.sakura.ne.jp>
 <a06093f1-22b3-7d72-bc6c-f99f4e0d0de9@linuxfoundation.org>
 <40617d66-1334-13a0-de9b-bd7cc1155ce5@i-love.sakura.ne.jp>
 <43d8d6bf-53f3-11e6-894d-c257f7f4bd07@linuxfoundation.org>
 <4368349b-fc0c-6da3-a502-2733f953d271@i-love.sakura.ne.jp>
 <92a4c6ae-172d-91cb-b89e-8eb857fdfb3a@linuxfoundation.org>
 <d177302a-3050-41db-cf44-6d614fd0c3a0@i-love.sakura.ne.jp>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e5cb1f77-cd4b-9d74-4f28-d613d5478704@linuxfoundation.org>
Date:   Thu, 11 Feb 2021 18:34:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <d177302a-3050-41db-cf44-6d614fd0c3a0@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 6:14 PM, Tetsuo Handa wrote:
> (Dropping LSM ML because this is not a TOMOYO's bug.)
> 
> On 2021/02/11 4:29, Shuah Khan wrote:
>> This is a good find. I already replied to the thread to send a complete
>> fix.
> 
> As I said at https://lkml.kernel.org/r/f8cae6b1-8f84-0e6a-7d9c-fc4aec68f07b@i-love.sakura.ne.jp ,
> the as-is patch is effectively a complete fix. And applying the as-is patch should help spending
> syzbot resources for reproducing "general protection fault in tomoyo_socket_sendmsg_permission"
> with debug printk() patch applied, which in turn will help you in
> 
>> Right. I would like to get a clear understanding of how this condition
>> is triggered. I am not saying this isn't a problem. Understanding how
>> it is triggered helps find the best fix.
> 
> part. Therefore, I strongly expect you to apply this version now.
> 

Is there a reproducer for this problem?

thanks,
-- Shuah
