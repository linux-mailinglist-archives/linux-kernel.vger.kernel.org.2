Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B706E42E0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhJNSD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:03:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44200 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhJNSD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:03:27 -0400
Received: from zn.tnic (p200300ec2f0c720076278dcac58b4415.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:7627:8dca:c58b:4415])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC4C21EC01A8;
        Thu, 14 Oct 2021 20:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634234480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRcndT5Kinp3hQ5DZnAb/X5FayKpaOwfofj3HhPRJTE=;
        b=JcUofPEF88i3FgmADKN7Zs9sAPIS/PgPq4jduE6jL1GuL0CKG9VHKq47qBkvOE+MUwU586
        rIQxTt4yigpQeuqmVVakkZ3MdbxGdrvD0z+Q0AAf/qb3vp9VzvoxpHNSEqpjeuobBPACVp
        /dftlzu1gjgo1/1Lmwajz63oPEcdMn0=
Date:   Thu, 14 Oct 2021 20:01:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Ser Olmy <ser.olmy@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YWhwdDI5ECoMZQzU@zn.tnic>
References: <YWgYIYXLriayyezv@intel.com>
 <YWg+O1AXrWLO3Sf9@zn.tnic>
 <YWg/5h3OcQKE94Nz@intel.com>
 <YWhCAqDxAuTh1YwE@intel.com>
 <YWhFOJCF1pxIBANv@zn.tnic>
 <YWhG0kv/d/hddf+t@intel.com>
 <YWhsvSM5tAvwqprN@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWhsvSM5tAvwqprN@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 08:45:33PM +0300, Ville Syrjälä wrote:
> That ~ was indeed the problem. With it gone the machine is happy again.
> 
> I presume you'll turn this into a real patch?

Actually, you found it and you should be the one to write it and do the
honors. Unless you don't want to - then I can do it.

If you do, pls add 

Ser Olmy <ser.olmy@protonmail.com>

to Cc so that he can test your patch. I *think* it should work for him
too but I don't know anything anymore. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
