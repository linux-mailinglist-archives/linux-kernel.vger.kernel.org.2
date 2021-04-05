Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE91353C67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhDEIbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 04:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhDEIbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 04:31:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A0556138A;
        Mon,  5 Apr 2021 08:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617611491;
        bh=4h+3V9BjLvedrsA7WoinA5RtgLJESAo1x/zGN78m6w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aln2MlR32CE3jYHBOtdofAc6y6FPQk2w2FWjPg2YQMOZ0ESH3lseWv1CN7EW3taRK
         wOfLtJbPPs0pfPBiQME579aTAUAv2jCPAiDpfbSZmIDJaP0wOo1GD7LCnSHlsInxxu
         L8+0jg94uinFclmeiTlHi6S0c7Vw0eX7kAz/mVI4=
Date:   Mon, 5 Apr 2021 10:31:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel@pengutronix.de,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] driver core: add helper for deferred probe reason
 setting
Message-ID: <YGrK4Swr6qnq09VX@kroah.com>
References: <20210323153714.25120-1-a.fatoum@pengutronix.de>
 <20210323153714.25120-2-a.fatoum@pengutronix.de>
 <55ed4f2d-70f6-9ee0-731c-8a7b3a379aa0@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ed4f2d-70f6-9ee0-731c-8a7b3a379aa0@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 10:27:56AM +0200, Ahmad Fatoum wrote:
> Hello Greg,
> 
> On 23.03.21 16:37, Ahmad Fatoum wrote:
> > We now have three places within the same file doing the same operation
> > of freeing this pointer and setting it anew. A helper makes this
> > arguably easier to read, so add one.
> > 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> are there still objections to this patch?
> Patch 1 was applied, should I resend without?

No, I'll queue this up now, I wanted patch 1 to show up in my "next"
branch first, it's now there, give me a chance to catch up on patches...

thanks,

greg k-h
