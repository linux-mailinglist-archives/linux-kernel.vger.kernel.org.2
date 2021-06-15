Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E347B3A74E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhFODUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbhFODUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623727093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qDOARxyjp3s81AcKrTJyYh6uHmxeKnBGbL+eKwM0n80=;
        b=M+615BTGRbWnSKxy1FyShuEXK0/XyFOxAtx1XYdVPWlis85K/NhNKuok66zaStI202QFIZ
        tNNC/Gig5dbX53sdLygo6ljeq5wlrZ8SQSvJCnDL8cJwiFSAmuGOmXhwrTKmUdDKTs3Vfe
        YMQSiwyAxg/XaHFHx3XFsqJD589+61g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-BqHktxwGPLGxLWUNnXHH0w-1; Mon, 14 Jun 2021 21:09:09 -0400
X-MC-Unique: BqHktxwGPLGxLWUNnXHH0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8146E800D55;
        Tue, 15 Jun 2021 01:09:03 +0000 (UTC)
Received: from localhost (ovpn-12-172.pek2.redhat.com [10.72.12.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2648A5C1A3;
        Tue, 15 Jun 2021 01:08:58 +0000 (UTC)
Date:   Tue, 15 Jun 2021 09:08:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Peter Anvin" <hpa@zytor.com>, vgoyal@redhat.com,
        x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
        dyoung@redhat.com
Subject: Re: [PATCH v3] Documentation: kdump: update kdump guide
Message-ID: <20210615010856.GA630506@MiWiFi-R3L-srv>
References: <20210609083218.GB591017@MiWiFi-R3L-srv>
 <878s3dbbuz.fsf@meer.lwn.net>
 <87sg1l9vo5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg1l9vo5.fsf@meer.lwn.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/21 at 05:44pm, Jonathan Corbet wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
> 
> > Baoquan He <bhe@redhat.com> writes:
> >
> >> Some parts of the guide are aged, hence need be updated.
> >>
> >> 1) The backup area of the 1st 640K on X86_64 has been removed
> >>    by below commits, update the description accordingly.
> >>
> >>    commit 7c321eb2b843 ("x86/kdump: Remove the backup region handling")
> >>    commit 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
> >>
> >> 2) Sort out the descripiton of "crashkernel syntax" part.
> >>
> >> 3) And some other minor cleanups.
> >>
> >> Signed-off-by: Baoquan He <bhe@redhat.com>
> >
> > Applied, thanks.
> 
> Actually, this patch added a docs build warning:
> 
>   /stuff/k/git/kernel/Documentation/admin-guide/kdump/kdump.rst:286: WARNING: Literal block ends without a blank line; unexpected unindent.
> 
> I've gone ahead and inserted the blank line to fix this.  In the future,
> please build-test your changes to make sure that you are not adding new
> warnings.

Thanks, jon. I didn't know doc change can cause build failure, so didn't
build. Will remember this.

