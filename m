Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6302322AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhBWM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232734AbhBWM6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:58:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B549064E62;
        Tue, 23 Feb 2021 12:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614085074;
        bh=rhzm5JG8eb5/DmRoVauZVUizQsVvzGQwlt1VbYXoOGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xjxB1yNT8oxI6NsJTb6Vd01NHPJGsbtGYC0j7ArY589nzrYiPEvHsp/wdmKa9GAIx
         ofXsZ2qi1PE8eiOfD8De5RqW5H9ztVgM6iiub2YaMYBALwwlMu3yL3n4sdoysJz3Zw
         9i6Qab/KW8fz5uP5W+XOmYCBV8SZOaMF355iNtXs=
Date:   Tue, 23 Feb 2021 13:57:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.11 00/12] 5.11.1-rc1 review
Message-ID: <YDT7z/FHCgIQ+2Rk@kroah.com>
References: <20210222121013.586597942@linuxfoundation.org>
 <20210222212917.GG98612@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222212917.GG98612@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 01:29:17PM -0800, Guenter Roeck wrote:
> On Mon, Feb 22, 2021 at 01:12:52PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.11.1 release.
> > There are 12 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 24 Feb 2021 12:07:46 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 435 pass: 435 fail: 0
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks for testing them all and letting me know.

greg k-h
