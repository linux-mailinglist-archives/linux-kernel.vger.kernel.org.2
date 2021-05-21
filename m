Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110ED38CDB4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbhEUSow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbhEUSou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:44:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B30C061574;
        Fri, 21 May 2021 11:43:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ea400fbcd5718c7a034c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a400:fbcd:5718:c7a0:34c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87CDF1EC071E;
        Fri, 21 May 2021 20:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621622604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vFVTqBpUpF5lkAZTvKtHNXOqH6JbT1bVaIWzNcF9VCc=;
        b=dlCubREL4UKZBjnpzC3sdwbWEX30Y3DMl3RVW3wCw3kiQoX9kpB3uEJEp2i+cEk5vNtGZN
        OBeMn4w/ZyQCPysR+CZh5Ep2ks8Kk8EN+tU8T4PYayDin9VOVsXRe5SbHWVw7sMz+ywH6d
        0COejeCpRPS0HP5y19suAo0V1U6+O/w=
Date:   Fri, 21 May 2021 20:43:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wei Huang <wei.huang2@amd.com>, David Bartley <andareed@gmail.com>,
        linux-kernel@vger.kernel.org, linux-x86_64@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: add AMD family 19h model 50h PCI ids
Message-ID: <YKf/SwCD1Efsn4nV@zn.tnic>
References: <20210520174130.94954-1-andareed@gmail.com>
 <YKeHBI757jX65ULa@zn.tnic>
 <2ba654b5-1c08-85da-b932-9d5a92d5c930@amd.com>
 <13e9db0f-a1d7-8699-a7d9-90246c7df553@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13e9db0f-a1d7-8699-a7d9-90246c7df553@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 10:45:53AM -0700, Guenter Roeck wrote:
> Yes, it does [1]. Fine with me though to define it locally there.
> I personally find that easier since it would avoid the recurring
> "I don't see this define used anywhere else besides xxx".
> Someone else can clean that up later if so desired.

Or someone can ask first or maybe even get CCed on both patches so that
someone can see the full picture. :-)

Anyway, I'll commit it as-is.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
