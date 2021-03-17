Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D0E33EDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCQKCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhCQKCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:02:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A7F164F6C;
        Wed, 17 Mar 2021 10:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615975337;
        bh=rnFPxkpXYUq+oUBeFeUJ54dHBeYSHquuWQJDH+00gro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDvYWw5juOdHu/wa5T8Bwx+L1fnA+U6JjUgp/+b2vv1ijzgnMzzJzFm896oT6rhbI
         HJWOavZZ1aePmX2iqLDyHFWxznQ6rFgV6iK8nEXWqs01h7NF2J5RsO/1AJO3UUI2Jd
         M+pcnrYGarWK8IuWbyn/c1lxZ6zITX+9iRQTxBBA=
Date:   Wed, 17 Mar 2021 11:02:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: staging: rtl8723bs: remove unused code blocks completed?
Message-ID: <YFHTpb6oSarirQJv@kroah.com>
References: <20210317095932.GA2308@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317095932.GA2308@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:59:32AM +0100, Fabio Aiuto wrote:
> Hi,
> 
> I'm trying to search other unused code blocks:
> 
> grep -r '^\(#ifdef \|#if defined(\|#ifndef \)CONFIG_' drivers/staging/rtl8723bs/
> 
> drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:#if defined(CONFIG_PM)
> drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:#if defined(CONFIG_PM)
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:#if defined(CONFIG_WEXT_PRIV)
> drivers/staging/rtl8723bs/include/drv_conf.h:#ifndef CONFIG_RTW_HIQ_FILTER
> drivers/staging/rtl8723bs/include/autoconf.h:#ifndef CONFIG_WIRELESS_EXT
> 
> all blocks left are checked by existing defines.
> Could we apply this?

Sure, looks good, submit this as a real patch with this information in
the changelog and I"ll be glad to take it.

thanks,
greg k-h
