Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE34318587
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 08:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBKHG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhBKHGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:06:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D284364E66;
        Thu, 11 Feb 2021 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613027174;
        bh=Sc3Cyv5FeJ+6gphZB8xqkKTJVvyTcP99G7i68/7smS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iga/rBKcgi7KJ9pi00EmKRVzi1I4eV58Jjcv7IyNP1yXZfZhdDcQcw0BP/N1Vn+Gi
         475G+IxSa3kaSeIG9/Y5xZQcWFT8tk3p+HUVgGvdlG/i/3RratW93EzNt2B8/l8xZ7
         IneRmflKYW1boLi28V90KItfh38+K7aFceuVE7g8=
Date:   Thu, 11 Feb 2021 08:06:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YCTXY8zIS8AQrmVO@kroah.com>
References: <1613012611-8489-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613012611-8489-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:03:31PM -0500, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This driver supports 1588 related functions of ClockMatrix(TM)
> and 82P33xxx families of timing and synchronization devices. The
> supported functons are:
> 
> - set combomode
> - get dpll's state
> - get dpll's ffo
> 
> Please note that this driver needs to work with rsmu mfd driver
> to access SMU through I2C/SPI.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

Where is the new user/kernel api you are creating here documented?  What
userspace tools use it?

thanks,

greg k-h
