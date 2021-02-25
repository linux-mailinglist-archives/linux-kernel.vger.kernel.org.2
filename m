Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D7324B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhBYH1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:27:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232000AbhBYH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614237928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4wcRvtsO4y5OfAp6pyfE1ewYb2DKBqCK08OK1qyG89Y=;
        b=UWORBS0NNGEJe4aN9NSpCHmKn1c3+d04t7LvPOfS5Eh/pq2fpxURIc6U35f+YvmMfbPIuX
        C+M9YbBOACo4xxD6W1AjQVOemGIKnBbDepd4L+4u2mwGzTeEe8mzlojvRtLpNPSdZrMne8
        VQ0MyErpbznASjCCDvJQ9IxNreoGB04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-Y81AmIhhOfeVfOt5M0EZOQ-1; Thu, 25 Feb 2021 02:25:24 -0500
X-MC-Unique: Y81AmIhhOfeVfOt5M0EZOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A501D186DD22;
        Thu, 25 Feb 2021 07:25:21 +0000 (UTC)
Received: from localhost (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FB8510023B1;
        Thu, 25 Feb 2021 07:25:17 +0000 (UTC)
Date:   Thu, 25 Feb 2021 15:25:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>, ebiederm@xmission.com
Cc:     Chen Zhou <chenzhou10@huawei.com>, mingo@redhat.com,
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
Message-ID: <20210225072426.GH3553@MiWiFi-R3L-srv>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-2-chenzhou10@huawei.com>
 <20210224141939.GA28965@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224141939.GA28965@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/21 at 02:19pm, Catalin Marinas wrote:
> On Sat, Jan 30, 2021 at 03:10:15PM +0800, Chen Zhou wrote:
> > Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
> > alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
> > function reserve_crashkernel() also used 1M alignment. So just
> > replace hard-coded alignment 1M with macro CRASH_ALIGN.
> [...]
> > @@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
> >  	} else {
> >  		unsigned long long start;
> >  
> > -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> > +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
> >  						  crash_base + crash_size);
> >  		if (start != crash_base) {
> >  			pr_info("crashkernel reservation failed - memory is in use.\n");
> 
> There is a small functional change here for x86. Prior to this patch,
> crash_base passed by the user on the command line is allowed to be 1MB
> aligned. With this patch, such reservation will fail.
> 
> Is the current behaviour a bug in the current x86 code or it does allow
> 1MB-aligned reservations?

Hmm, you are right. Here we should keep 1MB alignment as is because
users specify the address and size, their intention should be respected.
The 1MB alignment for fixed memory region reservation was introduced in
below commit, but it doesn't tell what is Eric's request at that time, I
guess it meant respecting users' specifying.

commit 44280733e71ad15377735b42d8538c109c94d7e3
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Sun Nov 22 17:18:49 2009 -0800

    x86: Change crash kernel to reserve via reserve_early()
    
    use find_e820_area()/reserve_early() instead.
    
    -v2: address Eric's request, to restore original semantics.
         will fail, if the provided address can not be used.

