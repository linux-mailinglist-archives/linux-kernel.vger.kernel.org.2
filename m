Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CAA38CC32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhEURc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232526AbhEURcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:32:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5347161168;
        Fri, 21 May 2021 17:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621618292;
        bh=OG23lV2iBZOz9Wi57t4JrGC9Btm0OCvWAaAL5rT2Rhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSkYUhxHlXxUdKGYyTuDBpRttRih5xw+K1i19km6VOo4CE97qB612nkgEm3ijjhER
         2oWoTLN3UZVDcLgbzhNTf8Z3POtH3R8+ua8p6WKTMSGDWOW0uhsbKoUAzHEUZ8LwP4
         nh+3DEiOoF/YDgTQVLUY45/buDwSwsfE+EhqsYkiRHmAkYP9/FShvTFkCSSf3cLFZb
         s5H6p+CeBJ8AizHqbOdsXZ4Bnn2uCTkQDx4KyWugRW//K7ID0FHpsOIs7F6lmKdGR6
         nhDcFUebNoqHPS7UdJ2x9VBYRe54erOsLz+5bmlc2jVxJsgAglQFe2q79B/17wkpEL
         eLSYY2CdexIYg==
Date:   Sat, 22 May 2021 02:31:25 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>
Subject: Re: [BISECTED] nvme probe failure with v5.13-rc1
Message-ID: <20210521173125.GC29013@redsun51.ssa.fujisawa.hgst.com>
References: <40071b11108987556d0473f9d968fe7dcd3f304a.camel@intel.com>
 <20210521145705.GA29013@redsun51.ssa.fujisawa.hgst.com>
 <e8ad9de961f3bfcb748733b59c189aa577ffa1fd.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ad9de961f3bfcb748733b59c189aa577ffa1fd.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 04:50:15PM +0000, Verma, Vishal L wrote:
> 
> Thanks for looking into it - yes with that the problem goes away.
> Let me chat with the simics folks and see if I can get them to fix it.

Thanks for confirming. It sounds like the simics implementation is
missing a default case in its identify function's CNS check and simply
loses track of the command. I'd wager it probably also times out for any
reserved or unsupported CNS value.
