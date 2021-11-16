Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7D452D85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhKPJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:07:19 -0500
Received: from www62.your-server.de ([213.133.104.62]:51464 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhKPJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:07:01 -0500
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mmuNj-0002fu-Bp; Tue, 16 Nov 2021 10:03:59 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mmuNj-000Q3d-5q; Tue, 16 Nov 2021 10:03:59 +0100
Subject: Re: arch/x86/net/bpf_jit_comp.c:2188:5: warning: no previous
 prototype for 'arch_prepare_bpf_dispatcher'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, bjorn@kernel.org
References: <202111161117.ZvVGmBJV-lkp@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <74c60313-699a-2e3b-af36-49387cfadae3@iogearbox.net>
Date:   Tue, 16 Nov 2021 10:03:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <202111161117.ZvVGmBJV-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26354/Mon Nov 15 10:21:07 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cc Bjorn ]

On 11/16/21 4:25 AM, kernel test robot wrote:
> Hi Daniel,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8ab774587903771821b59471cc723bba6d893942
> commit: b24abcff918a5cbf44b0c982bd3477a93e8e4911 bpf, kconfig: Add consolidated menu entry for bpf with core options
> date:   6 months ago
> config: x86_64-buildonly-randconfig-r006-20211012 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b24abcff918a5cbf44b0c982bd3477a93e8e4911
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout b24abcff918a5cbf44b0c982bd3477a93e8e4911
>          # save the attached .config to linux build tree
>          make W=1 ARCH=x86_64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> arch/x86/net/bpf_jit_comp.c:2188:5: warning: no previous prototype for 'arch_prepare_bpf_dispatcher' [-Wmissing-prototypes]
>      2188 | int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs)
>           |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/arch_prepare_bpf_dispatcher +2188 arch/x86/net/bpf_jit_comp.c
> 
> 75ccbef6369e94 Björn Töpel 2019-12-13  2187
> 75ccbef6369e94 Björn Töpel 2019-12-13 @2188  int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs)
> 75ccbef6369e94 Björn Töpel 2019-12-13  2189  {
> 75ccbef6369e94 Björn Töpel 2019-12-13  2190  	u8 *prog = image;
> 75ccbef6369e94 Björn Töpel 2019-12-13  2191
> 75ccbef6369e94 Björn Töpel 2019-12-13  2192  	sort(funcs, num_funcs, sizeof(funcs[0]), cmp_ips, NULL);
> 75ccbef6369e94 Björn Töpel 2019-12-13  2193  	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs);
> 75ccbef6369e94 Björn Töpel 2019-12-13  2194  }
> 75ccbef6369e94 Björn Töpel 2019-12-13  2195
> 
> :::::: The code at line 2188 was first introduced by commit
> :::::: 75ccbef6369e94ecac696a152a998a978d41376b bpf: Introduce BPF dispatcher
> 
> :::::: TO: Björn Töpel <bjorn.topel@intel.com>
> :::::: CC: Alexei Starovoitov <ast@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

