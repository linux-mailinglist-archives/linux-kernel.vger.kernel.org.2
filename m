Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB3438C08
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhJXVT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:19:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41424 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhJXVT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:19:56 -0400
Received: from zn.tnic (p200300ec2f392000e24953d98d2057ed.dip0.t-ipconnect.de [IPv6:2003:ec:2f39:2000:e249:53d9:8d20:57ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CCCD1EC01CE;
        Sun, 24 Oct 2021 23:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635110254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CL2pDRN+bKHOGb1vkbQZJLxys8I21P9t5oQbl1qDthY=;
        b=nYvNBIs66o9R3Tpc01vo8QUgdw/AUS7aOu6lYaPfFb6Oy8L994TfkJWyhFwJmECplz1VWG
        KGyhAuGtU/ldy9QyYSeV/1NpztUppGxmzgnFLQQFnFAhwr3d4xKPwZOj2WIRB1DU+tzFVt
        W07NgGs6wIGdxABdOxaHZzW6+rzu0zs=
Date:   Sun, 24 Oct 2021 23:17:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, arjan@linux.intel.com,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH 06/23] x86/arch_prctl: Add controls for dynamic XSTATE
 components
Message-ID: <YXXNa4FcvbGfCrxr@zn.tnic>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
 <20211021225527.10184-7-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211021225527.10184-7-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 03:55:10PM -0700, Chang S. Bae wrote:
> +/**
> + * fpu_xstate_prctl - xstate permission operations
> + * @tsk:	Redundant pointer to current
> + * @option:	A subfunction of arch_prctl()
> + * @arg2:	option argument
> + * Return:	0 if successful; otherwise, an error code
> + *
> + * Option arguments:
> + *
> + * ARCH_GET_XCOMP_SUPP: Pointer to user space u64 to store the info
> + * ARCH_GET_XCOMP_PERM: Pointer to user space u64 to store the info
> + * ARCH_REQ_XCOMP_PERM: Facility number requested
> + *
> + * For facilities which require more than one XSTATE component, the request
> + * must be the highest state component number related to that facility,
> + * e.g. for AMX which requires XFEATURE_XTILE_CFG(17) and
> + * XFEATURE_XTILE_DATA(18) this would be XFEATURE_XTILE_DATA(18).
> + */

Can I pls get this new set of prctl()s documented properly ontop of this
patchset?

I guess Documentation/x86/xstate.rst or so.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
