Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE253B1F99
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 19:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFWRhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 13:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229902AbhFWRg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 13:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624469680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=82l7b5mph8aViFGBqr97Zc7YWOX6QRR3iD1HvNwnDpc=;
        b=FU6Ke+A3RckDNMWtZ5ziAYqLVqbDVMV8NhQPeOmpGHhtXDOSLPCSXiuf7VByBjUBfDHFiM
        Ncl8OGCohrHmDDtuxQS2cTIAjZ67ri3oGLvLTbTSd0Vd5chX2Bh+tW3B8DiKev5qIVKkL1
        O+t+8LB5FBwAc4XIrJhj7WPbWdJZC5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-9bCgQpL_N7GkIrBmfyO0-w-1; Wed, 23 Jun 2021 13:34:38 -0400
X-MC-Unique: 9bCgQpL_N7GkIrBmfyO0-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82E6F19057A2;
        Wed, 23 Jun 2021 17:34:37 +0000 (UTC)
Received: from optiplex-fbsd (unknown [10.3.128.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15C5E5D6D7;
        Wed, 23 Jun 2021 17:34:35 +0000 (UTC)
Date:   Wed, 23 Jun 2021 13:34:33 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: add cond_resched() in __vunmap()
Message-ID: <YNNwqdM/U+ZErA6j@optiplex-fbsd>
References: <20210622225030.478384-1-aquini@redhat.com>
 <20210623112704.GA1911@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623112704.GA1911@pc638.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:27:04PM +0200, Uladzislau Rezki wrote:
> > On non-preemptible kernel builds the watchdog can complain
> > about soft lockups when vfree() is called against large
> > vmalloc areas:
> > 
> > [  210.851798] kvmalloc-test: vmalloc(2199023255552) succeeded
> > [  238.654842] watchdog: BUG: soft lockup - CPU#181 stuck for 26s! [rmmod:5203]
> > [  238.662716] Modules linked in: kvmalloc_test(OE-) ...
> > [  238.772671] CPU: 181 PID: 5203 Comm: rmmod Tainted: G S         OE     5.13.0-rc7+ #1
> > [  238.781413] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYXCRB1.86B.0553.D01.1809190614 09/19/2018
> > [  238.792383] RIP: 0010:free_unref_page+0x52/0x60
> > [  238.797447] Code: 48 c1 fd 06 48 89 ee e8 9c d0 ff ff 84 c0 74 19 9c 41 5c fa 48 89 ee 48 89 df e8 b9 ea ff ff 41 f7 c4 00 02 00 00 74 01 fb 5b <5d> 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 29 77
> > [  238.818406] RSP: 0018:ffffb4d87868fe98 EFLAGS: 00000206
> > [  238.824236] RAX: 0000000000000000 RBX: 000000001da0c945 RCX: ffffb4d87868fe40
> > [  238.832200] RDX: ffffd79d3beed108 RSI: ffffd7998501dc08 RDI: ffff9c6fbffd7010
> > [  238.840166] RBP: 000000000d518cbd R08: ffffd7998501dc08 R09: 0000000000000001
> > [  238.848131] R10: 0000000000000000 R11: ffffd79d3beee088 R12: 0000000000000202
> > [  238.856095] R13: ffff9e5be3eceec0 R14: 0000000000000000 R15: 0000000000000000
> > [  238.864059] FS:  00007fe082c2d740(0000) GS:ffff9f4c69b40000(0000) knlGS:0000000000000000
> > [  238.873089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  238.879503] CR2: 000055a000611128 CR3: 000000f6094f6006 CR4: 00000000007706e0
> > [  238.887467] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  238.895433] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  238.903397] PKRU: 55555554
> > [  238.906417] Call Trace:
> > [  238.909149]  __vunmap+0x17c/0x220
> > [  238.912851]  __x64_sys_delete_module+0x13a/0x250
> > [  238.918008]  ? syscall_trace_enter.isra.20+0x13c/0x1b0
> > [  238.923746]  do_syscall_64+0x39/0x80
> > [  238.927740]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > Like in other range zapping routines that iterate over
> > a large list, lets just add cond_resched() within __vunmap()'s
> > page-releasing loop in order to avoid the watchdog splats.
> > 
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > ---
> >  mm/vmalloc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index a13ac524f6ff..cd4b23d65748 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2564,6 +2564,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
> >  
> >  			BUG_ON(!page);
> >  			__free_pages(page, page_order);
> > +			cond_resched();
> >  		}
> >  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
> >  
> > -- 
> > 2.26.3
> > 
> I have a question about a test case you run to trigger such soft lockup.
> 
> Is that test_vmalloc.sh test-suite or something local? Do you use a huge
> vmalloc mappings so high-order pages are used?
>

Vlad,

It's a variant of the simple testcase presented with Kernel Bug 210023:
https://bugzilla.kernel.org/show_bug.cgi?id=210023#c7

Cheers,
-- Rafael

