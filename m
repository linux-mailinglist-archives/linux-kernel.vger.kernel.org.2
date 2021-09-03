Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935AD3FFABF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347488AbhICG5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347087AbhICG5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:57:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7787B60231;
        Fri,  3 Sep 2021 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630652163;
        bh=AKJqf4REVrL60CH7L/7m+mBMFtIF9TJI0PvNB5nOnxU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=udwLZJqAwtTGg66C/uvVMkj3CvvTzWTQK8+Hq27xDSvE/DbGznpB04yGh8xboiN5T
         FhixZhGGE1JtTSYdTlvpPze1pMZevX81oNMg0oJtHEh2ihC07s0lNMbSPjFXkGRYsc
         eiz5V8+QTguo2EuEzFvg+Thy/0T7DvuYyLm1dx35kSGpat+O1r1K29KivMc3s+0K6U
         apjBVtfLgjzWex2Rt5P/990rHNyRp4s9rG7Hma14YzfrROYsc6FRqWOPmEdSm6LRbr
         3UDDDM4n6V4oTcyKjnsVSSqxKjpBBgq1S4QC9kGBorNxlgP8L4FsBWd2DGDA/h2PMI
         OpirGoMkz3F6A==
Message-ID: <681d530d72de842c8bf43733c11f3c3f2ebf8c6e.camel@kernel.org>
Subject: Re: [PATCH v4 5/6] x86/sgx: Hook sgx_memory_failure() into mainline
 code
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Sep 2021 09:56:00 +0300
In-Reply-To: <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-6-tony.luck@intel.com>
         <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-03 at 09:12 +0300, Jarkko Sakkinen wrote:
> On Fri, 2021-08-27 at 12:55 -0700, Tony Luck wrote:
> > +#ifdef CONFIG_X86_SGX
> > +int sgx_memory_failure(unsigned long pfn, int flags);
> > +bool sgx_is_epc_page(u64 paddr);
> > +#else
> > +static inline int sgx_memory_failure(unsigned long pfn, int flags)
> > +{
> > +	return -ENXIO;
> > +}
> > +
> > +static inline bool sgx_is_epc_page(u64 paddr)
> > +{
> > +	return false;
> > +}
> > +#endif
>=20
> These decl's should be in arch/x86/include/asm/sgx.h, and as part of
> patch that contains the implementations.

To align with this, I wrote a small patch:

https://lore.kernel.org/linux-sgx/20210903064156.387979-1-jarkko@kernel.org=
/T/#u

/Jarkko
