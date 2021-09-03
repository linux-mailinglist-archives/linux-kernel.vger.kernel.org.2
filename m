Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024953FFA28
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244587AbhICGOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236242AbhICGOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:14:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E1826102A;
        Fri,  3 Sep 2021 06:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630649581;
        bh=L1P9QokrorTJ7b4vh+JmxBeBnSGGbsF7TDkZtkCRRB4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q8qa3mC52Ezw8CMP1IfGrIyXjQ/3gROhCN2r3ZP/J7cAutPfncsNz1AtLbzTrSfJJ
         hKHb2mLsHTgUIWJ1RQTBWh6KKSlg0w57mT4YBHejjhZ8/nYZkZiQTdQZcUgkrS9kTz
         U5CoapkxayhRarcDjAvaY4g5iK0Q7Wq/mQxxwkjv9MsXxtBrf7Qk0q5rh3cLP92Pjl
         kuDGjJv5sQza/c0BkAkjEmplmEM8MyoeFmfxKxvy5EQr3aMJ2Zz7TfMoMbZTjZloC/
         8qkecNbuo6sWBGV2afqVjacB8NQ+kkW/WSophw/Q3HvXmGMV1oGdyS0Cq0pG+yEHYW
         +r8QA/QG84Caw==
Message-ID: <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
Subject: Re: [PATCH v4 5/6] x86/sgx: Hook sgx_memory_failure() into mainline
 code
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Sep 2021 09:12:58 +0300
In-Reply-To: <20210827195543.1667168-6-tony.luck@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-6-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-27 at 12:55 -0700, Tony Luck wrote:
> +#ifdef CONFIG_X86_SGX
> +int sgx_memory_failure(unsigned long pfn, int flags);
> +bool sgx_is_epc_page(u64 paddr);
> +#else
> +static inline int sgx_memory_failure(unsigned long pfn, int flags)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline bool sgx_is_epc_page(u64 paddr)
> +{
> +	return false;
> +}
> +#endif

These decl's should be in arch/x86/include/asm/sgx.h, and as part of
patch that contains the implementations.

/Jarkko

