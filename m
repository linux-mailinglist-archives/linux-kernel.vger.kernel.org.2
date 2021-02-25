Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0CC3252AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 16:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhBYPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 10:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233159AbhBYPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 10:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614267902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6q+Q5NQOXbRifBC8SSR9ugXbvqn66/46WmsQY9vYlk=;
        b=JEA+IFz8Nlu/+uCL5bFNCEhXiBB5xYbAV3MkKWd/MlZ4oODqoV3fBftB0N9guzPrwVLGUP
        gIfiaVdZKsHYCkhvFXMolVbt8NFqIiH52YVO/1l2v0t3xu7TDe9rCnODZRYp2JyJLP4GUK
        8x+gSDJR1nQo+MQM9xT5TSVDIzmszm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-1nkb0a5vOVKmgZhXqpt6CA-1; Thu, 25 Feb 2021 10:44:56 -0500
X-MC-Unique: 1nkb0a5vOVKmgZhXqpt6CA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E857C19611A8;
        Thu, 25 Feb 2021 15:44:53 +0000 (UTC)
Received: from localhost (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 547E45D767;
        Thu, 25 Feb 2021 15:44:49 +0000 (UTC)
Date:   Thu, 25 Feb 2021 23:44:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Chen Zhou <chenzhou10@huawei.com>, mingo@redhat.com,
        tglx@linutronix.de, rppt@kernel.org, dyoung@redhat.com,
        will@kernel.org, nsaenzjulienne@suse.de, corbet@lwn.net,
        John.P.donnelly@oracle.com, prabhakar.pkin@gmail.com,
        horms@verge.net.au, robh+dt@kernel.org, arnd@arndb.de,
        james.morse@arm.com, xiexiuqi@huawei.com, guohanjun@huawei.com,
        huawei.libin@huawei.com, wangkefeng.wang@huawei.com,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v14 02/11] x86: kdump: make the lower bound of crash
 kernel reservation consistent
Message-ID: <20210225154446.GI3553@MiWiFi-R3L-srv>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-3-chenzhou10@huawei.com>
 <20210224143547.GB28965@arm.com>
 <20210225070717.GG3553@MiWiFi-R3L-srv>
 <20210225144237.GA23418@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225144237.GA23418@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/21 at 02:42pm, Catalin Marinas wrote:
> On Thu, Feb 25, 2021 at 03:08:46PM +0800, Baoquan He wrote:
> > On 02/24/21 at 02:35pm, Catalin Marinas wrote:
> > > On Sat, Jan 30, 2021 at 03:10:16PM +0800, Chen Zhou wrote:
> > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > index da769845597d..27470479e4a3 100644
> > > > --- a/arch/x86/kernel/setup.c
> > > > +++ b/arch/x86/kernel/setup.c
> > > > @@ -439,7 +439,8 @@ static int __init reserve_crashkernel_low(void)
> > > >  			return 0;
> > > >  	}
> > > >  
> > > > -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> > > > +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
> > > > +			CRASH_ADDR_LOW_MAX);
> > > >  	if (!low_base) {
> > > >  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> > > >  		       (unsigned long)(low_size >> 20));
> > > 
> > > Is there any reason why the lower bound can't be 0 in all low cases
> > > here? (Sorry if it's been already discussed, I lost track)
> > 
> > Seems like a good question.
> > 
> > This reserve_crashkernel_low(), paired with reserve_crashkernel_high(), is
> > used to reserve memory under 4G so that kdump kernel owns memory for dma
> > buffer allocation. In that case, kernel usually is loaded in high
> > memory. In x86_64, kernel loading need be aligned to 16M because of
> > CONFIG_PHYSICAL_START, please see commit 32105f7fd8faa7b ("x86: find
> > offset for crashkernel reservation automatically"). But for crashkernel
> > low memory, there seems to be no reason to ask for 16M alignment, if
> > it's taken as dma buffer memory.
> > 
> > So we can make a different alignment for low memory only, e.g 2M. But
> > 16M alignment consistent with crashkernel,high is also fine to me. The
> > only affect is smaller alignment can increase the possibility of
> > crashkernel low reservation.
> 
> I don't mind the 16M alignment in both low and high base. But is there
> any reason that the lower bound (third argument) cannot be 0 in both
> reserve_crashkernel() (the low attempt) and reserve_crashkernel_low()
> cases? The comment in reserve_crashkernel() only talks about the 4G
> upper bound but not why we need a 16M lower bound.

Ah, sorry, I must have mixed this one with the alignment of fixed
memory region reservation in patch 1 when considering comments.

Hmm, in x86 we always have memory reserved in low 1M, lower bound
being 0 or 16M (kernel alignment) doesn't make difference on crashkernel
low reservation. But for crashkernel reservation, the reason should be
kernel loading alignment being 16M, please see commit 32105f7fd8faa7b
("x86: find offset for crashkernel reservation automatically").

So, for crashkernel low, keeping lower bound as 0 looks good to me, the
only reason is just as patch log tells. And it can skip the unnecessary
memblock searching under 16M since it will always fail, even though it
won't matter much. Or changing it to CRASH_ALIGN as this patch is doing,
and adding code comment, is also fine to me.

Thanks
Baoquan

