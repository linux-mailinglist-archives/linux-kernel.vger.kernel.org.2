Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70033447E44
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbhKHKvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:51:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44780 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235584AbhKHKva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:51:30 -0500
Received: from zn.tnic (p200300ec2f331100bbe06604d19d6498.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:bbe0:6604:d19d:6498])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 677931EC0104;
        Mon,  8 Nov 2021 11:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636368525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=o0oXFowwcpygWp+R/nQLU5GyARB9J53V8h/ASNJWtfo=;
        b=j+SWxC83yDDcf9seADRWUsORNCrNAhJLmybVuX9HFoXl3pxbPiabyGlTA0i3/d0PCq3qN6
        Q0Itp5Vp5cfMGgB0wVoZhKaYwdX7d29mioJNyDDGjrPNOR+TUhL29VF7gOQdwSO4HNiWK/
        0z/dhJ9fP9mCL+8thzF0fcCb0qdu78I=
Date:   Mon, 8 Nov 2021 11:48:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Subject: Re: [PATCH v0 25/42] arch/um: Check notifier registration return
 value
Message-ID: <YYkAiFhxVsLaPTqr@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-26-bp@alien8.de>
 <129beb0a860102ba7970ab7497a5a83fe2041e68.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <129beb0a860102ba7970ab7497a5a83fe2041e68.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 11:23:59AM +0100, Johannes Berg wrote:
> Maybe it should just return it? I don't see how this is ever possible,
> since it's an initcall.

If it would return it, you'd see the warning only when booting with
"initcall_debug", I believe.

I can do that if it is preferred...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
