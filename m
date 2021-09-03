Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4773F400408
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbhICRWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:22:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38762 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhICRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:22:54 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 748131FDAD;
        Fri,  3 Sep 2021 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630689713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hM3W/onCHq9iYy2Mbh8EsDHg51cZRbQTbohRjagfa8E=;
        b=D5w1M6visvcKk5+KeC+zKI0bOs8AJAbzGqLai8ZtePXCav1sAG2ol+uuX4jJO42Qh9nmZl
        nmpfnPhtQxeIXc6f9DxkNkY87famPBoHG12WPGkdq6zrO/ugbbRpzC8mkYV7h6S0lM9Pg9
        7XgZq137r+rGboh9Zh3MfidawkPC5+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630689713;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hM3W/onCHq9iYy2Mbh8EsDHg51cZRbQTbohRjagfa8E=;
        b=J890ILo3oNjnp4egKK280BxuwbsHrjYmN2/wrROno098NokNjXaivsw5vOyY3u8p6W+eZz
        xAYxfzmWF53c3nAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 642D1137E2;
        Fri,  3 Sep 2021 17:21:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gu0aGLFZMmEIcQAAGKfGzw
        (envelope-from <bp@suse.de>); Fri, 03 Sep 2021 17:21:53 +0000
Date:   Fri, 3 Sep 2021 19:22:25 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: vmlinux.o: warning: objtool: noist_exc_machine_check()+0x93:
 call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
Message-ID: <YTJZzVrutm4yZAzi@zn.tnic>
References: <202108221656.2tMcBD2a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202108221656.2tMcBD2a-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 04:54:06PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9ff50bf2f2ff5fab01cac26d8eed21a89308e6ef
> commit: bcb1b6ff39da7e8a6a986eb08126fba2b5e13c32 objtool: Correctly handle retpoline thunk calls
> date:   5 months ago
> config: x86_64-buildonly-randconfig-r003-20210822 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bcb1b6ff39da7e8a6a986eb08126fba2b5e13c32
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout bcb1b6ff39da7e8a6a986eb08126fba2b5e13c32
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    vmlinux.o: warning: objtool: mce_wrmsrl.constprop.0()+0x6b: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: do_machine_check()+0xb14: call to queue_task_work() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: exc_machine_check()+0xdb: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: noist_exc_machine_check()+0x93: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: __context_tracking_enter()+0x95: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: __context_tracking_exit()+0x42: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

https://lkml.kernel.org/r/YTHpmGmlo9N%2B1Rs7@hirez.programming.kicks-ass.net

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
