Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9A43D96F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhJ1CpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:45:23 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56364 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhJ1CpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:45:22 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mfvNW-00018y-EH; Thu, 28 Oct 2021 10:42:54 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mfvNN-0007VG-J9; Thu, 28 Oct 2021 10:42:45 +0800
Date:   Thu, 28 Oct 2021 10:42:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolai Stange <nstange@suse.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH 8/8] crypto: api - make the algorithm lookup priorize
 non-larvals
Message-ID: <20211028024245.GA28789@gondor.apana.org.au>
References: <20211003181413.12465-1-nstange@suse.de>
 <20211003181413.12465-9-nstange@suse.de>
 <20211008115432.GC26495@gondor.apana.org.au>
 <87lf30rmd8.fsf@suse.de>
 <20211022115146.GA27997@gondor.apana.org.au>
 <87zgqupz41.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgqupz41.fsf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:59:26AM +0200, Nicolai Stange wrote:
>
> Hmm, I checked a couple of crypto/drivers and it seems like not all are
> setting this flag: random examples would include cavium/nitrox/,
> chelsio/, padlock*.c, vmx/, ...

For padlock and vmx this is correct as they're just like aesni.

The others are omissions and should be fixed.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
