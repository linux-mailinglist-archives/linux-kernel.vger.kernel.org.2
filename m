Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E12A347B74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhCXPA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:00:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50450 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235911AbhCXPA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:00:26 -0400
Received: from zn.tnic (p200300ec2f0a08002d870c266ff9a9b0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:800:2d87:c26:6ff9:a9b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E792D1EC0242;
        Wed, 24 Mar 2021 16:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616598007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uhe8YqLCtLYleSlX4ajdqL397sj8jPLc14UqZ/u8OVo=;
        b=TZvkYtqs4wjx1SKxLsbHUOO9g5YCCJzzAV8/f8vQCTB6vOK5OuTueIrtRUPeihrsKfyKRt
        cL8U6XzU0XIvB13BJhGp3iN2SHL5JKOdpdAU7NvVLMLO5Jq0rU7AMSCqEmHndL0SULd+Dq
        CeBlRD25W1CcuzIRV6oLodXJLLOwblU=
Date:   Wed, 24 Mar 2021 16:00:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Message-ID: <20210324150004.GG5010@zn.tnic>
References: <20210322223710.307123-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322223710.307123-1-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:37:10PM -0700, Tony Luck wrote:
> From: Youquan Song <youquan.song@intel.com>
> 
> Skylake has a mode where the system administrator can use a BIOS setup
> option to request that the memory controller report uncorrected errors
> found by the patrol scrubber as corrected.  This results in them being
> signalled using CMCI, which is less disruptive than a machine check.
> 
> Add a quirk to detect that a "corrected" error is actually a downgraded
> uncorrected error with model specific checks for the "MSCOD" signature in
> MCi_STATUS and that the error was reported from a memory controller bank.
> 
> Adjust the severity to MCE_AO_SEVERITY so that Linux will try to take
> the affected page offline.
> 
> [Tony: Wordsmith commit comment]
> 
> Signed-off-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> Repost ... looks like this got lost somewhere.

Yeah, into

fd258dc4442c ("x86/mce: Add Skylake quirk for patrol scrub reported errors")

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
