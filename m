Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5DD357E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhDHIuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:50:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50180 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhDHIuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:50:09 -0400
Received: from zn.tnic (p200300ec2f095000c11580856fe05acf.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5000:c115:8085:6fe0:5acf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 058401EC0345;
        Thu,  8 Apr 2021 10:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617871798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OAmeFLxEiSolAtavkLNebYBz6u4TA38CbLrXFCNSsa4=;
        b=DbQfLkO4nEavplK0PylAAefss1MYNn/kKkD47krySK/6WU+MpsszVfIOB54iEs81mG6dW1
        RBYTPSt7g/L2Qd3qKZ/31+WTImnQqsqpYxH08K8wpcEOMBz7lLJYVGCnd9SSi2ZhYhL+eQ
        JBzqjFBbCU5U67v1S2FK9XsAmohnrBg=
Date:   Thu, 8 Apr 2021 10:49:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEoIOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
Message-ID: <20210408084958.GC10192@zn.tnic>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210326000235.370514-4-tony.luck@intel.com>
 <20210407211816.GP25319@zn.tnic>
 <20210407214310.GA479383@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407214310.GA479383@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:43:10PM -0700, Luck, Tony wrote:
> On Wed, Apr 07, 2021 at 11:18:16PM +0200, Borislav Petkov wrote:
> > On Thu, Mar 25, 2021 at 05:02:34PM -0700, Tony Luck wrote:
> > > Andy Lutomirski pointed out that sending SIGBUS to tasks that
> > > hit poison in the kernel copying syscall parameters from user
> > > address space is not the right semantic.
> > 
> > What does that mean exactly?
> 
> Andy said that a task could check a memory range for poison by
> doing:
> 
> 	ret = write(fd, buf, size);
> 	if (ret == size) {
> 		memory range is all good
> 	}
> 
> That doesn't work if the kernel sends a SIGBUS.
> 
> It doesn't seem a likely scenario ... but Andy is correct that
> the above ought to work.

We need to document properly what this is aiming to fix. He said
something yesterday along the lines of kthread_use_mm() hitting a SIGBUS
when a kthread "attaches" to an address space. I'm still unclear as to
how exactly that happens - there are only a handful of kthread_use_mm()
users in the tree...

> Yes. This is for kernel reading memory belongng to "current" task.

Provided "current" is really the task to which the poison page belongs.
That kthread_use_mm() thing sounded like the wrong task gets killed. But that
needs more details.

> Same in that the page gets unmapped. Different in that there
> is no SIGBUS if the kernel did the access for the user.

What is even the actual use case with sending tasks SIGBUS on poison
consumption? KVM? Others?

Are we documenting somewhere: "if your process gets a SIGBUS and this
and that, which means your page got offlined, you should do this and
that to recover"?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
