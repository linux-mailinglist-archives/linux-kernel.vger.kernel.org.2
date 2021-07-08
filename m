Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4645A3BFABB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhGHM6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231520AbhGHM6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:58:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBF2261461;
        Thu,  8 Jul 2021 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625748938;
        bh=QImtMzYSj2hdFM2xOlbEV7tWGf8EqO9glFH8QnOFGwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nT3Gry7YmAJ+tkg9raeoGNwQJ1SLkoVhWRZhlY4oPoU52nKqmJ9APqLpK8f0ga3k1
         at88sqDxdJqQWwZhG9S78RTNGB2c0mCYZrpkb0ukxTABdVVm9Spj85vYaI2Riex+S+
         WmAUKUiu6w9AChgqJwfbldCRqVQRVVI3sZHw3hkY=
Date:   Thu, 8 Jul 2021 14:55:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@arm.linux.org.uk, mhiramat@kernel.org, tixy@linaro.org,
        chenzefeng2@huawei.com, kepler.chenxin@huawei.com,
        liucheng32@huawei.com, nixiaoming@huawei.com, xiaoqian9@huawei.com,
        young.liuyang@huawei.com, zengweilin@huawei.com
Subject: Re: ping // [PATCH 4.4.y] arm: kprobes: Allow to handle reentered
 kprobe on single-stepping
Message-ID: <YOb1xv0a0U+0Wp1z@kroah.com>
References: <20210302012449.23428-1-huangshaobo6@huawei.com>
 <20210708124240.20048-1-huangshaobo6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708124240.20048-1-huangshaobo6@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 08:42:40PM +0800, Shaobo Huang wrote:
> ping

???

What are you asking about here?  Please be specific, "naked pings" like
this are not informative.

thanks,

greg k-h
