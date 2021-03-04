Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3626432D127
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbhCDKuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:50:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55158 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239011AbhCDKtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:49:40 -0500
Received: from zn.tnic (p200300ec2f0f5900e15878ab9d7a3926.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:e158:78ab:9d7a:3926])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F88B1EC0328;
        Thu,  4 Mar 2021 11:48:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614854939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=usPlPnG+TN8B9j8SKK3AZ5P+yKgh8QbuCpr8oNtt/9c=;
        b=rIKxU3cBVWWwveyYBANFdA8RuzM/g2Wz0eVDSGL6Hdvzsx/rODREuX0DUsIZYytPTzf/aO
        9+4D+rVlBXCc7YDRz8+Yzr24CQ1PhGv53NqnkLbAn7dZxHzgRniOnvaciSS2d4IZxeu7dL
        ttQx1/rd6FdNcpoUZ50Celouk6PVHJo=
Date:   Thu, 4 Mar 2021 11:48:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] x86/vdso: Use proper modifier for len's printf in extract
Message-ID: <20210304104853.GA15496@zn.tnic>
References: <20210303064357.17056-1-jslaby@suse.cz>
 <20210303183650.GG22305@zn.tnic>
 <1804463d-bb45-ea75-b4b0-1238c35638a0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1804463d-bb45-ea75-b4b0-1238c35638a0@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 06:18:25AM +0100, Jiri Slaby wrote:
> It's built with gcc 10 from tumbleweed and it's a standard config from
> kerncvs:
> https://github.com/openSUSE/kernel-source/blob/stable/config/i386/pae

Nope, can't trigger with that one either. :-\

Anyway, it is obvious enough so applied.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
