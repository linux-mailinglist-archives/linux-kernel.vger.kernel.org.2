Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE739BB3B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFDO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhFDO4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:56:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA7DC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 07:54:21 -0700 (PDT)
Received: from zn.tnic (p200300ec2f138500346025dad93ce3b3.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:3460:25da:d93c:e3b3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 505051EC04A6;
        Fri,  4 Jun 2021 16:54:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622818459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=31n7UU4Z15y1OAxRM8RKNfIIbW0wtbe/JpXMxqq/xWU=;
        b=OnAwmC+Gr6fatcUvQOj9omjmVJnxckDvCSvkfmkqMnfu+7qe1oVKkS7s1PpIo3pNgHpaCy
        sLVNrpSHBHg/fmzcIc9tes10kc1aqbl18IAgvvzoekQCt9XziZaj2OE97275V0cI8k4PL3
        I1bpSCs10vv8IGDwna0dW7qXrNVLpow=
Date:   Fri, 4 Jun 2021 16:54:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>, mtk@man7.org
Cc:     Jiashuo Liang <liangjs@pku.edu.cn>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal/x86: Don't send SIGSEGV twice on SEGV_PKUERR
Message-ID: <YLo+l4KyKNPxupM2@zn.tnic>
References: <20210601085203.40214-1-liangjs@pku.edu.cn>
 <YLkhV+lSqXlcfUc5@zn.tnic>
 <87lf7qocsd.fsf@disp2133>
 <YLolc7z64h9yHNao@zn.tnic>
 <878s3plmxj.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878s3plmxj.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 09:33:12AM -0500, Eric W. Biederman wrote:
> At some point I just figured someone needs to take the time to
> understand the linux signal handling and get as many bugs out as we
> can.  It may not be flashy but it is one of those core things
> that everything is built on so we need code that works.

Oh yeah, good idea. Signals and their handling make most people cringe.

Also, selftests. I wonder if it would be a good idea to make it a
kernelnewbies project for people to do short programs, each exercising
an API from the Linux manpages.

Or maybe even get Michael (CCed) to donate some of the examples from his
book:

https://man7.org/tlpi/code/online/all_files_by_chapter.html

in this case, chapters 20-22, as selftests for the kernel. Or maybe even
all examples. :-)

Just an idea anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
