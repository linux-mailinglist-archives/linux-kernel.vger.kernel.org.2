Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8673D4C74
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 08:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhGYGAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 02:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhGYGAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 02:00:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC4CD60F26;
        Sun, 25 Jul 2021 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627195230;
        bh=VXgaFXFy38GhSc0p1Vo65tW32HjGWyvHj4oMZjNOvZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kn+O1olVuaYGlE7nRJf45PIky51MH1nbuuRmtZks91GbihoG5LlFTmLBQWCH1Ysz4
         U9pcdF4hkZf3FxWIz9xa4zF3ZXRPsRixvBK5zg8dLL6F2lCGxAF76hOBDrcdG/BOdK
         IanP+DL6XUXjT03Cycv7mAkfJjoT/Z4qYrWwa34k=
Date:   Sun, 25 Jul 2021 08:40:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth: bfusb: update the reference count of udev
Message-ID: <YP0HWx/xc2llWmAx@kroah.com>
References: <20210724192131.GA490422@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724192131.GA490422@pc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 08:21:31PM +0100, Salah Triki wrote:
> Use usb_get_dev() and usb_put_dev() in order to update the reference
> count of udev.

What does this fix?
