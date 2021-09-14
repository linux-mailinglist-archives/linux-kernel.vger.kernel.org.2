Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17140B557
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhINQyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:54:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45808 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhINQyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:54:19 -0400
Received: from zn.tnic (p200300ec2f104800a3d420f33d0f872b.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:4800:a3d4:20f3:3d0f:872b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0EF51EC04EC;
        Tue, 14 Sep 2021 18:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631638374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Yyrj90l77ltEqpUWFU3UCdJqakTo+Wlc4DRAjWBj5rE=;
        b=Athu7ensH09GL7kxTUM95VwrkFcPRcvJuTJPTlBMLWX8Ip4FKmrHbybKastKxBrfAGMigr
        ABozkhmLY2CNN9qqq1j3Mk+Fy8EECK19VbHg6JLY+kj1DH8cXwvJreZfA4nRRBo+GAG5u1
        uPG6DhA0EGAl8OcYD0L+KQn+7CJx8OY=
Date:   Tue, 14 Sep 2021 18:52:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Marcus =?utf-8?Q?R=C3=BCckert?= <mrueckert@suse.com>
Subject: Re: [PATCH] x86/umip: Add a umip= cmdline switch
Message-ID: <YUDTZQ9MHl5hXas3@zn.tnic>
References: <20210907200454.30458-1-bp@alien8.de>
 <20210913214503.GB10627@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913214503.GB10627@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 02:45:03PM -0700, Ricardo Neri wrote:
> Strictly, this hunk does not logically belong to this patch. I guess it
> is harmless, though. Admittedly, the new line should have been there
> since umip.c was added.

Yeah, I don't like crammed code - that's why I've added it.

> Wouldn't it be better to use parse_option_str() with __setup("umip=",
> parse_umip_param)? This would avoid the first two checks.

Sure.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
