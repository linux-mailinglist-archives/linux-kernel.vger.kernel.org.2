Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D473F1798
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhHSK7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:59:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D943C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:58:57 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f6a00d82486aa7bad8753.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:d824:86aa:7bad:8753])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FFDD1EC046C;
        Thu, 19 Aug 2021 12:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629370732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uJc8iQOMh19YUZqvbvnpPt1cT6a67MCNsTrmP9yUlCQ=;
        b=aMEues0qL4uAPysYn7M4pLmNxYe79yEci73YSkAkq4yUtJkdQWjpYpPIFKzjVF17Nizs6T
        Tsq2YwJj9Lll2RJQkaOTyvG6Xj8uIKkOp8sRmF1SBnBA3+lzvuW3C64SIt4gX4hk+axTw1
        o5+R46hpjHtn8hUIoLqbtRtT3PLfkcY=
Date:   Thu, 19 Aug 2021 12:59:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: x86/boot/compressed/64: Lenovo Ideapad Miix300 bug report
Message-ID: <YR45kjdCNXCp15eZ@zn.tnic>
References: <20210819100230.GA28768@agape.jhs>
 <YR4uffjFuqvrz1Tp@zn.tnic>
 <6d7f217e-f8bb-54c5-844d-4b1dff14c785@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d7f217e-f8bb-54c5-844d-4b1dff14c785@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 12:47:05PM +0200, Hans de Goede wrote:
> Fabio is using the standard Fedora kernels which as generic distro
> kernels have this enabled.

Right, I suspected but wanted to make sure. Then my second question
would need answering:

Does it boot plain 5.13.x (without any reverts) fine with that config
item disabled?

> (even if using a distro-kernel-config leads to long build times for
> the bisect).

Yah, tell me about it. :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
