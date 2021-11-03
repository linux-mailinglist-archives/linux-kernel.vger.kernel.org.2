Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307D24443E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhKCOzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:55:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56494 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhKCOzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:55:20 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1miHd1-0000v5-Ut; Wed, 03 Nov 2021 22:52:39 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1miHct-0001Aw-Iv; Wed, 03 Nov 2021 22:52:31 +0800
Date:   Wed, 3 Nov 2021 22:52:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] crypto: x86/aes-ni: fix AVX detection
Message-ID: <20211103145231.GA4485@gondor.apana.org.au>
References: <20211103124614.499580-1-mlevitsk@redhat.com>
 <622444d6-f98b-dae4-381e-192e5cb02621@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622444d6-f98b-dae4-381e-192e5cb02621@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 07:43:43AM -0700, Dave Hansen wrote:
>
> The kernel shouldn't crash in this case.  We've got a software
> dependency which should disable AVX2 if AVX is off:

It's qemu, I thought it was a qemu bug but Paulo disagrees.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
