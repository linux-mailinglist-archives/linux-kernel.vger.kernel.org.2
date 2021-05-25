Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DAF3907A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhEYR2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbhEYR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:28:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3403C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:27:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c1b000aca3c1b1089f8dd.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1b00:aca:3c1b:1089:f8dd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 13E171EC0249;
        Tue, 25 May 2021 19:27:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621963631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6ADo+SJAFDYoZ/cFSnzSHZKB9hTw+MZcTWevSiWUSgc=;
        b=pL8P7QCZ9HNe+NWlAqQR386tRlbmLdOcUoWgO4zbA4srQfTe8qvBUrl4yDj9kM4M5PVeVo
        2emcZ2PzH1gctKxcwZMIFMPURMzrKgJlP0t72ZXd3Orn8/xpStZBYkK/fu5s1O+/nAHDGv
        OoII/7s68zOa5YBR4CKlD7XG8za8T0k=
Date:   Tue, 25 May 2021 19:27:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 15/28] x86/arch_prctl: Create
 ARCH_GET_XSTATE/ARCH_PUT_XSTATE
Message-ID: <YK0zaVVf6bx8F/H0@zn.tnic>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-16-chang.seok.bae@intel.com>
 <CAJvTdKnrFSS0fvhNz5mb9v8epEVtphUesEUV0hhNErMBK5HNHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdKnrFSS0fvhNz5mb9v8epEVtphUesEUV0hhNErMBK5HNHQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 07:10:57PM -0400, Len Brown wrote:
> 1. CPUID has AMX
> 2. XCR0 has AMX
> 3. Linux permission has been requested and granted to this process

Actually, you want *only* 3 as 1 is a bad idea - we're in this mess
because userspace does feature detection on its own even when kernel
support is needed.

When Linux grants the permission, 1 and 2 should be implicitly given.

> The dis-advantage of on-demand is that there is no buffer release mechanism --
> the buffer lives as long as the task lives.  Though, per previous conversation,
> a future kernel could easily implement a buffer re-claim mechanism
> behind the scenes
> since the kernel is empowered to re-arm XFD for whatever reason it wants...

Why is buffer release even needed? 1) sounds like a simple and clean thing to
do.

> 2. Synchronous allocation.  Any task in the process that has AMX permission can
> make a 2nd system call to request that the kernel synchronously allocate the
> 8KB buffer for that task. *

That doesn't sound as clean. More like unneeded work on the side of
userspace programmer which she/he can save her-/himself from.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
