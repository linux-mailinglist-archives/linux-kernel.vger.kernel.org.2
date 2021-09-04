Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9B400A3F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 09:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhIDHfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 03:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233278AbhIDHfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 03:35:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C9F260F38;
        Sat,  4 Sep 2021 07:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630740850;
        bh=BBgdDw2pbrzGmdbh2uLjiJOpUEwB831X9jZZ+sjK8Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQAgZjSHQWBSlWGRABAE8n7AdkcGh7hnbOeNZt+tMCYfAscjPUYDdeITvwnsgdIeX
         4ZexBxh7DvzsjsF+NGx4ZJ6qAIyZNBjuxTDglPB8QXGTO0adqwz6QJqbCE4nR0j3Au
         J7UDwofXmu/iKsEDgQLiiEFdNtd+BJD4aCbolREc=
Date:   Sat, 4 Sep 2021 09:34:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove _rtw_mutex_{init,free}
Message-ID: <YTMhcMSqWCepQMMT@kroah.com>
References: <20210903193356.31927-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903193356.31927-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 10:33:56PM +0300, Pavel Skripkin wrote:
> While testing Fabio's patch I hit lockdep warning about possible
> deadlock:
> 
> [  252.063305] WARNING: possible recursive locking detected
> [  252.063642] 5.14.0+ #9 Tainted: G         C
> [  252.063946] --------------------------------------------
> [  252.064282] ip/335 is trying to acquire lock:
> [  252.064560] ffff888009ebad28 (pmutex){+.+.}-{4:4}, at: usbctrl_vendorreq+0xc5/0x4a0 [r8188eu]
> [  252.065168]
> [  252.065168] but task is already holding lock:
> [  252.065536] ffffffffc021b3b8 (pmutex){+.+.}-{4:4}, at:  netdev_open+0x3a/0x5f [r8188eu]
> [  252.066085]
> [  252.066085] other info that might help us debug this:
> [  252.066494]  Possible unsafe locking scenario:
> [  252.066494]
> [  252.066866]        CPU0
> [  252.067025]        ----
> [  252.067184]   lock(pmutex);
> [  252.067367]   lock(pmutex);
> 
> There is one problem with this warning: there is no pmutex in this
> driver, *BUT* all mutexes are initialized via private _rtw_mutex_init
> API, which had struct mutex *pmutex argument.
> 
> So, all mutexes in this driver had same name in lockdep map. Of course,
> lockdep will complain about any nested locking.
> 
> Fix it by open-coding _rtw_mutex_{init,free} wrappers, because we do not
> need them at all.
> 
> Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")

No need for "Fixes:" on this, as it's not a bug, it's just a badly
designed implementation.

thanks,

greg k-h
