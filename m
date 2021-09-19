Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3AE410CED
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhISSl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 14:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhISSl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 14:41:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259F9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 11:40:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f302e00e933c602c4b95b78.dip0.t-ipconnect.de [IPv6:2003:ec:2f30:2e00:e933:c602:c4b9:5b78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36A411EC0287;
        Sun, 19 Sep 2021 20:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632076794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y7s5JPf4MLgaXX7S3eVLHT/yv9IOqUfMVCkV12ErJbQ=;
        b=dyufiRGV4nwEI894No3KAhBo4gQ7ckkkRnsS762FcmmWbAOlLhzKfZfFeoaKEVXoMTSkGT
        +N9H2ejeuSEjON006JSxHMzfZq1mY0HqclsJYafKuAoDPKwxavBHqQ0pD0S5/D98EVYIr3
        xYJYYwnTOf4mrIPitVg9aitFBph+IOw=
Date:   Sun, 19 Sep 2021 20:39:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] x86/urgent for v5.15-rc2
Message-ID: <YUeD9Gcx99EbMyMA@zn.tnic>
References: <163207602242.947088.16824174748243890514.tglx@xen13>
 <163207602540.947088.6038710845965846842.tglx@xen13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <163207602540.947088.6038710845965846842.tglx@xen13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Sep 19, 2021 at 08:28:10PM +0200, Thomas Gleixner wrote:
> Juergen Gross (1):
>       x86/setup: Call early_reserve_memory() earlier

this one has been reported as failing on some machines:

https://lkml.kernel.org/r/4422257385dbee913eb5270bda5fded7fbb993ab.camel@gmx.de

please hold off on merging this.

I'm preparing a new pull without it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
