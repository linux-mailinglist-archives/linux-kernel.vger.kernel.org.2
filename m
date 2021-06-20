Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5C43ADDF5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 12:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhFTKY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 06:24:57 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:43430 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbhFTKYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 06:24:55 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Jun 2021 06:24:55 EDT
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.18])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1luuHn-0007q2-Mg; Sun, 20 Jun 2021 11:02:39 +0100
Subject: Re: [PATCH v2 0/5] riscv: improving uaccess with logs from network
 bench
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <542310bc-840d-d5c9-a7b3-40f58504e7b5@codethink.co.uk>
Date:   Sun, 20 Jun 2021 11:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2021 12:21, Akira Tsukamoto wrote:
> Optimizing copy_to_user and copy_from_user.
> 
> I rewrote the functions in v2, heavily influenced by Garry's memcpy
> function [1].
> The functions must be written in assembler to handle page faults manually
> inside the function.
> 
> With the changes, improves in the percentage usage and some performance
> of network speed in UDP packets.
> Only patching copy_user. Using the original memcpy.
> 
> All results are from the same base kernel, same rootfs and same
> BeagleV beta board.

Is there a git tree for these to try them out?

> Comparison by "perf top -Ue task-clock" while running iperf3.
> 
> --- TCP recv ---
>   * Before
>    40.40%  [kernel]  [k] memcpy
>    33.09%  [kernel]  [k] __asm_copy_to_user
>   * After
>    50.35%  [kernel]  [k] memcpy
>    13.76%  [kernel]  [k] __asm_copy_to_user
> 
> --- TCP send ---
>   * Before
>    19.96%  [kernel]  [k] memcpy
>     9.84%  [kernel]  [k] __asm_copy_to_user
>   * After
>    14.27%  [kernel]  [k] memcpy
>     7.37%  [kernel]  [k] __asm_copy_to_user
> 
> --- UDP send ---
>   * Before
>    25.18%  [kernel]  [k] memcpy
>    22.50%  [kernel]  [k] __asm_copy_to_user
>   * After
>    28.90%  [kernel]  [k] memcpy
>     9.49%  [kernel]  [k] __asm_copy_to_user
> 
> --- UDP recv ---
>   * Before
>    44.45%  [kernel]  [k] memcpy
>    31.04%  [kernel]  [k] __asm_copy_to_user
>   * After
>    55.62%  [kernel]  [k] memcpy
>    11.22%  [kernel]  [k] __asm_copy_to_user

What's the memcpy figure in the above?
Could you explain the figures please?

> Processing network packets require a lot of unaligned access for the packet
> header, which is not able to change the design of the header format to be
> aligned.

Isn't there an option to allow padding of network packets
in the skbuff to make the fields aligned for architectures
which do not have efficient unaligned loads (looking at you
arm32). Has this been looked at?

> And user applications call system calls with a large buffer for send/recf()
> and sendto/recvfrom() to repeat less function calls for the optimization.
> 
> v1 -> v2:
> - Added shift copy
> - Separated patches for readability of changes in assembler
> - Using perf results
> 
> [1] https://lkml.org/lkml/2021/2/16/778
> 
> Akira Tsukamoto (5):
>    riscv: __asm_to/copy_from_user: delete existing code
>    riscv: __asm_to/copy_from_user: Adding byte copy first
>    riscv: __asm_to/copy_from_user: Copy until dst is aligned address
>    riscv: __asm_to/copy_from_user: Bulk copy while shifting misaligned
>      data
>    riscv: __asm_to/copy_from_user: Bulk copy when both src dst are
>      aligned
> 
>   arch/riscv/lib/uaccess.S | 181 +++++++++++++++++++++++++++++++--------
>   1 file changed, 146 insertions(+), 35 deletions(-)

I'm concerned that delete and then re-add is either going to make
the series un-bisectable or leave a point where the kernel is very
broken?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
