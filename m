Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6ACF3702BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhD3VMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbhD3VMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:12:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73682C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:11:27 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c57007f2124644a28e2fb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5700:7f21:2464:4a28:e2fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 052321EC0493;
        Fri, 30 Apr 2021 23:11:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619817086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R7SUAKctQXSO3bp7YOOvdGp4SijTzrM9sqUzSwirMSg=;
        b=rVOucNWXmpJtuzMocO+sF8MKOqGLnu6cvuCx1isFubzfQdgX0upKzb7OAouqstsfhZuanR
        H/YByaiBroaX4NXZMbIknjAOVD+ukcxRjHaQXjYtagqr7nVtUUFdgUF+n+7jR0TgQbRo1N
        9SF7kNvsr/GSJTBrZYUCCIXlWKgVbAo=
Date:   Fri, 30 Apr 2021 23:11:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reiji Watanabe <reijiw@google.com>
Cc:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        bsd@redhat.com
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
Message-ID: <YIxyeZodkm3KpRYK@zn.tnic>
References: <20210430131733.192414-1-rsaripal@amd.com>
 <20210430131733.192414-2-rsaripal@amd.com>
 <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com>
 <YIxhCSt6t5U/Eldb@zn.tnic>
 <CAAeT=FxqM5P+6U8vBywuvnaJ0s4sWdRHK2fvn4b1zf5mMLKReg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAeT=FxqM5P+6U8vBywuvnaJ0s4sWdRHK2fvn4b1zf5mMLKReg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 02:03:07PM -0700, Reiji Watanabe wrote:
> Could you please clarify ?

Clarify what?

I asked you whether you have a VM use case. Since you're talking/asking
about virt support, you likely have some use case in mind...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
