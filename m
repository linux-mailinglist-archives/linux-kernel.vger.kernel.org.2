Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C425B32A288
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381562AbhCBIFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:05:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376701AbhCBHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614671282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MWmfTGoakd9LBO1VMeVkYajYIWBMlYHOLSc6eReAmE0=;
        b=MGi5gcBbHZJ53S0AN0DgtgvOUc5AtHcUe6kQQa82Nqvo5VDWNS+hWkSt4wyTyzDEHxVioG
        Gn0lCQRdlL8dKJRvKH6/+u+Ms1EjxUHc+xH1zoQejc7JgOkYVnl8FO6bmRrpXWO7ZqhsRA
        i38TERtaDFJpyxLz/CSQViMS7KL0yAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-mbBi3S46PL6RUT4PGsUrxg-1; Tue, 02 Mar 2021 02:43:45 -0500
X-MC-Unique: mbBi3S46PL6RUT4PGsUrxg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E91BE1005501;
        Tue,  2 Mar 2021 07:43:41 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C36E710013DB;
        Tue,  2 Mar 2021 07:43:30 +0000 (UTC)
Date:   Tue, 2 Mar 2021 15:43:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        chenzhou <chenzhou10@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, mingo@redhat.com,
        tglx@linutronix.de, rppt@kernel.org, dyoung@redhat.com,
        will@kernel.org, nsaenzjulienne@suse.de, corbet@lwn.net,
        John.P.donnelly@oracle.com, prabhakar.pkin@gmail.com,
        horms@verge.net.au, robh+dt@kernel.org, arnd@arndb.de,
        james.morse@arm.com, xiexiuqi@huawei.com, guohanjun@huawei.com,
        huawei.libin@huawei.com, wangkefeng.wang@huawei.com,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v14 01/11] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
Message-ID: <20210302074327.GC13714@MiWiFi-R3L-srv>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-2-chenzhou10@huawei.com>
 <20210224141939.GA28965@arm.com>
 <20210225072426.GH3553@MiWiFi-R3L-srv>
 <121fa1e6-f1a3-d47f-bb1d-baaacf96fddc@huawei.com>
 <m14khykfeq.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14khykfeq.fsf@fess.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/21 at 09:38am, Eric W. Biederman wrote:
> chenzhou <chenzhou10@huawei.com> writes:
> 
> > On 2021/2/25 15:25, Baoquan He wrote:
> >> On 02/24/21 at 02:19pm, Catalin Marinas wrote:
> >>> On Sat, Jan 30, 2021 at 03:10:15PM +0800, Chen Zhou wrote:
> >>>> Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
> >>>> alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
> >>>> function reserve_crashkernel() also used 1M alignment. So just
> >>>> replace hard-coded alignment 1M with macro CRASH_ALIGN.
> >>> [...]
> >>>> @@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
> >>>>  	} else {
> >>>>  		unsigned long long start;
> >>>>  
> >>>> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> >>>> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
> >>>>  						  crash_base + crash_size);
> >>>>  		if (start != crash_base) {
> >>>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
> >>> There is a small functional change here for x86. Prior to this patch,
> >>> crash_base passed by the user on the command line is allowed to be 1MB
> >>> aligned. With this patch, such reservation will fail.
> >>>
> >>> Is the current behaviour a bug in the current x86 code or it does allow
> >>> 1MB-aligned reservations?
> >> Hmm, you are right. Here we should keep 1MB alignment as is because
> >> users specify the address and size, their intention should be respected.
> >> The 1MB alignment for fixed memory region reservation was introduced in
> >> below commit, but it doesn't tell what is Eric's request at that time, I
> >> guess it meant respecting users' specifying.
> 
> 
> > I think we could make the alignment unified. Why is the alignment system reserved and
> > user specified different? Besides, there is no document about the 1MB alignment.
> > How about adding the alignment size(16MB) in doc  if user specified
> > start address as arm64 does.
> 
> Looking at what the code is doing.  Attempting to reserve a crash region
> at the location the user specified.  Adding unnecessary alignment
> constraints is totally broken. 
> 
> I am not even certain enforcing a 1MB alignment makes sense.  I suspect
> it was added so that we don't accidentally reserve low memory on x86.
> Frankly I am not even certain that makes sense.
> 
> Now in practice there might be an argument for 2MB alignment that goes
> with huge page sizes on x86.  But until someone finds that there are
> actual problems with 1MB alignment I would not touch it.
> 
> The proper response to something that isn't documented and confusing is
> not to arbitrarily change it and risk breaking users.  Especially in
> this case where it is clear that adding additional alignment is total
> nonsense.  The proper response to something that isn't clear and
> documented is to dig in and document it, or to leave it alone and let it

Sounds reasonable. Then adding document or code comment around looks
like a good way to go further so that people can easily get why its
alignment is different than other reservation.

> be the next persons problem.
> 
> In this case there is no reason for changing this bit of code.
> All CRASH_ALIGN is about is a default alignment when none is specified.
> It is not a functional requirement but just something so that things
> come out nicely.
> 
> 
> Eric
> 

