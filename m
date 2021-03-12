Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0607338E76
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhCLNNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:13:17 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54506 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231436AbhCLNMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:12:51 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lKhay-0006G9-R1; Sat, 13 Mar 2021 00:12:49 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Mar 2021 00:12:48 +1100
Date:   Sat, 13 Mar 2021 00:12:48 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] crypto: ccp - Don't initialize SEV support without the
 SEV feature
Message-ID: <20210312131248.GG31502@gondor.apana.org.au>
References: <c1ea9899e6169bf3a3042866e165a2f90bda3ebd.1614810669.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ea9899e6169bf3a3042866e165a2f90bda3ebd.1614810669.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 04:31:09PM -0600, Tom Lendacky wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> If SEV has been disabled (e.g. through BIOS), the driver probe will still
> issue SEV firmware commands. The SEV INIT firmware command will return an
> error in this situation, but the error code is a general error code that
> doesn't highlight the exact reason.
> 
> Add a check for X86_FEATURE_SEV in sev_dev_init() and emit a meaningful
> message and skip attempting to initialize the SEV firmware if the feature
> is not enabled. Since building the SEV code is dependent on X86_64, adding
> the check won't cause any build problems.
> 
> Cc: John Allen <john.allen@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
