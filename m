Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6D42DBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhJNOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhJNOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:46:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F661C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 07:44:29 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c72008718c38cc37e4684.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:8718:c38c:c37e:4684])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 148C11EC01A8;
        Thu, 14 Oct 2021 16:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634222668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XfaBAqU6z4wkM+UPU9qksZ3loC/MVSpSms6Ss36qZMs=;
        b=PByOEsokXsscd8ggGeYI0tQcNucxF8b1g10qFRhFIHNlkMfHs0BibusML8u3Ac+YK4BE9N
        j4rdHFI1bMefDAje5NfSWJ4u9sTMezL+sstge8Mx+E9tk6KGb4Duoz3lKjwt3XaQ1ycM2j
        LHBgg5esRJ+5pnfRZLw7lZHHi/QcRC8=
Date:   Thu, 14 Oct 2021 16:44:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Ser Olmy <ser.olmy@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YWhCS2wSSu8rq/Ae@zn.tnic>
References: <YWgYIYXLriayyezv@intel.com>
 <YWg+O1AXrWLO3Sf9@zn.tnic>
 <YWg/5h3OcQKE94Nz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWg/5h3OcQKE94Nz@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 05:34:14PM +0300, Ville Syrjälä wrote:
> > > Tested the same disk on on both a 64bit capable Pentium D
> > > and a 32bit only Pentium 4 just to rule out the specific CPU.
> > > Busted on both.
> > 
> > So that's a purely 32-bit installation and a 32-bit kernel and you've
> > booted it on two different machines?
> 
> Yes.

This is insane, grrr!

So Ser's report was about an old 32-bit Intel CPU failing:

https://lore.kernel.org/all/YVtA67jImg3KlBTw@zn.tnic/T/#u

so if we revert, it'll break booting on his machine.

Can you give /proc/cpuinfo from your machines?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
