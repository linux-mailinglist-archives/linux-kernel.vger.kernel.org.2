Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC34319AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 08:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhBLHmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhBLHkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:40:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C36564DD6;
        Fri, 12 Feb 2021 07:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613115566;
        bh=Gnb01Zlt7JlELKwkyjC2FjCJvYfhhVCdeifBUFpHFkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KL4wts0ySgi1Xwt3fBv2gOOK8brB/EKoPhxiONVibR22++V9jH8K6h8b9LRwK7ocV
         1+Tu3wDeyxmIdwAVLnlk5or5j5RtvJOetlhSfCxlRjG7GdTi4ue918mHrmZJiYuPB7
         gnyOjGbFJsDcShugcQhC8sHkHkhtYmzFAVhdHrp8=
Date:   Fri, 12 Feb 2021 08:39:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YCYwrNE8547uuODo@kroah.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 08:16:15PM -0500, min.li.xe@renesas.com wrote:
> +static int
> +rsmu_open(struct inode *iptr, struct file *fptr)
> +{
> +	struct rsmu_cdev *rsmu;
> +
> +	rsmu = container_of(iptr->i_cdev, struct rsmu_cdev, rsmu_cdev);
> +	if (!rsmu)
> +		return -EAGAIN;
> +
> +	/* Only one open per device at a time */
> +	if (!atomic_dec_and_test(&rsmu->open_count)) {
> +		atomic_inc(&rsmu->open_count);
> +		return -EBUSY;

This does not do what you think it does, and does not prevent multiple
applications from talking to your device at the same time.

There is no need for this at all, as it does not work, sorry.  If
multiple apps talk to your device, it's their fault, not the kernel's
fault, that things go wrong.

And I thought that Arnd already told you to fix this?

thanks,

greg k-h
