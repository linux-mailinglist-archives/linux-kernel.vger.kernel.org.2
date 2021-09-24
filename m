Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB5416D75
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbhIXIKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:10:21 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55466 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244496AbhIXIKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:10:20 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mTgGE-00085u-JO; Fri, 24 Sep 2021 16:08:46 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mTgGC-0003SF-88; Fri, 24 Sep 2021 16:08:44 +0800
Date:   Fri, 24 Sep 2021 16:08:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Michael Walle <michael@walle.cc>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: caam: disable pkc for non-E SoCs
Message-ID: <20210924080844.GB13213@gondor.apana.org.au>
References: <20210915220307.3079917-1-michael@walle.cc>
 <0b8ae053-698b-2c03-c729-c4c86ba79550@nxp.com>
 <936221D6-08D2-4656-86AF-DC921E3CB14A@walle.cc>
 <1517fbd7-8f23-f5f5-983d-469a1856bbe8@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517fbd7-8f23-f5f5-983d-469a1856bbe8@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 05:26:45PM +0300, Horia Geantă wrote:
>
> >>> it is still reported as available, that is the number of instances is
> >>> non-zero, but it has limited functionality. In particular it doesn't
> >>> support encryption and decryption, but just signing and verifying. This
> >>> is indicated by a bit in the PKHA_MISC field. Take this bit into account
> >>> if we are checking for availablitly.
> >> typo:			 ^ availability
> > 
> > If there is nothing else wrong, could this be fixed while applying?
> > 
> Fine by me, but Herbert will have to do this.

I fixed the typo while applying this.

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
