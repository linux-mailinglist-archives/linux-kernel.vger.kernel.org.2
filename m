Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7862530B019
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhBATK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhBATK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:10:26 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5D0C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:09:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m13so17850304wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZi22gvuBwqLPDw7duQoMyJfkf0Ns5lGGvKYgIcT0M0=;
        b=UK1+re8uelEE9t/0L7EegL7C3kNRfJ3JoCcg1MGv29LRpwMTRTZKHCBfKCiCmGpt2D
         M12l60IfJOBrblKbEqLqzCcMIK3cpef/UlZf5Ye8o5wbedwZWxL21MzE8+9JJph28oVh
         jZKg5Y7La97pY/SN8AZOvGBqMkj2sCRRWfQYE0H8N78mzmN/RbBWgvqHeYSUbp2V+gjO
         CXVFOJEsqFEYY5rGO23x1EKcQ9q7Qzs1x8RbGeZi0a1EWIrgD/eo3JkttplJiE2W2CRn
         NfRJfcgYm2vnsRuErNLic8lywWAGFc+CzWgsEwxgXjuVOnuUeC25o+HZM9CqXgaptgKy
         N3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZi22gvuBwqLPDw7duQoMyJfkf0Ns5lGGvKYgIcT0M0=;
        b=ECFbPtTABNWKolCnuLtmpELLD8TgOeCLXbFCWwAvDX8Lih7Nf4DzSNHNHBiMOpn3Tc
         YZGCi9EV8gtK/M0E1bD/D41sXnko7cI2Uzespo8BHv19esl4x70EIYF7AT0kK1P1/VSG
         ky/3KNk5TVGlwGA8RRAI7o02kCCfR4JksqMsDD2PWfvdncNeQVcwSQqSlLH/cdTDfNAJ
         jU9srPY34daWdLhThLEB5412bndei3E7MZp/Xki3VeTzUrKCME7vxfHoteJfI/cu+AG9
         mLdVKBVXGYDinrJZebP/1Gh/kXSdkXF/a7I3PUQpSG1dBEc7e0+65qnRygvVwmz0OKtT
         DuNg==
X-Gm-Message-State: AOAM531WxJ+3yTI0rCl5FeXb631/e/DUPkIXVBJTdmfc3JlAFJtfE4uJ
        fu7P9+jfbhpp+BQrNSFgVJ0=
X-Google-Smtp-Source: ABdhPJzq2/635daITjmdfnXEoXNbSSImmLPo+eE0Q03DvygR8UEIHnqVAcVix/o8GrWPEpFyanhGgQ==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr19183573wrw.415.1612206584578;
        Mon, 01 Feb 2021 11:09:44 -0800 (PST)
Received: from p4 (net-93-70-85-165.cust.vodafonedsl.it. [93.70.85.165])
        by smtp.gmail.com with ESMTPSA id s24sm220864wmh.22.2021.02.01.11.09.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:09:44 -0800 (PST)
Date:   Mon, 1 Feb 2021 19:09:41 +0000
From:   Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        rppt@kernel.org, penberg@kernel.org, geert@linux-m68k.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201190938.GB15399@p4>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201143943.GA15399@p4>
 <20210201153012.GC66060@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201153012.GC66060@C02TD0UTHF1T.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 01, 2021 at 03:30:12PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Mon, Feb 01, 2021 at 02:39:46PM +0000, Giancarlo Ferrari wrote:
> > On Mon, Feb 01, 2021 at 12:47:20PM +0000, Mark Rutland wrote:
> > > On Mon, Feb 01, 2021 at 12:44:56AM +0000, Giancarlo Ferrari wrote:
> > > > machine_kexec() need to set rw permission in text and rodata sections
> > > > to assign some variables (e.g. kexec_start_address). To do that at
> > > > the end (after flushing pdm in memory, etc.) it needs to invalidate
> > > > TLB [section] entries.
> > > 
> > > It'd be worth noting explicitly that set_kernel_text_rw() alters
> > > current->active_mm...
> > > 
> > > > If during the TLB invalidation an interrupt occours, which might cause
> > > > a context switch, there is the risk to inject invalid TLBs, with ro
> > > > permissions.
> > > 
> > > ... which is why if there's a context switch things can go wrong, since
> > > active_mm isn't stable, and so it's possible that set_kernel_text_rw()
> > > updates multiple tables, none of which might be the active table at the
> > > point we try to make an access.
> > 
> > Maybe the behaviour causing issue is not completely clear to me, and I do
> > apologize for that (moreover I haven't eougth debug capabilities).
> 
> I think we're in rough agreement that the issue is likely related to the
> context switch, but our understanding of the specifics differs (and I
> think we're missing a detail here).
> 
> > However, current-active_mm is switched among context switches. Correct ?
> 
> In some cases current->active_mm is not switched, and can be inherited
> over a context switch. When switching to a user task, we always switch
> to its mm (which becomes the active_mm), but when switching to a kthread
> we retain the previous task's mm as the active_mm as part of the lazy
> context switch.
> 
> So while a kthread is preemptible, its active_mm (and active ASID) can
> change under its feet. That could happen anywhere while the task is
> preemptible, e.g. in the middle of set_kernel_text_rw(), or
> mid-modification to the kexec variables.
> 

Yes.

In my understanding, even in the case of user process, when current->active_mm is switched,
we can run into trouble. For instance:

- Process A issue kexec (PageTables entry of A has 0x8000_0000-0x8010_0000 with ro
  permission and section is global, no NG bit set).

- A context switch happens in the middle of set_kernel_text_rw(), right after the
  section 0x8000_0000-0x8010_0000 has been invalidated.

- Process B, in its execution, re-inject its own PageTable entry with ro permission, which
  is not shared with Process A (and is not touched by the previous invalidation) in the MMU
  cache.

- When Process A, is rescheduled, it carries on with the invalidation, but unfortunately I have
  "wrong" entries in the MMU.

> > So, in principle, the invalidation, if stopped, is carried on where it
> > left.
> 
> That's true so long as all the processes we switch between share the
> same leaf tables for the region we're altering. If not, then the lazy
> context switch means that those tables can change under our feet.
> 
> I believe the tables mapping the kernel text are shared by all threads,
> and if so this _should_ be true. Russell might be able to confirm that
> or correct me if I have that wrong.
> 

I am not ready to put my hand on the fire, but I seen the behaviour described above.

> > I thought the issue was that the PageTable entry for the section 0x8010_0000
> > is global, thus not indexed by ASID (Address Space ID). By the fact that each
> > process has its own version of that entry, is the cause of the issue, as the
> > schedule process might bringing a spurious entry (with ro permission) in the
> > MMU cache.
> 
> The TLB invalidation performed under set_kernel_text_rw() affects all
> ASIDs on the current CPU, so there shouldn't be any stale RO TLB entries
> to hit unless the kthread is migrated to another CPU.
> 
> > If the entry is not global holds the ASID, and the issue cannot happen.
> 
> I don't think that's true, since switching to a different active_mm
> would also change ASID, and we'd have no additional guarantee.
> 

I agree, my fault.

> Thanks,
> Mark.

Thanks,


GF
