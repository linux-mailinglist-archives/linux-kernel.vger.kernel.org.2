Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AB943080F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbhJQKnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245349AbhJQKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:43:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFE6C061768
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 03:41:05 -0700 (PDT)
Received: from zn.tnic (p200300ec2f2597001cf927021e2e0f44.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:9700:1cf9:2702:1e2e:f44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B5C41EC0518;
        Sun, 17 Oct 2021 12:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634467262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3UnJNRE7IyVV/n+BflWrH+ptfqfhNsHx6+NGIlnMzzk=;
        b=Rt2CrhaERYBK1RZtnetTfEpFVHTkq9r0dy9cKg6nzhILYSi95y2yIoRS+iw8yafTwSCae2
        Y6nqb/YvL5dcTBVCTk7AeFugiYD19hPXxIUz4/7PFuwfQo6DvXFlGMT92SNGigC5hh1D+I
        Pv6t4WHiqKKEmtyl6kjC13CHxoBbl5c=
Date:   Sun, 17 Oct 2021 12:41:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: 5.15-rc on x86-32: chromium dies with floating point exception
Message-ID: <YWv9wfVCllOnXex6@zn.tnic>
References: <20211017093905.GA3069@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211017093905.GA3069@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 11:39:05AM +0200, Pavel Machek wrote:
> does someone have any ideas?

Fix just went to Linus:

https://git.kernel.org/tip/b2381acd3fd9bacd2c63f53b2c610c89959b31cc

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
