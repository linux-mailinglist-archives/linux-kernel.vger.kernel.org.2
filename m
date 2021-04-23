Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E169368E28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbhDWHyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhDWHx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:53:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401D3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:53:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cb1009438669cca5ae2d7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:b100:9438:669c:ca5a:e2d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 895211EC0518;
        Fri, 23 Apr 2021 09:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619164398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I4sBEhGQg0nsiwK/Wd4yKl+4oAITsLtnuIhLDtPS3r8=;
        b=KZjLPfapiGjkLOqVzvvujFsIk0xWUJ7Ln8J8IVNpfhlkOxiN7yDfRlJB0ddKJP06Cs49tw
        SM7RI5zX8/FwnRsCJrrQfgOofD2ZPQ0OOJ5lOuT2oeDZakgQN491ns1ah+K+ZO1df5lq1K
        j6A12jDlfgsnA2LaELpfimtvuDPO+jQ=
Date:   Fri, 23 Apr 2021 09:53:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joerg Roedel <jroedel@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed: enable -Wundef
Message-ID: <20210423075314.GA18085@zn.tnic>
References: <20210422190450.3903999-1-ndesaulniers@google.com>
 <YIIVlahVlJAsaE9W@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIIVlahVlJAsaE9W@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 05:32:21PM -0700, Nathan Chancellor wrote:
> I wonder if it is worth turning on -Wall for this directory...

Yeah, I don't see why not. That is, until someone sits down and converts
that file to include the toplevel Makefile flags...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
