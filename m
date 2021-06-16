Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B134B3A9439
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhFPHlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhFPHlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:41:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB60061055;
        Wed, 16 Jun 2021 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623829170;
        bh=dCefW3/LX4d2ZVUE7U5M5Ui+AhEKEegfMc5DkNgJwp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zof/ErTet3FRTt8mutBDlkG4M+/hwEZXVx6f4VgW3ZB5UXfCCMcev6TVQCi04c0zd
         xbd3cQkSPq1Axo+bWlt7eMV6qXBtgNh1sgCOoRm8XoQa5ATolHruuGDOUZTqgIPOg1
         zEhigZgOR3qMA6S3JIDXkmFDmbECYawssYWVJB+M=
Date:   Wed, 16 Jun 2021 09:39:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: Fix CR bit value when initiator=0
Message-ID: <YMmqsJ3xwIIxzop+@kroah.com>
References: <1623812199-31866-1-git-send-email-zhenguo6858@gmail.com>
 <YMmYD3rkS8o+1dXr@kroah.com>
 <CAGGV+3JjiuAoXefUwpekbcqB_Xye32xQSMK0jKQ_zNM6dvOPAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGGV+3JjiuAoXefUwpekbcqB_Xye32xQSMK0jKQ_zNM6dvOPAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jun 16, 2021 at 03:29:11PM +0800, 赵振国 wrote:
> Dear gregkh
> 
> 1:  Documentation/driver-api/serial/n_gsm.rst
> 
> The text introduces the config of master ( c.initiator = 1), but the
> config of as responder is different.
> when set gsm->initiator=0 by GSMIOC_SETCONF ,ngsm driver should be
> responder(slaver)
> 
> config：
> 	c.initiator = 0;    // set initiator=0，ngsm as responder
> 	ioctl(fd, GSMIOC_SETCONF, &c);
> 
> 2:  if master side send SABM/DISC frame data by uart dev
>     DLC0 control data frame:f9 03 3f 01 1c f9
>     kernel log： gsmld_receive: 00000000: f9 03 3f 01 1c f9
> 
> {
> 	cr = gsm->address & 1;		/* C/R bit */
> //CR value=1
> 
> 	gsm_print_packet("<--", address, cr, gsm->control, gsm->buf, gsm->len);
> 
> 	cr ^= 1 - gsm->initiator;	/* Flip so 1 always means command */
> //when gsm->initiator is 0, CR value=0 by "^=" calculation
> 	dlci = gsm->dlci[address];
> 
> 	switch (gsm->control) {
> 	case SABM|PF:
> 		if (cr == 0)
> 			goto invalid;                       //if CR value=0,ngsm will goto
> invalid,but the dlc0 control frame data is right,if we can't modify
> ,ngsm can't send UA response data
> }

I am sorry, but I really do not understand what you are saying here.
Please resubmit your patch with an updated changelog that explains why
this change is needed and what it does.

thanks,

greg k-h
