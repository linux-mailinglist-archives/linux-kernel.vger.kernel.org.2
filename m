Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A88316458
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBJKwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:52:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhBJKs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:48:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63B2A64E32;
        Wed, 10 Feb 2021 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612954098;
        bh=A+tqUFt0v8C9om2Xb5/6c/J5Tk6/Nn0sYZZCRyzgco0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qepgKNGPFnho/8QJnDNNpJZJ069jF0DqEVa4U0mzFOfZ6XAx1Ze6eJ3X37gqjvHX+
         1ezWbeX1QUCzheOeQ1QelmyKHj2o+77sDIdiEU4Nzj/ZhZr3u5/2V37I0Q83Ae1gnl
         /5GfpvERdrBEdLe7Yr6faKnMSyX52giFPbb+9wC4=
Date:   Wed, 10 Feb 2021 11:48:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hikaru Nishida <hikalium@chromium.org>
Cc:     linux-kernel@vger.kernel.org, suleiman@google.com,
        Alexander Graf <graf@amazon.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 2/2] drivers/virt: introduce CLOCK_BOOTTIME
 adjustment sysfs interface driver
Message-ID: <YCO579W6NQOWgKYp@kroah.com>
References: <20210210103908.1720658-1-hikalium@google.com>
 <20210210193728.RFC.2.I03c0323c1564a18210ec98fb78b3eb728a90c2d2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210193728.RFC.2.I03c0323c1564a18210ec98fb78b3eb728a90c2d2@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 07:39:08PM +0900, Hikaru Nishida wrote:
> From: Hikaru Nishida <hikalium@chromium.org>
> 
> This adds a sysfs interface /sys/kernel/boottime_adj to enable advancing
> CLOCK_BOOTTIME from the userspace without actual susupend/resume cycles.
> 
> This gives a way to mitigate CLOCK_BOOTTIME divergence between guest
> and host on virtualized environments after suspend/resume cycles on
> the host.
> 
> We observed an issue of a guest application that expects there is a gap
> between CLOCK_BOOTTIME and CLOCK_MONOTONIC after the device is suspended
> to detect whether the device went into suspend or not.
> Since the guest is paused instead of being actually suspended during the
> host's suspension, guest kernel doesn't advance CLOCK_BOOTTIME correctly
> and there is no way to correct that.
> 
> To solve the problem, this change introduces a way to modify a gap
> between those clocks and align the timer behavior to host's one.
> 
> Signed-off-by: Hikaru Nishida <hikalium@chromium.org>
> ---
> 
>  drivers/virt/Kconfig        |  9 ++++++
>  drivers/virt/Makefile       |  1 +
>  drivers/virt/boottime_adj.c | 57 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>  create mode 100644 drivers/virt/boottime_adj.c

No Documentation/ABI/ update for your new sysfs file?  Please fix...
