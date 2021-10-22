Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948AA437431
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhJVJEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232314AbhJVJEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BFF1610EA;
        Fri, 22 Oct 2021 09:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634893304;
        bh=4bMvhQPX6/fDL7Lv2GrhBhjdUgYTkWIOQGwWTJp8Mus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGa/DdEgrvkc6gENd9RQfXyxyQVdC2u8DToYV85zHurQ7I0EeGnarmUBjqdcqSIpk
         QELa4uJi4lc1Q3Ln3uzocv2RFYMdEBKzqwN/F77kvqSWQhvyp9c0w11EV8gM5NrkAI
         YcoyJOJo6bkwCkvqepJD+ZJBvnicHbjWk1FX7s8Q=
Date:   Fri, 22 Oct 2021 11:01:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove unused semaphores
Message-ID: <YXJ99WIRPOYa+Dk9@kroah.com>
References: <20211022084727.28035-1-fmdefrancesco@gmail.com>
 <1905861.9EeI4ENUQp@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1905861.9EeI4ENUQp@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:54:26AM +0200, Fabio M. De Francesco wrote:
> On Friday, October 22, 2021 10:47:25 AM CEST Fabio M. De Francesco wrote:
> > Remove two unused semaphores.
> > 
> > Fabio M. De Francesco (2):
> >   staging: r8188eu: Remove initialized but unused semaphore
> >   staging: r8188eu: Remove unused semaphore "io_retevt"
> > 
> >  drivers/staging/r8188eu/core/rtw_xmit.c      | 1 -
> >  drivers/staging/r8188eu/include/osdep_intf.h | 1 -
> >  drivers/staging/r8188eu/include/rtw_xmit.h   | 1 -
> >  3 files changed, 3 deletions(-)
> > 
> > -- 
> > 2.33.1
> 
> I'm sorry but I overlooked the name of the driver in this cover letter :(
> Am I required to send a v2?

Please do.
