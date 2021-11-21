Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53053458276
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 08:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhKUHwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 02:52:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhKUHvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 02:51:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C8C660174;
        Sun, 21 Nov 2021 07:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637480930;
        bh=yrZbAg2VZMn/Jhp85ezFPHv3SOjcOXE38NsMmyE8d+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFgFuh/z8WPGts8AuM7wb79BZ1ZpkTAU8ctM2P+pUTiV//IlEznBvGmCVFpBSMVr9
         3qFMvcDK6yubvQUZxDC4uHrCOsYBS6B/aWpZKlBrA3bKI6ZC3aN2dA8ozXUoMUnZ6E
         93gP7ED+8hdJMtCVG6uJ9KA6IMz6ffBy7MpCJKVY=
Date:   Sun, 21 Nov 2021 08:48:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Lucas Henneman <henneman@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5.10 11/21] arm64: vdso32: suppress error message for
 make mrproper
Message-ID: <YZn531dEhZh7Llmt@kroah.com>
References: <20211119171443.892729043@linuxfoundation.org>
 <20211119171444.250202515@linuxfoundation.org>
 <20211119214713.GB23353@amd>
 <CAKwvOdnxTRuMDDnriD5y26uWeUD8eoTH=6wrcFWvQZj8qOt2yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnxTRuMDDnriD5y26uWeUD8eoTH=6wrcFWvQZj8qOt2yA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 02:24:09PM -0800, Nick Desaulniers wrote:
> On Fri, Nov 19, 2021 at 1:47 PM Pavel Machek <pavel@denx.de> wrote:
> >
> > Hi!
> >
> > > commit 14831fad73f5ac30ac61760487d95a538e6ab3cb upstream.
> > >
> > > When running the following command without arm-linux-gnueabi-gcc in
> > > one's $PATH, the following warning is observed:
> > >
> > > $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 mrproper
> > > make[1]: arm-linux-gnueabi-gcc: No such file or directory
> > >
> > > This is because KCONFIG is not run for mrproper, so CONFIG_CC_IS_CLANG
> > > is not set, and we end up eagerly evaluating various variables that try
> > > to invoke CC_COMPAT.
> >
> > Upstream commit is fine, but 5.10 port misses the 2> part of the
> > change.
> 
> You're right; thanks for the report. Greg, can you drop this version
> of the backport for 5.10 and 5.4? I'll resubmit an updated version.

Now dropped, thanks.

greg k-h
