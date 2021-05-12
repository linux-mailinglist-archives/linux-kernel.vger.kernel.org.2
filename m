Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB137B894
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhELIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhELIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:52:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 01:51:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l4so33817203ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fce5qJN1hadTzFdkSFVgTLhw/gyfml8gF90uU9wKwAo=;
        b=XQlayrCX96DZLM7WQw2rZQ+XhpwQHyQOgChpTkVdq4QH8yeol/wikkX7VUx0sSY38Y
         GxIDHMVcS7I/c4E4uU2Nky18YypHIwU9BOeAjBXmff+c2BbS0j4neSQG0WosI2TmVOQd
         nJRx3HK+Gp8vBQDrZD2rHxtecg0S5Z+p6OUZS4CQiWfF+W4SVvrxJd2Mw6zoSFKChcc0
         v4cAVcZXK/hFdbrz08D5buiz+grHpDi7kfVUSlcoVmtqhHYN9EE40J+Fexff8ttDn3FL
         5oevBRxYBawkkJU8R+20Wv1Ei992xAVqA21rAHz8GFWLHPX/UYVU7pibLHaC2wuIqI0h
         lA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fce5qJN1hadTzFdkSFVgTLhw/gyfml8gF90uU9wKwAo=;
        b=lsChrfB553hne7GrbtI7UdACPuTk57DI2RHJgiUMA8rf1VWueZFtUOWjZSEbeNR43Y
         A6jr4vM3+DRHL6FxtMSLwWL1HLLGr63HQgP6dk3rLo5VXRQf/J5OHTLdQO42DnDQ+3pN
         tBaoO3JN6RrbpvobfcMZYwheWV95Q5IU6BdZKDeFxt5hT+zpbp5RAa3BTWl3C5Azm+ld
         l+obROeqKZLujVV0KU50T794dHN6psHpuoCyvyVF0wqCyaMQBqkKxKCVwWlHHR1sTVQ4
         0mzMzOg9hgYiU2yUfHy3auhS1/gV9u+PUXkDhbFtiK6FlYbHGHVSyjG0gh/uOPdUfu0X
         r98A==
X-Gm-Message-State: AOAM530XK+YzdZe6sIpBiVvDJYS/PtkcmZea1o8MdwhIiiLuHHQL/3BK
        XM98ZMZIwD6MfjHL+LBRsXs=
X-Google-Smtp-Source: ABdhPJzE7c4W/Zb/i8vZYyIsoNFI1WXRmbJJoTm41AgXwltIY05v5hDAvMoN1v2CfCg/93vYQ9A58w==
X-Received: by 2002:a17:906:cede:: with SMTP id si30mr34479922ejb.99.1620809482940;
        Wed, 12 May 2021 01:51:22 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id k9sm17883147edv.69.2021.05.12.01.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:51:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 12 May 2021 10:51:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle
 all invalid syscall nrs
Message-ID: <YJuXCFAh0RR2+x25@gmail.com>
References: <20210510185316.3307264-1-hpa@zytor.com>
 <20210510185316.3307264-8-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510185316.3307264-8-hpa@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Redefine the system call number consistently to be "int". The value -1
> is a non-system call (which can be poked in by ptrace/seccomp to
> indicate that no further processing should be done and that the return
> value should be the current value in regs->ax, default to -ENOSYS; any
> other value which does not correspond to a valid system call
> unconditionally calls sys_ni_syscall() and returns -ENOSYS just like
> any system call that corresponds to a hole in the system call table.
> 
> This is the defined semantics of syscall_get_nr(), so that is what all
> the architecture-independent code already expects.  As documented in
> <asm-generic/syscall.h> (which is simply the documentation file for
> <asm/syscall.h>):
> 
> /**
>  * syscall_get_nr - find what system call a task is executing
>  * @task:       task of interest, must be blocked
>  * @regs:       task_pt_regs() of @task
>  *
>  * If @task is executing a system call or is at system call
>  * tracing about to attempt one, returns the system call number.
>  * If @task is not executing a system call, i.e. it's blocked
>  * inside the kernel for a fault or signal, returns -1.
>  *
>  * Note this returns int even on 64-bit machines.  Only 32 bits of
>  * system call number can be meaningful.  If the actual arch value
>  * is 64 bits, this truncates to 32 bits so 0xffffffff means -1.
>  *
>  * It's only valid to call this when @task is known to be blocked.
>  */
> int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);

I've applied patches 1-6, thanks Peter!

Wrt. patch #7 - the changelog is hedging things a bit and the changes are 
non-trivial. Does this patch (intend to) change any actual observable 
behavior in the system call interface, and if yes, in which areas?

Or is this a pure cleanup with no observable changes expected?

Thanks,

	Ingo
