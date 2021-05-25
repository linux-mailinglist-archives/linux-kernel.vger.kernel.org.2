Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3A3906DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhEYQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhEYQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:48:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800DBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:46:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f22so22263284pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xwS5IVdCekJk7kv3FtNxGVNuofglwTIwxkn43HaNTJo=;
        b=LkOcj4gtSJPG6QLSDZLLxKY0eFWqg75E5lt7Vq6by8faYpV4d+j1pbincVWsRHY6cR
         gehPrbn8jhvFppDxsZ3sUCPBNj+hlo56GFqvOLg3VWW3LtU9Xp5qX8CCW/4zZwfQ2awY
         Pgd4SE2ggCQEo9OKVolYfCWIBVOqpjCpgvY5S9G90MfYVrZ8jnDbOKyRQNlMA3Lxreqs
         djtJpam7l9btEoGR6Pd0kZlk3uC9t5y/+i9BxICFj84qhjhmTDim4ZkzBnOB9tnAp5Lu
         x2LunG+TtD/xW1Z+NWOLEV7pqUMKMXt1+2VMRngnppROoZRhOwCstn8YDpEi8QjkAOS1
         jkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xwS5IVdCekJk7kv3FtNxGVNuofglwTIwxkn43HaNTJo=;
        b=ou9taipcKwMidBW9pIvi/J0swwCSU8qm2fGm2JHt3dO++mF4deR/kH/V/2SVkTfWWZ
         PF0N7dWSVjG7IpBIXOeK7CQMS3OgQFyaMiUHIayo7dmF4wPHUWD6wYVRZohLTIxKSHId
         Vq3oW/7Iko1bwiB+JbOVT+DdaG4A20NDl1BRG9x1JfTDz9v+70UYp0FuV1wkyF2bw8hP
         +FMDR1Fj+pTJVGG2tgzsfxfp29/wuY/g645gm1gVPU64on/z+5OIWKdhu/HLd6u2ojch
         APTYHrFDQ2qkomhkpSLKIPpaE4XmyxSoAkvdZUcNyWdaydq+kRSugsuOdEHlT2NrU+vM
         812g==
X-Gm-Message-State: AOAM531mvpks5tXWSngHDiUZ5P8kGp6gdMHSS0ij671ZYH9tyAaT7eEK
        1zXxzZpM58Nc8aECIALUVtgyxw==
X-Google-Smtp-Source: ABdhPJwzX5Z1/XMITezELAhA4gfUFx10BkBRwzCVyyn+CkMr7oR5/cLRKHNBzud+DuLNirYdfDXmxw==
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id p30-20020a056a000a1eb02902e289d85c87mr29438912pfh.73.1621961195812;
        Tue, 25 May 2021 09:46:35 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 10sm15223768pgl.39.2021.05.25.09.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:46:35 -0700 (PDT)
Date:   Tue, 25 May 2021 16:46:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [kbuild-all] Re: [PATCH] kvm: fix boolreturn.cocci warnings
Message-ID: <YK0p53dAhark4xuy@google.com>
References: <202105251316.O1igBtAa-lkp@intel.com>
 <20210525055940.GA7291@9b81fe870f96>
 <YKyjCOk2UiVQCh7m@hirez.programming.kicks-ass.net>
 <91885328-dc7f-3d12-3ddb-53a403bb8c60@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91885328-dc7f-3d12-3ddb-53a403bb8c60@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021, Rong Chen wrote:
> 
> 
> On 5/25/21 3:11 PM, Peter Zijlstra wrote:
> > On Tue, May 25, 2021 at 01:59:40PM +0800, kernel test robot wrote:
> > > From: kernel test robot <lkp@intel.com>
> > > 
> > > arch/arm64/kvm/mmu.c:1203:9-10: WARNING: return of 0/1 in function 'kvm_age_gfn' with return type bool
> > > arch/arm64/kvm/mmu.c:1173:9-10: WARNING: return of 0/1 in function 'kvm_set_spte_gfn' with return type bool
> > > arch/arm64/kvm/mmu.c:1216:9-10: WARNING: return of 0/1 in function 'kvm_test_age_gfn' with return type bool
> > > arch/arm64/kvm/mmu.c:1159:9-10: WARNING: return of 0/1 in function 'kvm_unmap_gfn_range' with return type bool
> > > 
> > >   Return statements in functions returning bool should use
> > >   true/false instead of 1/0.
> > > Generated by: scripts/coccinelle/misc/boolreturn.cocci
> > Per 2b076054e524 ("remove boolinit.cocci"), I have a very dim view of
> > this sort of thing.
> 
> Hi Peterz,
> 
> Sorry for the noise, we'll disable the check.
> 
> > 
> > > Fixes: 63b3f96e1a98 ("kvm: Select SCHED_INFO instead of TASK_DELAY_ACCT")
> > *how* ?!?
> 
> The bot is stupid

LOL.  FWIW, it's not _that_ stupid, or maybe it's the broken clock adage...  The
proper fix is sitting in the KVM tree, it should soon make its way to Linus.

  fcb8283920b1 ("KVM: arm64: Fix boolreturn.cocci warnings")
