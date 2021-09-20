Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB2D411101
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhITIdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:33:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49424 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhITIds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:33:48 -0400
Received: from zn.tnic (p200300ec2f0a2a0063d0dab944a9c04a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2a00:63d0:dab9:44a9:c04a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E48131EC0287;
        Mon, 20 Sep 2021 10:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632126737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2tkRxJuSpa5sVLgOZGbfXkByQRn28aji50fY5ARUDIM=;
        b=lr/dGhJ42eGiTB8pDWnlPVDnNm2fPZ5jL5SqGlyIty/fZvwbUn+NTngjBjcSO9+fLjdQBo
        95zGFX+zSWD+9vg8AHugAwdMMF+iKppPjdhWexHAYZAeNiTbDqJ3yFhH3sYfHb0tmBIEHq
        aFs/JG3yrAd8cq3FbBIgP43WZTo9N6I=
Date:   Mon, 20 Sep 2021 10:32:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86/mce: Get rid of msr_ops
Message-ID: <YUhHC7SJ+/xTnuI4@zn.tnic>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-4-bp@alien8.de>
 <YUgSd6Sl/bFaGydO@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUgSd6Sl/bFaGydO@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 09:47:51PM -0700, Luck, Tony wrote:
> I think this would be easier on the eyeballs with
> a couple of helper functions:
> 
> 	if (mce_flags.smca)
> 		return smca_msr_number(bank, reg);
> 	else
> 		return msr_number(bank, reg);
> 
> with the switch (reg) in each of those helper functions.

I'll switch it to

	if ()
	else

but please don't make me add more helper functions. Those MSR defines
already have "SMCA" and "IA32" in their names so that should be a good
enough differentiation, I'd say.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
