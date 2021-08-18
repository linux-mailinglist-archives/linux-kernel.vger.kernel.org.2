Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82FD3F0ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhHRSKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhHRSKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:10:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDD3C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:09:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cc30025743e574fa309df.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:2574:3e57:4fa3:9df])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00FE41EC0541;
        Wed, 18 Aug 2021 20:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629310171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K4GK/gSkcU3s6BhJqhvsXq6XiGfFkNPqxOUSWUeTU+Y=;
        b=HHeO2hei73zSSUU3tUUG07OOciBKumbQebHZn1QZREG4FbOoPa6VPDbTNR6TsA6vvrhFsn
        UkI6P4q2BT6QtTnEpf4ZJrpSaE5/20S+7LM3u4a1BryvF8HizMtzVYGsEqr5o8TdaU9xa0
        fb4lgFRg6TEuzDEzzTkEGQXZAUb1tfE=
Date:   Wed, 18 Aug 2021 20:10:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, x86@kernel.org,
        len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Message-ID: <YR1NAvJW4w8bhEEu@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5>
 <YR1HYRRN0HMTxXrw@zn.tnic>
 <4493449.UzBjrsCbmA@tjmaciei-mobl5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4493449.UzBjrsCbmA@tjmaciei-mobl5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:58:42AM -0700, Thiago Macieira wrote:
> That tells me what the CPU supports, not what the kernel does. By
> omitting the "xfd" entry in /proc/cpuinfo, we are assuming that all
> kernels with "amxtile" also implicitly support xfd. That is a valid
> assumption.

What relevance does the fact have for userspace whether the kernel
supports XFD or not?

IOW, userspace cares about AMX and the other features which are supposed
to use XFD - not how those features are implemented: whether with
faulting or with pre-allocation or whatever.

> Many applications need to determine which plugins and code paths to
> enable before getting the data that will tell them what to do. It's
> entirely possible for them to never need to run the AMX instructions,
> so they may wish to defer the request to allocate the XSAVE state
> until they have read their input data.
>
> It's indeed possible that the allocation then fails and the
> application be unable to continue. But OOM conditions are unlikely, so
> it may be an acceptable price to pay. In fact, by *not* allocating the
> extra state for every thread in the current process, it may avoid the
> OOM.

And?

That doesn't conflict with my suggestion. It goes and asks the kernel
what it supports and then requests the buffers.

> Sorry, that's not what I meant. I was going to request an extra API, a third 
> call. We'd have:
>  - get current state
>  - set new state
>  - get available bits to set

Yes, this should have been the API from the very beginning. Of course
you need to be able to query what bits can be set at all.

> ...
> Now, if we are going to have this API any way, it might be a good
> idea to combine the two getters in one by adding a second pointer
> parameter.

Yeah, I'll get to that patch in the coming days and have a look. So far,
it only makes sense to have a querying API too so that we can provide
support for more "fat" features.

Unless Intel folks decide to stop using XSAVE for that - it was a bad
idea in the first place anyway, TBH - but it's not like hw people listen
to sw folk so...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
