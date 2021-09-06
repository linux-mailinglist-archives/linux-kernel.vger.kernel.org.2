Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8A401927
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbhIFJq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241595AbhIFJqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:46:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F25926069E;
        Mon,  6 Sep 2021 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630921549;
        bh=/35z53h420eVd9x0GGMxOV6puR3UCGj0ROP/2GZkhJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTSidDurVKGLtwj/gtT1DF8lJu2lpq/11xP/Ua2sEBBFrMSTqSa6KdlDFAyNK/Txs
         T17/IpmwriF7ZFI49MU0W1CrDOVmCSUIyRvHWDSP7cUdq0HCDugpL+dFtMJ7o67QxM
         f6qj+Fvrla5GKahJG2phieiocqVPT5BT/LpmD6y0=
Date:   Mon, 6 Sep 2021 11:45:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8712: Move similar execution in to a
 function.
Message-ID: <YTXjSwWcyd6RRMjO@kroah.com>
References: <YTUQZdPiYFscIsvU@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTUQZdPiYFscIsvU@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 12:15:57AM +0530, Saurav Girepunje wrote:
> Move the common execution for read_macreg_hdl, write_macreg_hdl,
> write_bbreg_hdl and write_rfreg_hdl in to a new function
> common_read_write_hdl.

You said _what_ you did here, but not _why_ you did this.

I can't easily see why you did this, please explain it better in the
next version of this patch.

thanks,

greg k-h
