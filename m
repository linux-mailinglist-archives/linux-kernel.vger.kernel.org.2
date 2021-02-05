Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825A8310780
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBEJPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhBEJHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:07:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DCCC64FD8;
        Fri,  5 Feb 2021 09:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612515909;
        bh=8kU1sOKnvGKSA4kIBOEOBJ3217Z14XZu+oE3K4f1cQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7XI5F+lzNajjT25oNcGlutpm2IPyEgAQxbOcOiddR6D8BvgtQnv6uIt0yyHHDgLN
         ID7LtHXs76OaIjAhJutoR/SesieoOtHddmHVl+kILlGRmXOw0JkUwVJxEHGnu98pjc
         VZg7aASArxwmIzmH/EOmowRMH06PqqS1dhaUYEMA=
Date:   Fri, 5 Feb 2021 10:04:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benson Leung <bleung@google.com>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        bleung@kernel.org, linux-usb@vger.kernel.org, pmalani@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Fix for cros_ec_typec for USB for v5.12 merge window
Message-ID: <YB0KO7Nhira7NPBy@kroah.com>
References: <YBxKC0IeWBJ/X/wJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBxKC0IeWBJ/X/wJ@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:24:59AM -0800, Benson Leung wrote:
> Hi Greg,
> 
> I found a bug in the typec driver you pulled earlier this week
> and Prashant developed a fix.
> 
> The following changes since commit 64eaa0fa66ac55965f793a8b65730299854e55cd:
> 
>   platform/chrome: cros_ec_typec: Fix call to typec_partner_set_pd_revision (2021-02-02 19:42:52 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-ib-usb-typec-chrome-platform-cros-ec-typec-clear-pd-discovery-events-for-5.12

Now pulled and pushed out, thanks.

greg k-h
