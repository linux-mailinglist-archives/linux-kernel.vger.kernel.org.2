Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BE839BD95
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhFDQuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:50:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43686 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDQuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:50:32 -0400
Received: from zn.tnic (p200300ec2f138500ccc4f931c2b36ed4.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:ccc4:f931:c2b3:6ed4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E389C1EC0246;
        Fri,  4 Jun 2021 18:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622825325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n3blpXGcAlOsTwAsvYLiZnrHUzit9GYssdd2aU7sh3A=;
        b=AKUWsIJbln7+qAmdHWpFhPBZsix75VzabSyJh47Cd7IgiKVnqLfn3IAT7pXMRrC7kF6M2d
        eNT7NTFYM8ZZJDcmCTtCjCXe2ajWE5wGTTs9Z62s7QNq+Fhy8E1LQwd8BFEpxcYGxT9QFe
        MgLsaYQzNigKuHqMMNonWx0MkQBetO4=
Date:   Fri, 4 Jun 2021 18:48:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v2] notifier: Return non-null when callback is already
 registered
Message-ID: <YLpZY3fSYvcefzS6@zn.tnic>
References: <20210604144102.13849-1-bp@alien8.de>
 <YLpYbQnswxZUB5sW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLpYbQnswxZUB5sW@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 04:44:29PM +0000, Sean Christopherson wrote:
> The WARN is still going to make that "necessary", and the vast number of callers
> and variations that don't check the return value means that WARN isn't going
> anywhere for quite some time.  Returning an error code still makes sense, but
> the changelog is misleading in that it implies callers can blindly register
> without any repercussions.

Yeah, so tglx gave me a much better idea on IRC: make that function
__must_check and drop the WARN.

I'll play with a full allmodconfig build and see what complains and
whether I can make it into a kernelnewbies project. :)

Thanks for the review anyway, I'll use some of it in the new version.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
