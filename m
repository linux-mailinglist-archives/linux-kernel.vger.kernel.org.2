Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7B535F5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349249AbhDNNyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:54:40 -0400
Received: from foss.arm.com ([217.140.110.172]:57018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351750AbhDNNyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:54:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3994E113E;
        Wed, 14 Apr 2021 06:53:52 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFAF33F694;
        Wed, 14 Apr 2021 06:53:49 -0700 (PDT)
Subject: Re: [PATCH 1/1] arm: topology: parse the topology from the dt
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        mingo@kernel.org, ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com>
 <87y2dnn3gw.mognet@arm.com>
 <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com>
 <87tuobmsba.mognet@arm.com>
 <CAG7+-3OMYVTc+ja9CK+94X8XtKq3hbRb+XOEv7xOeuXgNm0BHQ@mail.gmail.com>
 <87o8eimmyw.mognet@arm.com>
 <CAG7+-3NaUAvjv9=9HZ4jQU=DVcZW6gRKZg9ZjutL3aKnnC4FLw@mail.gmail.com>
 <74b3ff57-473f-4d5a-daf8-ecbb0761abb2@arm.com>
 <CAG7+-3P6FYhqmt3p6g8b5ZXzaFW2pfx-vOZJYwuLCKXVqfFMVw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <02ed2223-6f33-faee-38a6-fc4ef071d431@arm.com>
Date:   Wed, 14 Apr 2021 15:53:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAG7+-3P6FYhqmt3p6g8b5ZXzaFW2pfx-vOZJYwuLCKXVqfFMVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 13:26, Ruifeng Zhang wrote:
> Dietmar Eggemann <dietmar.eggemann@arm.com> 于2021年4月14日周三 下午5:43写道：
>>
>> On 13/04/2021 15:26, Ruifeng Zhang wrote:
>>> Thanks for your review. Patch-v2 that solve the capacity issue will be
>>> uploaded as soon as possible. : )
>>>
>>> Valentin Schneider <valentin.schneider@arm.com> 于2021年4月13日周二 下午7:40写道：
>>>>
>>>> On 13/04/21 14:13, Ruifeng Zhang wrote:
>>>>> Valentin Schneider <valentin.schneider@arm.com> 于2021年4月12日周一 下午11:33写道：

[...]

>> Looks like sc9863a has two frequency domains (1.6 and 1.2GHz). So
>> technically it's a big.LITTLE system (based only on max CPU frequency
>> (not on uarch) differences).
>> But the dts file doesn't contain any `capacity-dmips-mhz` entries? So
>> asymmetric CPU capacity (even only based on max CPU frequency) detection
>> won't kick in. Since you don't have any uarch diffs, you would have to
>> specify `capacity-dmips-mhz = <1024>` for each CPU.
> 
> Yes, for capacity, the DT should have a capacity-dmips-MHz entry or a
> clock-frequency entry (for A7 and A15 only).
> The sc9863a dts is a vendor file,  in my opinion is not appropriate to
> be update with this series.
> What do you think if I independently update the sc9863a dts file later?
> 

Yes, this is a separate thing. Just wanted to mention it here since this
allows you to test asymmetric CPU capacity on your platform w/ and w/o
your patch on arm64 and arm.

No need to add `clock-frequency` entries, just `capacity-dmips-mhz`
entries should do.
