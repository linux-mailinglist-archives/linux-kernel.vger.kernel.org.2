Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE941C18B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbhI2JYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhI2JYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:24:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A45CA613D0;
        Wed, 29 Sep 2021 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632907370;
        bh=j1iOY8IOPalSV7rWzGucjk6aw8Cof5o98mqaQKFeaek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MNz7+B+8GfDcFQnnfBvPc8Eb5JHNVvAZ+ShI/uQGCRpnKkSnMZvvUDb4l5IOKFH1I
         GpjTgDEA2R47lfv06fb1Y3nDikdxU+2uXNV0FysTE+3yxxdRr1wro4x1QqbjZvMIOm
         ZIkFVqgWSRx/HcIhs/qhHxnP+Z8nqg3/Vq7RNBAA=
Date:   Wed, 29 Sep 2021 11:22:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v0] usb: ohci: add check for start frame in host controller
 functional states
Message-ID: <YVQwZ8ed4od0q/Jh@kroah.com>
References: <1632901259-32746-1-git-send-email-zhuyinbo@loongson.cn>
 <YVQaxS3vjvZuT9JP@kroah.com>
 <bf56ff89-3800-9786-bba3-53175822a5d3@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf56ff89-3800-9786-bba3-53175822a5d3@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 04:58:15PM +0800, zhuyinbo wrote:
> 
> 在 2021/9/29 下午3:50, Greg Kroah-Hartman 写道:
> > On Wed, Sep 29, 2021 at 03:40:59PM +0800, Yinbo Zhu wrote:
> > > The pm states of ohci include UsbOperational、UsbReset、UsbSuspend、UsbResume
> > > , among them only the UsbOperational state supports launching the start frame
> > > for host controller according the ohci protocol spec, but in S3/S4 press test
> > > procedure, it may happen that the start frame was launched in other pm states
> > > and cause ohci works abnormally then kernel will allways report rcu CallTrace
> > > . This patch was to add check for start frame in host controller functional
> > > states for fixing above issue.
> > 
> > > Odd use of punctuation :(
> > 
> > > Change-Id: Ic5c2c0a41d01d9396a9452f3eb64acc52b4cbf76
> > > Always run checkpatch.pl on your patches do you do not get grumpy
> > > maintainers asking you to run checkpatch.pl on your patches.
> > 
> > > and what does "v0" on the subject line mean?
> > 
> > > thanks,
> > 
> > > greg k-h
> 
> Hi greg k-h,
> 
> 
> The string "v0" of subject line is patch version,  as for the punctuation
> I'll revise it,
> 
> and I don't find any error that use checkpatch.pl to check patch. then
> please you

You had a Change-Id: in the changelog, that is not needed or allowed in
the kernel tree.

thanks,

greg k-h
