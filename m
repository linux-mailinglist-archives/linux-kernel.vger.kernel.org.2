Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23B13537BD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 12:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhDDKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 06:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230399AbhDDKIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 06:08:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8BE761380;
        Sun,  4 Apr 2021 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617530926;
        bh=tmz2ngPlpmeSZ+3lRmqvtJnXqzdaApgAxpvCzTnHM/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1PjpmpW8X7Fgj+r8uZ2nG2DWk8b93KCOJI3jwPg1S5Eq+WoMSs6MHiemHsVJ7452a
         N3cLNs3GJ236N21sulLXe286uo0MEC1w3tvzU3eZ8m7CBuiCZr9CeApT6lLpGXwdUy
         oprI+H4VNGfev/HGZCp/2Q0vuq/Z0Jt9PdxGZxW8=
Date:   Sun, 4 Apr 2021 12:08:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YGmQKyweNi3lWoGM@kroah.com>
References: <1617487714-8312-1-git-send-email-min.li.xe@renesas.com>
 <1617487714-8312-2-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617487714-8312-2-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 06:08:34PM -0400, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families
> of timing and synchronization devices.It will be used by Renesas PTP Clock
> Manager for Linux (pcm4l) software to provide support to GNSS assisted
> partial timing support (APTS) and other networking timing functions.
> 
> Current version provides kernel API's to support the following functions
> -set combomode to enable SYNCE clock support
> -read dpll's state to determine if the dpll is locked to the GNSS channel
> -read dpll's ffo (fractional frequency offset) in ppqt
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

Any specific reason you are not using the misc_device api?  That would
clean up this driver a lot, there's no need to create a whole class just
for a single driver.

thanks,

greg k-h
