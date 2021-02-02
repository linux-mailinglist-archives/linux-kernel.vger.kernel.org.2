Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2970C30C441
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhBBPph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:45:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60718 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235403AbhBBPo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:44:28 -0500
Received: from zn.tnic (p200300ec2f0e1f00d5f9b577de02d878.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:1f00:d5f9:b577:de02:d878])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA3431EC051E;
        Tue,  2 Feb 2021 16:43:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612280622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dUZnglEtEStsBqDf7rEFf/OitrOe7r+ty4Ma0CKAJgA=;
        b=ctW8Nk1p0+P459QZQgKExcGpUmthMapXSIdrXr7Go5bhV3ia4PYzfNCcC2SlCMpULpxm2h
        jVlEVA/astF/kP3I4ynDAXTwxbMKCtgH3yAvc4HRKXIYATF9r/7wOu3ewyrvsJ3lqPsCCK
        vh8m1IufHEu0KWDiG++kn74eiQzf1TA=
Date:   Tue, 2 Feb 2021 16:43:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Add blurb about
 backtraces in commit messages
Message-ID: <20210202154339.GE18075@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
 <20201221095425.6da68163@lwn.net>
 <20201222130555.GA13463@zn.tnic>
 <20210104161911.38eb3e1e@lwn.net>
 <20210105104805.GC28649@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210105104805.GC28649@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 11:48:05AM +0100, Borislav Petkov wrote:
> On Mon, Jan 04, 2021 at 04:19:11PM -0700, Jonathan Corbet wrote:
> > So I have some questions, I guess...  How often is a backtrace *in a commit
> > message* really helpful at all?  The value in problem reports is clear, but
> > I'm not sure how often having a backtrace in a commit message will really
> > help the reader understand why the patch was written.  But perhaps I'm
> > wrong?
> 
> Does the subthread here with Sean shed some light on the matter or... ?
> 
> > If we do want this advice in our already-too-long submitting-patches
> > document,
> 
> Thought the same thing when looking at that doc - it is a *lot* and I
> guess we should put only very globally relevant info in there...
> 
> > we should perhaps give some advice as to what is "relevant
> > information" and what is not?
> 
> Right, in that subthread, the gist of what we wanna say is to almost
> always put the splat in the commit message - except for the example I
> gave there and other early boot cases - but leave it to the committer to
> do the final decision whether to keep or ditch the splat.
> 
> Something like that. Yah, I know, it is fuzzy :-\

Lemme ping here quick - my TODO list still has it. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
