Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2E33C656C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 23:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhGLV1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 17:27:38 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:59968 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233998AbhGLV1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 17:27:37 -0400
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.18])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1m33Ps-0004zD-6N; Mon, 12 Jul 2021 22:24:40 +0100
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
Message-ID: <1934063a-8973-932a-6029-58593bd5fa3a@codethink.co.uk>
Date:   Mon, 12 Jul 2021 22:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
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
> 
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
> 
> Processing network packets require a lot of unaligned access for the packet
> header, which is not able to change the design of the header format to be
> aligned.
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
> 

I'm doing some work on allow benchmarking and testing the uaccess code.

So far the initial results are:

> 
> copy routine 1: original
> test 1: copier 1: offset 0, size 8192: took 43.394000 ms, 1800.364106 MiB/sec
> test 1: copier 1: offset 1, size 8191: took 343.767000 ms, 227.233746 MiB/sec
> test 1: copier 1: offset 2, size 8190: took 343.727000 ms, 227.232445 MiB/sec
> test 1: copier 1: offset 3, size 8189: took 343.664000 ms, 227.246350 MiB/sec
> test 1: copier 1: offset 4, size 8188: took 343.751000 ms, 227.161093 MiB/sec
> test 1: copier 1: offset 5, size 8187: took 343.620000 ms, 227.219941 MiB/sec
> test 1: copier 1: offset 6, size 8186: took 343.540000 ms, 227.245094 MiB/sec
> test 1: copier 1: offset 7, size 8185: took 343.640000 ms, 227.151213 MiB/sec
> copy routine 2: new
> test 1: copier 2: offset 0, size 8192: took 18.819000 ms, 4151.389553 MiB/sec
> test 1: copier 2: offset 1, size 8191: took 43.770000 ms, 1784.680449 MiB/sec
> test 1: copier 2: offset 2, size 8190: took 43.727000 ms, 1786.217360 MiB/sec
> test 1: copier 2: offset 3, size 8189: took 43.679000 ms, 1787.961944 MiB/sec
> test 1: copier 2: offset 4, size 8188: took 43.620000 ms, 1790.161693 MiB/sec
> test 1: copier 2: offset 5, size 8187: took 43.577000 ms, 1791.709303 MiB/sec
> test 1: copier 2: offset 6, size 8186: took 43.533000 ms, 1793.301163 MiB/sec
> test 1: copier 2: offset 7, size 8185: took 43.471000 ms, 1795.639456 MiB/sec
> write tests:
> copy routine 1: original
> test 2: copier 1: offset 0, size 8192: took 43.443000 ms, 1798.333448 MiB/sec
> test 2: copier 1: offset 1, size 8191: took 344.281000 ms, 226.894494 MiB/sec
> test 2: copier 1: offset 2, size 8190: took 343.788000 ms, 227.192126 MiB/sec
> test 2: copier 1: offset 3, size 8189: took 343.735000 ms, 227.199412 MiB/sec
> test 2: copier 1: offset 4, size 8188: took 343.695000 ms, 227.198106 MiB/sec
> test 2: copier 1: offset 5, size 8187: took 343.626000 ms, 227.215974 MiB/sec
> test 2: copier 1: offset 6, size 8186: took 343.597000 ms, 227.207396 MiB/sec
> test 2: copier 1: offset 7, size 8185: took 343.823000 ms, 227.030312 MiB/sec
> copy routine 2: new
> test 2: copier 2: offset 0, size 8192: took 18.999000 ms, 4112.058529 MiB/sec
> test 2: copier 2: offset 1, size 8191: took 43.897000 ms, 1779.517125 MiB/sec
> test 2: copier 2: offset 2, size 8190: took 43.784000 ms, 1783.891981 MiB/sec
> test 2: copier 2: offset 3, size 8189: took 43.803000 ms, 1782.900481 MiB/sec
> test 2: copier 2: offset 4, size 8188: took 43.768000 ms, 1784.108322 MiB/sec
> test 2: copier 2: offset 5, size 8187: took 43.739000 ms, 1785.073191 MiB/sec
> test 2: copier 2: offset 6, size 8186: took 43.620000 ms, 1789.724428 MiB/sec
> test 2: copier 2: offset 7, size 8185: took 43.573000 ms, 1791.436045 MiB/sec
> read tests:
> copy routine 1: original
> test 1: copier 1: offset 0, size 16384: took 87.173000 ms, 1792.412788 MiB/sec
> test 1: copier 1: offset 1, size 16383: took 689.480000 ms, 226.606230 MiB/sec
> test 1: copier 1: offset 2, size 16382: took 689.251000 ms, 226.667682 MiB/sec
> test 1: copier 1: offset 3, size 16381: took 689.203000 ms, 226.669631 MiB/sec
> test 1: copier 1: offset 4, size 16380: took 689.385000 ms, 226.595956 MiB/sec
> test 1: copier 1: offset 5, size 16379: took 689.201000 ms, 226.642614 MiB/sec
> test 1: copier 1: offset 6, size 16378: took 689.158000 ms, 226.642917 MiB/sec
> test 1: copier 1: offset 7, size 16377: took 689.038000 ms, 226.668548 MiB/sec
> copy routine 2: new
> test 1: copier 2: offset 0, size 16384: took 38.825000 ms, 4024.468770 MiB/sec
> test 1: copier 2: offset 1, size 16383: took 88.706000 ms, 1761.329146 MiB/sec
> test 1: copier 2: offset 2, size 16382: took 88.663000 ms, 1762.075798 MiB/sec
> test 1: copier 2: offset 3, size 16381: took 88.614000 ms, 1762.942535 MiB/sec
> test 1: copier 2: offset 4, size 16380: took 88.592000 ms, 1763.272677 MiB/sec
> test 1: copier 2: offset 5, size 16379: took 88.518000 ms, 1764.639014 MiB/sec
> test 1: copier 2: offset 6, size 16378: took 88.481000 ms, 1765.269149 MiB/sec
> test 1: copier 2: offset 7, size 16377: took 88.437000 ms, 1766.039585 MiB/sec
> write tests:
> copy routine 1: original
> test 2: copier 1: offset 0, size 16384: took 87.150000 ms, 1792.885829 MiB/sec
> test 2: copier 1: offset 1, size 16383: took 689.470000 ms, 226.609516 MiB/sec
> test 2: copier 1: offset 2, size 16382: took 689.242000 ms, 226.670642 MiB/sec
> test 2: copier 1: offset 3, size 16381: took 689.165000 ms, 226.682129 MiB/sec
> test 2: copier 1: offset 4, size 16380: took 689.697000 ms, 226.493450 MiB/sec
> test 2: copier 1: offset 5, size 16379: took 689.070000 ms, 226.685701 MiB/sec
> test 2: copier 1: offset 6, size 16378: took 689.018000 ms, 226.688968 MiB/sec
> test 2: copier 1: offset 7, size 16377: took 689.009000 ms, 226.678088 MiB/sec
> copy routine 2: new
> test 2: copier 2: offset 0, size 16384: took 38.871000 ms, 4019.706208 MiB/sec
> test 2: copier 2: offset 1, size 16383: took 88.732000 ms, 1760.813047 MiB/sec
> test 2: copier 2: offset 2, size 16382: took 88.672000 ms, 1761.896952 MiB/sec
> test 2: copier 2: offset 3, size 16381: took 88.642000 ms, 1762.385661 MiB/sec
> test 2: copier 2: offset 4, size 16380: took 88.730000 ms, 1760.530294 MiB/sec
> test 2: copier 2: offset 5, size 16379: took 88.670000 ms, 1761.614033 MiB/sec
> test 2: copier 2: offset 6, size 16378: took 88.627000 ms, 1762.361126 MiB/sec
> test 2: copier 2: offset 7, size 16377: took 88.543000 ms, 1763.925356 MiB/sec
> read tests:
> copy routine 1: original
> test 1: copier 1: offset 0, size 32768: took 243.592000 ms, 1282.882853 MiB/sec
> test 1: copier 1: offset 1, size 32767: took 1426.538000 ms, 219.055127 MiB/sec
> test 1: copier 1: offset 2, size 32766: took 1426.340000 ms, 219.078850 MiB/sec
> test 1: copier 1: offset 3, size 32765: took 1426.297000 ms, 219.078768 MiB/sec
> test 1: copier 1: offset 4, size 32764: took 1426.069000 ms, 219.107107 MiB/sec
> test 1: copier 1: offset 5, size 32763: took 1425.970000 ms, 219.115631 MiB/sec
> test 1: copier 1: offset 6, size 32762: took 1425.975000 ms, 219.108175 MiB/sec
> test 1: copier 1: offset 7, size 32761: took 1425.906000 ms, 219.112089 MiB/sec
> copy routine 2: new
> test 1: copier 2: offset 0, size 32768: took 205.966000 ms, 1517.240710 MiB/sec
> test 1: copier 2: offset 1, size 32767: took 304.295000 ms, 1026.932625 MiB/sec
> test 1: copier 2: offset 2, size 32766: took 304.219000 ms, 1027.157825 MiB/sec
> test 1: copier 2: offset 3, size 32765: took 304.114000 ms, 1027.481108 MiB/sec
> test 1: copier 2: offset 4, size 32764: took 304.102000 ms, 1027.490293 MiB/sec
> test 1: copier 2: offset 5, size 32763: took 304.032000 ms, 1027.695494 MiB/sec
> test 1: copier 2: offset 6, size 32762: took 304.012000 ms, 1027.731733 MiB/sec
> test 1: copier 2: offset 7, size 32761: took 304.250000 ms, 1026.896443 MiB/sec
> write tests:
> copy routine 1: original
> test 2: copier 1: offset 0, size 32768: took 269.605000 ms, 1159.103132 MiB/sec
> test 2: copier 1: offset 1, size 32767: took 1438.271000 ms, 217.268139 MiB/sec
> test 2: copier 1: offset 2, size 32766: took 1438.197000 ms, 217.272687 MiB/sec
> test 2: copier 1: offset 3, size 32765: took 1438.157000 ms, 217.272099 MiB/sec
> test 2: copier 1: offset 4, size 32764: took 1438.121000 ms, 217.270906 MiB/sec
> test 2: copier 1: offset 5, size 32763: took 1438.085000 ms, 217.269714 MiB/sec
> test 2: copier 1: offset 6, size 32762: took 1438.012000 ms, 217.274111 MiB/sec
> test 2: copier 1: offset 7, size 32761: took 1437.998000 ms, 217.269595 MiB/sec
> copy routine 2: new
> test 2: copier 2: offset 0, size 32768: took 237.597000 ms, 1315.252297 MiB/sec
> test 2: copier 2: offset 1, size 32767: took 340.638000 ms, 917.368183 MiB/sec
> test 2: copier 2: offset 2, size 32766: took 340.669000 ms, 917.256711 MiB/sec
> test 2: copier 2: offset 3, size 32765: took 340.615000 ms, 917.374131 MiB/sec
> test 2: copier 2: offset 4, size 32764: took 340.542000 ms, 917.542779 MiB/sec
> test 2: copier 2: offset 5, size 32763: took 340.543000 ms, 917.512080 MiB/sec
> test 2: copier 2: offset 6, size 32762: took 340.775000 ms, 916.859451 MiB/sec
> test 2: copier 2: offset 7, size 32761: took 343.885000 ms, 908.539898 MiB/sec

It looks like the aligned is about 2.2 faster on the aligned and 7.8
times faster for the unalgined tests. I'll try and get this published
some time this week.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
