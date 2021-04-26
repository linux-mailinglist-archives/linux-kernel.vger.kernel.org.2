Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63536B751
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhDZQ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235018AbhDZQ5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:57:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61A6261077;
        Mon, 26 Apr 2021 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456185;
        bh=FGAsHwfLwgWxRoNTb3DZ0REvRPDMMG+dUYfqK1AcTTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aq+hfXGZAGD9ysw8wP9TM4DPtSbZeanWjHLleZAPer1OTxNF8uXAIaB7+Wksxs1hL
         FKl4QxsFRkvt8DTfE+IIc6BvQX2L4CGegLhE26SEZSQZfhfAA18aaa+LvoWwBIvzPO
         STVcMgDebO3IM36WcNQqYgdqCklwTZwba1eky5Yw=
Date:   Mon, 26 Apr 2021 18:56:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 054/190] Revert "clk: samsung: Remove redundant check in
 samsung_cmu_register_one"
Message-ID: <YIbwtmtY1Bn6CgHb@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-55-gregkh@linuxfoundation.org>
 <05bd90cf-e761-9ade-388c-7b78a0ed716a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05bd90cf-e761-9ade-388c-7b78a0ed716a@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 09:09:21AM +0200, Krzysztof Kozlowski wrote:
> On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> > This reverts commit 8d7a577d04e8ce24b1b81ee44ec8cd1dda2a9cd9.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: https
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/clk/samsung/clk.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> > index 1949ae7851b2..dad31308c071 100644
> > --- a/drivers/clk/samsung/clk.c
> > +++ b/drivers/clk/samsung/clk.c
> > @@ -356,6 +356,10 @@ struct samsung_clk_provider * __init samsung_cmu_register_one(
> >  	}
> >  
> >  	ctx = samsung_clk_init(np, reg_base, cmu->nr_clk_ids);
> > +	if (!ctx) {
> > +		panic("%s: unable to allocate ctx\n", __func__);
> > +		return ctx;
> > +	}
> 
> Hi Greg,
> 
> The commit was fine here, so please keep it. NAK for the revert.

Now dropped, thanks!

greg k-h
