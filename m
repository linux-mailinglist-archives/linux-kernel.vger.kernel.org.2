Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0788937B0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhEKVr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhEKVr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:47:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8E3461628;
        Tue, 11 May 2021 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620769609;
        bh=yQ5/e8IUju67X6+70qV5Ek399SBWebFRuJc27jgg3as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1ikvOxt3Ug+YIjZgxvz/wNXfZwzjxatli9+qeX6baqqRqjxx/3WDMn6kYRY/rvg/
         8httbkC9/PJN8FuuTgZf6ICCwdBwDfje9SVhtfsxv8/trfxxpurcyf6KQTAquz4l9Z
         8591X4jt8KsrV4Bi4uhGzzOMBHzlii3qLFf160axu4UAykhj7XxZ7KowrHV7g/ubuo
         5Wrfvi1IXnD+eZ9HhjaiEx6XsGCmgWM3EOf4DXUNoz1tOI5xwtEPZdaxFnG1+R9Lg8
         RwKCBRUG9rBbYPQJ/Qm0Nb+9dHnTpqZrT6z7XmfNnhBpF76mE9pcnCJSs0Kxb9tMJZ
         mfeAgjsEpPK7A==
Received: by pali.im (Postfix)
        id 0094A9DD; Tue, 11 May 2021 23:46:46 +0200 (CEST)
Date:   Tue, 11 May 2021 23:46:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 mvebu + mvebu/dt64 1/6] firmware: turris-mox-rwtm: fix
 reply status decoding function
Message-ID: <20210511214646.qifskipplwmjvqex@pali>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210429083636.22560-1-pali@kernel.org>
 <YI/rGQfWdMdanPcN@lunn.ch>
 <20210505180433.550178c8@thinkpad>
 <YJLF3hRmT1UsxJ3k@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJLF3hRmT1UsxJ3k@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 May 2021 18:20:46 Andrew Lunn wrote:
> On Wed, May 05, 2021 at 06:04:33PM +0200, Marek Behún wrote:
> > On Mon, 3 May 2021 14:22:49 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> > > On Thu, Apr 29, 2021 at 10:36:31AM +0200, Pali Rohár wrote:
> > > > From: Marek Behún <kabel@kernel.org>
> > > > 
> > > > The status decoding function mox_get_status() currently contains a dead
> > > > code path: if the error status is not MBOX_STS_SUCCESS, it always
> > > > returns -EIO, so the comparison to MBOX_STS_FAIL is never executed and
> > > > we don't get the actual error code sent by the firmware.
> > > > 
> > > > Fix this.
> > > > 
> > > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > > Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")  
> > > 
> > > You have put a fixes tag here, meaning you want it in stable? How does
> > > dead code elimination fulfil the stable requirements?
> > > 
> > > Do any of these changes contain real fixes?
> > > 
> > >    Andrew
> > 
> > Andrew, this is not dead code elimination.
> 
> Please word you commit message differently.
> 
> The status decoding function mox_get_status() currently contains an
> incorrect check: ...
> 
> 	  Andrew

Andrew, Marek has already updated commit message and I have sent a new
version v3 of this patch series with this update. It is OK now?
