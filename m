Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE740FA1D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhIQOZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233452AbhIQOZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:25:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 257DA60EB2;
        Fri, 17 Sep 2021 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631888657;
        bh=D3iclerjs1yfwe1iw8xdpKqn4WmBdxHj82MZ1c0LB3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmBt9+j8+48lPT3uROFUvfZyl7E+lnetnrZwzpKvwdC1Q+tubAYRBSjLcH3+ArLDK
         y1DZMvAPJqvUj0PmNBBp/3zC7oY+mBRxVR5SsCRkELmMuHeveaZwo4O0E5md5fJfJZ
         14aQ5MxAY/0nSSCMLSFl/NcRJi1b0lLdUhA6ElA8=
Date:   Fri, 17 Sep 2021 16:24:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Srivathsa Dara <srivathsa729.8@gmail.com>,
        jerome.pouiller@silabs.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: sta: Fix 'else' coding style warning
Message-ID: <YUSlD7sS3bFNZ/M+@kroah.com>
References: <20210914143107.18436-1-srivathsa729.8@gmail.com>
 <20210914145643.GE2088@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914145643.GE2088@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 05:56:43PM +0300, Dan Carpenter wrote:
> On Tue, Sep 14, 2021 at 08:01:06PM +0530, Srivathsa Dara wrote:
> > Fix 'else is not generally useful after a break or return' checkpatch
> > warning
> > 
> > Signed-off-by: Srivathsa Dara <srivathsa729.8@gmail.com>
> 
> It doesn't apply for me.  Please check that you are working against
> staging-next or linux-next.

It applied for me, odd.


