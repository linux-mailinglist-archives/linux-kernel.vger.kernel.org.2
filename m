Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593C239AA27
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFCSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:39:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45128 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:39:01 -0400
Received: from zn.tnic (p200300ec2f13850043af4c4d530a3258.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:43af:4c4d:530a:3258])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 087CE1EC04A6;
        Thu,  3 Jun 2021 20:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622745436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BEr//xjV1GqZSBzi3bsF+G1FWwbefcv6uCbPmM9RANQ=;
        b=pplRkp7EY+j9InipnsnnnKO/1sbfKryAA3g8xS3VlD8O/OBPlMooUIp264da5HsrdXfEyh
        ltmTCqJ4TnzY3bzBjOC2Vzg0boeUt9epLGfJEsCOTdb8MtiZn+XtCNwroE/9Kv016b6Rtt
        XrduIsQT/Endddr+FRp8lWaSbL82QkI=
Date:   Thu, 3 Jun 2021 20:37:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiashuo Liang <liangjs@pku.edu.cn>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal/x86: Don't send SIGSEGV twice on SEGV_PKUERR
Message-ID: <YLkhV+lSqXlcfUc5@zn.tnic>
References: <20210601085203.40214-1-liangjs@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210601085203.40214-1-liangjs@pku.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 04:52:03PM +0800, Jiashuo Liang wrote:
> Before this patch, the __bad_area_nosemaphore function calls both
> force_sig_pkuerr and force_sig_fault when handling SEGV_PKUERR. This does
> not cause problems because the second signal is filtered by the
> legacy_queue check in __send_signal.

I'm likely missing something but the first signal gets filtered by that
same legacy_queue() check too, no?

Because both calls end up in

	force_sig_info_to_task(info, current);

with the info struct populated with:

	info.si_signo = SIGSEGV;
        info.si_errno = 0;
        info.si_code  = SEGV_PKUERR;
        info.si_addr  = addr;
        info.si_pkey  = pkey;

except the second call - force_sig_fault() - doesn't put pkey in
->si_pkey.

So what's up?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
