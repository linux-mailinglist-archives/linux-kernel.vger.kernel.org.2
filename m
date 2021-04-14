Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5184A35F7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhDNPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:36:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44580 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231983AbhDNPgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:36:20 -0400
Received: from zn.tnic (p200300ec2f0e8f008ccc887bddfa0520.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8f00:8ccc:887b:ddfa:520])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0CF51EC04D6;
        Wed, 14 Apr 2021 17:35:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618414558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7QUzYLHM4/+zVfpSckS+KvePCizty5xc6tScIXPXiqY=;
        b=eQvu9OVvEIJVqgHE0EkPsiN9cb3jEblOQMnS33QLuuRHfT0XKfSLzPsBnDTGS+LhCWwPfg
        mPKQQXzvlsdWkrmjIZEONJniIfaTXS76xpWrbXz9bjgs6+IwLQ+JDWobwo6xHf/ITFBPDT
        4Bv5At1ERm6BrmoW9mBWN/ZyHf8WaZc=
Date:   Wed, 14 Apr 2021 17:35:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jue Wang <juew@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, "Luck, Tony" <tony.luck@intel.com>,
        x86 <x86@kernel.org>, yaoaili@kingsoft.com
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
Message-ID: <20210414153554.GH10709@zn.tnic>
References: <CAPcxDJ6xx00Gjn6DxoMpdJ7UjNeJUp2613jqGRm7ZZeuMNeSjQ@mail.gmail.com>
 <20210414131018.GG10709@zn.tnic>
 <CAPcxDJ5q8=pwqsNV4ydSPJWp35f886n1TB7dWOx9cst=cb2myA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcxDJ5q8=pwqsNV4ydSPJWp35f886n1TB7dWOx9cst=cb2myA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 07:46:49AM -0700, Jue Wang wrote:
> I can see this is useful in other types of domains, e.g., on multi-tenant cloud
> servers where many VMs are collocated on the same host,
> with proper recovery + live migration, a single MCE would only affect a single
> VM at most.
> 
> Another type of generic use case may be services that can tolerate
> abrupt crash,
> i.e., they periodically save checkpoints to persistent storage or are stateless
> services in nature and are managed by some process manager to automatically
> restart and resume from where the work was left at when crashed.

Yap, thanks for those.

So I do see a disconnect between us doing those features in the kernel
and not really seeing how people use them. So this helps, I guess the VM
angle will become important real soon - if not already - so hopefully
we'll get more feedback in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
