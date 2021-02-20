Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9B7320248
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 01:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhBTAkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 19:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhBTAkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 19:40:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FA8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 16:39:29 -0800 (PST)
Received: from zn.tnic (p200300ec2f04670057cd3f2d2693719b.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:6700:57cd:3f2d:2693:719b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 838821EC041D;
        Sat, 20 Feb 2021 01:39:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613781565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xCS74TGIVlHffee6XsxWByYzoIpChbExKS5f7fUQKNw=;
        b=Y9T1ivVBGwboZFV4geMWD6qIP1Xope1oMQc47rw0DrBD00QPDju1hPGobArZEA2CD9O1y/
        SbUnpHa2vgkpFni8tos9VjT38Q7dgv+zaKBGDhIHZBBCYuiwRpESv9NalJLDmWUUcIjQdw
        Xt8f77I6MIydcN3qnWREtbHImQByK/g=
Date:   Sat, 20 Feb 2021 01:39:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        pjt@google.com, mbenes@suze.cz, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210220003920.GG26778@zn.tnic>
References: <20210219204300.749932493@infradead.org>
 <20210219210535.492733466@infradead.org>
 <20210219215530.ivzzv3oavhuip6un@treble>
 <20210219220158.GD59023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219220158.GD59023@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:01:58PM +0100, Peter Zijlstra wrote:
> We could, but it so happens Joerg is also wanting negative features. 

Juergen.

> So I was thikning that perhaps we can convince Boris they're not
> really all that aweful after all :-)

Well, I'm not crazy about this, TBH - I totally agree with Josh:

"with objtool generating code, it's going to be a maze to figure out
where the generated code is coming from"

and without a real good reason to do this, what's the point? I know,
because we can. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
