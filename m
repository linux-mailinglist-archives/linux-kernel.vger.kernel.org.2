Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD33ADF5F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhFTQjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhFTQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 12:39:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF71C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 09:36:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y4so4820393pfi.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=40fJho7zFxUORfAU0PgoiB9XNKSR1aFNaisbGsGTME4=;
        b=fa039sxkxMwhDT+fC80Yz6MdjfczZw4ak/wSFBDwMgmpSyA8QWq5v4pwq1/DJVY9SH
         ioaISrjNWG1IV1HEM2LfCLw5vI+4W7VXnm/C5Qa1Gt8JoX/7ITadgkFhg10a3eHDvO9S
         /iyq83bNXpdbaTTka/ad8rjt0lyMlRo2d7kHb7AoeuStWEkbIvUcKSrmue7kRoNQyHI8
         5/XEkf9g/lDx5gckvo8+79U94f+niI8rSNjwNQRIrAbM/woh1rFWAqzkM04VhX3Hm72Q
         FMBLTQuapfuAe3s+iR1Gi4YnsI82sUgXcmJ0eNU/xeRwvI0U9OfPNRgF50aLVvqY+xOG
         TWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=40fJho7zFxUORfAU0PgoiB9XNKSR1aFNaisbGsGTME4=;
        b=VPdFVE30HgpY+2l6y1tRTbDmIqQqmGrnFd7/h5UfbXFdC+PwvMoElbK3x9X6TTPgrf
         9knsqyQSjRYz1IS9j8RFJBVDiI96RlhnXNJTb+LLlGC9cbw65f6UrwdfAB956vWEMWvs
         cqIB96b1Luxm5F4kV5wEouuiRpap62vqIstCwR6fMIW7VEIjHU2P1mv/CRvJWL/jKwUv
         MfAL2vE2ODXZE1jIpGFvqZ2VDhJFPIkSu6pOjCxoEYiQJ0dq+oAPdEWQJ7ga0bdFh6iB
         aCXeG63io5RFgTVTcrB3OZyvM5Yy5dlMcz0Bdr50FRwuMLLphML++HgzGRpdxLACDhZs
         qE/g==
X-Gm-Message-State: AOAM531xQfrgdabnAYpwVA1rytdhb+VJvmr7xKt6hsqGQCGpilIWkzoS
        WUB/5YtxgoGXjkoYiNZqKIg=
X-Google-Smtp-Source: ABdhPJwAWt0Q9dppEFDIYFvVOXfk56VB5bN5oTHiQS/DJ1Lv4QvzmoXvV8uKggnuFht7CDLBjbBb6Q==
X-Received: by 2002:a62:3606:0:b029:302:3c87:4f37 with SMTP id d6-20020a6236060000b02903023c874f37mr5042058pfa.53.1624207012263;
        Sun, 20 Jun 2021 09:36:52 -0700 (PDT)
Received: from [192.168.1.153] (87.19.178.217.shared.user.transix.jp. [217.178.19.87])
        by smtp.gmail.com with ESMTPSA id v9sm12913263pfn.22.2021.06.20.09.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 09:36:51 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] riscv: improving uaccess with logs from network
 bench
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
 <542310bc-840d-d5c9-a7b3-40f58504e7b5@codethink.co.uk>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <88ba6862-b43b-bcab-9485-1339cc765f47@gmail.com>
Date:   Mon, 21 Jun 2021 01:36:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <542310bc-840d-d5c9-a7b3-40f58504e7b5@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/20/21 19:02, Ben Dooks wrote:
> On 19/06/2021 12:21, Akira Tsukamoto wrote:
>> Optimizing copy_to_user and copy_from_user.
>>
>> I rewrote the functions in v2, heavily influenced by Garry's memcpy
>> function [1].
>> The functions must be written in assembler to handle page faults manually
>> inside the function.
>>
>> With the changes, improves in the percentage usage and some performance
>> of network speed in UDP packets.
>> Only patching copy_user. Using the original memcpy.
>>
>> All results are from the same base kernel, same rootfs and same
>> BeagleV beta board.
> 
> Is there a git tree for these to try them out?

Sure, please try.

The kernel without the patch is starlight branch and
the kernel with these patches is starlight-ua-new-up at 
https://github.com/mcd500/linux-jh7100

The starlight is maintained by Esmil where main development
is happening.

And the rootfs on beaglev is uploaded bellow.
https://github.com/mcd500/Fedora_on_StarFive#custome-fedora-image

To reproduce the results:
(please customize with your ip addreses)

The command I used for iperf3.

--- TCP recv ---
** on PC side, using default mtu 1500
$ iperf3 -c 192.168.1.112
** on riscv beaglev side, using default mtu 1500
[root@fedora-starfive ~]# iperf3 -s

--- TCP send ---
** on PC side, using default mtu 1500
$ iperf3 -s
** on riscv beaglev side, using default mtu 1500
[root@fedora-starfive ~]# iperf3 -c 192.168.1.153

--- UDP send ---
** on PC side first, changing mtu size from 1500 to 9000
$ sudo ifconfig eth0 down
$ sudo ifconfig eth0 mtu 9000 up
$ iperf3 -s
** on riscv beaglev, No changing the mtu size on riscv beaglev
[root@fedora-starfive ~]# iperf3 -u -b 1000M --length 50000 -c 192.168.1.153

--- UDP recv ---
** on PC side first, changing mtu size to 9000
$ sudo ifconfig eth0 down
$ sudo ifconfig eth0 mtu 9000 up
$ iperf3 -u -b 1000M --length 6500 -c 192.168.1.112
** on riscv beaglev side, changing mtu size to 9000 too
[root@fedora-starfive ~]# sudo ifconfig eth0 down
[root@fedora-starfive ~]# sudo ifconfig eth0 mtu 9000 up
[root@fedora-starfive ~]# iperf3 -s

The perf:
$ sudo perf top -Ue task-clock
after login with ssh.

> 
>> Comparison by "perf top -Ue task-clock" while running iperf3.
>>
>> --- TCP recv ---
>>   * Before
>>    40.40%  [kernel]  [k] memcpy
>>    33.09%  [kernel]  [k] __asm_copy_to_user
>>   * After
>>    50.35%  [kernel]  [k] memcpy
>>    13.76%  [kernel]  [k] __asm_copy_to_user
>>
>> --- TCP send ---
>>   * Before
>>    19.96%  [kernel]  [k] memcpy
>>     9.84%  [kernel]  [k] __asm_copy_to_user
>>   * After
>>    14.27%  [kernel]  [k] memcpy
>>     7.37%  [kernel]  [k] __asm_copy_to_user
>>
>> --- UDP send ---
>>   * Before
>>    25.18%  [kernel]  [k] memcpy
>>    22.50%  [kernel]  [k] __asm_copy_to_user
>>   * After
>>    28.90%  [kernel]  [k] memcpy
>>     9.49%  [kernel]  [k] __asm_copy_to_user
>>
>> --- UDP recv ---
>>   * Before
>>    44.45%  [kernel]  [k] memcpy
>>    31.04%  [kernel]  [k] __asm_copy_to_user
>>   * After
>>    55.62%  [kernel]  [k] memcpy
>>    11.22%  [kernel]  [k] __asm_copy_to_user
> 
> What's the memcpy figure in the above?
> Could you explain the figures please?

It is the output of "perf top -Ue task-clock" 
while performing the iperf3 which I described above.
Showing which functions are causing the most overhead
inside the kernel during running iperf3 in cpu usage.

The two biggest culprits were memcpy and __asm_copy_to_user
showing high cpu usage, and this is the reason I listed the two.

Initially this discussion started with Gary's memcpy patch
on this list. I will write more details bellow.

> 
>> Processing network packets require a lot of unaligned access for the packet
>> header, which is not able to change the design of the header format to be
>> aligned.
> 
> Isn't there an option to allow padding of network packets
> in the skbuff to make the fields aligned for architectures
> which do not have efficient unaligned loads (looking at you
> arm32). Has this been looked at?

I am trying at 64bit risc-v beaglev beta board.
My understanding of skbuff is that it is for aligning data when
the handling inside the kernel. It would help if memcpy and 
__asm_copy_to_user were not causing such a huge percentage.

This patch is against copy_to_user and copy_from_user
purely used for copying between kernel space and user space.

By looking the overhead on perf, the cpu usage is increasing
on copy_to_user because the user app (iperf3 here) uses socket API 
with large packet size. I used to use maximum buffer size 
of mtu for reduce the number of calling recvform() sendto()
for UDP programing too. And most of the network programmer probably
do the same.

> 
>> And user applications call system calls with a large buffer for send/recf()
>> and sendto/recvfrom() to repeat less function calls for the optimization.
>>
>> v1 -> v2:
>> - Added shift copy
>> - Separated patches for readability of changes in assembler
>> - Using perf results
>>
>> [1] https://lkml.org/lkml/2021/2/16/778
>>
>> Akira Tsukamoto (5):
>>    riscv: __asm_to/copy_from_user: delete existing code
>>    riscv: __asm_to/copy_from_user: Adding byte copy first
>>    riscv: __asm_to/copy_from_user: Copy until dst is aligned address
>>    riscv: __asm_to/copy_from_user: Bulk copy while shifting misaligned
>>      data
>>    riscv: __asm_to/copy_from_user: Bulk copy when both src dst are
>>      aligned
>>
>>   arch/riscv/lib/uaccess.S | 181 +++++++++++++++++++++++++++++++--------
>>   1 file changed, 146 insertions(+), 35 deletions(-)
> 
> I'm concerned that delete and then re-add is either going to make
> the series un-bisectable or leave a point where the kernel is very
> broken?

I completely agree and understand. The only reason I split the patches
is because of the comments in the other thread. It definitely breaks
the bisect. Once the content of this patch is understood and agreed,
I will re-spin them in one patch, otherwise it will not boot when
only individual patch is applied.

The Gary's memcpy patch was posted a while ago, and even it has the 
best result in bench, it was not merged.

When we were measuring network performance on beaglev beta board,
the Gary's memcpy did have huge improvement.

The patch was not easy to review and understand, but it really helps
the network performance.

By reading the discussion on his patch, I felt the first priority
is able to be understood the cause of cpu usage and speed results.

Please read the discussion by Gary, Palmer, Matteo, others and I in 
the list.

Matteo is rewriting Gary's patch in C, which is better for 
maintainability and incorporate the wisdom of the optimization
of the compiler.
The user_copy are written in assembler or inline assembler,
as I wrote.

I just want to help making it better, so once the consensus are
made, I will make them to one patch.
Or I am fine somebody else comes out with better results.

My attempt to do similar patches dates long time ago in 2002.
https://linux-kernel.vger.kernel.narkive.com/zU6OFlI6/cft-patch-2-5-47-athlon-druon-much-faster-copy-user-function
http://lkml.iu.edu/hypermail/linux/kernel/0211.2/0928.html

Akira
