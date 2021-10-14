Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CDC42DB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhJNOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:33:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40546 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhJNOdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:33:04 -0400
Received: from zn.tnic (p200300ec2f0c72008718c38cc37e4684.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:8718:c38c:c37e:4684])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 092D01EC01A8;
        Thu, 14 Oct 2021 16:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634221859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yJLOnF+PwPE6j6ArGGogfdclVh6tETtuaHOV2wZ5gtM=;
        b=C48j7rU+0LNWGA+rtvsWt6Lr1tyLBlJOtvIV96tkfdCs3Z2ndT8+JZHWUof9b5WDCSILYa
        oW/6gDMgncG0Rg6TsD49eHvaXnvCcAKjXLrjI6FRT3LCroC5fCb7tQIURpG9qyHV+P1IIy
        nddWMrwTopTFBbQApQYPNpU3TPXZy24=
Date:   Thu, 14 Oct 2021 16:31:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Matz <matz@suse.de>
Cc:     Willy Tarreau <w@1wt.eu>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Message-ID: <YWg/Jk4RX7gvkXAG@zn.tnic>
References: <YWbUbSUVLy/tx7Zu@zn.tnic>
 <20211013125142.GD5485@1wt.eu>
 <YWbZz7gHBV18QJC3@zn.tnic>
 <20211013140723.GE5485@1wt.eu>
 <YWbrR1BqI1CxneN/@zn.tnic>
 <20211013142433.GB8557@1wt.eu>
 <alpine.LSU.2.20.2110131601000.26294@wotan.suse.de>
 <20211013163023.GD8557@1wt.eu>
 <YWcOvmXkSiecGkER@zn.tnic>
 <alpine.LSU.2.20.2110141234390.3481@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.2110141234390.3481@wotan.suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 12:44:27PM +0000, Michael Matz wrote:
> Usually it's good to resolve a conflict towards what the document says, or 
> intended to say.  But glibc of course provides a huge amount of pressure 
> to resolve toward it ;-)

I call that "wagging the dog" or in this case "wagging the doc". :-P

> (laws are also changed toward practice when the latter overtakes :) )

Hohumm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
