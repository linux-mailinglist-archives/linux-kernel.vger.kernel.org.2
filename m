Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B115A39EAAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhFHA2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhFHA2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:28:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4310A61108;
        Tue,  8 Jun 2021 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623111969;
        bh=snPAZuAOgkkqsG4GmRCwE8HGSlQHlrj0xdKmSFqf1Vs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hvel4w0ED4cnDiJjzmuiFmSk4D0EmI/3vNYCKsPRXAUeS9vwnJ5kf6GGUqSoK2EBn
         Lz+xbCQ4kVxBXEbKT7yh+gAiyjrNTVjN513vQws8Au51m76VK93nmsvG9C9r87xZuS
         AZA5ikXn9aYPiH/elXlzpp+17+gsWkaQMAJdt26Q=
Date:   Mon, 7 Jun 2021 17:26:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>
Subject: Re: [PATCH v2 15/15] x86: convert to setup_initial_init_mm()
Message-Id: <20210607172608.fda6ee76f9b195428ddb1d0d@linux-foundation.org>
In-Reply-To: <20210604070633.32363-16-wangkefeng.wang@huawei.com>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
        <20210604070633.32363-16-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 15:06:33 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Use setup_initial_init_mm() helper to simplify code.
> 
> ...
>
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -868,10 +868,7 @@ void __init setup_arch(char **cmdline_p)
>  
>  	if (!boot_params.hdr.root_flags)
>  		root_mountflags &= ~MS_RDONLY;
> -	init_mm.start_code = (unsigned long) _text;
> -	init_mm.end_code = (unsigned long) _etext;
> -	init_mm.end_data = (unsigned long) _edata;
> -	init_mm.brk = _brk_end;
> +	setup_initial_init_mm(_text, _etext, _edata, _brk_end);
>  
>  	code_resource.start = __pa_symbol(_text);
>  	code_resource.end = __pa_symbol(_etext)-1;

arch/x86/kernel/setup.c:873:47: warning: passing argument 4 of 'setup_initial_init_mm' makes pointer from integer without a cast [-Wint-conversion]
  873 |  setup_initial_init_mm(_text, _etext, _edata, _brk_end);
      |                                               ^~~~~~~~
      |                                               |
      |                                               long unsigned int
In file included from ./include/linux/pid_namespace.h:7,
                 from ./include/linux/ptrace.h:10,
                 from ./include/linux/elfcore.h:11,
                 from ./include/linux/crash_core.h:6,
                 from ./include/linux/kexec.h:18,
                 from ./include/linux/crash_dump.h:5,
                 from arch/x86/kernel/setup.c:9:
./include/linux/mm.h:248:29: note: expected 'void *' but argument is of type 'long unsigned int'
  248 |       void *end_data, void *brk);
      |                       ~~~~~~^~~


afaict the other architectures will warn this way, not sure.

Please check all that, refresh ,retest and resend?
