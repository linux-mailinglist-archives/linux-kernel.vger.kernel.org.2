Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD7A3829F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhEQKh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236218AbhEQKh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:37:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 089D4611CA;
        Mon, 17 May 2021 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621247770;
        bh=wIbh01EGhpy2Glxz4BA0QU4Cr0YfmkGXDrZC8LNYWGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qXqCwsqd4/oJdhAqwblyA+uVGI4d3ZMXTQW/UonB7RAz3WPMBgDKp3FjI/nSFW9TR
         g+S2/QyR4XcHbVz5d2tnjw8SSFL9JinR6gDRnOrSslyWR4+Tnylz4RFVWGBUCPafcV
         /I23a6mo5vHaPgyFtOELvXps7hbBBThmlO/LxSRM=
Date:   Mon, 17 May 2021 12:36:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH] uacce: use sysfs_emit instead of sprintf
Message-ID: <YKJHGP9LTnCRfIx6@kroah.com>
References: <1621247137-42693-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621247137-42693-1-git-send-email-yekai13@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 06:25:37PM +0800, Kai Ye wrote:
> Use the sysfs_emit to replace sprintf.

That says _what_ you did, not _why_ you are doing this.  What problem
are you solving with this change?

thanks,

greg k-h
