Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FE530DEA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhBCPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhBCPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:49:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34245C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:49:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c8400c151208e8a6ffcb8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:c151:208e:8a6f:fcb8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95BBB1EC04DE;
        Wed,  3 Feb 2021 16:48:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612367338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VEZiAMaFdrz5pKUlgJAs/gGSWii85hA0CrJGItwBOd0=;
        b=lxKFEdJmL0043/zdn5vGmv4gWnqwr+1Yd1rGgielws4ABRjiUGCtcX/7MtTXa62YTvGeBd
        T5aeNaeD/j9gQWKTvyaNRqP+XBurjUyte+0HRk44kR6aMSLR4k0HyhIxCnT2ES3jUaXM5W
        X1COI/jgeE9G8/tnsi7i13KSrxO6TQ4=
Date:   Wed, 3 Feb 2021 16:48:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/11] x86/fault: Correct a few user vs kernel checks wrt
 WRUSS
Message-ID: <20210203154855.GE13819@zn.tnic>
References: <cover.1612113550.git.luto@kernel.org>
 <d5a32187f77197c8adddf9008c085c50d548bae2.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5a32187f77197c8adddf9008c085c50d548bae2.1612113550.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:24:36AM -0800, Andy Lutomirski wrote:
> In general, page fault errors for WRUSS should be just like get_user(),
> etc.  Fix three bugs in this area:
> 
> We have a comment that says that, if we can't handle a page fault on a user
> address due to OOM, we will skip the OOM-kill-and-retry logic.  The code
> checked kernel *privilege*, not kernel mode, so it missed WRUSS.  This
> means that we would malfunction if we got OOM on a WRUSS fault -- this
> would be a kernel-mode, user-privilege fault, and we would invoke the OOM
> killer and retry.

Please convert all those commit messages to passive voice - the "we" is
ambiguous.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
