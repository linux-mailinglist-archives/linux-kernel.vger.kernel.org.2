Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81103672FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245346AbhDUTAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:00:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239751AbhDUTAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:00:07 -0400
Received: from zn.tnic (p2e58483a.dip0.t-ipconnect.de [46.88.72.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B5B141EC01B7;
        Wed, 21 Apr 2021 20:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619031572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1o1imbBarj6dETiKm39DNAq8E4f8mKRo2g5LdAjz65c=;
        b=NlSSQs1FHjYasXdCKmBnNCKi3SmUh72P7QVZYdsFMQl/49C1jQlmpnhaV4Rnwp6TY0bdBe
        JUoL5xnxAp9Lc7nwFTQQlemIJozLTkAyf4umIZ9GDW0qPTyo08UO7WU/s0WZslAGPhIUjb
        JIWHpRRO4qUef/K1By4PJeC9++L7ZBs=
Date:   Wed, 21 Apr 2021 20:57:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Saripalli, RK" <rsaripal@amd.com>
Cc:     Bandan Das <bsd@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/4] x86/speculation: Add PSF mitigation kernel parameters
Message-ID: <20210421185725.GC22401@zn.tnic>
References: <20210421090117.22315-1-rsaripal@amd.com>
 <20210421090117.22315-5-rsaripal@amd.com>
 <4c688fc7-67df-3187-54b2-bf20e510fb39@infradead.org>
 <jpg4kfzfpzm.fsf@linux.bootlegged.copy>
 <20210421184826.GA3120@zn.tnic>
 <863ece71-463f-fc50-db13-7fd280902d6b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <863ece71-463f-fc50-db13-7fd280902d6b@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 01:55:03PM -0500, Saripalli, RK wrote:
> I separated them into separate patches because the KVM patch depends on one of the patch.
> The corresponding QEMU patch depends on another patch.
> 
> By separating them into 4 separate patches, my thinking was I could keep them logically separate.

Sure but they all go together through the same tree - why does that
matter for Qemu/KVM?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
