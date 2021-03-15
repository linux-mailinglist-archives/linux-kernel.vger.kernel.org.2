Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C91733ACDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCOH41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCOH4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:56:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D787264E12;
        Mon, 15 Mar 2021 07:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615794973;
        bh=osdF5qmTEUxcpJl4FEQ0M6fxE/JEHBv/lB5q6kUbatw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWcRgyOj3/E4paueDASxMWAqjMW5+JR7dUmIznngZpofmklvV60rmnN64pCRABsLR
         LEP+K22Q0KoPRQ90Z6525FmrOUczeE2omMGCijIMTzVwREI20Z347nu++7AVrHb4xx
         Gt4w99enn9MiokquVkr7+kAul278eEJJCCluBqtE=
Date:   Mon, 15 Mar 2021 08:56:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     straube.linux@gmail.com, lu@pplo.net, dan.carpenter@oracle.com,
        serrazimone@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: remove extra lines
Message-ID: <YE8TGufU6hyEBPgX@kroah.com>
References: <20210315072759.23107-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315072759.23107-1-zhaoxiao@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 03:27:59PM +0800, zhaoxiao wrote:
> Remove extra lines in many functions in r8192U_wx.c.
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>

You did mor than just remove extra lines :(

Also we need an extra line right before your signed-off-by line, as
checkpatch should have warned you about.

Please fix up and resend.

thanks,

greg k-h
