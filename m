Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C113D3A974F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhFPKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232030AbhFPKci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:32:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D3F460FE6;
        Wed, 16 Jun 2021 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623839432;
        bh=mqqLnnrtOe1x+IQER3v/M1RZ1eEvzy87JkFegkes+cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OnWsBphAHVb2rg/ju/6Hmsj9CKJESH5L8S3YyKZMowlYIITokBtAacamo6ne6B4RJ
         xkyDkVC44/qaGqBTWAXtH/TaV1e/lcQ7RNlplQvYzisJOz4p/Dw9LrtsbDA8TOBvmH
         UBpffBaFYiJKlt50hNCdpZBmpU/RzF4RFEi/LMWg=
Date:   Wed, 16 Jun 2021 12:30:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Halman <lukasz.halman@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: ALSA: usb-audio: fix rate on Ozone Z90 USB headset
Message-ID: <YMnSxQx15C8xAq98@kroah.com>
References: <CGME20210616094912epcas2p38028df32b89b7cc79ba16c0215f8f664@epcas2p3.samsung.com>
 <1623836097-61918-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623836097-61918-1-git-send-email-dh10.jung@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 06:34:55PM +0900, Daehwan Jung wrote:
> It mislabels its 96 kHz altsetting and that's why it causes some noise
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I don't care about this.  But the stable tree probably does, please
read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h
