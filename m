Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B934BC5A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhC1MkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 08:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhC1MkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 08:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A217600EF;
        Sun, 28 Mar 2021 12:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616935205;
        bh=eu5d97hSMAWimAQeOp1i4JVeqM3czhuZjG/u5FMBSbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqzFwpXWBsAshmGZg+OLXCEg2MqP1e9r33/GkjOzYfBHKg4OnWyotM9iFHVbHmzAM
         btPzRhVyq5ZK5MzJccv4E1xy6gDFcP4Ucr4zZdLd09acmjcENw/SKjs9+bLdIpuikS
         Az5aFkVoQtS53R6pNWNozfZXF5KTO/Fh/T/ze/eE=
Date:   Sun, 28 Mar 2021 14:40:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdbts: Switch to do_sys_openat2() for breakpoint testing
Message-ID: <YGB5IlM7/WqSOdQ2@kroah.com>
References: <20210325094807.3546702-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325094807.3546702-1-daniel.thompson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:48:07AM +0000, Daniel Thompson wrote:
> Currently kgdbts can get stuck waiting for do_sys_open() to be called
> in some of the current tests. This is because C compilers often
> automatically inline this function, which is a very thin wrapper around
> do_sys_openat2(), into some of its callers. gcc-10 does this on (at least)
> both x86 and arm64.
> 
> We can fix the test suite by placing the breakpoints on do_sys_openat2()
> instead since that isn't (currently) inlined. However do_sys_openat2() is
> a static function so we cannot simply use an addressof. Since we are
> testing debug machinery it is acceptable to use kallsyms to lookup a
> suitable address because this is more or less what kdb does in the same
> circumstances. Re-implement lookup_addr() to be based on kallsyms rather
> than function pointers.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> 
> Notes:
>     So less than a week ago I said I had nothing pending for kgdbts.
>     That was entirely true when I said it... but then this came up.

No worries, I'll take this too :)

thanks,

greg k-h
