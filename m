Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8A93E2B3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244231AbhHFNUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241700AbhHFNUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:20:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F5E3610CB;
        Fri,  6 Aug 2021 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628256023;
        bh=4fUwVtY0UBd4gZKl2UhdGSxZuzyaO+mlZjfxAwkOBko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z5eU5YPszznDZKXOwijl4rNlhSV8jVgbfVcQtXJY4yQquFWERxMsoo4cVCy9A3Fkg
         QAmTnQkDi93wYpBDJxtDbFdcQupzYtfkK5k8u98wOVLxdI6CLr6n3OdSvL0qXVw4wH
         A/5229nDkUSEbSOvIYfA9pcBqbZnhOdVj1u8Wmd0=
Date:   Fri, 6 Aug 2021 15:20:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] slimbus: patches (set 1) for 5.15
Message-ID: <YQ03FPyxF8DFlwI7@kroah.com>
References: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:16:35AM +0100, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Recently runtime pm testing on slimbus reveled that its
> totally broken on SlimBus ngd drivers.
> 
> Below are the fixes to get it back working.
> 
> - One of the reason begin incorrect device pointer used for
> runtime pm and in some places
> 
> - Second one was to do with unable to validate transaction id
>  which resulted in negative runtime pm count.
> 
> - Other fix was to do with resetting dma addresses once ngd
> controller is power-cycled.
> 
> With all these fixed runtime pm is now fully functional on NGD
> controllers.
> 
> Currently I marked them all with Cc: <stable@vger.kernel.org>
> as these all patches are required to fix runtime pm on SlimBus
> NGD controller.
> 
> Can you please queue them up for 5.15.

Why do you want these for 5.15-rc1 when you need them to fix problems in
5.14?  Shouldn't they go into 5.14-final?

confused,

greg k-h
