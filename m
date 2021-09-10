Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB954068EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhIJJPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 05:15:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42440 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231929AbhIJJPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 05:15:46 -0400
Received: from zn.tnic (p200300ec2f0f0700510d70add229dcc0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:700:510d:70ad:d229:dcc0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 48A4A1EC04E0;
        Fri, 10 Sep 2021 11:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631265270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mg2KCJRCngKdnfrJ87i+9lfhY9Ln0gC4Hcxl/MpDIXI=;
        b=iKwoDsKL98WvhBBlKSeQG25xjDzhUhTHPsxGDY6pGggCa+D7wEJx9A3UeoNW6JHHfkaYKc
        U1iDB3WqRWvcJ7mVZVS6MdVYvTYJx+kHzFsS/pks2+4xTtkAISRSkXYNPoxz3uF06jNGiw
        hwuUSTqPhc84hAJkiBRRm4lJOZmjFGY=
Date:   Fri, 10 Sep 2021 11:14:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/asm: pessimize the pre-initialization case in
 static_cpu_has()
Message-ID: <YTsh7kdH+eGHgK7U@zn.tnic>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <YTo92+0ruBlkcaDf@zn.tnic>
 <1a73e0c2-8efe-fee9-5141-f7e9a95c748d@zytor.com>
 <f59dbeee-8d2f-0964-90db-bf9c3c176763@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f59dbeee-8d2f-0964-90db-bf9c3c176763@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 03:17:14PM -0700, H. Peter Anvin wrote:
> ... into the visible part of the subject line, that was supposed to say.
> This is rather important when browsing logs, e.g. using gitk.

So you resize your gitk window. It's not like there are no other commits
with a bit longer commit titles.

The important part is that our commit messages should be readable months
and years from now - I don't have to explain this to you, of all people.

"pessimize" is not even a word:

https://www.merriam-webster.com/dictionary/pessimize:

“pessimize”

  The word you've entered isn't in the dictionary. Click on a spelling
  suggestion below or try again using the search bar above.

So while I have an idea what you mean, I'm sure that "what" can be
formulated in a better way.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
