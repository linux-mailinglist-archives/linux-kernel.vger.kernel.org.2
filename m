Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50A4402B56
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbhIGPJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231362AbhIGPJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:09:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54415610FE;
        Tue,  7 Sep 2021 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631027313;
        bh=wb3iMuE8+dgGBp7mPY7dLBqnaPDERTiGYW/cvaJFmj4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ES2OUYneQn0YkL+UU5T4YP55gCC2ZcCmPLcAWwLonU9V4r1D1sY1QpnmexpxigVJI
         cxdNeeXcsqM8GaOhtOKW9Ok91tkiDfRlX/ugxGQsl8WIShwnHVv5osnRXszISn5ZSW
         OjBgRUy4qqLQnct8zk9tqhgaiFuIM8Dbmd2gi/SGX0m2LmTJYzCeVqpwAAVrx7ZdQV
         +4Vbi2gR7jZeQPal6+qAj+5gikK2FrCQCZLgHA0vE18tlL5a2XqdOQk6z2IEFw3WQr
         m0yK+I8KDu0rcJwN2JJmm6QbkYdgBHSzB2QgV7Yq0LeFmpRjGpRRqC1/V8D9MfaZaK
         aSh0Ngx2P5FZg==
Message-ID: <250de8f97efe2458afc39f080c3ef6a55f42623c.camel@kernel.org>
Subject: Re: [PATCH v4 5/6] x86/sgx: Hook sgx_memory_failure() into mainline
 code
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Cc:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 07 Sep 2021 18:08:31 +0300
In-Reply-To: <40da1a9a7d5f41bb9b82ea2cbebce73a@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-6-tony.luck@intel.com>
         <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
         <681d530d72de842c8bf43733c11f3c3f2ebf8c6e.camel@kernel.org>
         <25db682402d14c34af9ba525cffe85c5@intel.com>
         <848905ffa20cf234446b16682cbbcf1e56853950.camel@kernel.org>
         <40da1a9a7d5f41bb9b82ea2cbebce73a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-07 at 15:03 +0000, Luck, Tony wrote:
> > > If I just #include <asm/sgx.h> in those files I'll break the build fo=
r other
> > > architectures.
> >=20
> > What does specifically break the build?
>=20
> There is no file named arch/arm/include/asm/sgx.h (ditto for other archit=
ectures that build memory-failure.c and einj.c).
>=20
> -Tony

Would it be too obnoxious to flag that include in those files?

/Jarkko
