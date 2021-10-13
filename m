Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2BA42C0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhJMNHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234870AbhJMNHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:07:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BB79610CB;
        Wed, 13 Oct 2021 13:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634130339;
        bh=2wpgNMp/xwS95ZLKd4Ypa7M47fvb7ni003XFeMctCI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAU+s1+/+Ryw7aJqpvVZJfWgsBR+mfNGQYKeD+MXahGXqXfrnmkOiUiakpLJVDgnZ
         BlqnV+cZqIGnKuWeoyNp1DeR5VSsD+Qp0c5FoCy6jRuM7DfLEiyapOLr24MmWkV5pk
         tOpV1411Fc0bAwluNsEiqiOO3ms2sFoDXUdXGQGk=
Date:   Wed, 13 Oct 2021 15:05:36 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Abhyuday Godhasara <agodhasa@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
Message-ID: <YWbZoPHDzc4e5Nme@kroah.com>
References: <438b398c-a901-7568-11e0-cd9bf302343f@xilinx.com>
 <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbYKQXf8g8s55kG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWbYKQXf8g8s55kG@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:59:21PM +0200, gregkh@linuxfoundation.org wrote:
> On Wed, Oct 13, 2021 at 12:27:58PM +0000, Abhyuday Godhasara wrote:
> > Hi Greg,
> > 
> > > -----Original Message-----
> > > From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > Sent: Wednesday, September 15, 2021 6:46 PM
> > > To: gregkh@linuxfoundation.org
> > > Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
> > > <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Manish Narani
> > > <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna Potthuri
> > > <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; Jiaying Liang
> > > <jliang@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org
> > > Subject: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > > 
> > > This Linux driver provides support to subscribe error/event notification and
> > > receive notification from firmware for error/event and forward event
> > > notification to subscribed driver via registered callback.
> > > 
> > > All types of events like power and error will be handled from single place as
> > > part of event management driver.
> > > 
> > > Changes in v4:
> > > - Rebase on latest tree
> > > 
> > > Changes in v3:
> > > - Update the commit message.
> > > 
> > > Changes in v2:
> > > - Removed updated copyright year from unchanged files.
> > > - make sgi_num as module parameter for event management driver.
> > > - Use same object for error detection and printing.
> > > 
> > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > [Abhyuday] Michal suggested to merge this via your tree. Please have a look.
> > Please let me know if there is anything required from my side.
> 
> Ok, I'll pick it up, thanks.

Nope, I can not as for some reason it all did not show up on
lore.kernel.org.

Please resend this, with Michal's ack and I will be glad to pick it up.

thanks,

greg k-h
