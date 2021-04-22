Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD2367B56
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhDVHq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:46:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48704 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhDVHqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:46:25 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lZU1w-0002yH-Il; Thu, 22 Apr 2021 17:45:45 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 22 Apr 2021 17:45:44 +1000
Date:   Thu, 22 Apr 2021 17:45:44 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Gowtham Tammana <g-tammana@ti.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Update dt-bindings and sa2ul driver for AM64x SoCs
Message-ID: <20210422074544.GC14354@gondor.apana.org.au>
References: <20210316220558.GA3754419@robh.at.kernel.org>
 <20210413091559.154169-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413091559.154169-1-vaibhavgupta40@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:45:56PM +0530, Vaibhav Gupta wrote:
> From: Vaibhav Gupta <v_gupta@ti.com>
> 
> This patch series aims to modify necessary files before an entry for sa2ul
> can be made in the respective am64 device tree.
> 
> v2?
>   - Simplify the dt-binding changes.
> 
> Peter Ujfalusi (3):
>   dt-bindings: crypto: ti,sa2ul: Add new compatible for AM64
>   crypto: sa2ul: Support for per channel coherency
>   crypto: sa2ul: Add support for AM64
> 
>  .../devicetree/bindings/crypto/ti,sa2ul.yaml  |  24 +++-
>  drivers/crypto/sa2ul.c                        | 133 ++++++++++++------
>  drivers/crypto/sa2ul.h                        |   4 +
>  3 files changed, 120 insertions(+), 41 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
