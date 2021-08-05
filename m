Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2EC3E12E9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbhHEKpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240567AbhHEKpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:45:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55474610A2;
        Thu,  5 Aug 2021 10:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628160285;
        bh=uuSRXYUJQ2JKiO34YmHy3eRsJCTq+2osVujjet2YoSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5fFIDKpEQqHZES1HDS2KqGrRmS5vmbs3T5gCq9mRdH21BAwiPdubDWAAeBJk+zsH
         AyvjtuWhXueguC7sMPcj3aw03+FIVOJQ4Dj/oy/Vzcu9KNZ4nisNFg9Nfvqh8efVqp
         HgJCo6Sr9rfJDSV0/mH98HHq0R8uyPrHOexFxoAk=
Date:   Thu, 5 Aug 2021 12:44:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: core: Change the length of an array
Message-ID: <YQvBG0FDoQu/koJL@kroah.com>
References: <20210802203020.9679-1-fmdefrancesco@gmail.com>
 <20210803061441.GK25548@kadam>
 <YQjgN/Xx5LUYtzz0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQjgN/Xx5LUYtzz0@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 08:20:39AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 03, 2021 at 09:14:42AM +0300, Dan Carpenter wrote:
> > On Mon, Aug 02, 2021 at 10:30:20PM +0200, Fabio M. De Francesco wrote:
> > > IPX_NODE_LEN == 6, while addr.f1 should only have 4 elements.
> > > Replace IPX_NODE_LEN with 4. In the while, remove the excess spaces
> > > before the fields of the union.
> > > 
> > > Fixes: 56febcc2595e ("staging: r8188eu: Fix different base types in assignments and parameters")
> > 
> > Ugh...  I really feel we'd be better off reverting that patch entirely.
> 
> I do too, let me go revert that...
> 

Now reverted.
