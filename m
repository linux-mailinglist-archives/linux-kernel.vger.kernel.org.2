Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4D13F171D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbhHSKMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:12:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C06AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:11:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f6a00d82486aa7bad8753.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:d824:86aa:7bad:8753])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C2CB1EC046C;
        Thu, 19 Aug 2021 12:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629367890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2rIS3j5hRVJneesLIDW/X7CVqvAEHEFlKzJwQXcMrvo=;
        b=piDF6tt/UP76IrK9h6CfvrTA75QFScregkGZ9qondfONZbaCcLQdNL91rPs+1fqMUa1MDA
        0qhK4AXIEHPsMrabVSjIvD2Am9kaVFkhuz4ozuoGA61Od6LWldriGuFQc7GNS5XPSCdMxL
        ByonJkLvfflWTePhBi60MhUhEDk9fpA=
Date:   Thu, 19 Aug 2021 12:12:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: x86/boot/compressed/64: Lenovo Ideapad Miix300 bug report
Message-ID: <YR4uffjFuqvrz1Tp@zn.tnic>
References: <20210819100230.GA28768@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819100230.GA28768@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 12:02:31PM +0200, Fabio Aiuto wrote:
> CONFIG_AMD_MEM_ENCRYPT=y

Lemme see if I understand it correctly: you have this enabled on an
Intel-based tablet?

Does it boot plain 5.13.x (without any reverts) fine with that config
item disabled?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
