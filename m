Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C3645063E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhKOOIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhKOOI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:08:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A269861104;
        Mon, 15 Nov 2021 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636985133;
        bh=VkEvTyZzw5kgnM3r67IPpEh+ipxBl/9VUZgnIrAFDOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZUKbwK+4M5VTNmakW0TwCP4ClSDf+LmkMMKoqIB6u9StDE/2os6LQRXjsfS2c/5b
         cwKHHeyKnE96gdWCiurpZKITFeZkpGLEQPi8T4eQ81jK6gUSK0EUu9FHkt/k/21gcn
         2ejr2SqY3ukPge7tnFs4Q6qJBQD8CyIhVML0mt0Q=
Date:   Mon, 15 Nov 2021 15:05:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, jack@suse.cz, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com, stable-commits@vger.kernel.org
Subject: Re: Patch "block: Hold invalidate_lock in BLKRESETZONE ioctl" has
 been added to the 5.10-stable tree
Message-ID: <YZJpKiXdsLw3gPWh@kroah.com>
References: <163698414911658@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163698414911658@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 02:49:10PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     block: Hold invalidate_lock in BLKRESETZONE ioctl
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Oops, no, these are now dropped from the 5.10.y and 5.14.y queues, sorry
about that.


greg k-h
