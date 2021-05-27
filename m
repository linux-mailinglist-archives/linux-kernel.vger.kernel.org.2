Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE4392C67
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhE0LQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhE0LQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:16:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09462C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:14:43 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f02008ae29220a5f6f448.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:200:8ae2:9220:a5f6:f448])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B41031EC0372;
        Thu, 27 May 2021 13:14:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622114081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=766p7g0LU4WqD9Eftpu/3876laZiYIQ8RHQ9Vc4kL+w=;
        b=mHsbgQMkALnLqLiOf8FNT7v9Qhg0QLp2GUEmz5I8LAIJo/fFsQ2blqoT7yFlk/k8T6QHvY
        yBa4drxVVvXF5M/x5Ma/BbMPMZEyURpTjC/49bU+5eIW+xRCMicya/EK948V4lUdOANr1S
        0Ond6t6SDCzQ4Ye9nPJstR/uwUpbcUI=
Date:   Thu, 27 May 2021 13:14:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: second, sync-alloc syscall
Message-ID: <YK9/Gu2Bse0Mc0F3@zn.tnic>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-16-chang.seok.bae@intel.com>
 <CAJvTdKnrFSS0fvhNz5mb9v8epEVtphUesEUV0hhNErMBK5HNHQ@mail.gmail.com>
 <CAJvTdKmzN0VMyH8VU_fdzn2UZqmR=_aNrJW01a65BhyLm6YRPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdKmzN0VMyH8VU_fdzn2UZqmR=_aNrJW01a65BhyLm6YRPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 08:38:16PM -0400, Len Brown wrote:
> 7. In addition, a 2nd system call to request that buffers be
> pre-allocated is available. This is a per task system call. This
> synchronous allocate system call will return an error code if it
> fails, which will also likely result in program exit.

...

> Unclear if we have consensus on the need for a synchronous allocation
> system call (#7 above).  Observe that this system call does not
> improve the likelihood of failure or the timing of failure.

Just when I was thinking that the use case for this is for application
writers to run this upfront and prealloc everything and *then* start
computations. I.e., to not risk doing some work and then get killed
later on the AMX buffer alloc failure and thus lose that work.

> An #NM-based allocation and be done at exactly the same spot by
> simply touching a TMM register. The benefit of this system call is
> that it returns an error code to the caller, versus the program
> being delivered a SIGSEGV at the offending instruction pointer. Both
> will likely result in the program exiting, and at the same point in
> execution.

So if this second syscall doesn't sound really great, I'd say we stick
to the #NM-based allocation and keep this one in the bag for now and
take it out only if it turns out that it makes sense as a use case.

As tglx said: it is easy to add stuff later. It is a lot harder - even
impossible - to remove already present machinery.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
