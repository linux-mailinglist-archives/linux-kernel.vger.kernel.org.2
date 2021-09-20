Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215204113D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhITL5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhITL5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:57:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16AB660F6E;
        Mon, 20 Sep 2021 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632138944;
        bh=OA42Um0J2Hw897wOt3NAQ6pe3Xc88JqjkcCsaDgd9SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWRAF27dQCbCzUbokjwZSjxZY0+82LbSfXazSA+Ylsuoa7kvUSFucwbig6Ceof6AK
         aY3Py6zkqh20xarbgtuNpvHg2vbmg8PtJnjddyCjYh9hM5rGy/Wo9QS0GgnDHdea3P
         ipEwxqFHZmSj1lNbKL4KuASKL795muu+DNNWF8Z8=
Date:   Mon, 20 Sep 2021 13:55:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 00/19] staging: r8188eu: shorten and simplify calls
 chains
Message-ID: <YUh2vtxNxNBmpKHQ@kroah.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:53:37AM +0200, Fabio M. De Francesco wrote:
> --- Preface ---
> 
> This is v8 of "shorten and simplify calls chain". The first 14 patches
> have already been applied to staging-testing, so we have been requested
> to reset the numbering of the remaining patches to 01/19, while discarding
> from this new submission the above-mentioned 14 patches (otherwise we would 
> have submitted a series containing 33 patches).
> 
> The following commit message is provided as it was in v7, both for the 
> purpose of presenting the whole picture to Maintainers, Reviewers, and to 
> anybody else who may be interested in knowing the entire design and the
> evolution since v1 to the current v8.
> 
> --- Commit message ---
> 
> io_ops abstraction is useless in this driver, since there is only one ops
> registration. Without io_ops we can get rid of indirect calls mess and
> shorten the calls chain.
> 
> Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
> For this purpose unify the three usb_read8/16/32 into the new
> usb_read(); make the latter parameterizable with 'size'; embed most of
> the code of usbctrl_vendorreq() into usb_read() and use in it the new
> usb_control_msg_recv() API of USB Core.
> 
> Shorten the calls chain of rtw_write8/16/32() down to the actual writes.
> For this purpose unify the four usb_write8/16/32/N() into the new
> usb_write(); make the latter parameterizable with 'size'; embed most of
> the code of usbctrl_vendorreq() into usb_write() and use in it the new
> usb_control_msg_send() API of USB Core.
> 
> The code with the modifications was thoroughly tested by Pavel Skripkin
> using a TP-Link TL-WN722N v2 / v3 [Realtek RTL8188EUS] and by Fabio M.
> De Francesco using a ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano].
> 
> --- Changelog ---
> 
> v7->v8 (old numbering):
> 	- 1-14:
> 		Patches applied to staging-testing, so they are dropped
> 		from the current v8;
> 
> 	- 15-19:
> 		Split into 19 patches. Numbering reset to 01. After this
> 		reset, 15-19/19 become 01-19/19 (so we have a total of 33
> 		patches in this series. 

Better, still needs a bit more work.  I took 2 of these to shorten your
load a bit :)

thanks,

greg k-h
