Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD0361F16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbhDPLrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240164AbhDPLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618573637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KF/dzNzZan6fUVFJHuSnh1NdDQwGWSz1Twu2a0uJ5s=;
        b=AUpU6UU7uy7Q4wdLa6KoNJbALfsn6C8sNkfTwkGvQCuT1tVVpJyAbchf/752GRFvF7uLRl
        z/eSSanjqdCL5t5EqrGYDjGNMsndI6bJ86OJb8wbZQlpnRdXs+VlxZzUiA211FIQVYKg/V
        4fLtvIy4oGL4IwdqiI33Lb25mKAyYQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-6wZK_FotPSSrRDnITcAqmQ-1; Fri, 16 Apr 2021 07:47:16 -0400
X-MC-Unique: 6wZK_FotPSSrRDnITcAqmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE1580A19E;
        Fri, 16 Apr 2021 11:47:14 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32B455D9C0;
        Fri, 16 Apr 2021 11:47:11 +0000 (UTC)
Date:   Fri, 16 Apr 2021 19:47:08 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: x86/crash: fix crash_setup_memmap_entries() out-of-bounds access
Message-ID: <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
 <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
 <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/21 at 01:28pm, Mike Galbraith wrote:
> On Fri, 2021-04-16 at 19:07 +0800, Dave Young wrote:
> >
> > > We're excluding two ranges, allocate the scratch space we need to do that.
> >
> > I think 1 range should be fine, have you tested 1?
> 
> Have now, and vzalloc(struct_size(cmem, ranges, 1)) worked just fine.

Ok, thanks for your quick response.  Care to resend and cc x86 list and
Andrew?

Andrew usually takes core kexec/kdump fixes, x86 usually go through x86
maintainer.

Thanks
Dave

