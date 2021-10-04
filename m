Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAB2420DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhJDNUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbhJDNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:17:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535A8C09425B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 05:57:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633352260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ci4ldOVRBoNvDyQzdBZauCNnQ8/uDxK8+Q/HRGqix+8=;
        b=CRqm6Jl4XTKFq0opKtfU9nyjQhp+zTuBGgj2n4Mxzy3y8JiRgQ8pkz/GweiIEcwD/tL192
        h5w1doYtjySsAjBLqAZcCKS5/jVmc4k3JvUt08TDOixFaSjNxvieU9r+cMLC4UG1Kk0nfq
        u71T9tbpoPRT5SIp7yJHBmE8t5axlbLTvVtA8mQKEqJOQoLNhsDz1jEJxAc2joEcpMDa+G
        +QcDQamTIKb6wIPcMKm7/Sz3EtBb/GkNggTdiPuiLS5I5FERNRPixTU+nD29ZeBIA0purX
        vYcF+GtLkWUauDX8horWzG8goOn0v7URNiYnPk+tMsr8TNbZJrwmyE3bmkDqvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633352260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ci4ldOVRBoNvDyQzdBZauCNnQ8/uDxK8+Q/HRGqix+8=;
        b=CdAGMJLK8rQJmdKYVTeI+It/ko3hAYf8gfCeC62EcxO/WSV0BRpx/xhlGNvLDHParLr9Qw
        nlRXMn1uwns98tBg==
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 05/28] x86/fpu/xstate: Add a new variable to
 indicate dynamic user states
In-Reply-To: <DC2E88A6-4CE8-4F10-B527-081EE147927A@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-6-chang.seok.bae@intel.com> <87bl486g1y.ffs@tglx>
 <DC2E88A6-4CE8-4F10-B527-081EE147927A@intel.com>
Date:   Mon, 04 Oct 2021 14:57:39 +0200
Message-ID: <875yudgd6k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03 2021 at 22:35, Chang Seok Bae wrote:
> On Oct 1, 2021, at 06:16, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Wed, Aug 25 2021 at 08:53, Chang S. Bae wrote:
>>> +/*
>>> + * This represents user xstates, a subset of xfeatures_mask_all, saved in a
>>> + * dynamic kernel XSAVE buffer.
>>> + */
>>> +u64 xfeatures_mask_user_dynamic __ro_after_init;
>>> +
>>> static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
>>> 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
>>> static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
>>> @@ -709,6 +715,7 @@ static int __init init_xstate_size(void)
>>> static void fpu__init_disable_system_xstate(void)
>>> {
>>> 	xfeatures_mask_all = 0;
>>> +	xfeatures_mask_user_dynamic = 0;
>> 
>> It's zero at boot already, isn't it?
>
> I thought of this as a safety net here when it was introduced.

A safety net for what? The compiler initializing the variable to 4711?
