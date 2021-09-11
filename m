Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC54075BE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhIKJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhIKJWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 05:22:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD1BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 02:21:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1e14001f3479bbc118498e.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:1400:1f34:79bb:c118:498e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E19A1EC0136;
        Sat, 11 Sep 2021 11:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631352070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1K8w5ltTbwNutI84VGh773NSo6ZyE/kRaKIysbMSfIQ=;
        b=chCmliHB697mDjctTtfrhn1DsCwcNLRhXARWyok4xrw/tYGsjx1CKcw4wRIMBuu9tOjnp8
        idqDuB91ORvLVUKihryiOnMIQ0iZJ3sEO1n1ARKStz4tIKFhFdgv7L51F1HjJ1G9q279xK
        z9ifrBdiX/vGWWfErOC/ZxbHjFppeo8=
Date:   Sat, 11 Sep 2021 11:20:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Marcus =?utf-8?Q?R=C3=BCckert?= <mrueckert@suse.com>
Subject: Re: [PATCH] x86/umip: Add a umip= cmdline switch
Message-ID: <YTx0+0pfyzHuX80L@zn.tnic>
References: <20210907200454.30458-1-bp@alien8.de>
 <20210911011459.GA11980@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210911011459.GA11980@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 06:14:59PM -0700, Ricardo Neri wrote:
> If it is printing the same information again and again, wouldn't it be
> simpler to have a umip_pr_warn_once()?

If you do a once thing, you're blocking any other programs from warning,
output you probably wanna see.

With the command line switch you do the same but you're at least pushing
the user to become active and do it first. I.e., with enabling that
option, the user basically says that she/he is not interested in any of
that output and that is ok.

The optimal thing would be to ratelimit it per process but that would be
an overkill and not really needed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
