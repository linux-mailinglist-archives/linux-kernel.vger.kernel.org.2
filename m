Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAEA460172
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 21:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356160AbhK0UbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 15:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhK0U3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 15:29:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF986C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 12:26:07 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638044765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZM5frfbRejB6abeMT8h8hAleK0UKz+gQ6g4WHVpTEI=;
        b=xQiGLhhN3tibns6w4J5X8HXNqS0pq8/hTFC3z9FJSLWzXYHPxcZFMveeAP0gxMyOOaiQ5+
        K8jZuoCPKp+E9bjFWeDm1NaMIGk5P/bEvzaqpjRXZF6SaNJqQqTckGUWzWBnivFfFDuzvS
        dmThTJJemCEQN66+WHSDRtc5O2kqNWB/uMsT4h/uvrJt12BauWVqYibesc+qj2e1qFiJ2O
        PiYJC7mRJq4/HcnoLl4pwaN/XpxRYcV+3o7Uas+PTSqhWVgmv+63FrOebtzymPDdS8IwcS
        ykbPlAVtGq/ogbbNxg1DI1Skldk7H0MKRF8y05fv3PSlm99h4t80Jy3tq1yvcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638044765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZM5frfbRejB6abeMT8h8hAleK0UKz+gQ6g4WHVpTEI=;
        b=cm+ysgDIhfNVPAQbM8Dth94tcNSYbk9aQz7DpT0xZKBezsOpVTEh5cr+QhJ7lEKe/bejL9
        Eifmu042LUKuElAQ==
To:     Alexander Potapenko <glider@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Taras Madan <tarasmadan@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Potential information leak in save_xstate_epilog()
In-Reply-To: <CAG_fn=V9T6OKPonSjsi9PmWB0hMHFC=yawozdft8i1-MSxrv=w@mail.gmail.com>
References: <CAG_fn=V9T6OKPonSjsi9PmWB0hMHFC=yawozdft8i1-MSxrv=w@mail.gmail.com>
Date:   Sat, 27 Nov 2021 21:26:04 +0100
Message-ID: <87fsrhfiqr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26 2021 at 12:06, Alexander Potapenko wrote:
> Hi Chang, Thomas, Borislav,
>
> "x86/fpu/signal: Prepare for variable sigframe length" has presumably
> introduced an information leak to the userspace.
>
> According to https://elixir.bootlin.com/linux/v5.16-rc2/source/arch/x86/kernel/fpu/signal.c#L126,
> save_sw_bytes() only initializes the first 20 bytes of sw_bytes, but
> then the whole struct is copied to the userspace.

Yes, that clearly lacks a memset(0).

Thanks,

        tglx
