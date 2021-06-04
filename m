Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648DD39BB19
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFDOue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhFDOud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:50:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E31BF613FF;
        Fri,  4 Jun 2021 14:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622818110;
        bh=QQn1UfMVw3Uzd/V33nhP6feE1JGrPpO/4zviSgunk2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pT0253kn1l1z1CyXGDrrobXROOR2Ti2X/xfcvRAiN90T+pL2MX78Y3Bl7u3SW9kH0
         ymrwbxCH0/o1UK27+2MY/BZKrYyo7oq/oD4K9vlzRQrVoVvFH/nfaZYorMUmm7HiYc
         2AR7Zsr0W89VDXZNkFUCWMXiuYgRVsIbQKwCEAeE=
Date:   Fri, 4 Jun 2021 16:48:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, bhelgaas@google.com, rui_feng@realsil.com.cn,
        ulf.hansson@linaro.org, vaibhavgupta40@gmail.com,
        yang.lee@linux.alibaba.com, keitasuzuki.park@sslab.ics.keio.ac.jp,
        chris.chiu@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: separate aspm mode into MODE_REG and MODE_CFG
Message-ID: <YLo9O/gGOuFIsVH0@kroah.com>
References: <20210604144211.6470-1-ricky_wu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604144211.6470-1-ricky_wu@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 10:42:11PM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> Divide Realtek Card Reader Group into two different modes
> ASPM_MODE_CFG: 8411 5209 5227 5229 5249 5250
> Change back to use original way to control aspm

What is "aspm"?

> +#define ASPM_MODE_CFG		0x01
> +#define ASPM_MODE_REG		0x02
> +	u8				aspm_mode;

Why not use an enum?

thanks,

greg k-h
