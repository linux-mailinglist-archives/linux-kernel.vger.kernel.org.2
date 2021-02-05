Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66656311310
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhBETX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 14:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhBETUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 14:20:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E13C64FB1;
        Fri,  5 Feb 2021 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612558945;
        bh=vzHM+GB4d6cNHxt/eXwSgK8ie3TrlRUy0i2DzIfSIqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2IMkEBmnIJ3N9+KJfo5rYf3xEfWx9JNSithtGkCniKXlKzJ2yqtY/3pj+vuFYUo/w
         MXCq1GXFUIQh0/viPwqh8WGNR8iLVI39aUMgBYnXV4d0mMH8x9ZUDmCbR63shUv9GJ
         fyismZVQf1eJ/gpYA1d5I4cyT4o6fF4q6VapGdYY=
Date:   Fri, 5 Feb 2021 13:02:23 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mm/mremap: fix BUILD_BUG_ON() error in get_extent
Message-Id: <20210205130223.37e6bf7fb8bfc773db9b5fda@linux-foundation.org>
In-Reply-To: <20210205190005.GB461042@localhost>
References: <20201230154104.522605-1-arnd@kernel.org>
        <20210112191634.GA1587546@ubuntu-m3-large-x86>
        <20210203184840.GA1711681@localhost>
        <202102031202.F0AEC4A7@keescook>
        <20210205190005.GB461042@localhost>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 12:00:05 -0700 Nathan Chancellor <nathan@kernel.org> wrote:

> > > > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > > 
> > > Ping? It is pretty late into the 5.11 cycle and this is still broken.
> > 
> > I think we should just do the __always_inline. Who can take this?
> 
> This should probably go through -mm, unless we get an ack then Nick and
> I could take it.

I added it to -mm on Wednesday. 
