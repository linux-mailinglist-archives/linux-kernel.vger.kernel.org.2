Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C82353305
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhDCHvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232157AbhDCHvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:51:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 349E361166;
        Sat,  3 Apr 2021 07:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617436262;
        bh=rGx2RlrFnBUXUoslVGAxfcreAkeLNxmJ3ZBe2T7O+SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4B1Cl2jnN0sUQVn588rlmSJ7DsE25M2ovtIok3HeV4cG5JOYY/OxrFfpR2U93QB+
         2ty9IV7xphKmat8HHD6v+67GbjjDD0lC3CBg26O+7QBGLtZAkp74WTIPUbUg3L7taz
         EnMYKyBFQp///Y4hiOCcYjj8aW4wt33o7wlC0XeI=
Date:   Sat, 3 Apr 2021 09:50:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/30] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_xmit.c
Message-ID: <YGgeY4Q0MIvyx1FY@kroah.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
 <34b6f0b80cd3913722b258e9554dbc77268fb2bf.1617384172.git.fabioaiuto83@gmail.com>
 <YGgb2Mtzyp79elQ6@kroah.com>
 <20210403074805.GB1563@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403074805.GB1563@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 09:48:06AM +0200, Fabio Aiuto wrote:
> On Sat, Apr 03, 2021 at 09:40:08AM +0200, Greg KH wrote:
> > On Fri, Apr 02, 2021 at 07:29:43PM +0200, Fabio Aiuto wrote:
> > > remove all RT_TRACE logs
> > > 
> > 
> > I don't mean to be a pain, but this changelog text needs some work.
> > 
> > This says _what_ it does, but not _why_ you are doing this.  The kernel
> > documentation has a section on how to write a good changelog text, you
> > might want to look at that.
> 
> you are right, I spent time writing the cover, but not the changelog which
> will remain in kernel history

Take portions of what you write in the cover letter, into the changelog
for the patches.  Or the other way around is also good, depending on
which you write first :)

thanks,

greg k-h
