Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A1382277
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 03:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhEQBHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 21:07:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:45562 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhEQBHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 21:07:10 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.89 #2 (Debian))
        id 1liRhf-0000jx-4P; Mon, 17 May 2021 09:05:51 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1liRha-0005QV-KF; Mon, 17 May 2021 09:05:46 +0800
Date:   Mon, 17 May 2021 09:05:46 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] poly1305: Make prototypes match
Message-ID: <20210517010546.bpv4752q3njptdzv@gondor.apana.org.au>
References: <20210425211325.3157769-1-ak@linux.intel.com>
 <20210514104813.wvdvviyoyo6pqbhw@gondor.apana.org.au>
 <20210514141355.3rvfysiluo3udfga@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514141355.3rvfysiluo3udfga@two.firstfloor.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:13:57AM -0700, Andi Kleen wrote:
> 
> I thought it was already fixed by Arnd? I think I collided with him.

Nevermind, you are right Andi.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
