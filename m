Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC142F5BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhJOOmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbhJOOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:42:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69738C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:40:39 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cfb008d2f1a8e7c2e2a2a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:fb00:8d2f:1a8e:7c2e:2a2a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8481F1EC04CB;
        Fri, 15 Oct 2021 16:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634308837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GubYf2mcqcx4jKRvoVoqfVF22A6GHWoTIn0b4DKRCoA=;
        b=RfBilr+jwe7Zg+ufgGxd5MbQ2AUmE4nWuH2oJPhml7aEdnmXGh0ue4EMCDFIoNOG5GZZp+
        6LKrDviKLspHK06GqCvfarA7yMhRpcRkVaE6tMY/vmFQv+88hrtDpOWC4VS8+YsMJZ/Xlv
        wj5zsuv9Sxf1jaB9/DBIjfjcvY6XJwA=
Date:   Fri, 15 Oct 2021 16:40:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] x86/fpu: Remove opmask state from avx512_timestamp
 check
Message-ID: <YWmS5JNqxuJkSNY/@zn.tnic>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <CAFUsyfJWXJEc1879uX_YOJg7cvie0gitv+bu83DiUXiE74uQww@mail.gmail.com>
 <CAFUsyfJQ8_=QnZjZ2zS45wwB6AaRgL4JO8_sT1a_rXUsfh_1WQ@mail.gmail.com>
 <YWfqEIaCKOwSWGHF@zn.tnic>
 <CAFUsyfLf5a6-L7f2AjLx3j8+qbG7EU9iLPJCTA0+UoOUg3C61A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFUsyfLf5a6-L7f2AjLx3j8+qbG7EU9iLPJCTA0+UoOUg3C61A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 10:49:25AM -0500, Noah Goldstein wrote:
> Is there a cost to the change I am not seeing?

The cost is having yet another macro in our crazy FPU code because
apparently everything but the kitchen sink is being put into xstates.

So I'd suggest you carve out that timestamp update into a separate
function, i.e., something like fpu_update_avx_timestamp() or so - and
add the macro in it along with the comment explaining what and why
is being tracked.

So that that functionality is separated out of the main flow,
save_fpregs_to_fpstate() simply calls it and it doesn't get in the way
of the next rewrite of the FPU code to accomodate new crap^W features.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
