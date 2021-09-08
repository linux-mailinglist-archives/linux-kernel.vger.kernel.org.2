Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED84032A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 04:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347357AbhIHCa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 22:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345608AbhIHCaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:30:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0847160F0F;
        Wed,  8 Sep 2021 02:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631068156;
        bh=JhJZWLPxZetxNlG1RFUDUGFWSZ/6Xdfv1We2iCjoEPs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tHnRDv6NKvSzxm68VtH9Voyq2o19bE10bE+/25F1f1z3QakgpoxbzAYdVUJs24lHF
         aD9F23f3S61h/9sYvq/9QvzBba/8iDCBfGBECWyjgydxs45lrd7VHyRaWQERR8G5Mx
         K9CRYuG/wmnWpFU09vPOybEKVwHwCaEKnz9ctd4hAFMB/Jy22vXvuBCFxAAVDfnEIy
         IR9KCTOrIEiIy/SFU1Y7uUCiNd5iYRdjamcFiLGSehH7fYAkItxC694R3h1EQ4FtW9
         WwFwfsOyLVZ2vkHyVnFvRKaCMHxSsSpKm1MPUEDs946vDemk/5zxfkhLowthi83R2y
         u3JG7GjLCw6Tg==
Message-ID: <97928561eb5b4a7fd677eaba3d376c83352571a2.camel@kernel.org>
Subject: Re: [PATCH v4 5/6] x86/sgx: Hook sgx_memory_failure() into mainline
 code
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Cc:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 08 Sep 2021 05:29:13 +0300
In-Reply-To: <e0280b82cf964a0797293b0c8e302777@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-6-tony.luck@intel.com>
         <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
         <681d530d72de842c8bf43733c11f3c3f2ebf8c6e.camel@kernel.org>
         <25db682402d14c34af9ba525cffe85c5@intel.com>
         <848905ffa20cf234446b16682cbbcf1e56853950.camel@kernel.org>
         <40da1a9a7d5f41bb9b82ea2cbebce73a@intel.com>
         <250de8f97efe2458afc39f080c3ef6a55f42623c.camel@kernel.org>
         <e0280b82cf964a0797293b0c8e302777@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-07 at 17:46 +0000, Luck, Tony wrote:
> > Would it be too obnoxious to flag that include in those files?
>=20
> Jarkko,
>=20
> You mean:
>=20
> #ifdef CONFIG_X86_SGX
> #include <asm/sgx.h>
> #endif
>=20
> in mm/memory-failure.h?
>=20
> That wouldn't help. I need the do-nothing stub definition on other archit=
ectures.
>=20
> I'm going to explore Dave's suggestion of changing the names to something=
 less sgx specific.
>=20
> -Tony


Ah sorry, I get it :-) Yeah, Dave's suggestion makes much more sense.

/Jarkko
