Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5636012D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 06:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhDOEoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 00:44:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41754 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhDOEoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 00:44:11 -0400
Received: from zn.tnic (p200300ec2f0ace003285750f1ad285f1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ce00:3285:750f:1ad2:85f1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E80FA1EC0323;
        Thu, 15 Apr 2021 06:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618461827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LyEJqIbC60JiuQvwuLB1m2Jz09yI2emc/L43roObh0s=;
        b=fZNETryaNY5m3ZFQQnqoGPRMxYxezDRBMttgr1qWxvg0aOyY3MoIjgiSYdKIWMD7PFuQni
        iBGEY/d/mf7vOAMz3ITbmpSWOwP1EwVWu7yceJD4PIpdwBDUc3H66CdHlgMV10fQxpDtSP
        1VL2J6svHYZee33E0tovmKczbrwXQqg=
Date:   Thu, 15 Apr 2021 06:43:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210415044258.GA6318@zn.tnic>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com>
 <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <20210413034346.GA22861@1wt.eu>
 <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
 <20210414095804.GB10709@zn.tnic>
 <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 05:57:22PM -0400, Len Brown wrote:
> I'm pretty sure that the "it isn't my use case of interest, so it
> doesn't matter" line of reasoning has long been established as -EINVAL
> ;-)

I have only a very faint idea what you're trying to say here. Please
explain properly and more verbosely what exactly has been established
where?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
