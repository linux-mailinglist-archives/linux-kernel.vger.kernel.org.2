Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA39379962
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhEJVpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhEJVpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:45:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF621C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 14:44:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620683043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpZHZILIVURBA4uZge0VeiF3/MxcG74g/FLqlaAURhc=;
        b=YxBeXXWEQgJ5X2nX0hY5xOeOa3vM2NwSDUlf24gr0P2uW0IVZj7jbroySMJALdl1aB+GgU
        yMje+laDS5hdkKtebyV2b/0n8S0slU+nvIPz+uqLHAoKHjyatn9jDj140h78nlVT/pFm7F
        OhzUi3EZ0R2nz09WVlq7/Afy0zNoQ/8WRVvBxrsHF1T58uk/a0sJK8USA4mslBDM++/0zU
        Vw7rYPQbrlux3UuQal3XHl6IyDQ0kThJRKkuACtr5g374Kq3dN8gP9hG1QwguV6ZWKev/N
        2SaLetL0SWWrxP5D580sfEQ3411R3wnrEbLHfw3jvNyx/6UFpROuIKQToaz9gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620683043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpZHZILIVURBA4uZge0VeiF3/MxcG74g/FLqlaAURhc=;
        b=3t+psbvTUJjOUoaFVqIThGokCXoG0I38L+HBKfPA1LyRnCAoIZa0bVRAsVnwK9Iqv94ZUp
        CCb1MJOFYPbOTtCA==
To:     "Saripalli\, RK" <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        bsd@redhat.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 1/1] x86/cpufeatures: Implement Predictive Store Forwarding control.
In-Reply-To: <d134cbb1-a8a5-161a-1927-2a04df6b4b4a@amd.com>
References: <20210505190923.276051-1-rsaripal@amd.com> <20210505190923.276051-2-rsaripal@amd.com> <87wnsamvaa.ffs@nanos.tec.linutronix.de> <d134cbb1-a8a5-161a-1927-2a04df6b4b4a@amd.com>
Date:   Mon, 10 May 2021 23:44:03 +0200
Message-ID: <87h7jagt7g.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10 2021 at 06:10, RK Saripalli wrote:
> On 5/7/2021 10:13 AM, Thomas Gleixner wrote:
>> What's wrong with just treating this in the same way in which we treat
>> all other speculative vulnerabilities and provide a consistent picture
>> to the user?
>> 
>> Something like the below. You get the idea.
>
> Thomas, thank you very much for the comments.
>
> I provided the links to the original patches which treat PSF similar to other
> speculative vulnerabilities.
>
> Could you review them please?. The first patch is the cover letter.
>
> https://lore.kernel.org/lkml/20210406155004.230790-1-rsaripal@amd.com/
> https://lore.kernel.org/lkml/20210406155004.230790-2-rsaripal@amd.com/
> https://lore.kernel.org/lkml/20210406155004.230790-3-rsaripal@amd.com/
> https://lore.kernel.org/lkml/20210406155004.230790-4-rsaripal@amd.com/
> https://lore.kernel.org/lkml/20210406155004.230790-5-rsaripal@amd.com/
> https://lore.kernel.org/lkml/20210406155004.230790-6-rsaripal@amd.com/

They are going into the right direction, i.e. detection and reporting.

Vs. mitigation control the question is whether we need the full
machinery of prctl/seccomp and so forth especially under the aspect that
the SSBD mitigation already covers the PSF issue.

So for the start a simple on/off might be good enough.

Kees, any opinions?

Thanks,

        tglx

