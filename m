Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC184314AFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhBII6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhBIIyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:54:00 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA99C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 00:53:20 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h12so4353038wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 00:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=H208pVEPEbQ1MKSr4OW/7+4dNKsHEjdg7nesnQMvyp8=;
        b=nEOooPDEVr2l45WeE7wb95Sm/9VCZYRDo2IDYlfp7OyUip+YG8taZwJNy6NutaQbTS
         uNEDbwAeJj/AJlyEOBYwxQHrNzv8uSi60zxOBa+Dm+iEDq9VfFAy74NJX72E8Ugk81n9
         9GVv/2zSK1G2H6rFXL7iSkSi9BuegWhZW6BwFbi2wXzNmBZcQ3nc0MEObEqgSKltJJGJ
         f1TBzMEIBHk61cssdfbyGaL12eLdhXEVUM8RI05F0CnZLoW3EFKiW0GZtrgyOTkzKIwW
         YgryQpDvKCmW0I/fwsvm4zcXW1w0RSQbtpVQH9rI8wVag5Q0xmZcWxk3QGCePVUpi/nm
         HbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H208pVEPEbQ1MKSr4OW/7+4dNKsHEjdg7nesnQMvyp8=;
        b=TvW+kju6p1JBB27AigOTz+pyxqs7G5tjUHtSP5ioJfL82/zBDemw/bbppYPXJ5ZINf
         iVxta1HD9Nttxec/y5A+LkgUuUaHO2AO37/Ds7qXa37JTWDGnqYmoGcHqie4PLIgU1pp
         +ms4cw/0h12l9/M+wKQ/B5yQU7+CFqBeGnbpF3Udug2UJ8aWneyk8XC1yaWn4RqLjXKX
         JiXPaW/uz6IbVt+kj84rAIELUlUOZewi4/e8YpFXi4m5tgfIUvDAVeovTaMPQ+j1Cn7o
         bl5Ivcoa5mg9ILmjc5rSwOZ69gt6jdqocwjlBwwSNiHMJlJ9YDNFKSW1gcuW4HXW9n8P
         T9HQ==
X-Gm-Message-State: AOAM530U6dvCdQb2SjJX4Dqplicp6NYnH98zXDJtnzQkWVFKSaVWP3Ec
        TUAiyQd1b4ttRloSJeldDQnPmA==
X-Google-Smtp-Source: ABdhPJzN9QLvfxnc87FTfAej1i1vfCta3vnRz10Qfk8dnuz0GigPQqeqioTRm2sIPYW4akt9sBr4hg==
X-Received: by 2002:adf:fe82:: with SMTP id l2mr5098493wrr.341.1612860798577;
        Tue, 09 Feb 2021 00:53:18 -0800 (PST)
Received: from tmp.scylladb.com (bzq-109-67-58-110.red.bezeqint.net. [109.67.58.110])
        by smtp.googlemail.com with ESMTPSA id q15sm7180104wrr.58.2021.02.09.00.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 00:53:17 -0800 (PST)
Subject: Re: Linux 4.9.256
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
References: <1612535085125226@kroah.com>
 <23a28990-c465-f813-52a4-f7f3db007f9d@scylladb.com>
 <20210208185707.GC4035784@sasha-vm>
From:   Avi Kivity <avi@scylladb.com>
Message-ID: <219a26ec-fd6b-b841-43ef-57e04b417c4e@scylladb.com>
Date:   Tue, 9 Feb 2021 10:53:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208185707.GC4035784@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 8:57 PM, Sasha Levin wrote:
> On Mon, Feb 08, 2021 at 05:50:21PM +0200, Avi Kivity wrote:
>> On 05/02/2021 16.26, Greg Kroah-Hartman wrote:
>>> I'm announcing the release of the 4.9.256 kernel.
>>>
>>> This, and the 4.4.256 release are a little bit "different" than normal.
>>>
>>> This contains only 1 patch, just the version bump from .255 to .256 
>>> which ends
>>> up causing the userspace-visable LINUX_VERSION_CODE to behave a bit 
>>> differently
>>> than normal due to the "overflow".
>>>
>>> With this release, KERNEL_VERSION(4, 9, 256) is the same as 
>>> KERNEL_VERSION(4, 10, 0).
>>
>>
>> I think this is a bad idea. Many kernel features can only be 
>> discovered by checking the kernel version. If a feature was 
>> introduced in 4.10, then an application can be tricked into thinking 
>> a 4.9 kernel has it.
>>
>>
>> IMO, better to stop LINUX_VERSION_CODE at 255 and introduce a 
>
> In the upstream (and new -stable fix) we did this part.
>
>> LINUX_VERSION_CODE_IMPROVED that has more bits for patchlevel.
>
> Do you have a usecase where it's actually needed? i.e. userspace that
> checks for -stable patchlevels?
>

Not stable patchlevels, but minors. So a change from 4.9 to 4.10 could 
be harmful.


I have two such examples (not on the 4.9->4.10 boundary), but they test 
the runtime version from uname(), not LINUX_VERSION_CODE, so they would 
be vulnerable to such a change.


