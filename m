Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2942E1D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhJNTKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhJNTKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:10:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50AAC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:08:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c7200d22ebf2cfed8089c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:d22e:bf2c:fed8:89c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A4311EC01A8;
        Thu, 14 Oct 2021 21:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634238526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lgyPayuoS0zrF7NkQk/+tiXiQ1H5QRoLpFaRKO0SYAQ=;
        b=Za77ZUJFEbN8vUDb0rGqfvG/iuNJhrfU6+rIf4T+rerH26+DgoFIGTqIuM1DwGhf/Ijn0D
        RGy4QgglSGOuwcW7wQ85BL5c81OHASFA5eC6DaqV1wuuDpO44vSb6STZDOB6Zn0Zlrxysc
        JC8/T0oLr1CXWkB9mgmrFGWUymnFADk=
Date:   Thu, 14 Oct 2021 21:08:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Ser Olmy <ser.olmy@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YWiAPQCRm4RnOiCd@zn.tnic>
References: <YWgYIYXLriayyezv@intel.com>
 <YWg+O1AXrWLO3Sf9@zn.tnic>
 <YWg/5h3OcQKE94Nz@intel.com>
 <YWhCAqDxAuTh1YwE@intel.com>
 <YWhFOJCF1pxIBANv@zn.tnic>
 <YWhG0kv/d/hddf+t@intel.com>
 <YWhsvSM5tAvwqprN@intel.com>
 <YWhwdDI5ECoMZQzU@zn.tnic>
 <YWh7GgCgdtwRj3GU@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWh7GgCgdtwRj3GU@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 09:46:50PM +0300, Ville Syrjälä wrote:
> I figured you can write a reasonably succinct commit message, instead
> of having me ramble on incoherently. ATM I don't even know what mxcsr
> is or why clobbering it would cause floating point exceptions with
> sse specifically.
> 
> But I can certainly ramble, if you prefer that.

Well, you can simply say that d298b03506d3 was supposed to mask out the
reserved bits in the MXCSR register but the author mistakenly used the
negation of the mask.

And if the commit message is not explaining stuff properly, I'll fix it
up, no worries there.

But your call - I'm done for today and I'll do a patch tomorrow. That
is, unless you haven't decided that you wish to write one in the
meantime and you've sent it to me overnight.

:-)))

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
