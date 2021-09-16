Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60B40D766
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhIPKbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbhIPKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:31:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2851CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:29:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f11c600b77f9e345fbfb487.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:c600:b77f:9e34:5fbf:b487])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E3DB1EC01DF;
        Thu, 16 Sep 2021 12:29:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631788188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EXpt8wshiO7ImZN+Zx5zekJn4i6gD7QW4fNVEzzyMB0=;
        b=jdKCZeacNO/kKHUWytZdn5Fjo98CAZEQp+DgI7I37Kq2atS39x82DLxp+PzrfJ6w/OMpOx
        2kRvyfMEU9NGc0BdDMyQFTyKr41mebgtFFj1rEwSkta4odAJx3N6y0DSrQaVrO5hfk6wCD
        w9bRZIOCbxUdY5+wJ29B3EVPzm2K9/U=
Date:   Thu, 16 Sep 2021 12:29:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/setup: call early_reserve_memory() earlier
Message-ID: <YUMclVZ5uxKV/bRZ@zn.tnic>
References: <20210914094108.22482-1-jgross@suse.com>
 <b15fa98e-f9a8-abac-2d16-83c29dafc517@suse.com>
 <6cdc71dc-c26d-5c59-b7dd-0eb47ab9c861@suse.com>
 <YUHSRKubsGT2Jvur@zn.tnic>
 <YUMJx2ckLlWKi3VF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUMJx2ckLlWKi3VF@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 12:09:27PM +0300, Mike Rapoport wrote:
> I think the first sentence about reserving memory before memblock
> allocations are possible is important and I think we should keep it.

I expanded that comment this way:

        /*
         * Do some memory reservations *before* memory is added to memblock, so
         * memblock allocations won't overwrite it.
         *
         * After this point, everything still needed from the boot loader or
         * firmware or kernel text should be early reserved or marked not RAM in
         * e820. All other memory is free game.
         *
         * This call needs to happen before e820__memory_setup() which calls the
         * xen_memory_setup() on Xen dom0 which relies on the fact that those
         * early reservations have happened already.
         */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
