Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCBF30557F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317019AbhAZXNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbhAZFAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:00:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C805FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:52:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b8so9132101plh.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eQKrbfMg9apB2fq4n7gF++OHi/XlTEUw11uN3HmUDu8=;
        b=i3ZgjdZnEt7qlMz23j/qwccf1uzLMu602kHPxxO1DFzf8BJ8LTZR8IR2+7RLUHV0Vd
         fr/jCHko3aegsGYa1guuouNrrmEmyfZjHu//qpQOolLiDpoEsX7aU5S0TiG5NtSPA4hy
         bP8XC16KtJd/yxtGQfTuAt0TGjezFslhPOd2bfp1Wlk3swTTfDzWmonuT+AQP0p58iY3
         eIXyRJqZAWSCcQ6jEJBFAC/aAf1R32lhJULMYDw/U8zM4RSE6m5nJ/9ZynaUyDib+LfL
         KAl831jTgmmD33JSG5X/X5//Iv50iaxw3hn3MYZ9Ab5nODlSNHVcSl8lg6fyhA5ue8GY
         ssWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eQKrbfMg9apB2fq4n7gF++OHi/XlTEUw11uN3HmUDu8=;
        b=t95rWxVhxyvHKunAgFSRfMwyoBteJDAc3xVhyNYk5cqvxH367rc/1e8xxfMb9dPw29
         YHIaF8A0B5GIDNJQJZFENl2acfwN7Uw6Hf5vmsloYxW7L2shbFK/tLc7HIo9hUyx2UqR
         uCe7UYFT/d14C+OG0R1z1VF6Hpx8wKzSocOAbF8uQeUmwDqEoh9XS3X7jkws7aiuOAhd
         wpKj3LgbaltmkpH+qjbsx+bpgwI2tB3jmo5R/6OdauYtp+MS0cfmDkAvZLHALvkpPER+
         WGWuojP2XBNSpGsVGYKoGb+9X16mfN8sNwd6oOneMinU7QpkToFpFQp8Y2QyRknxDaCT
         tCWA==
X-Gm-Message-State: AOAM530ZZ9wxejPgoV6xZYZpPyTIm95TPH5PI8+3Chr2qb7TpVheditR
        UBxE2qzK0drCXS2L23zZTkA=
X-Google-Smtp-Source: ABdhPJzRzCuSXHZd4qJ69MxRV7nhe25GWTQW/Qr6vSihPEVVhxL4U434YdPKkvxQylJMNaWMd1kP5A==
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr4072244pjz.22.1611636740326;
        Mon, 25 Jan 2021 20:52:20 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id b17sm6419498pfo.151.2021.01.25.20.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:52:19 -0800 (PST)
Date:   Tue, 26 Jan 2021 13:52:17 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
Message-ID: <YA+gAV1kW8Ru1+Bo@jagdpanzerIV.localdomain>
References: <20210122081311.GA12834@xsang-OptiPlex-9020>
 <YAr7d6A4CkMpgx+g@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAr7d6A4CkMpgx+g@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/22 17:21), Petr Mladek wrote:
[..]
> > [  952.271861] ? firmware_map_remove (kbuild/src/consumer/kernel/sched/core.c:4411) 
> > [  952.272870] ? ksys_write (kbuild/src/consumer/fs/read_write.c:661) 
> > [  952.273709] schedule (kbuild/src/consumer/include/linux/thread_info.h:84 (discriminator 1) kbuild/src/consumer/include/linux/sched.h:1897 (discriminator 1) kbuild/src/consumer/kernel/sched/core.c:4608 (discriminator 1)) 
> > [  952.274495] exit_to_user_mode_prepare (kbuild/src/consumer/kernel/entry/common.c:160 kbuild/src/consumer/kernel/entry/common.c:191) 
> > [  952.275516] syscall_exit_to_user_mode (kbuild/src/consumer/arch/x86/include/asm/jump_label.h:41 kbuild/src/consumer/arch/x86/include/asm/nospec-branch.h:288 kbuild/src/consumer/arch/x86/include/asm/entry-common.h:80 kbuild/src/consumer/kernel/entry/common.c:133 kbuild/src/consumer/kernel/entry/common.c:268) 
> 
> > [  952.276650] entry_INT80_compat (kbuild/src/consumer/arch/x86/entry/entry_64_compat.S:412) 
> > [  952.277673] RIP: 0023:0xf7f93a02
> > [  952.278497] RSP: 002b:00000000ff8db2f4 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
> > [  952.280235] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 000000005666f220
> > [  952.281813] RDX: 0000000000000001 RSI: 00000000f7f59d60 RDI: 0000000000000001
> > [  952.283347] RBP: 000000005666f220 R08: 0000000000000000 R09: 0000000000000000
> > [  952.284919] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > [  952.286507] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [  952.294673] tasks-torture:torture_onoff task: online 0 failed: errno -5
> > [  952.328047] tasks-torture:torture_onoff task: online 0 failed: errno -5
> > [  952.336658]
> > [  352.572231]
> > [   98.585525] tasks-torture:torture_onoff task: online 0 failed: errno -5
> > [  952.336693]
> > [  952.359450]
> > [  352.594642] tasks-torture:torture_onoff task: online 0 failed: errno -5
> > [  952.359483]
> > [  952.377678] tasks-torture:torture_onoff task: online 0 failed: errno -5
> > [  952.409955] tasks-torture:torture_onoff task: online 0 failed: errno -5
> > [  952.412504]
> > [  352.610470]
> > [   98.605699] tasks-torture:torture_onoff task: online 0 failed: errno -5
> > [  952.412531]
> > [  952.444293]
> > [  352.625170] tasks-torture:torture_onoff task: online 0 failed: errno -5
> > [  952.444328]
> > [  952.453669] tasks-torture:torture_onoff task: online 0 failed: errno -5
> > [  952.480340]
> > [  352.638172]
> > 
> > To reproduce:
> > 
> >         # build kernel
> > 	cd linux
> > 	cp config-5.10.0-rc5-gb031a684bfd0 .config
> > 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> I am still struggling with lkp-tests. I have never used them before
> and have troubles to get it working. It asks for a newer qemu at
> the moment. It means that I am still not able to reproduce it :-/
> 
> I wonder if there is a way to reproduce this without lpk-tests
> framework.

AFAIU this is just 'modprobe rcutorture'

	-ss
