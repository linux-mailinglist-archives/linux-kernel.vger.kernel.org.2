Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A70314878
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBIGJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhBIGJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:09:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9002F64EB8;
        Tue,  9 Feb 2021 06:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612850936;
        bh=7ZFeJoTMAgClPx+EU8W9uRO0tg2vEEeuop17o7Cs8Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xUHDV35uVMGKQ4TNZs5xaMxieWSSyQQmNygNIuoxx/xn3R4dG/ayZE6JOUUQHM5uK
         eYMzNitPjQSYz1Lhx0l01Snvv/acXBAnPWGljl+46rRfHL+BP6B/W0gibrjw3/SKtx
         Bd+gPWGNl9h04FS785HR0A5fPoseMBDkg+Va4r6A=
Date:   Tue, 9 Feb 2021 07:08:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Gopinathan <leoatul12@gmail.com>
Cc:     mchehab+huawei@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: hikey9xx: fix checkpatch error and warning
Message-ID: <YCIm9e0w06aeOL91@kroah.com>
References: <20210209055703.7211-1-leoatul12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209055703.7211-1-leoatul12@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:27:04AM +0530, Atul Gopinathan wrote:
> Fix the following types of checkpatch error and warning:
> 
> ERROR: code indent should use tabs where possible
> WARNING: struct phy_ops should normally be const

That is 2 different things, which means this should be 2 different
patches.  Please make this a patch series and resend.

thanks,

greg k-h
