Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F60041364D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhIUPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233860AbhIUPik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:38:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6985660E08;
        Tue, 21 Sep 2021 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632238631;
        bh=1L59Qf8dZlUk3zyJnpg6Mrmzjp8u5lw/A8gCnR4hqtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aawSD7LvOO0CmvE94phTcMeCNI0F76yi1WFd7TKgEA+Fs58sGjRbMyS1f1lBmo2iV
         +bGV42SQqB+0dVvhHIsU6CkeWEoNKhtqcR4w0ePBB6Jnm4h/lnpfVzRJB2eF2HUo3G
         tY9QKgkZPRSogClE8X8GfB43KzfDHOGq5QTmHDEI=
Date:   Tue, 21 Sep 2021 17:37:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au, linux@roeck-us.net,
        jdelvare@suse.com, alistair@popple.id.au, jk@ozlabs.org
Subject: Re: [PATCH 3/3] hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
Message-ID: <YUn8JcqBQVy2Nwd3@kroah.com>
References: <20210914213543.73351-1-eajames@linux.ibm.com>
 <20210914213543.73351-4-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914213543.73351-4-eajames@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:35:43PM -0500, Eddie James wrote:
> Save any FFDC provided by the OCC driver, and provide it to userspace
> through a binary sysfs entry. Do some basic state management to
> ensure that userspace can always collect the data if there was an
> error. Notify polling userspace when there is an error too.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/hwmon/occ/p9_sbe.c | 98 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)

You forgot a Documentation/ABI/ entry :(

Binary sysfs files are for "pass through to the hardware" only, you
should not be dumping kernel data to userspace through them.  I can't
really determine if this is the case here or not, as there's no
documentation saying what you are trying to represent here...

thanks,

greg k-h
