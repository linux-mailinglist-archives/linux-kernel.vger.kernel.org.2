Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595E53B1A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFWMfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:35:22 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:48402 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhFWMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:35:20 -0400
Received: from localhost (unknown [192.168.167.224])
        by regular1.263xmail.com (Postfix) with ESMTP id D2222125B;
        Wed, 23 Jun 2021 20:32:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [10.4.23.82] (unknown [58.240.82.166])
        by smtp.263.net (postfix) whith ESMTP id P4529T140205619136256S1624451574785705_;
        Wed, 23 Jun 2021 20:32:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <09e2cf980420933e90fdf735905f1bf3>
X-RL-SENDER: wubian@uniontech.com
X-SENDER: wubian@uniontech.com
X-LOGIN-NAME: wubian@uniontech.com
X-FST-TO: will.deacon@arm.com
X-RCPT-COUNT: 4
X-SENDER-IP: 58.240.82.166
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH] uio: Fix bus error that access memory mapped by physical
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <20210623065214.4525-1-wubian@uniontech.com>
 <YNLfVX5YVWouP1qD@kroah.com>
 <5a2737e1-2a77-98b0-eea7-eae04d7a9fba@uniontech.com>
 <YNL99ImFxKADvDIB@kroah.com>
From:   wubian <wubian@uniontech.com>
Message-ID: <a6562bd2-9f42-1b39-bfe6-83f1cf53f72b@uniontech.com>
Date:   Wed, 23 Jun 2021 20:32:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YNL99ImFxKADvDIB@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/23 下午5:25, Greg KH wrote:
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top
> 
> On Wed, Jun 23, 2021 at 04:49:16PM +0800, wubian wrote:
>> First,thanks for your reply
>>
>> I haven’t found this problem on the x86 platform. I only found it on arm64.
>> I used gdb to track memset and found that the bus error in
>> glibc/sysdeps/aarch64/memset.S: dc zva, dst; reference "Architecture
>> Reference ManualArmv8, for Armv8-A architecture profile" manual found that
>> the dc assembly instruction（performance optimization） is related to the
>> operation of the cache, that is to say, there is a bus error in the
>> operation of the cache, and then check the "ARM Cortex-A Series Programmer's
>> Guide for ARMv8-A " manual, found that the armv8 architecture cache has data
>> cache and write buffer, and there are two operation modes write-back and
>> write-through, write operations in these two modes, the data flow will pass
>> through the write buffer, and pgprot_noncached will prohibit data Cache and
>> write buffer, this causes the dc command in memset to fail (bus error), and
>> pgprot_writecombine does not prohibit write buffer, so the dc command in
>> memset is successfully operated when pgprot_writecombine is used.
> 
> Are you sure this is not just a specific hardware platform issue?  Are
> you sure this is going to be correct for _ALL_ arm64 systems?
> 
> Perhaps get the arm64 developers to agree with what is happening here as
> this is the first time anyone has reported this problem.
> 
> What specific platform are you using that this issue happens on?
> 
> thanks,
> 
> greg k-h
> 
> 

I apologize for the kernel mail reply format problem, I will pay 
attention to it in the future.

I only found this problem on Huawei Kunpeng 920 cpu at present, and 
found that some people
have raised similar problems on the Internet.
link：https://github.com/ikwzm/udmabuf/issues/31

@Catalin Marinas @Will Deacon Has anyone reported a similar problem on 
the arm64 platform?


