Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D99A394459
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhE1Oox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbhE1Oom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:44:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24334C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:43:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e8e00d6a866fcf7197725.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8e00:d6a8:66fc:f719:7725])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B3A71EC056D;
        Fri, 28 May 2021 16:43:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622212985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=k424emnjUzEcEougI7OW6CXCCA0P74W2zWVBfp+ccSE=;
        b=FNVKhXo3AZ25ZW9GPi04yomE/czgGdAUvQKwwlSdnP62QYZKtXb4zv8pSPOfB+3lfDUngW
        xAGcV2x7GTBnSuSnyUZ6dN+UwUIG0Xy+va8hEU/7tXAwLYQmLmI9o9yO3qM22H97Od9kw5
        rXgvMIWBHpv53NkOCn0f6LVmJC2HaB8=
Date:   Fri, 28 May 2021 16:43:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        untaintableangel@hotmail.co.uk, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
Message-ID: <YLEBeJwHgnLxRtYW@zn.tnic>
References: <20210526081100.12239-1-rppt@kernel.org>
 <YK4LGUDWXJWOp7IR@zn.tnic>
 <YK53kWHb4cPeeHsd@kernel.org>
 <YK6QFLUoPZ7btQfH@zn.tnic>
 <f7525409-3987-f79d-9f52-71f6c0231491@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7525409-3987-f79d-9f52-71f6c0231491@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 07:12:51PM -0700, H. Peter Anvin wrote:
> BIOSes have been known to clobber more than 64K. They aren't supposed to
> clobber any.

Yah, the BIOSes and what they're not supposed to do. Like they even care.

> 640K is the limit because that is the address of the EGA/VGA frame
> buffer. In the words of Bill Gates "640K ought to be enough for anyone."

Right.

So thoughts on:

https://lkml.kernel.org/r/YK%2Bgv0vDfLVD7Sqp@kernel.org

?

Time to do what windoze 7 does?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
