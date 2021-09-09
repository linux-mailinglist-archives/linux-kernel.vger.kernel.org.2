Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD034048EB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhIILJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:09:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59354 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234216AbhIILJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:09:05 -0400
Received: from zn.tnic (p200300ec2f0e4500a512d950ff073124.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4500:a512:d950:ff07:3124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98DDE1EC051F;
        Thu,  9 Sep 2021 13:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631185671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P4SGia4zv5d1uDpVPQGhMPIvAopBVtBUT+4Tkct+Xuw=;
        b=OdDajBG0ZEE9YklBTtUXlNYu5pL6prbv1Afmi+Jbdol7QyOFDFIx9KNuC3O9B9hAGpO0gD
        Ex4aVQinm+R6ipez7kkkIm85p6KdpUGPii8vlWLpHXXFLRk5qv+WwbleUXdA6CJQ7d09Z0
        a1Cq4Dlu4Ljpj6XzkCG7huCs1DOwP0M=
Date:   Thu, 9 Sep 2021 13:07:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     wujinhua <wujinhua@linux.alibaba.com>
Cc:     x86 <x86@kernel.org>, "zelin.deng" <zelin.deng@linux.alibaba.com>,
        "jiayu.ni" <jiayu.ni@linux.alibaba.com>, ak <ak@linux.intel.com>,
        "luming.yu" <luming.yu@intel.com>, "fan.du" <fan.du@intel.com>,
        "artie.ding" <artie.ding@linux.alibaba.com>,
        "tony.luck" <tony.luck@intel.com>, tglx <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "pawan.kumar.gupta" <pawan.kumar.gupta@linux.intel.com>,
        "fenghua.yu" <fenghua.yu@intel.com>, hpa <hpa@zytor.com>,
        "ricardo.neri-calderon" <ricardo.neri-calderon@linux.intel.com>,
        peterz <peterz@infradead.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENIXSBwZXJm?= =?utf-8?Q?=3A_optimiz?=
 =?utf-8?Q?e?= clear page in Intel specified model with movq instruction
Message-ID: <YTnq/3rzmD6ADyZm@zn.tnic>
References: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com>
 <YTnWXIB42sCLbM2k@zn.tnic>
 <bf6fe59d-c760-40d4-8201-4170cd90ffc3.wujinhua@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf6fe59d-c760-40d4-8201-4170cd90ffc3.wujinhua@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 07:02:08PM +0800, wujinhua wrote:
> I provide three tests and result for you. All the tests run in Intel
> CPX.

I said

"What you should do is show the extensive tests you've run with
real-world benchmarks..."

Are your tests real-world benchmarks?

IOW, no microbenchmarks please.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
