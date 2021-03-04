Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32A532D3E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbhCDNID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241092AbhCDNHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:07:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFD8A64F04;
        Thu,  4 Mar 2021 13:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614863228;
        bh=PoUZt7/VmCLpDxeN+0y2s7PKMDbV1FmM7FzfAmlbCUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gW/Blo95cl82eTLjajhQFJtbBMakAhsYmEF2OK5dqLRsqYRubId4b5pg36Cavo7dh
         DNSExyOML/tuhOurlsWQ76UJhJ5qr0yJ2SqOUWYdNw09Z2l4VtP+IW0WfmbXfCjKOH
         yAkGtJRDA3YX4GVKNAdKMPl8Ogmp/ZoYoS+qqfUk=
Date:   Thu, 4 Mar 2021 14:07:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Ray Chi <raychi@google.com>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: next/master bisection: baseline.login on rk3399-gru-kevin
Message-ID: <YEDbeY03ATiiL0pa@kroah.com>
References: <6040cc3b.1c69fb81.cba3d.5b5c@mx.google.com>
 <9ada6ed0-eef0-407b-cf9b-22d077cee578@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ada6ed0-eef0-407b-cf9b-22d077cee578@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 12:22:02PM +0000, Guillaume Tucker wrote:
> Hi Ray,
> 
> Please see the bisection report below about a boot failure on
> rk3399-gru-kevin on linux-next.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
> 
> The boot log shows a kernel panic with a NULL pointer
> dereference:
> 
>   https://storage.kernelci.org/next/master/next-20210304/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html#L673

Well known issue, fix is already in my tree, will show up in the next
linux-next, thanks!

greg k-h
