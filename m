Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24CD40C606
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhIONQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhIONQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:16:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 06:14:45 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d0700798b413daeaceac5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:700:798b:413d:aeac:eac5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9DA281EC01A9;
        Wed, 15 Sep 2021 15:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631711679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UyjjuZ3RxaOPyQN/JJz9euCWQRnVG443Q1medYZK240=;
        b=dD3M0ZT9E/1a3WTquuWmZJAzFHEJzHKc1RyFvx4v8Z3EV8HvdL4Yziq81Quja1wIk9f8Tm
        U/x4I3hx8izAtSuoRG5MSpNeWSFOKjxRGvgB9I6LHVRerst/cjIhQxZt3E+1jsF+axDVMQ
        SaKdfiE2t5ZhenoPcPNncM4yp5uebiY=
Date:   Wed, 15 Sep 2021 15:14:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Marcus =?utf-8?Q?R=C3=BCckert?= <mrueckert@suse.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/umip: Add a umip= cmdline switch
Message-ID: <YUHxuLB1sKPb9RtY@zn.tnic>
References: <20210907200454.30458-1-bp@alien8.de>
 <20210911011459.GA11980@ranerica-svr.sc.intel.com>
 <YTx0+0pfyzHuX80L@zn.tnic>
 <20210913213836.GA10627@ranerica-svr.sc.intel.com>
 <YUDTCgEOZ3JOMSl7@zn.tnic>
 <20210915113410.GA7130@ranerica-svr.sc.intel.com>
 <20210915142123.49f8137b@fortress.home.nordisch.org>
 <20210915130007.GA7946@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210915130007.GA7946@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 06:00:07AM -0700, Ricardo Neri wrote:
> Ah! 5 years old does not seem too old to me. Then it is not only old
> applications. Then the warning did catch an app that could in theory be
> fixed (if Overwatch is still maintained).

I wouldn't hold my breath though.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
