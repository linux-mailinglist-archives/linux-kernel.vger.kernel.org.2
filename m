Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A47399621
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 01:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFBXCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 19:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhFBXCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622674859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MPrBm4pCU4C8JgZ5tgMYa+zwFIgSn7emHLBFvwvnEFo=;
        b=gOygiIBeXR0TogldueEmZbMC+Yf0x+Mh+VlRNrMdb7O/GTVPrxs+HwzIouvbcBL70qWaKZ
        JoYgPeEOsLx2e0d66cGJtooo9ntCwlTrgBTC0VtWvv0y+9KLK1pGuAsxYy056b7eocXNXf
        FMfzexGMyXkDjiBR5bz7gQZcGqMojj8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-4XgPyYmrPimlc7yX8fcSVg-1; Wed, 02 Jun 2021 19:00:58 -0400
X-MC-Unique: 4XgPyYmrPimlc7yX8fcSVg-1
Received: by mail-qv1-f71.google.com with SMTP id dr11-20020a05621408ebb029021e40008bd5so2122758qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 16:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MPrBm4pCU4C8JgZ5tgMYa+zwFIgSn7emHLBFvwvnEFo=;
        b=CxsiFxpjf0nr2VC6GFYegg+sKrhVglL4yLz0WpPcRY+IHLMbPtr7J0LiiZiQWiR3Qd
         ols6TXZeodpWn7Tjc3HagW1mHQ5mcDUhBjz+x8q4ThyfkIRBuOVoEPdDEV12gbNDdupF
         ElvkAQKGy+62S5G3ODAsBciWmadUUiXeE0cPifI7drzwa50PuTGW409y3wxXBTX+cD5T
         MsUbEoCdr0GPJTOI6xTLVfynA+Y0elnUEg77tB3s3mH/X7cZdRFuFxXr6GsrvNOhds2o
         EDBipkeOlg+cn76MLUA8BpRV/3uusQT8WM64N9giBmvAX+r3LvAn18tVqfL51iBYBWrg
         PZTw==
X-Gm-Message-State: AOAM530bPsgI166VfypUhOoGPHu5WR4zC+BCH2yY4LR50cJdK7jGBI+V
        I609RN9NFccIX5WH27m/X7NYCOxcotOGdRoNQb2QUC60EoarUcKJkt/Sf4OuJhfD5iYHAS87zEW
        TEbKCrJuUnnLHXuKPUlaFK49U
X-Received: by 2002:a0c:ec08:: with SMTP id y8mr11140208qvo.35.1622674857658;
        Wed, 02 Jun 2021 16:00:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKByDB//1nEMXQjHiVcu2qe/IpkTl49oBUX5DkT4EcGohrOxWr/rvUs53wqb8RdAWaUBdBuA==
X-Received: by 2002:a0c:ec08:: with SMTP id y8mr11140186qvo.35.1622674857426;
        Wed, 02 Jun 2021 16:00:57 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id i5sm777014qki.115.2021.06.02.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 16:00:56 -0700 (PDT)
Date:   Wed, 2 Jun 2021 18:00:54 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>
Cc:     ak@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        inglorion@google.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
Message-ID: <20210602230054.vyqama2q3koc4bpo@treble>
References: <00000000000030293b05c39afd6f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000030293b05c39afd6f@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 12:15:23AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1246d43dd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9f3fc7daa178986
> dashboard link: https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3
> compiler:       Debian clang version 11.0.1-2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
> Read of size 8 at addr ffffc90001c0f7a0 by task systemd-udevd/12323

This looks like a valid bug in profile_pc().  With !FRAME_POINTER, it
has an ancient (2006) hack for unwinding a single frame, for when
regs->ip is in a lock function.

I guess the point is to put lock functions' callees in the profile,
rather than the lock functions themselves.

profile_pc() assumes the return address is either directly at regs->sp,
or one word adjacent to it due to saved flags, both of which are just
completely wrong.  This code has probably never worked with ORC, and
nobody noticed apparently.

We could just use ORC to unwind to the next frame.  Though, isn't
/proc/profile redundant, compared to all the more sophisticated options
nowadays?  Is there still a distinct use case for it or can we just
remove it?

-- 
Josh

