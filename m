Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0D31F035
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhBRTn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbhBRTMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:12:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D861CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 11:11:44 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c6200329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:6200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CD8E1EC036C;
        Thu, 18 Feb 2021 20:11:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613675500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P5zcVspOeOdmLQAZeX6+Y+uadFSlhwR9QnTiiHgVz04=;
        b=jfZqLYlAaz+6KXme+J606CmRemnWucPxRI8j7Tk38WAM3PuVh60qmk5txXgXNmRHcM4Rg9
        kZS90do+YzQR0eZ4lx6Uw5JPf1vm5uQeJZbfFnY1fqY2Xgu/nZTFpSx3sVr1btrJg/CZAb
        xYH7UZ9E4ch43M2ADxtU8dz7oeNKx2U=
Date:   Thu, 18 Feb 2021 20:11:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, tony.luck@intel.com, pjt@google.com,
        linux-kernel@vger.kernel.org, r.marek@assembler.cz,
        jpoimboe@redhat.com, jikos@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [RFC PATCH] x86/retpolines: Prevent speculation after RET
Message-ID: <20210218191138.GH4214@zn.tnic>
References: <20210218165938.213678824@infradead.org>
 <20210218184639.GF4214@zn.tnic>
 <20210218190231.GA59023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218190231.GA59023@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:02:31PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 18, 2021 at 07:46:39PM +0100, Borislav Petkov wrote:
> > Both vendors speculate after a near RET in some way:
> > 
> > Intel:
> > 
> > "Unlike near indirect CALL and near indirect JMP, the processor will not
> > speculatively execute the next sequential instruction after a near RET
> > unless that instruction is also the target of a jump or is a target in a
> > branch predictor."
> 
> Right, the way I read that means it's not a problem for us here.

Look at that other thread: the instruction *after* the RET can be
speculatively executed if that instruction is the target of a jump or it
is in a branch predictor.

And yes, the text is confusing and no one from Intel has clarified
definitively yet what that text means exactly.

> Now, if AMD were to say something like: hey, that retpoline is pretty
> awesome, we ought to use that instead of an uconditional LFENCE, then
> sure, but as is, I don't think so.

AMD prefers the LFENCE instead of the ratpoline sequence.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
