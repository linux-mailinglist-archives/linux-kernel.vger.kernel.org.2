Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085F439A027
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFCLwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:52:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60596 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhFCLwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:52:07 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lolrc-00018j-H3; Thu, 03 Jun 2021 19:50:16 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lolrX-0000WU-RI; Thu, 03 Jun 2021 19:50:11 +0800
Date:   Thu, 3 Jun 2021 19:50:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: algboss - Replaced simple_strtol() with
 kstrtouint()
Message-ID: <20210603115011.GA1988@gondor.apana.org.au>
References: <20210524120834.1580343-1-liushixin2@huawei.com>
 <YKwhXlrJzdOjS9lJ@gmail.com>
 <20210603081238.GA1160@gondor.apana.org.au>
 <cbb52d9a-af7a-b920-0471-1efe0ee480e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbb52d9a-af7a-b920-0471-1efe0ee480e2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 06:53:00PM +0800, Liu Shixin wrote:
>
> Besides, I noticed that type CRYPTOA_UNSPEC has never been used, should I remove it together?

No please leave it alone.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
