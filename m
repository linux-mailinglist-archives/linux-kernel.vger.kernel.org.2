Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AAB3DA79C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbhG2P3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237779AbhG2P3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:29:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65A6060F12;
        Thu, 29 Jul 2021 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627572587;
        bh=30kv93VyMSYdwpESq1mG1eKMBipoOzvLA9ZnvKdAaw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Flr1BZ5HtkQCYR1os070E2BRtShejGpAW2BipGSMOQ7UCw2li/IkHv6m9eBNL3f9Z
         Qz99V/KHVuw8ZT04QSdtaNWVxm8oNiDcZp4EcLSXtTRkqai0RJeQkZk+M+FZXkbLkK
         momaDV54WkTb/QS7pKddHV1m7NjaDeTXzRyrXHBE=
Date:   Thu, 29 Jul 2021 17:29:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] pps: clients: parport: Switch to use
 module_parport_driver()
Message-ID: <YQLJaIoBIINxXoRA@kroah.com>
References: <20210607153729.58623-1-andriy.shevchenko@linux.intel.com>
 <YOxJy5SbObWeZbf5@smile.fi.intel.com>
 <YQLGjZ7/TLB6Mud5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQLGjZ7/TLB6Mud5@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 06:17:33PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 12, 2021 at 04:55:23PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 07, 2021 at 06:37:29PM +0300, Andy Shevchenko wrote:
> > > Switch to use module_parport_driver() to reduce boilerplate code.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> > > ---
> > > v2: added tag (Rodolfo)
> > 
> > Seems missed patch.
> 
> Greg, can you pick this up, or should I resend?

I took it now, thanks.

greg k-h
