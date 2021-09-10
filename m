Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E807C406964
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 11:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhIJJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 05:59:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48848 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232094AbhIJJ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 05:59:22 -0400
Received: from zn.tnic (p200300ec2f0f0700510d70add229dcc0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:700:510d:70ad:d229:dcc0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 40EB71EC0287;
        Fri, 10 Sep 2021 11:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631267886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eMH0OYhSENU+8l9RdprI+/qV2v32JfEhFp7Y3uknai8=;
        b=myNaE2VvwfjdGG2lk6PL0KkPRdPkt0ZDCvsWRf5Y2rodWtTjbIA2+CyCD8IHFVywVlEW7g
        fjllVPDi/4exU0ilN+we/nNkRA3wFUzJzEkDQ+O4nepkUkvjU1HuU82L+YiATyZemqdIca
        lNsrYvT66piTCJXmwHpWxHz5GyaoHTQ=
Date:   Fri, 10 Sep 2021 11:57:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux@roeck-us.net, yazen.ghannam@amd.com,
        mingo@redhat.com, nathan.fontenot@amd.com, lewis.carroll@amd.com,
        Ingo Molnar <mingo@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 1/3] x86/amd_nb: Add support for HSMP mailbox access
Message-ID: <YTssJkXH/ATm9zaA@zn.tnic>
References: <20210902174155.7365-1-nchatrad@amd.com>
 <YTEQzIVfY/A1uy32@zn.tnic>
 <ad2bbcad-857c-f39d-9bee-49cd8ad582b2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad2bbcad-857c-f39d-9bee-49cd8ad582b2@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 10:41:20PM +0530, Chatradhi, Naveen Krishna wrote:
> In all the future server platforms, AMD's direction is the support HSMP
> interface, which exposes system management knobs.

I know you all think about the future only but there's the past too and
there's a bunch of AMD hardware out there which doesn't have that.

> > You could make it a separate driver module called amd_hsmp.ko which
> > loads only on the appropriate hw and uses amd_nb.c for detection only
> > like the other drivers, for example.
> 
> How about, creating a module under drivers/platform/x86/ (lets say
> amd_hsmp.c) export an API from here and it can be extended to support all
> the knobs that does not fit in an existing frameworks (such as hwmon, etc)
> and provide a user space access.
> 
> I can see similar references in the drivers/platform/x86/ directory.

That sounds ok to me too. There's also arch/x86/platform/, btw, and I
still have to find out what the difference is. :-)

Lemme add the platform drivers folks.

Thread begins at:

https://lkml.kernel.org/r/20210902174155.7365-1-nchatrad@amd.com

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
