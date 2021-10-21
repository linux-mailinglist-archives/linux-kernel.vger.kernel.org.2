Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B850436742
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhJUQJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJUQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:09:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C47C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:06:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so785229plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m3LNgj0O/EXMuPerErFfv8v3ZBKINoSF6egU7Q9+w6o=;
        b=VluUCZI5Zb5BTknGwQTyQF+4e1x/d0hzfTejBQzID7EOo2c7LL2H55BJCJyzDqz+TY
         eopKS0vvjh1ta40dEl/PecFKas4qyf0oFKD9A4UW7/OqH1mtSPUfkEMqv2oYbNmDH5et
         RgtwwZtcSQXUO/559PvY3hzysWPdXVTGUMTfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m3LNgj0O/EXMuPerErFfv8v3ZBKINoSF6egU7Q9+w6o=;
        b=dkv4x5KLVLhMZ8EWWh1+4wW+Wn1uoPzLzZaq1dk/I9SoGxg1LTA4xcffHbCEpLUZW3
         fS+TyT5ork7fpfwXG3G/5S/IVWO5Vik/eWgm3g8eJZD8gobRVAbDKFJrxfS+6OSeH4+v
         Qks/8tfMqQ3tVScPu7QesH1yPGz+74WtDjuQa4V9z800MxL4QccVon2oloy0h3biC5PX
         Czmk4eai8ymIh6toK80hEsdBgSxlRwflCg3AmHRK7EC2WfGxhHvmOQyyvj7xN4c4G5ow
         ZTHljxuNEXAoJmLcz3LWYyImB/P1fzRDmsF4E1sBttNLYflgeGqeJi/AaLb1eDDIoTv4
         yoDA==
X-Gm-Message-State: AOAM531A0038pJABGQTTnjaCPhFJrl58L3/80x+NL6LkH0nocdJR1opG
        bgDXrlq+OWO1OA1oY8lO08GcZA==
X-Google-Smtp-Source: ABdhPJxgGu/kN8JubYDrPPD2bRBuFYPLrSNply2C5Q8AmdkddFccWiBgO05LI4OoBiR/2Tp4xlB9MQ==
X-Received: by 2002:a17:902:c94e:b0:13f:1b02:e539 with SMTP id i14-20020a170902c94e00b0013f1b02e539mr5894109pla.72.1634832411588;
        Thu, 21 Oct 2021 09:06:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s2sm5721985pgd.13.2021.10.21.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:06:51 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:06:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Maciej Rozycki <macro@orcam.me.uk>, linux-mips@vger.kernel.org
Subject: Re: [PATCH 05/20] signal/mips: Update (_save|_restore)_fp_context to
 fail with -EFAULT
Message-ID: <202110210906.AA70D50BA@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-5-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:51PM -0500, Eric W. Biederman wrote:
> When an instruction to save or restore a register from the stack fails
> in _save_fp_context or _restore_fp_context return with -EFAULT.  This
> change was made to r2300_fpu.S[1] but it looks like it got lost with
> the introduction of EX2[2].  This is also what the other implementation
> of _save_fp_context and _restore_fp_context in r4k_fpu.S does, and
> what is needed for the callers to be able to handle the error.
> 
> Furthermore calling do_exit(SIGSEGV) from bad_stack is wrong because
> it does not terminate the entire process it just terminates a single
> thread.
> 
> As the changed code was the only caller of arch/mips/kernel/syscall.c:bad_stack
> remove the problematic and now unused helper function.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Maciej Rozycki <macro@orcam.me.uk>
> Cc: linux-mips@vger.kernel.org
> [1] 35938a00ba86 ("MIPS: Fix ISA I FP sigcontext access violation handling")
> [2] f92722dc4545 ("MIPS: Correct MIPS I FP sigcontext layout")
> Fixes: f92722dc4545 ("MIPS: Correct MIPS I FP sigcontext layout")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
