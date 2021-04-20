Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF07365374
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhDTHqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhDTHql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:46:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12AB8613AB;
        Tue, 20 Apr 2021 07:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618904770;
        bh=O4XCOj84rCYc3BbzkoCylLe567dg3DqeHzJJdPr6bz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alNUiiq9bHh+oY8xhwzbo0hZhrcO7a+Ulp2x3x9nKzacJ67mUd7Hbd/5t6BubJpkl
         TvSUshcs31qhmVUwNuyrE5dgGMzc+hZ6nFJT+sKJmLqJUzOWcgfk9Dbn6Z9Wtuzo1H
         W+awanfu3gBHOY7xgjjMT+r9igujT83maAK9ee10=
Date:   Tue, 20 Apr 2021 09:46:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Zago <frank@zago.net>
Cc:     linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "USB: serial: ch341: add new Product ID for
 CH341A"
Message-ID: <YH6Gv9QG5VusXlgy@kroah.com>
References: <20210420022520.47965-1-frank@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420022520.47965-1-frank@zago.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 09:25:19PM -0500, Frank Zago wrote:
> From: frank zago <frank@zago.net>
> 
> The 0x5512 USB PID is for the I2C/GPIO/SPI interfaces. UART is still
> present but only the TX and RX pins are available; DTS, DTR, ... are
> used for other things. Remove the PID, and let a I2C driver bind to
> it.
> 
> Existing CH341 boards usually have physical jumpers to switch between
> the 3 modes.
> 
> This reverts commit 46ee4abb10a07bd8f8ce910ee6b4ae6a947d7f63.
> 
> Signed-off-by: Frank Zago <frank@zago.net>
> Signed-off-by: frank zago <frank@zago.net>

Why are you signing off twice?

