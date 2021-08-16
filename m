Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689923ED2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhHPLRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhHPLRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:17:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0896C61B5D;
        Mon, 16 Aug 2021 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629112633;
        bh=VQHVWgx/Vnp6vrq90JYPhAK5Lk/clExK25/y4fl3xCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqHWfe7autrBSS9uvYSMOkt15g1cptInQs5EnCeKzesa5Ef8x4GsQT5ZijTDStdUF
         s1t79tgDSoQfdpeb432fHgYHOmlcqddFDfVQ2D7P4CvIj8JpWN2X1X+MpY1ePuMHCC
         7SJYggdjMyyGN9/yvE95njTDecBjbEa4Hh62BkTg=
Date:   Mon, 16 Aug 2021 13:17:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     Reinhard Speyerer <rspmn@arcor.de>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] [V2,1/1]USB: serial: option: add Foxconn T77W175
 composition 0x901d
Message-ID: <YRpJN414JQyfyEGo@kroah.com>
References: <20210816035404.4210-1-slark_xiao@163.com>
 <YRoqAJmGBpV/OuZL@arcor.de>
 <d1d16fd.6f62.17b4e3ffa26.Coremail.slark_xiao@163.com>
 <YRot+wBa6v529Z7q@kroah.com>
 <278bcd0d.7189.17b4e479a3a.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278bcd0d.7189.17b4e479a3a.Coremail.slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:25:20PM +0800, Slark Xiao wrote:
> At 2021-08-16 17:20:59, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Mon, Aug 16, 2021 at 05:17:00PM +0800, Slark Xiao wrote:
> >>   So should I use USB_DEVICE_INTERFACE_NUMBER(QUALCOMM_VENDOR_ID, 0x901d, 0x00) to bind Diag port only?
> >
> >Why is this device using the QUALCOMM vendor id anyway?  Is this allowed
> >by Qualcomm?
> >
> >thanks,
> >
> >greg k-h
> 
> Hi Greg,
>   Our product are designed based on Qualcomm SDX55 platform. So it still support Qualcomm vendor ID.
>   I think there is no infringement about this ID combo.

Do you have permission from Qualcomm to use their vendor id?  I know
some vendors get very upset about this...

Why not use your own vendor id?

thanks,

greg k-h
