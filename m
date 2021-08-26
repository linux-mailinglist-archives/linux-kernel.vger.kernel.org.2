Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C703F8500
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbhHZKFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233880AbhHZKFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:05:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 621F9610E6;
        Thu, 26 Aug 2021 10:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629972290;
        bh=uqKb6h0Wiejse2anuZ4qCYAvlJ79825SKg+gZQGrYog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQVsZ9JAF3ZrBhI0vq+RuHkxjmM7SrqHupJKh/w5ZsIseHYkATITGV+m1/lJQ6NgW
         fw+oiW41cYa6pDNP0iU6/MP1CXzDrfginSU2OH6/7rv3Y9yOVJhedvJu/pVpN/qmRa
         FKTfcNViwfRSWTHkSgWiyKCjPwWLwYtc2Hcgn4LI=
Date:   Thu, 26 Aug 2021 12:04:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] staging: rtl8723bs: remove unused functions
Message-ID: <YSdnPavatnKCVmqy@kroah.com>
References: <20210822204212.2832397-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822204212.2832397-1-hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 08:42:58PM +0000, Bryan Brattlof wrote:
> Changes in v2:
>  - Remove build warnings I introduced in the previous version.
> 
> ***
> 
> There is a lot of un-used code and un-needed abstractions leftover
> in this driver from when (I assume) it could be compiled on more than
> one kernel.
> 
> This series removes dead code and is one small step toward
> refactoring how this driver interacts with the SDIO subsystem.
> 

Better, but these are still not threaded properly (some were, patches 1
and 2, but not the rest.)

Please fix up and resend a v3.

thanks,

greg k-h
