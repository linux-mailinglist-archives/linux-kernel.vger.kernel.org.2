Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5BE3A932D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhFPGyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231455AbhFPGyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:54:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A5C661164;
        Wed, 16 Jun 2021 06:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623826359;
        bh=qTFDHzODbPzqXY9UfRAdRA5d+yym2wIiYpO2f1PU/bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XthdH5JeVo8V7KATLPy3nv6h1NnUpVOt2wzrGK3bWxoq4AnrII2VMsi7YAFd1PRa3
         RCB3zmxv+NRuURNLTvgJ722Y97s6BXeN1fr+G/whKvMU5z+DevhG2nkyAm9tYBE5as
         Ac+ezbtCnuiA4bWj8OZ8zu4jOMIYRuZWN0iunRks=
Date:   Wed, 16 Jun 2021 08:52:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thorsten Scherer <t.scherer@eckelmann.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/1] siox: Simplify error handling via dev_err_probe()
Message-ID: <YMmfszfP5pIqJcvL@kroah.com>
References: <20210616061736.3786173-1-t.scherer@eckelmann.de>
 <20210616061736.3786173-2-t.scherer@eckelmann.de>
 <20210616064446.l76d7evhgf55iy52@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210616064446.l76d7evhgf55iy52@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 08:44:46AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Jun 16, 2021 at 08:17:36AM +0200, Thorsten Scherer wrote:
> > commit a787e5400a1c ("driver core: add device probe log helper")
> > introduced a helper for a common error checking pattern.  Use it.
> > 
> > Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> @gregkh: You used to take siox patches, can you please do that for this
> patch, too?

Sure, will be glad to take this, thanks.

greg k-h
