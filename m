Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A793F3F6B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 15:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhHVNHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 09:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhHVNHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:07:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F316B61206;
        Sun, 22 Aug 2021 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629637615;
        bh=EQOmStsJmOqdUqnPphlHpXfj8gNo53ILHo1sVqpPmz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3IUzMTXP27vOPWqw/5sm00/EGje48cZMDLO92t/3N8bB3+oDIiqM1U+lYI1coRe0
         GODJJLVrPhCeV4tIPTrgRTjI0GFXwqf1HKPmcUx4Gyxd8XXBJiZ+gCHWRXRFsC0OAb
         Lvq8fh+/iSWXZoDJXZk1qRaWezjy7qrudU5qfysI=
Date:   Sun, 22 Aug 2021 15:06:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
Message-ID: <YSJL7B9Sk6V6/VLw@kroah.com>
References: <cover.1629479152.git.paskripkin@gmail.com>
 <10584649.zhyk0TxWeL@localhost.localdomain>
 <ae27d6a0-dc00-459f-7b36-acf7f4c08d72@gmail.com>
 <2327383.5TodInGmHT@localhost.localdomain>
 <435eea22-da31-1ebc-840c-ee9e42b27265@gmail.com>
 <YSJFhmTs74PUyo8b@kroah.com>
 <e5d189b7-15b2-8cc3-1e84-021dc5ab51af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d189b7-15b2-8cc3-1e84-021dc5ab51af@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 03:50:35PM +0300, Pavel Skripkin wrote:
> On 8/22/21 3:39 PM, Greg KH wrote:
> > > 
> > > Yes, but _rtw_read*() == 0 indicates 2 states:
> > > 
> > > 	1. Error on transfer side
> > > 	2. Actual register value is 0
> > 
> > That's not a good design, it should be fixed.  Note there is the new
> > usb_control_msg_recv() function which should probably be used instead
> > here, to prevent this problem from happening.
> > 
> 
> Thank you, Greg, for confirmation. That's was the point why I started to
> write this series :)
> 
> I think, usb_control_msg_recv() won't help us with this problem, since all
> rtw_read*() functions return an unsigned value now. In future, when driver
> code will be fixed (ex: a lot of void function, which can fail and leave
> passed pointer uninitialized) we can move to new usb API and then move
> driver out of staging :)

That function _should_ be used at the lower levels of this call chain.
If you want to go from the top -> down or bottom -> up of fixing this is
your choice, but as others have pointed out, this patch series as-is
still needs some work.

thanks,

greg k-h
