Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6E931610E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhBJIb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:31:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhBJI3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:29:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF99564E3E;
        Wed, 10 Feb 2021 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612945749;
        bh=LQsCzkjx0NLKt5cCCr3XUfYAv8RvJqK9I98Kr6IhBgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQDIvFBuQJ5SvJ4bRDcaVx9yjjH1s9eUwIcUNfeJ03WdWf+Q+y1EGWVnwjtjZmDVH
         XlAsBOebsTqD/in+4O3zVHTxEtS8tm43Ps5OA7LF9pEt8VvZrZVpSXq8dFwQLf0vle
         31jZ98rJCwGk/y+f+gP2vgQdwvH4RTuGbPk6BKuk=
Date:   Wed, 10 Feb 2021 09:29:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Igor Torrente <igormtorrente@gmail.com>
Cc:     linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH 5.4 00/65] 5.4.97-rc1 review
Message-ID: <YCOZUtmBNXVSgyJk@kroah.com>
References: <20210208145810.230485165@linuxfoundation.org>
 <CAOA8r4Gzz=F-T=+Du9-YgGeygz3mkx03TOJ5pPsHUp4fAEFBZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOA8r4Gzz=F-T=+Du9-YgGeygz3mkx03TOJ5pPsHUp4fAEFBZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 08:00:00AM -0300, Igor Torrente wrote:
> On Mon, Feb 8, 2021 at 12:24 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.4.97 release.
> > There are 65 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 10 Feb 2021 14:57:55 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.97-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> >
> 
> Compiled and booted on my machine(x86_64) without any dmesg regression.
> My compilation uses the default Debian 10 .config(From kernel
> 4.19.0-14-amd64), followed by olddefconfig.
> 
> Tested-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>

Thanks for testing and letting me know.

greg k-h
