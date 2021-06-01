Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023CC397C76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhFAWjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:39:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34950 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234714AbhFAWjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:39:09 -0400
Received: from zn.tnic (p200300ec2f111d0093004df6f0d27e9c.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1d00:9300:4df6:f0d2:7e9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B245F1EC04DE;
        Wed,  2 Jun 2021 00:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622587046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GqP0+T23mTprX4YAEpRg+N2kSe5+fCX/w4EtyzFEnHk=;
        b=bSaJztAL6vxO3lbvu32w2txgbnnzs0OzAvhU5II0CbPChc5swPmwTfM8VFYlOcQJmtuKMm
        WC2l7CdKxywU+81ro7ZyDbeXaf1VjBERyw2XxWH+lwfqKV6OOpAynCcwN+4eDPG/j3fh4S
        6S+wB+vwKPkvZw0tl2bKziy8fig8rrk=
Date:   Wed, 2 Jun 2021 00:37:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Document RESEND tag on
 patches
Message-ID: <YLa2oDQHqiQr9XhJ@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
 <20210413113834.GE16519@zn.tnic>
 <87pmyxsxsy.fsf@meer.lwn.net>
 <20210415060505.GC6318@zn.tnic>
 <YLT0MjAIO/8u4cjY@zn.tnic>
 <87zgw98blq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zgw98blq.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 04:27:13PM -0600, Jonathan Corbet wrote:
> Oops...somehow I missed the fact that there was something there for me
> to look at and respond to, sorry.

No worries, thanks for taking the time!

> I've just read it through...  if it were me, I would find a way to
> reduce its bulk in the hope that people would actually read it; much of
> what's there is in coding-style.rst (or should be). 

Right, the idea is to point to sections in it during review where the
topic in question is dealt with a greater detail so that we don't have
to type it each time.

I'll take a look at coding-style.rst and see if I can cross-link
sections so that there's no repetition.

> But it's not me, and if you want to keep it I won't whine (much).
> Except about reverse fir tree, perhaps, but nobody listens to me on
> that...:)

Yeah, that is the only correct way! :-)

> I'd say package it up as a maintainer-guide entry and go for it.

Thanks, will do so!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
