Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CBD454AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhKQQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:31:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbhKQQbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:31:50 -0500
Received: from zn.tnic (p200300ec2f13a300581971bf8eb608b9.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a300:5819:71bf:8eb6:8b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAF161EC0136;
        Wed, 17 Nov 2021 17:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637166531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nyy0Npgg/uDrfpHyGIa0EaJntR1EOaRQ1y2qt3lq3Dk=;
        b=dzlHf9SGSMz/98Ra6VKiZ0zIuihOPejKIFC60rcoFMSNH9aKwboXhlJzelMxuzusoZHp+W
        LovyuknW+MklORQtyu61D4Lhtp53e6/c0o3ZgnytjVczz0zqYVDmY3uBqOHSeJsqC3OMK4
        IaHlpoQnEqE6JMDbgGHgy8lJVaPVWDI=
Date:   Wed, 17 Nov 2021 17:28:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH v2 04/23] x86,copy_mc_64: Remove .fixup usage
Message-ID: <YZUtuAtlezsBrnNL@zn.tnic>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.127055887@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110101325.127055887@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:01:06AM +0100, Peter Zijlstra wrote:
> Place the anonymous .fixup code at the tail of the regular functions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/lib/copy_mc_64.S |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
