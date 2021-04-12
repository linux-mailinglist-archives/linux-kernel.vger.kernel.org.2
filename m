Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8335C8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbhDLOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237558AbhDLOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618238294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPyzOJSADw1ugiLVGR/0etGoaBvM2CULjUgMo7FWp2A=;
        b=AaMK0Rctb67BgNJrcRQHT8rbVNSEXb6MoVnQztkgRC3xO/AGNL38bsU0CB7cyc/u9UntoU
        eeXbKk7bq+tT1VScnnJqs5MsYkpFcxIXTZPITR9LibtgJ5FxDCbLUSi1mPwa4vUgMApKGH
        8gGsFAPmCCOtnH8qPP5qL1QGGJRmrJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-k7kdLMMmMvesWyhYmho-bA-1; Mon, 12 Apr 2021 10:38:09 -0400
X-MC-Unique: k7kdLMMmMvesWyhYmho-bA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C7CB189C44E;
        Mon, 12 Apr 2021 14:38:08 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-148.ams2.redhat.com [10.36.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF6D75D6B1;
        Mon, 12 Apr 2021 14:38:05 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
        <87lf9nk2ku.fsf@oldenburg.str.redhat.com>
        <20210412143139.GE24283@zn.tnic>
Date:   Mon, 12 Apr 2021 16:38:15 +0200
In-Reply-To: <20210412143139.GE24283@zn.tnic> (Borislav Petkov's message of
        "Mon, 12 Apr 2021 16:31:39 +0200")
Message-ID: <878s5nk1pk.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Borislav Petkov:

> On Mon, Apr 12, 2021 at 04:19:29PM +0200, Florian Weimer wrote:
>> Maybe we could have done this in 2016 when I reported this for the first
>> time.  Now it is too late, as more and more software is using
>> CPUID-based detection for AVX-512.
>
> So as I said on another mail today, I don't think a library should rely
> solely on CPUID-based detection of features especially if those features
> need kernel support too. IOW, it should ask whether the kernel can
> handle those too, first.

Yes, that's why we have the XGETBV handshake.  I was imprecise.  It's
CPUID + XGETBV of course.  Or even AT_HWCAP2 (for FSGSBASE).

> And the CPUID-faulting thing would solve stuff like that because then
> the kernel can *actually* get involved into answering something where it
> has a say in, too.

But why wouldn't we use a syscall or an entry in the auxiliary vector
for that?  Why fault a potentially performance-critical instruction?

Thanks,
Florian

