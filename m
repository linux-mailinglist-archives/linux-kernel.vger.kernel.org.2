Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0AB44D5F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhKKLlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232570AbhKKLlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:41:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C48A66124C;
        Thu, 11 Nov 2021 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636630709;
        bh=2SFqDj3ElYiZ6RIEouJ73Ei4EWdCvJuycIQp+XCr8L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+dYT338p6nbQolHa+W+RE+PyxoSXWZbeXrwryXV7XuNZvCsUMHNWQPsOLZ0XjxGH
         qml420fkM1tvIEfqHbrS9O/FA5y8SKYjbWAO3WuKz0hneWBe41lgIvTpc3yCjWzzwM
         ok1XHzVqYaAz9VUso/ffmLcwha9Hf7C2C+BLWmG8=
Date:   Thu, 11 Nov 2021 12:38:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Peter Chen <peter.chen@nxp.com>,
        Jack Pham <jackp@codeaurora.org>,
        Dean Anderson <dean@sensoray.com>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] usb: gadget: f_fs: Use stream_open() for endpoint files
Message-ID: <YY0Asjnm/Ce6FpS8@kroah.com>
References: <1636629117-2206-1-git-send-email-quic_pkondeti@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636629117-2206-1-git-send-email-quic_pkondeti@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 04:41:55PM +0530, Pavankumar Kondeti wrote:
> Function fs endpoint files does not have the notion of file position.
> So switch to stream like functionality. This allows concurrent threads
> to be blocked in the ffs read/write operations which use ffs_mutex_lock().
> The ffs mutex lock deploys interruptible wait. Otherwise, threads are
> blocking for the mutex lock in __fdget_pos(). For whatever reason, ff the
> host does not send/receive data for longer time, hung task warnings
> are observed.
> 
> Change-Id: I602fa56fb5ed4c8c46e19df68c3335c4b12cae81

Always run scripts/checkpatch.pl on your patches so you do not get
grumpy maintainers asking you to run scripts/checkpatch.pl on them...

thanks,

greg k-h
