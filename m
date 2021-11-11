Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615AB44D709
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhKKNPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233191AbhKKNPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:15:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 809B0603E8;
        Thu, 11 Nov 2021 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636636351;
        bh=KcxpveW8nNs9jo6raqqZ7oRga3SQkAVo5CHjN2JDXv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zwm6jlo+X+u+DuSDzQtlvkwfFvY/hpb+sIHvN3NvQtpJz8wjidnsINfNqB2wF9JNY
         sBpbQTGGXjhDS+HHWvn6r6N+22UtCMSPkpEZ8YFvPruSU7QZ0t4bW+0clh3xxeR+tz
         GYroQ58/XoL0cOF5QGmhy5/mCxFb3UXg/agAstgQ=
Date:   Thu, 11 Nov 2021 14:12:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jack Pham <jackp@codeaurora.org>,
        Peter Chen <peter.chen@nxp.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] usb: gadget: f_fs: Use stream_open() for endpoint
 files
Message-ID: <YY0WvD57FGums0a8@kroah.com>
References: <20211111120636.GA11612@hu-pkondeti-hyd.qualcomm.com>
 <1636632958-22802-1-git-send-email-quic_pkondeti@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636632958-22802-1-git-send-email-quic_pkondeti@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 05:45:56PM +0530, Pavankumar Kondeti wrote:
> Function fs endpoint files does not have the notion of file position.
> So switch to stream like functionality. This allows concurrent threads
> to be blocked in the ffs read/write operations which use ffs_mutex_lock().
> The ffs mutex lock deploys interruptible wait. Otherwise, threads are
> blocking for the mutex lock in __fdget_pos(). For whatever reason, ff the
> host does not send/receive data for longer time, hung task warnings
> are observed.

So the current code is broken?  What commit caused it to break?

Doesn't this change cause a change in behavior for existing userspace
tools, or will they still work as-is?

thanks,

greg k-h
