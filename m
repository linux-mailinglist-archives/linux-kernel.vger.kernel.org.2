Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D5D316284
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBJJkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:40:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42686 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhBJJhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:37:02 -0500
Received: from zn.tnic (p200300ec2f0374001f775f9bd4b55a7d.dip0.t-ipconnect.de [IPv6:2003:ec:2f03:7400:1f77:5f9b:d4b5:5a7d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66B901EC057F;
        Wed, 10 Feb 2021 10:36:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612949776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MFqqvRx1ScD60dZV9b5aUVBdl6BQqK8BxEBbEOrhLkM=;
        b=fMB+r6v8K2JBhTiWXVB1z7FoO8coJCMiwWiHNyz0lSZqkwagReP5stoIDXd2sEo1en1NQG
        qs31r2JS70ZaHGbWJ2TzTQBaw+PRTZ+I2yJjuppxdie9/X0JJRtJOOfAvOZ9pdRCJtLuFc
        JIKhTjnH2P1ESIym0qiBos/NW61dXDk=
Date:   Wed, 10 Feb 2021 10:36:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] x86/vdso: fix CE on non-compatible cflags
Message-ID: <20210210093611.GA14650@zn.tnic>
References: <20210210000749.3952313-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210000749.3952313-1-ztong0001@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 07:07:49PM -0500, Tong Zhang wrote:
> I am getting some compilation error on when using CONFIG_X86_32 kernel
> configuration

With an ubuntu gcc?

Does this branch work:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/urgent

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
