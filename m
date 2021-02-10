Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF531645C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhBJKxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:53:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhBJKtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:49:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98F9E64E38;
        Wed, 10 Feb 2021 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612954152;
        bh=xuEAqpQCWZdM1vTZm9mWZOn0t6k7CNDtwTAtObZl4a4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x20QtPRkE+KSwll/FbCQT+SAWvi8RZFtX45ZSojCSCfOQr5WIMIJYfDmfWM9jaWh8
         dNiS5dNi64k0ZtMCvUqa9j3ZfrpnuIbupsvtepiw+dY6Ne/uzwQmUJ7dPcARk5z/s7
         7WaP/A93iteT3D0u4LBHKI8nQ5gV+OxcvnN+gDac=
Date:   Wed, 10 Feb 2021 11:49:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hikaru Nishida <hikalium@chromium.org>
Cc:     linux-kernel@vger.kernel.org, suleiman@google.com,
        Alexander Graf <graf@amazon.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 0/2] Introduce a way to adjust CLOCK_BOOTTIME from
 userspace for VM guests
Message-ID: <YCO6JTkK4vzsNVLo@kroah.com>
References: <20210210103908.1720658-1-hikalium@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210103908.1720658-1-hikalium@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 07:39:06PM +0900, Hikaru Nishida wrote:
> From: Hikaru Nishida <hikalium@chromium.org>
> 
> 
> Hi folks,
> 
> We'd like to add a sysfs interface that enable us to advance
> CLOCK_BOOTTIME from userspace.

Why sysfs?  What device is the clock that you are attaching to here?
Why not use the existing kernel api to adjust clocks?

thanks,

greg k-h
