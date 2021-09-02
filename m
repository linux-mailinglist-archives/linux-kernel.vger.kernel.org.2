Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDFD3FF43C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347403AbhIBTfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:35:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51646 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347257AbhIBTfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:35:37 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 77FCB22465;
        Thu,  2 Sep 2021 19:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630611277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NIKFGy2Vshrszzk+gQOVieDLd7SGIo3rGkRcbRxXnQ=;
        b=vTQiy7g6q2j7ML9f3gFk7RHqEx3RUxKzRfepetU3gLrb9H0kCLnZT6C9AYh+fepc+RdJHP
        OUm0dvdIa/GY+Vl9EJJVMb2MnOg/nSgaefdEGnofUozBZPKa+T/ReydOb9nqWF60xAzKrk
        eiqikCRA2+KAEtJIzjh6zxVQ6JAuWt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630611277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NIKFGy2Vshrszzk+gQOVieDLd7SGIo3rGkRcbRxXnQ=;
        b=7vyoYxyQ+6R6Hu7FQbvNslgoZipn4WE6ToVaD1sw85WXh2PHaTOuf1ftWUXPxfDmTmp26r
        VzuAleKPU/03KxCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 63CEB1369B;
        Thu,  2 Sep 2021 19:34:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1NwNGE0nMWH7bQAAGKfGzw
        (envelope-from <bp@suse.de>); Thu, 02 Sep 2021 19:34:37 +0000
Date:   Thu, 2 Sep 2021 21:35:12 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86-ml <x86@kernel.org>
Subject: Re: vmlinux.o: warning: objtool: mce_wrmsrl.constprop.0()+0x6b: call
 to __sanitizer_cov_trace_pc() leaves .noinstr.text section
Message-ID: <YTEncGj84Sj/IdDb@zn.tnic>
References: <202108221334.TiXxFSTZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202108221334.TiXxFSTZ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 01:39:40PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9ff50bf2f2ff5fab01cac26d8eed21a89308e6ef
> commit: e100777016fdf6ec3a9d7c1773b15a2b5eca6c55 x86/mce: Annotate mce_rd/wrmsrl() with noinstr
> date:   11 months ago
> config: x86_64-buildonly-randconfig-r003-20210822 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e100777016fdf6ec3a9d7c1773b15a2b5eca6c55
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e100777016fdf6ec3a9d7c1773b15a2b5eca6c55
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> vmlinux.o: warning: objtool: mce_wrmsrl.constprop.0()+0x6b: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: do_machine_check()+0xe1a: call to mce_panic.isra.0() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: exc_machine_check()+0x1af: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: lock_is_held_type()+0x3c: call to check_flags() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: __context_tracking_enter()+0x9d: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: __context_tracking_exit()+0x42: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section

The sanitizer stuff is being NOPed out with newer compilers, says
peterz. And I can confirm after testing with your .config and with
gcc-11.

The mce_panic() thing I'm working on.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
