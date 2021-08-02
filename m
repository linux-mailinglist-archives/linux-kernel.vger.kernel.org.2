Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45A3DD260
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhHBIxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233133AbhHBIxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:53:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA26361057;
        Mon,  2 Aug 2021 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627894380;
        bh=GampQJdffLH3LWj8rSzcVbwCXl5Q0N87A/M7/gwDYh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DSCIW9vYa3UVCGR1Q2/UZxAj4OXiaDwrpGgRENfpm6bAuZhh/oOYT/9G2hwztYGDf
         5+MAhYbLMkpza5glUYE7naCWsPSifGkP96D+8drUpDOQ8prSVffOcXKEr09xI5Yisz
         pOJywEcrz6yovZnRs+tqUecVf4Ah05cQpi2UukZTdra63cvN02I8Fib03N4bzLMJ2H
         g8jsG6mXVyoMUAJxy/DcGDNJfYHBRWxeLvNwKY0V8bHyjAi2QRUmPkX3/7HfhX6pqM
         7+JwC5u8vjnprzMz1lERm+/wp205OSv5CpS+/cvOOsVItQGYYyRmPkM0bMAzNWq+9O
         aMDiUyFoHWyhQ==
Date:   Mon, 2 Aug 2021 11:52:57 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Message-ID: <20210802085257.ia3uloyco4gj7yxp@kernel.org>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-3-tony.luck@intel.com>
 <141602a3-ef61-01f0-4a3c-69f8e7012fcd@intel.com>
 <20210730003809.hp3nmqmgyysa45nz@kernel.org>
 <YQQsz/tvrQpqAbpX@google.com>
 <b7b6aabd-1f10-1b21-eaeb-102ead2989cd@intel.com>
 <20210730184400.GA1521057@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730184400.GA1521057@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 11:44:00AM -0700, Luck, Tony wrote:
> On Fri, Jul 30, 2021 at 09:50:59AM -0700, Dave Hansen wrote:
> > On 7/30/21 9:46 AM, Sean Christopherson wrote:
> > > Out of curiosity, on multi-socket systems, are EPC sections clustered in a single
> > > address range, or are they interleaved with regular RAM?  If they're clustered,
> > > you could track the min/max across all sections to optimize the common case that
> > > an address isn't in any EPC section.
> > 
> > They're interleaved on the systems that I've seen:
> > 
> > 	Socket 0 - RAM
> > 	Socket 0 - EPC
> > 	Socket 1 - RAM
> > 	Socket 1 - EPC
> > 
> > It would probably be pretty expensive in terms of the physical address
> > remapping resources to cluster them.
> 
> I thought xarray was overkill ... and it is ... but it makes the code
> considerably shorter/simpler!
> 
> I think I'm going to go with it. Thanks to Jarkko for the suggestion.

If it makes the code considerably simpler, that in my opinion justifies the
minor size increase.

/Jarkko
