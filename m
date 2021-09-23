Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684214161CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbhIWPMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:12:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56704 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241890AbhIWPMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:12:50 -0400
Received: from zn.tnic (p200300ec2f0d6800d149a76d0b562da3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:d149:a76d:b56:2da3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 759A51EC0516;
        Thu, 23 Sep 2021 17:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632409873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=83PeQFJnLC9Hj90LilkIUnPUeYf0Sh9043yi957lXII=;
        b=EOdiwBsgoW8r0WQd+CcHBTUJnLZ4XXWxZtZCicK0cRsS62oDZCj+xxXLcwtZbUMJTWpGMg
        NEUejqJilT/OeIlAx7mdK21phli7Rh8bLxClbFzAao3BgzvHESPGBxVdxvfaK/hQAHU/9b
        HyB3BYS7MwlWELZF+S93YPotVo7p2f0=
Date:   Thu, 23 Sep 2021 17:11:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86/mce: Get rid of the ->quirk_no_way_out()
 indirect call
Message-ID: <YUyZDAGloQB/M4ts@zn.tnic>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-5-bp@alien8.de>
 <YUyUhfTfY/3KtDTZ@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUyUhfTfY/3KtDTZ@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 02:51:49PM +0000, Yazen Ghannam wrote:
> On Fri, Sep 17, 2021 at 12:53:55PM +0200, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Use a flag setting to call the only quirk function for that.
> >
> 
> I'd like to add another quirk function. First revision here:
> https://lkml.kernel.org/r/20210504174712.27675-2-Yazen.Ghannam@amd.com
> 
> Do you recommend this create another quirk flag and follow this patch? Or
> should the quirks be grouped together somehow?

Does that quirk match machines with mce_flags.smca=1 per chance?

:-)

Also, your test:

+	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
+		return;

should be

+	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) ==
			    (MCG_STATUS_EIPV|MCG_STATUS_RIPV))
+		return;

methinks.

Unless I'm misunderstanding the erratum ofc...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
