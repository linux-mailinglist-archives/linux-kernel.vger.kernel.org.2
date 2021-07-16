Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B943CB0C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhGPC3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231700AbhGPC31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626402391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HbfQj6sCW3EDzaZcinPsyqAoy710pIqDnhr0KpSvvyo=;
        b=KbCvt9lbGIy3zQmFBWjaAjablbl1gMuLKsCZZ91E/6d5T5UkefE/IHLOw+ZYQjxhN68z34
        hZEr5YwNDglwkKbiGrq/vIPshLRHjWrjOzuuS+S6ULV8SDwBoNxN9QHC2Yy4z9/Xyd1tFd
        L08vPoEo1kmwff887F4aPDq5CSmMCKI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-3RUF3qJdMryc3l1lZyE_4Q-1; Thu, 15 Jul 2021 22:26:29 -0400
X-MC-Unique: 3RUF3qJdMryc3l1lZyE_4Q-1
Received: by mail-pl1-f199.google.com with SMTP id z13-20020a170903408db0290129a6155d3cso1839310plc.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 19:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HbfQj6sCW3EDzaZcinPsyqAoy710pIqDnhr0KpSvvyo=;
        b=ZBMx8ET9Yli0tQQlDQRkeG1ROBEeQ6xURfROoPo2QTvcy+H1T1hjyPjOetn9i4OHKi
         KSPZog98Zu27pBCNIcLlt5SKsyxrU5RHBanhZCX+afVJvu5NQOmog5MN0X6pYhrmnvQb
         qSMYGULWyfsoCiZv4lMXhy3kkrl8DBysYdlxMg6za4BD/nwOfkel4r+HwawMNolY9is8
         Mg9W+s/mA9ukvYkP5OCtyQEIaYSG/YeVwrV3gS98QmVsyenyEzvABS9It1Pa9TrlkPwI
         FpXq+QbUvZsXPBkFmES+BpVAZUHCnFeAvogaCRls8ETlIMlBU+dmZqaSXYb4I6JrcC9t
         n9yw==
X-Gm-Message-State: AOAM530CRGdEHyIr2iRDhUFCT+nyaYRAHQA+B0kVRJVZHcyuYGN29q3t
        MWnIB5EzwWFbECU++cwDzLazNHxzKJhKdWaPdgQ8fJ5bWGzu96HCFDwf2HxRrDQxUYeobC4fFUI
        01OLQ1L0Ol5WYUOzmNPbmAy6G
X-Received: by 2002:a17:90a:fb93:: with SMTP id cp19mr7353879pjb.30.1626402388437;
        Thu, 15 Jul 2021 19:26:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX0bcNFkDpZ5ajYsknACKTJbRTnPfRZhY9VHcnpeunwTVGUdqogLFGId1P2B+eG6+/zDhfyg==
X-Received: by 2002:a17:90a:fb93:: with SMTP id cp19mr7353857pjb.30.1626402388185;
        Thu, 15 Jul 2021 19:26:28 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m21sm7931709pfo.159.2021.07.15.19.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 19:26:27 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Paolo Bonzini <pbonzini@redhat.com>, He Zhe <zhe.he@windriver.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xie Yongji <xieyongji@bytedance.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
 <ab85cd9e-f389-0641-8084-cdfbc5c91e0b@windriver.com>
 <b73f8986-9071-6fbb-5c6a-d7892ba2302b@redhat.com>
 <e20c3d90-db24-7722-3f89-adadb83a9bf7@windriver.com>
 <c05b358b-1e96-c002-085c-b25e416e7be5@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <97704aa6-46eb-2462-a4d9-2bf93144a5ac@redhat.com>
Date:   Fri, 16 Jul 2021 10:26:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c05b358b-1e96-c002-085c-b25e416e7be5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/15 下午7:05, Paolo Bonzini 写道:
> On 15/07/21 12:10, He Zhe wrote:
>> The following was provided in this thread. The commit log contains 
>> the call traces that I met and fixed back to Apr. 2020.
>>
>> https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/ 
>>
>
>> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 
>> eventfd_signal+0x85/0xa0
>> ---- snip ----
>> 001: Call Trace:
>> 001:  vhost_signal+0x15e/0x1b0 [vhost]
>> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
>> 001:  handle_rx+0xb9/0x900 [vhost_net]
>> 001:  handle_rx_net+0x15/0x20 [vhost_net]
>> 001:  vhost_worker+0xbe/0x120 [vhost]
>> 001:  kthread+0x106/0x140
>> 001:  ? log_used.part.0+0x20/0x20 [vhost]
>> 001:  ? kthread_park+0x90/0x90
>> 001:  ret_from_fork+0x35/0x40
>
> This call trace is not of a reentrant call; there is only one call to 
> eventfd_signal.  It does fit the symptoms that Daniel reported for 
> PREEMPT_RT though.
>
>> https://lore.kernel.org/lkml/beac2025-2e11-8ed0-61e2-9f6e633482e8@redhat.com/ 
>>
>
> This one is about PREEMPT_RT, so it would be fixed by local_lock.
>
> There _may_ be two bugs, so let's start by fixing this one.  Once this 
> one is fixed, we will examine the call stacks of any further reports, 
> and diagnose whether the second bug (if it exists) is related to 
> vDUSE, PREEMPT_RT or neeither.


For VDUSE we may still need the patch since it tries to relay 
notifications (eventfds) which means the recursion of the eventfd signal.

But looking at the comment in the eventfd_signal() which say we should 
check with eventfd_signal_count() and delay the signal into a safe 
context (e.g workqueue etc).

Thanks


>
> Paolo
>

