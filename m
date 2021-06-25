Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB73B4795
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhFYQzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 12:55:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46280 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhFYQzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 12:55:38 -0400
Received: from zn.tnic (p200300ec2f0dae005eaeb42c95705db7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:5eae:b42c:9570:5db7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C82C1EC0595;
        Fri, 25 Jun 2021 18:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624639996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5oglbtDoCqv1rrsijHZLgwPJuabYmtu6XSdtgQz57Bw=;
        b=Fz6hzC/dAe73l8J3h7q3W3oJDTQQpeP/857Y2zyrbsLL6+qYVWP+/UkwBW/QQDM+QOP+ms
        o4LDOjLomxx6O+e9IpcyV+uxmFgfQK3qa6i1WRKlyvO/AEg9ybDRAXAirPkfthyU8Tj2vl
        V8mUpspV+w9CN+2Tc/RmZFS98UH5GNM=
Date:   Fri, 25 Jun 2021 18:53:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
Message-ID: <YNYJ9vVQPVWqCvVq@zn.tnic>
References: <YNRzSy3NuwBDYWwr@kroah.com>
 <YNR7aw+C+7AJnBIG@zn.tnic>
 <YNXG472lXPHlbuCF@kroah.com>
 <YNXkVBcmBvZL7khv@zn.tnic>
 <F8B4FDC6-851F-4EC5-A308-BBAB52A75EF3@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F8B4FDC6-851F-4EC5-A308-BBAB52A75EF3@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:19:38AM -0700, H. Peter Anvin wrote:
> You can use PRIu32/64 or cast to unsigned long long; it's not like the
> performance for this case is going to matter one iota.

Why "unsigned long long"?

Those fields are typedeffed as:

typedef __u32	Elf32_Off;

or

typedef __u64	Elf64_Off;

respectively so they should fit in an "unsigned long" on the respective
width.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
