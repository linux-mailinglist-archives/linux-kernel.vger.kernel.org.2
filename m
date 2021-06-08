Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE039FCCF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhFHQvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:51:15 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41509 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhFHQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:51:13 -0400
Received: by mail-pf1-f180.google.com with SMTP id x73so16150512pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y5ojMFkZcdug4Csq8mqm5JhvVrMpQqOorJMDrZfK3L0=;
        b=lh+DaKzUePslpvnoIkaJyz/zvSdSmE4QNC6I7Am/QQxbSrt6onCmZEg1XIqC423D/K
         5Qg/dmDRrkcF8iFS3p7pOjbpJNxZOWLM1H+4ZsYsftIOlttG6YWO2zjGqrNSxpP5e61V
         p6la1cPf/LPBLOeic7SXWnPpUTYLXQI5sbUAOv4+tFbJ/3M3qQV1WyncuEB/lhidDR8q
         I2LyGwk73EhoKhCabaDxoiZBE/L4/I//5hkUZRqCy1F/jIkF3R+gNEq/WXP1gPuhWvwR
         Lx46/SOijBtQSdOK3KQMoit6/qj8D+Azsj2CTeFLqMIj6TPtX+s5cNSnSH2ygrxU/nbC
         tjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y5ojMFkZcdug4Csq8mqm5JhvVrMpQqOorJMDrZfK3L0=;
        b=tUQtUbpyk9QWp6c0tkD9uEZutlGtnJpUZ8Hq9IOcC1cpK+bkDrU2E/idwFHdWn443I
         sfCmupPdtrp77KzAyb1UWTLom06m8gIOsMFKFRG6bxLwM9ix0jB1ED+q8i4qf7DoGbb5
         WAM9DEUkU4O452CsWxR3Hz13u6wD5atGZvawTo4oWTwYMTqNX+zav0eHgIb0aC1A0VMD
         yeh4HYK90L0Utl49qDApNvjgfoSoapB3GbvKyFr/+se4/BTryHd0+wN1BAx4j+hlzjON
         cAAUpDhIiJdeSpxawm0dOkWSATZSUqqoNORnBbGechbtXwiPmaPRNi02GqH1kHyYcoWY
         y8cw==
X-Gm-Message-State: AOAM530v7iiNDKHeAbsaTOh9Dqc7T/RAuVOVULF+Hv2imePw2B+JXTyG
        yuimoPKkqjVyZi83U4TCWMjJiQ==
X-Google-Smtp-Source: ABdhPJzG9sGuu05boZhU/9/aFHSUEkhfmiCLMIWQHg5uuxbvLJFY8PYIrlRuihBcLlz48X6Igk4SIg==
X-Received: by 2002:a65:6118:: with SMTP id z24mr23346109pgu.325.1623170900258;
        Tue, 08 Jun 2021 09:48:20 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id u24sm638650pfm.200.2021.06.08.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:48:19 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:48:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+fb0b6a7e8713aeb0319c@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [syzbot] general protection fault in gfn_to_rmap (2)
Message-ID: <YL+fTwfphU1Al3d8@google.com>
References: <0000000000006ac02a05c44397fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006ac02a05c44397fb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    614124be Linux 5.13-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a62298300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=547a5e42ca601229
> dashboard link: https://syzkaller.appspot.com/bug?extid=fb0b6a7e8713aeb0319c
> compiler:       Debian clang version 11.0.1-2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11395057d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d2b797d00000
> 
> The issue was bisected to:
> 
> commit 9ec19493fb86d6d5fbf9286b94ff21e56ef66376
> Author: Sean Christopherson <sean.j.christopherson@intel.com>
> Date:   Tue Apr 2 15:03:11 2019 +0000
> 
>     KVM: x86: clear SMM flags before loading state while leaving SMM
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1437f9bbd00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1637f9bbd00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1237f9bbd00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fb0b6a7e8713aeb0319c@syzkaller.appspotmail.com
> Fixes: 9ec19493fb86 ("KVM: x86: clear SMM flags before loading state while leaving SMM")
> 
> L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 PID: 8410 Comm: syz-executor382 Not tainted 5.13.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__gfn_to_rmap arch/x86/kvm/mmu/mmu.c:935 [inline]

Oh joy.  SMM, rmaps, and memslots.  I'll take this one...
