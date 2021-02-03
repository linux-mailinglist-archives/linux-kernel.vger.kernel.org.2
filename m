Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AFE30D8A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhBCL13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:27:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:36868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234200AbhBCLYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:24:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11D50AD26;
        Wed,  3 Feb 2021 11:24:01 +0000 (UTC)
Date:   Wed, 3 Feb 2021 12:23:40 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, len.brown@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: Use consistent test for X86_FEATURE_XSAVES
Message-ID: <20210203112340.GA11823@zn.tnic>
References: <20210203024052.15789-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210203024052.15789-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 06:40:52PM -0800, Chang S. Bae wrote:
> When XSAVES is present, the kernel always takes advantage of it, and XSAVES
> always uses compacted format.
> 
> The macro using_compacted_format() implies that using compacted format may

Not a macro.

> be possible without XSAVES (say by using XSAVEC), but that is not possible
> here, so delete that confusing macro and simply test for what we want to
> know in the first place -- if we have XSAVES or not.

Who's "we"?

> @@ -500,20 +500,6 @@ int xfeature_size(int xfeature_nr)
>  	return eax;
>  }
>  
> -/*
> - * 'XSAVES' implies two different things:
> - * 1. saving of supervisor/system state
> - * 2. using the compacted format
> - *
> - * Use this function when dealing with the compacted format so
> - * that it is obvious which aspect of 'XSAVES' is being handled
> - * by the calling code.

@dhansen, are you still hung up on that "obvious aspect" or can we kill
this?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
