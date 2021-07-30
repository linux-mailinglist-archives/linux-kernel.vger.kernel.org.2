Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE7A3DB500
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbhG3IWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbhG3IWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:22:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DB4C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:22:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mt6so14131770pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=owtpPAJp82sSEXgaqE/tgPPvh+r5r6VE9ueSm139Ez0=;
        b=n7s7sfQcrDjcVagPl2yFQhkUiD9wTx77nVfGl5BdZMwbRUXvDZTCJLAl8BmFneMRKb
         KA3bV69f1wMo1gWXlOs5Oq5K5fYO61smZYKf7ej91jlWHqXn3QJ04oD6XnAFcApQxuvy
         eQZk5l3nPHFxIn9/wPOYp6uqSZjEhZgA2ILcn80HdlptAmtVwYb3UUmSFPLNkupiX3M0
         XQKbwRZq84ImmPyUBn5mXGNzrEZrHjv9D6dmhOKED2TVQOqEEsGwl5f1lTgd0oOGoudy
         0XKooh4h8djj1I51pwEy1UEQeQDUvvySrx9KysCD7hwDl0oW7VD4eVqyopncTZIOzYaL
         f9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=owtpPAJp82sSEXgaqE/tgPPvh+r5r6VE9ueSm139Ez0=;
        b=SBLmddLxZ43I1ojUG4cyjWH7nzBihGkk1gqhs9BUKDLxGf4m36QOnalF+URv5Gz7Bm
         +nYtwzl7aJ9vDU7Dk/5PfWpV3+pWng3vexdArdYlF/9EOhXuh1uotQGjb5qy2f+De05p
         nztQKZpxFGjUj7NzSFaAC9H+dd2E0nLoMqFwcWt17DQpCa44Lo9rKKkoWXolg2OcJDZ+
         GdoKwg4/NWRU1M05heDKU1MTWYyLyYaYuUFthhTSSlHsyl1SJKIClkMr1jzkT9wYNzvG
         Nhaz9JSnbDRNVznkF/WloIh3Hj1Tjj8Os5fYsE2uT+bIJBrDXRRMvioHAt8mnlJygzGX
         fAKg==
X-Gm-Message-State: AOAM532NjLNOEe5nDn2bY9oQhILCAlaH5ZntE5yXBEAOED8eZLEHeFMG
        1sXUgpewo5JD9zxtKcm6rtc=
X-Google-Smtp-Source: ABdhPJzqq5BsYhq6GjcRMCIVcbXXaFr543J6sNC6rnXaMk3MmNxFcu8WWmWaefIQEaHfw2ywleCXMg==
X-Received: by 2002:a62:bd15:0:b029:31c:a584:5f97 with SMTP id a21-20020a62bd150000b029031ca5845f97mr1667205pff.33.1627633360132;
        Fri, 30 Jul 2021 01:22:40 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e12sm1423378pfc.214.2021.07.30.01.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 01:22:39 -0700 (PDT)
Date:   Fri, 30 Jul 2021 01:23:29 -0700
From:   CGEL <cgel.zte@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        James Morris <jamorris@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] set_user: add capability check when rlimit(RLIMIT_NPROC)
 exceeds
Message-ID: <20210730082329.GA544980@www>
References: <20210728072629.530435-1-ran.xiaokai@zte.com.cn>
 <20210728115930.2lzs57h4hvnqipue@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728115930.2lzs57h4hvnqipue@wittgenstein>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:59:30PM +0200, Christian Brauner wrote:
> [Ccing a few people that did the PF_NPROC_EXCEEDED changes]
> 
> 
> Hey Cgel,
> Hey Ran,
> 
> The gist seems to me that this code wants to make sure that a program
> can't successfully exec if it has gone through a set*id() transition
> while exceeding its RLIMIT_NPROC.
> 
> But I agree that the semantics here are a bit strange.
> 
> Iicu, a capable but non-INIT_USER caller getting PF_NPROC_EXCEEDED set
> during a set*id() transition wouldn't be able to exec right away if they
> still exceed their RLIMIT_NPROC at the time of exec. So their exec would
> fail in fs/exec.c:
> 
> 	if ((current->flags & PF_NPROC_EXCEEDED) &&
> 	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> 		retval = -EAGAIN;
> 		goto out_ret;
> 	}
> 
> However, if the caller were to fork() right after the set*id()
> transition but before the exec while still exceeding their RLIMIT_NPROC
> then they would get PF_NPROC_EXCEEDED cleared (while the child would
> inherit it):
> 
> 	retval = -EAGAIN;
> 	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> 		if (p->real_cred->user != INIT_USER &&
> 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
> 			goto bad_fork_free;
> 	}
> 	current->flags &= ~PF_NPROC_EXCEEDED;
> 
> which means a subsequent exec by the capable caller would now succeed
> even though they could still exceed their RLIMIT_NPROC limit.
> 
> So at first glance, it seems that set_user() should probably get the
> same check as it can be circumvented today unless I misunderstand the
> original motivation.
> 
> Christian

Hi Christian,

I think i didn't give enough information in the commit message.
When switch to a capable but non-INIT_SUER and the RLIMIT_NPROC limit already exceeded,
and calls these funcs:
1. set_xxuid()->exec() 
             ---> fail
2. set_xxuid()->fork()->exec()
             ---> success
Kernel should have the same behavior to uer space.
Also i think non init_user CAN exceed the limit when with proper capability,
so in the patch, set_user() clear PF_NPROC_EXCEEDED flag if capable()
returns true.
