Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112083584D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhDHNgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:36:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53928 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231255AbhDHNgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:36:45 -0400
Received: from zn.tnic (p200300ec2f095000f2588bda42a4deac.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5000:f258:8bda:42a4:deac])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB7111EC027D;
        Thu,  8 Apr 2021 15:36:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617888993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rcbTJeL0qCfNlPnpFLbjPA0s8qIHLH+BaXYJGvFUr2g=;
        b=PDCV24O1Z649Q88tnfXsownQZeUZXSFWR4FeNJSNsjta/DvUSRpxK6tGwEy/LLEsimBc3D
        vqG2xQAf0LQ8xFqh3OAbTmynPGnaGgadjobeZppnuKJvD65My0JpcpEe67bjZqYLSBmx7i
        Lz7rgxBlHvmE7q2v5J6kjVbFNDzX438=
Date:   Thu, 8 Apr 2021 15:36:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEoIOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
Subject: Re: [PATCH 4/4] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210408133631.GJ10192@zn.tnic>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210326000235.370514-5-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210326000235.370514-5-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:02:35PM -0700, Tony Luck wrote:
...
> Expected worst case is two machine checks before moving on (e.g. one user
> access with page faults disabled, then a repeat to the same addrsss with
> page faults enabled). Just in case there is some code that loops forever
> enforce a limit of 10.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 40 ++++++++++++++++++++++++++--------
>  include/linux/sched.h          |  1 +
>  2 files changed, 32 insertions(+), 9 deletions(-)

What I'm still unclear on, does this new version address that
"mysterious" hang or panic which the validation team triggered or you
haven't checked yet?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
