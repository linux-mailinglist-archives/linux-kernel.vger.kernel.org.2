Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7241535DC29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbhDMKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhDMKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:07:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A61C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 03:07:26 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b840069f7e8348dd41416.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8400:69f7:e834:8dd4:1416])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 715331EC0301;
        Tue, 13 Apr 2021 12:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618308445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xXJnmCs+7cnxcj2p6Htj9ZWokOkDtDqVoTLfsvw87Y4=;
        b=UmUaqHnObAMQLTeBzqsk2iFtpXQh+VSFJyYdf+gvxSA1VIpj2u3FURAfVyJIlpG7ZgHVkS
        eIZ/wNFssaq7dQ7Rd46e08ftLEXQMdrZsodYO7CL0CWyf+hA6syICPWRjG/16pcjXV9N4Y
        K1aUIxoXBubdFoNMbQKHQLJXGST3xkA=
Date:   Tue, 13 Apr 2021 12:07:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEoIOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
Message-ID: <20210413100722.GC16519@zn.tnic>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210326000235.370514-4-tony.luck@intel.com>
 <20210407211816.GP25319@zn.tnic>
 <20210407214310.GA479383@agluck-desk2.amr.corp.intel.com>
 <20210408084958.GC10192@zn.tnic>
 <20210408170852.GA485019@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210408170852.GA485019@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:08:52AM -0700, Luck, Tony wrote:
> Also not clear to me either ... but sending a SIGBUS to a kthread isn't
> going to do anything useful. So avoiding doing that is another worthy
> goal.

Ack.

> With these patches nothing gets killed when kernel touches user poison.
> If this is in a regular system call then these patches will return EFAULT
> to the user (but now that I see EHWPOISON exists that looks like a better
> choice - so applications can distinguish the "I just used an invalid address in
> a parameter to a syscall" from "This isn't my fault, the memory broke".

Yap, makes sense.

> KVM apparently passes a machine check into the guest.

Ah, there it is:

static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *tsk)
{
        send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
}

> Though it seems to be misisng the MCG_STATUS information to tell
> the guest whether this is an "Action Required" machine check, or an
> "Action Optional" (i.e. whether the poison was found synchonously by
> execution of the current instruction, or asynchronously).

Yeah, someone needs to deal with that sooner or later, considering how
virt is becoming ubiquitous.

> There is the ancient Documentation/vm/hwpoison.rst from 2009 ... nothing
> seems wrong in that, but could use some updates.

Ah yap, that.

So what I'm missing with all this fun is, yeah, sure, we have this
facility out there but who's using it? Is anyone even using it at all?

If so, does it even make sense, does it need improvements, etc?

Because from where I stand it all looks like we do all these fancy
recovery things but is userspace even paying attention or using them or
whatever...

> I don't know how much detail we might want to go into on recovery
> stratgies for applications.

Perhaps an example or two how userspace is supposed to use it...

> In terms of production s/w there was one ISV who prototyped recovery
> for their application but last time I checked didn't enable it in the
> production version.

See, one and it hasn't even enabled it. So it all feels like a lot of
wasted energy to me to do all those and keep 'em working. But maybe I'm
missing the big picture and someone would come and say, no, Boris, we
use this and this and that is our feedback...

> Essentially it boils down to:
> SIGBUS handler gets additional data giving virtual address that has gone away
> 
> 1) Can the application replace the lost page?
> 	Use mmap(addr, MAP_FIXED, ...) to map a fresh page into the gap
> 	and fill with replacement data. This case can return from SIGBUS
> 	handler to re-execute failed instruction
> 2) Can the application continue in degraded mode w/o the lost page?
> 	Hunt down pointers to lost page and update structures to say
> 	"this data lost". Use siglongjmp() to go to preset recovery path
> 3) Can the application shut down gracefully?
> 	Record details of the lost page. Inform next-of-kin. Exit.
> 4) Default - just exit

Right and this should probably start with "Hey userspace folks, here's
what you can do when you get a hwpoison signal and here's how we
envision this recovery to work" and then we can all discuss and converge
on an agreeable solution which is actually used and there will be
selftests and so on and so on...

But what the h*ll do I know.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
