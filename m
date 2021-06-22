Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC33B0BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhFVRsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:48:14 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:58636 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232536AbhFVRr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:47:58 -0400
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.18])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lvkSw-0000OM-AE; Tue, 22 Jun 2021 18:45:38 +0100
Subject: Re: [PATCH v2 0/5] riscv: improving uaccess with logs from network
 bench
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
 <e7d5f98b-5e0d-19b3-08f5-a7b49d542a85@codethink.co.uk>
 <f54ec904-2bf5-0c29-d467-7465993d5d6b@gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <a222f892-a2bc-c531-d17e-3ec2c8708fcd@codethink.co.uk>
Date:   Tue, 22 Jun 2021 18:45:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f54ec904-2bf5-0c29-d467-7465993d5d6b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2021 13:05, Akira Tsukamoto wrote:
> On 6/22/2021 5:30 PM, Ben Dooks wrote:
>> On 19/06/2021 12:21, Akira Tsukamoto wrote:
>>> Optimizing copy_to_user and copy_from_user.
>>>
>>> I rewrote the functions in v2, heavily influenced by Garry's memcpy
>>> function [1].
>>> The functions must be written in assembler to handle page faults manually
>>> inside the function.
>>>
>>> With the changes, improves in the percentage usage and some performance
>>> of network speed in UDP packets.
>>> Only patching copy_user. Using the original memcpy.
>>>
>>> All results are from the same base kernel, same rootfs and same
>>> BeagleV beta board.
>>>
>>> Comparison by "perf top -Ue task-clock" while running iperf3.
>>
>> I did a quick test on a SiFive Unmatched with IO to an NVME.
>>
>> before: cached-reads=172.47MB/sec, buffered-reads=135.8MB/sec
>> with-patch: cached-read=s177.54Mb/sec, buffered-reads=137.79MB/sec
>>
>> That was just one test run, so there was a small improvement. I am
>> sort of surprised we didn't get more of a win from this.
>>
>> perf record on hdparm shows that it spends approx 15% cpu time in
>> asm_copy_to_user. Does anyone have a benchmark for this which just
>> looks at copy/to user? if not should we create one?
> 
> Thanks for the result on the Unmatched with hdparm. Have you tried
> iperf3?

I will see if there is iperf3 installed. I've not done much other than
try booting it and then try booting it with a kernel i've built from
upstream.

> The 15% is high, is it before or with-patch?

Can't remember, I did this more to find out if the copy to/from user
was going to show up in the times for hdparm.

> Akira
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
