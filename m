Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4F319AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 08:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhBLHm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhBLHlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:41:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF10A64E57;
        Fri, 12 Feb 2021 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613115626;
        bh=NC6YL/6c8hJFmodCo5hFzbMLG6Jhztdn+/HB+CRRdFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmGRKEYfXn3dX7fVPgbjy4Aq/RSm1K7+yuGXjrPC5APBdSEM7QjKIAbNIM0HfdB4f
         8QIWnU5A+MfAXmWTH6vqE4l3SzXd9AWp8KONehtSnilSLdauE0Rbr9JeQOcOi6EECn
         fbIclQBahW+Z8Nhrn+1aQaPkM4hHkEOyhifSVrQA=
Date:   Fri, 12 Feb 2021 08:40:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YCYw5xXe16fSj6eI@kroah.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 08:16:15PM -0500, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This driver supports 1588 related functions of ClockMatrix(TM)
> and 82P33xxx families of timing and synchronization devices.
> 
> The driver is developed to be only used by Renesas PTP Clock
> Manager for Linux (pcm4l) software. It supports 1588/PTP
> releated functionalities that specific to Renesas devices
> but are not supported by general PHC framework. So pcm4l
> will use both the existing PHC driver and this module to
> complete 1588/PTP support. The supported functons are:
> 
> -set combomode
> -get dpll's state
> -get dpll's ffo
> 
> This driver must work with Renesas MFD driver to access SMU
> through I2C/SPI.
> 
> Changes since v1:
> -Provide more background for purpose of the change.
> -Provide compat_ioctl support
> -Fix ioctl cmd definition

This "changes" list goes below the --- line.

And you seem to have ignored my review, especially about documenting the
sysfs files here, please do that as I can not accept this patch as-is.

greg k-h
