Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE6402A66
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhIGOI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhIGOIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:08:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAAAF6103B;
        Tue,  7 Sep 2021 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631023637;
        bh=+6pq5RkAoSIUZfooNDRh1HsK7vTGdlktLrMWVjASe44=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QjGn5Z9WvN50IBXQt4+0/uMA1Nsheh/VG4nYFnb+d298Hzj4pdS4YllRxdiOoDQCM
         j4cvrq+M5qrWFEnOgz8SqW7Io+tku7z5ZuLMnTITy3/ZgYBAg2TAkyyNqiOIx9OUhI
         pls72UWzM93Fx9OOJie5iJpqfZO2oz7Op1Olpee9+Q4RSsiss15iNqn8bZo4xI/nFt
         VSRlvMUBIkOHhzag/Lv+2+1HMgGPcNQNhY84AYTdvfhCJ4Z6j5nsbqGBbc4rAaaJG+
         VwYHGp+9QvK/g0OaSnL58fD9Dshc2FBE1hdk5/fUHdwKHKHl/cihpR8sbK9jrEvrwp
         k3UVuo8G0nqFA==
Message-ID: <848905ffa20cf234446b16682cbbcf1e56853950.camel@kernel.org>
Subject: Re: [PATCH v4 5/6] x86/sgx: Hook sgx_memory_failure() into mainline
 code
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Cc:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 07 Sep 2021 17:07:14 +0300
In-Reply-To: <25db682402d14c34af9ba525cffe85c5@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-6-tony.luck@intel.com>
         <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
         <681d530d72de842c8bf43733c11f3c3f2ebf8c6e.camel@kernel.org>
         <25db682402d14c34af9ba525cffe85c5@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-09-06 at 18:51 +0000, Luck, Tony wrote:
> On Fri, 2021-09-03 at 09:12 +0300, Jarkko Sakkinen wrote:
> > On Fri, 2021-08-27 at 12:55 -0700, Tony Luck wrote:
> > > +#ifdef CONFIG_X86_SGX
> > > +int sgx_memory_failure(unsigned long pfn, int flags);
> > > +bool sgx_is_epc_page(u64 paddr);
> > > +#else
> > > +static inline int sgx_memory_failure(unsigned long pfn, int flags)
> > > +{
> > > +	return -ENXIO;
> > > +}
> > > +
> > > +static inline bool sgx_is_epc_page(u64 paddr)
> > > +{
> > > +	return false;
> > > +}
> > > +#endif
> >=20
> > These decl's should be in arch/x86/include/asm/sgx.h, and as part of
> > patch that contains the implementations.
>=20
> But I need to use these functions in arch independent code.  Specifically=
 in
> mm/memory-failure.c and drivers/acpi/apei/einj.c
>=20
> If I just #include <asm/sgx.h> in those files I'll break the build for ot=
her
> architectures.

What does specifically break the build?

/Jarkko
