Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5051C37F687
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhEMLO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231255AbhEMLOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:14:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E95F3613CB;
        Thu, 13 May 2021 11:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620904415;
        bh=anjQpvwfyTFxcZGGJ7zk1q+TRMnyGbYfj0RdJHyvSp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K20ZfS6UEaqYXk7kwYCvy/xCaJ0AZgRW9iGnAnlLSZfG+OWytALmkXTN3W5Sn0vp/
         290MMPcBeeVwwXA3Klwr1NW9j5F4uS92X+n7q0YRka1t4KJOz3A+yBoh/bydqs2l74
         av4a9pMZAiPHWcSubu9Djp+SryiW6LrlcbEJ/tSU=
Date:   Thu, 13 May 2021 13:13:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Savo Novakovic <savox.novakovic@intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v3 01/14] intel_gna: add driver module
Message-ID: <YJ0J3eMNfmpHY2tS@kroah.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <20210513110040.2268-2-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513110040.2268-2-maciej.kwapulinski@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:00:27PM +0200, Maciej Kwapulinski wrote:
> +#ifdef CONFIG_DEBUG_INTEL_GNA
> +module_param(recovery_timeout, int, 0644);
> +MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
> +#endif

This is not the 1990's, please no new module parameters ever.  If you
only need this for "debugging" then use debugfs, that's exactly what it
is for.

But really, shouldn't this "just work" and not require someone to change
this by hand?

thanks,

greg k-h
