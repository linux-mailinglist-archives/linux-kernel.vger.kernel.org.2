Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3943DEA3A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhHCKDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbhHCKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:03:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED5DC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:03:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z3so21738471plg.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/IzPtouOGEMSDGanSZKgSjtOJ/pVP6LYmNUggjWTPNI=;
        b=Etvr92bMhD5ZncIkzYe3n5eFfloayFtZRkVLBcurnqfA/PCO2DIgQoxdc0lhbOGc32
         055uWGT3hK5MkmbUY82dMENq1OyUUDUCx4axFBSpnUBUBo7NcdOLfx/CcwENSuLx5bvQ
         NEpfpqvbAESPyTQ+medQAc6Z2UoEM2Z981fVZnAj4tc8Kfyuu6Bs/Hpt9evkzKOZRFMT
         +ta/uFVHsIqzWGM+OGYQM+bH8ZojRNtg/4T3e6MUZXac2LYljtJu0j47O0iGjInZtbLd
         I03R3B8doHW/JFggsJM+3nHtCZgXNjpM6/s1oB99VHxt9Unat1tWQgdrg9PIF9wgfhAt
         FVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/IzPtouOGEMSDGanSZKgSjtOJ/pVP6LYmNUggjWTPNI=;
        b=MhmQrtw7JtD2LD6KrcyCzKMY/ztd4z1oh4LIWHvVCzMAQwddiP+Jys80SGQgB3Km/f
         F9A1coybgwDk+uxsmQtb0gBe92VSB3SgELttZ/+ULm2TEjmjUd1a+pv9emSPRNK00NBx
         5Zsmso/F1fBgWxbik3g+SLsEAF1rIe7IMhZeIpPyhzIJL9P2awlgjAIgxQrGgHE06wtF
         6lulur1oCfsUa+LT088mAK2sYwcz73h8fXd0JRqYQ/JwihXJjutkhNYjqE8WPCDgSLwp
         sj9FcXVnF0ZC0rkwrO3keSU+4e1YSUbuRMms5QtmzLjVFI7xGwS+2RRPu9fWrPb155A7
         5++Q==
X-Gm-Message-State: AOAM533evtUdcLtVLRpuAMtgLy/CTJZC/TF6hXm3LaIi8v/5Nc6gdOnF
        g0zr35Tj4weUs0k6NcTqcHtWZXRCdcNabQ==
X-Google-Smtp-Source: ABdhPJz+Z1T1Lz8QJ5oCyciwi2i38O/krIE4nCOfdPwsFK1d1Y83voF/avWJth+5fnOvtAKjx/yPTA==
X-Received: by 2002:a63:1c53:: with SMTP id c19mr797013pgm.394.1627984985974;
        Tue, 03 Aug 2021 03:03:05 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a12sm4405927pfg.120.2021.08.03.03.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:03:05 -0700 (PDT)
Date:   Tue, 3 Aug 2021 03:03:54 -0700
From:   CGEL <cgel.zte@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        James Morris <jamorris@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] set_user: add capability check when rlimit(RLIMIT_NPROC)
 exceeds
Message-ID: <20210803100354.GA607722@www>
References: <20210728072629.530435-1-ran.xiaokai@zte.com.cn>
 <20210728115930.2lzs57h4hvnqipue@wittgenstein>
 <20210730082329.GA544980@www>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730082329.GA544980@www>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 01:23:31AM -0700, CGEL wrote:
> On Wed, Jul 28, 2021 at 01:59:30PM +0200, Christian Brauner wrote:
> > [Ccing a few people that did the PF_NPROC_EXCEEDED changes]
> > 
> > 
> > Hey Cgel,
> > Hey Ran,
> > 
> > The gist seems to me that this code wants to make sure that a program
> > can't successfully exec if it has gone through a set*id() transition
> > while exceeding its RLIMIT_NPROC.
> > 
> > But I agree that the semantics here are a bit strange.
> > 
> > Iicu, a capable but non-INIT_USER caller getting PF_NPROC_EXCEEDED set
> > during a set*id() transition wouldn't be able to exec right away if they
> > still exceed their RLIMIT_NPROC at the time of exec. So their exec would
> > fail in fs/exec.c:
> > 
> > 	if ((current->flags & PF_NPROC_EXCEEDED) &&
> > 	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> > 		retval = -EAGAIN;
> > 		goto out_ret;
> > 	}
> > 
> > However, if the caller were to fork() right after the set*id()
> > transition but before the exec while still exceeding their RLIMIT_NPROC
> > then they would get PF_NPROC_EXCEEDED cleared (while the child would
> > inherit it):
> > 
> > 	retval = -EAGAIN;
> > 	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> > 		if (p->real_cred->user != INIT_USER &&
> > 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
> > 			goto bad_fork_free;
> > 	}
> > 	current->flags &= ~PF_NPROC_EXCEEDED;
> > 
> > which means a subsequent exec by the capable caller would now succeed
> > even though they could still exceed their RLIMIT_NPROC limit.
> > 
> > So at first glance, it seems that set_user() should probably get the
> > same check as it can be circumvented today unless I misunderstand the
> > original motivation.
> > 
> > Christian
> 
> Hi Christian,
> 
> I think i didn't give enough information in the commit message.
> When switch to a capable but non-INIT_SUER and the RLIMIT_NPROC limit already exceeded,
> and calls these funcs:
> 1. set_xxuid()->exec() 
>              ---> fail
> 2. set_xxuid()->fork()->exec()
>              ---> success
> Kernel should have the same behavior to uer space.
> Also i think non init_user CAN exceed the limit when with proper capability,
> so in the patch, set_user() clear PF_NPROC_EXCEEDED flag if capable()
> returns true.

Hi, Christian

Do you have any further comments on this patch?
is there anything i did not give enough infomation ?
