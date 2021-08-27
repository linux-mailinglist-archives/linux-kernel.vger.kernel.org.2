Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65F63F9AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhH0OT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232641AbhH0OTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B82D060FF2;
        Fri, 27 Aug 2021 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630073941;
        bh=ldDA9g1db1h6sOWFLUxuvCWXdNmekTYL01U7VHITjCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adaSf00qPRjl7Cn8RQHx8UlqiXXn2C2RZhkXbgzENJGtXso8EXwerepqVtr2gpJ8v
         vRGJ6Coa6SHFjmlC74ntnvFqRGS10wH3EKFS8vh99ijNzrPlievRPWhUBwzmDt3Lbx
         8DFylcuZh01ZCjZ/zK/aaSceWZiir4vktBFOrawE=
Date:   Fri, 27 Aug 2021 16:18:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] parport: remove non-zero check on count
Message-ID: <YSj0Tz8DwstOy4nG@kroah.com>
References: <20210730100710.27405-1-colin.king@canonical.com>
 <CADVatmOudaqZBr+cX_AXwKmDRd2LRTe=C=_bavEki0fdhWkADg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmOudaqZBr+cX_AXwKmDRd2LRTe=C=_bavEki0fdhWkADg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 09:52:07PM +0100, Sudip Mukherjee wrote:
> On Fri, Jul 30, 2021 at 11:07 AM Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The check for count appears to be incorrect since a non-zero count
> > check occurs a couple of statements earlier. Currently the check is
> > always false and the dev->port->irq != PARPORT_IRQ_NONE part of the
> > check is never tested and the if statement is dead-code. Fix this
> > by removing the check on count.
> >
> > Note that this code is pre-git history, so I can't find a sha for
> > it.
> >
> > Addresses-Coverity: ("Logically dead code")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> Greg, can you please take it through your tree..
> I think you might not have it in your queue as you were not in the
> original recipient list, if so, I can send it after adding my Ack to
> it.

Now picked up, thanks.

greg k-h
