Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC4E35F9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350108AbhDNRWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhDNRWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:22:02 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DAAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:21:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d15so9215514qkc.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K+CoWOryQXPkwoI6HADtuZJs0NXTCSdwEpDuMV86TlA=;
        b=bv523jUWRxpMuwbk6qn63MlBojHdAT3raBNQVr5ncdx1Pa+c+Slrjo3PVYbdNW24r2
         PmpEuKXoj0AIGt6346L38UqnljlFhqA5owtMDWCQmuCEdGy/Jap23GmsopTSqzqhB0kn
         d2w7tBccKzvOWz16UWg+IsJSk1l10NqIT8YDhAwRuqzSAC3RJMVJS6yxl213gzQ/+XWa
         ozm47LpwltErV6/fMMRuR2oNMlUodIlUZtZ7D9Ima6ZjJieOwN/3MkDbIB9bKLC4Vh90
         h7O5L7G01ke0hAATOA+OxqkGsEH1k8NEoYC+YeHEeCbCUpws4K+tFDNu1fAWieD/nK0+
         mmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+CoWOryQXPkwoI6HADtuZJs0NXTCSdwEpDuMV86TlA=;
        b=fGPJNHntrD9u9AgsM/hnr1j+szjC1uAvLLkaZffsKwnbEDsfjN0tkmCl0p0Mg2gHCu
         sypCW1NdQpqdeRRZUZF5yQcYr+bOjVqFE88Y4mM4iflxAXGiyS7ZAe6S9bK+lxHbd8I3
         wnmBaWdHmrKCTFjTc8AGOQbrWH10nSm0mJVNvVv1YK+VEwjpP+Pctkw+IMmvutzQ9+bC
         2HB1wkspuYkGOX8VP/etTkRsgqN1AKxx/UTLAQyfWtaVj2mIFlD0Cz9dKNYHzkHm5CFE
         Gz5+A+S5/Ty85Gcw311G22GxWbd8IOZ2pDat01wJDyX2PC56wUx1le3j42K/x9En+cXt
         gkvA==
X-Gm-Message-State: AOAM532pEA94X9UfFVdwSo0i2MLMkssmEzEWeKlK3I8lZ7/+zizMEMk4
        sjW2ASmulTRz2dTB/YTngqE80Q==
X-Google-Smtp-Source: ABdhPJze/w6tKhj7npYWuGbWGASAUlBgT9DXJ65oVl81RZf9YXd14o/U9XfEjNzujpifVZRg1rto5g==
X-Received: by 2002:a37:9604:: with SMTP id y4mr12435433qkd.354.1618420900166;
        Wed, 14 Apr 2021 10:21:40 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::127b? ([2620:10d:c091:480::1:e1e5])
        by smtp.gmail.com with ESMTPSA id h65sm18155qkd.112.2021.04.14.10.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 10:21:39 -0700 (PDT)
Subject: Re: the qemu-nbd process automatically exit with the commit 43347d56c
 'livepatch: send a fake signal to all blocking tasks'
To:     xiaojun.zhao141@gmail.com, Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
References: <20210414115548.0cdb529b@slime>
 <alpine.LSU.2.21.2104141320060.6604@pobox.suse.cz>
 <20210414232119.13b126fa@slime>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f7698105-23a4-4558-7b65-9116e8587848@toxicpanda.com>
Date:   Wed, 14 Apr 2021 13:21:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414232119.13b126fa@slime>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 11:21 AM, xiaojun.zhao141@gmail.com wrote:
> On Wed, 14 Apr 2021 13:27:43 +0200 (CEST)
> Miroslav Benes <mbenes@suse.cz> wrote:
> 
>> Hi,
>>
>> On Wed, 14 Apr 2021, xiaojun.zhao141@gmail.com wrote:
>>
>>> I found the qemu-nbd process(started with qemu-nbd -t -c /dev/nbd0
>>> nbd.qcow2) will automatically exit when I patched for functions of
>>> the nbd with livepatch.
>>>
>>> The nbd relative source:
>>> static int nbd_start_device_ioctl(struct nbd_device *nbd, struct
>>> block_device *bdev)
>>> { struct nbd_config *config =
>>> nbd->config; int
>>> ret;
>>>          ret =
>>> nbd_start_device(nbd); if
>>> (ret) return
>>> ret;
>>>          if
>>> (max_part) bdev->bd_invalidated =
>>> 1;
>>> mutex_unlock(&nbd->config_lock); ret =
>>> wait_event_interruptible(config->recv_wq,
>>> atomic_read(&config->recv_threads) == 0); if
>>> (ret)
>>> sock_shutdown(nbd);
>>> flush_workqueue(nbd->recv_workq);
>>>          mutex_lock(&nbd->config_lock);
>>>          nbd_bdev_reset(bdev);
>>>          /* user requested, ignore socket errors
>>> */ if (test_bit(NBD_RT_DISCONNECT_REQUESTED,
>>> &config->runtime_flags)) ret =
>>> 0; if (test_bit(NBD_RT_TIMEDOUT,
>>> &config->runtime_flags)) ret =
>>> -ETIMEDOUT; return
>>> ret; }
>>
>> So my understanding is that ndb spawns a number
>> (config->recv_threads) of workqueue jobs and then waits for them to
>> finish. It waits interruptedly. Now, any signal would make
>> wait_event_interruptible() to return -ERESTARTSYS. Livepatch fake
>> signal is no exception there. The error is then propagated back to
>> the userspace. Unless a user requested a disconnection or there is
>> timeout set. How does the userspace then reacts to it? Is
>> _interruptible there because the userspace sends a signal in case of
>> NBD_RT_DISCONNECT_REQUESTED set? How does the userspace handles
>> ordinary signals? This all sounds a bit strange, but I may be missing
>> something easily.
>>
>>> When the nbd waits for atomic_read(&config->recv_threads) == 0, the
>>> klp will send a fake signal to it then the qemu-nbd process exits.
>>> And the signal of sysfs to control this action was removed in the
>>> commit 10b3d52790e 'livepatch: Remove signal sysfs attribute'. Are
>>> there other ways to control this action? How?
>>
>> No, there is no way currently. We send a fake signal automatically.
>>
>> Regards
>> Miroslav
> It occurs IO error of the nbd device when I use livepatch of the
> nbd, and I guess that any livepatch on other kernel source maybe cause
> the IO error. Well, now I decide to workaround for this problem by
> adding a livepatch for the klp to disable a automatic fake signal.
> 

Would wait_event_killable() fix this problem?  I'm not sure any client 
implementations depend on being able to send other signals to the client 
process, so it should be safe from that standpoint.  Not sure if the livepatch 
thing would still get an error at that point tho.  Thanks,

Josef
