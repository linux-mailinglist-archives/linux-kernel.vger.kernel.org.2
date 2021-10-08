Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE48426717
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbhJHJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:47:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41626 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238284AbhJHJrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:47:42 -0400
Received: from zn.tnic (p200300ec2f0d56001d1e8fcbbc7c59cf.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5600:1d1e:8fcb:bc7c:59cf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7E8F1EC04F3;
        Fri,  8 Oct 2021 11:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633686346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDvjXf2G2Fog17uEppnXMkbhqsHtzjJX73iNz52CSDg=;
        b=PhxXR1gbnwtpqzn3+vgcIdufo54R1jpl4j6Q+vxVcZ7/GjKen7Ouvzx9malqusgUFjQXS3
        CDZV+7uNgrY9s8PZmzeuCwELgCFGWA5yA+3bb+6qvd6Wqo2Tjxw0Uw1FX1QWfaQTSRiiV5
        nzfaFayi+HzFSf7tFfk77Fro5G5pyY4=
Date:   Fri, 8 Oct 2021 11:45:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Werner Sembach <wse@tuxedocomputers.com>, benoitg@coeus.ca,
        bhelgaas@google.com, hpa@zytor.com, juhapekka.heikkila@gmail.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH RESEND] x86/resource: Do not exclude regions that are
 marked as MMIO in EFI memmap
Message-ID: <YWATQgGOFQIlLOlV@zn.tnic>
References: <20200617164734.84845-1-mika.westerberg@linux.intel.com>
 <1c225d72-44dc-1ddb-3284-a5d19e0db882@tuxedocomputers.com>
 <YWAOE5yV9V0/HMET@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWAOE5yV9V0/HMET@lahna>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:23:31PM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Fri, Oct 08, 2021 at 10:55:49AM +0200, Werner Sembach wrote:
> > Is there any update on this matter? Also happens on discrete Thunderbolt 4 chips:
> > https://bugzilla.kernel.org/show_bug.cgi?id=214259
> 
> AFAICT no updates.
> 
> @Bjorn, x86 maintainers,
> 
> If there are no alternatives can we get this patch merged so that people
> don't need to carry out-of-tree patches to get their systems working?

Just my 2¢ from briefly skimming over this:

So this reads yet again as BIOS is to blame but what else is new?

"All in all, I think we can fix this by modifying
arch_remove_reservations() to check the EFI type as well and if it is
EFI_MEMORY_MAPPED_IO skip the clipping in that case."

And this like we should trust EFI to mark those regions properly, which
is more of the same but in different color.

That original commit talks about windoze doing a different allocation
scheme and thus not trusting the untrustworthy firmware anyway and that
sounds like something we should do too. But WTH do I know?!

So I'd prefer if Bjorn chimed in here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
