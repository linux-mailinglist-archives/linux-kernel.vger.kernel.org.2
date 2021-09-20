Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BC441110E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhITIgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:36:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49898 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235968AbhITIgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:36:13 -0400
Received: from zn.tnic (p200300ec2f0a2a0063d0dab944a9c04a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2a00:63d0:dab9:44a9:c04a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E76461EC03D5;
        Mon, 20 Sep 2021 10:34:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632126882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OQ7yHNBqt/MgszI5LWX0FzlV6DqyOJAMJIRfVjQOy/E=;
        b=mzEAAbND23XoA9ZL90qqlF9uUs3Du/MHFsGXCechu4wopZBD8Yk57RBXJElPEfF2dKJDnC
        DIVlXWi6CYhhCK8C29m9pvcfaybaTIOg+29Vv35c4VuehQYo5Art7aJJF5Ig1N7BuN3/QQ
        llzzNrEQBCh+OODifkZWTpaRKNLB2B8=
Date:   Mon, 20 Sep 2021 10:34:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86/mce: Get rid of the ->quirk_no_way_out()
 indirect call
Message-ID: <YUhHoclcgh/qBNG9@zn.tnic>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-5-bp@alien8.de>
 <YUgWu14GqmjJ36+R@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUgWu14GqmjJ36+R@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 10:06:03PM -0700, Luck, Tony wrote:
> Someday all these tests for random vendor/family/model/stepping could be
> refactored into a x86_match_cpu() lookup table (now that x86_match_cpu
> can handle steppings). But that's a topic for a different patch series.

If it remains somewhat readable, sure. If it turns into my favourite
code in severity.c then probably not so much.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
