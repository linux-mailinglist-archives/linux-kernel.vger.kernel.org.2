Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0016339E05
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 13:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhCMMPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:15:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47310 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhCMMPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:15:48 -0500
Received: from zn.tnic (p200300ec2f1971005e6485920b35c85a.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:7100:5e64:8592:b35:c85a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B6451EC0324;
        Sat, 13 Mar 2021 13:15:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615637747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IzG8S19DfCJse+qsHPZZdLfllCfuzdUKyM1gOGVGTJA=;
        b=TFxeq+GQD69vlRaG/BgfgT4TB+Wci5Oh1LBQGfaYI0eLKZL0VD4Z4k808MS03K8Trmq8Ia
        FXw/IJbStjnhRe9UatyoQpNEha7iaK4oUD9oT31BdUYBTbpHIl8eFwOfYMsgj10MQqeRLx
        xt9VgMt10gVUSE6bq9cM4ohluxGGxfk=
Date:   Sat, 13 Mar 2021 13:15:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210313121541.GC16144@zn.tnic>
References: <20210312113253.305040674@infradead.org>
 <20210312205914.GG22098@zn.tnic>
 <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic>
 <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 01:10:29PM +0100, Sedat Dilek wrote:
> Here we go:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/patch/?id=864b435514b286c0be2a38a02f487aa28d990ef8

That's why I told earlier you to use tip/master - that patch is already
in it and all you would've needed to do is to apply the two nop patches.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
