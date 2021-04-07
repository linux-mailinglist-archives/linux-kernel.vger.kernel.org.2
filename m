Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0785A3574C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbhDGTHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:07:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58718 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhDGTHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:07:33 -0400
Received: from zn.tnic (p200300ec2f08fb0068bab63ea534f357.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:fb00:68ba:b63e:a534:f357])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAECB1EC027D;
        Wed,  7 Apr 2021 21:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617822442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WbaVYOwXFwTp1JFWvOPSCcGySR7lFOrJu5nqezgrt1w=;
        b=QdRmUV7WzwR34QL+I2v8zKgyRuvH1LCjS/l5FHxE1xzI+dG0pdPG3u5WbmRUxok7NYw23z
        94iNnSofzzzKYaMeofbG9c9OM55Mp7TuenQq0fhv+OmKTt9ZyBgdYvAweBRXh+enI+g5IU
        0252eB39O7G9nVdqIEziPY0BTe0XQvM=
Date:   Wed, 7 Apr 2021 21:07:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] x86/kernel: remove unneeded dead-store initialization
Message-ID: <20210407190727.GN25319@zn.tnic>
References: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com>
 <20210407120239.GD25319@zn.tnic>
 <CAKwvOdnuKazNhqXAM9Qj7DgCW=PqVHkyyfYWytmkyBzv0QeYsw@mail.gmail.com>
 <20210407190328.GM25319@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407190328.GM25319@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:03:28PM +0200, Borislav Petkov wrote:
> On Wed, Apr 07, 2021 at 10:41:26AM -0700, Nick Desaulniers wrote:
> > You do have clang-tidy installed right? `which clang-tidy`?

Btw, for user convenience, that "clang-analyzer" Makefile target could
check for the presence of clang-tidy and fail if it is not there, with
an informative error message. Methinks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
