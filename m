Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35786432D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhJSFxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233749AbhJSFxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 336B060F46;
        Tue, 19 Oct 2021 05:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634622679;
        bh=uaEXJ3RE9jDoGR1866eq9CZgtVSDD9EmXddcscP6CJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1jaYZVkWljjguq/uRaCDjXbZY1d/6YWziRxEud/fdl9psi8BrjDBtxRFal8UnYmp
         TADTAABlj8C415f3G1lme89lH/PXQNy4JkPpcu/xTOY3dmzXqGOeyLdPiY5xciQJgn
         Ym44euzflVaqfq4paOqvmHy9Y9RU3ekgzBxbirCI=
Date:   Tue, 19 Oct 2021 07:51:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: r8188eu: Remove redundant 'if' statement
Message-ID: <YW5c1BpyTKV5YpMC@kroah.com>
References: <20211017142812.4656-1-fmdefrancesco@gmail.com>
 <20211017142812.4656-4-fmdefrancesco@gmail.com>
 <YW2H63JAWKcM6+hL@kroah.com>
 <2162009.ybMk9oByy7@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2162009.ybMk9oByy7@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 06:28:46PM +0200, Fabio M. De Francesco wrote:
> On Monday, October 18, 2021 4:42:51 PM CEST Greg Kroah-Hartman wrote:
> > On Sun, Oct 17, 2021 at 04:28:12PM +0200, Fabio M. De Francesco wrote:
> > > Remove a redundant 'if' statement.
> > > 
> > > Acked-by: Martin Kaiser <martin@kaiser.cx>
> > > Acked-by: Phillip Potter <phil@philpotter.co.uk>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >  drivers/staging/r8188eu/core/rtw_cmd.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > 
> > Why is there not a "v2" in the subject line like the other patches in
> > this series?
> 
> Simply because I edited manually the "Subject" and overlooked to write "v2".

'git format-patchj -v 2' is your friend.

