Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3200634B644
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 11:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhC0KhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 06:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhC0KhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 06:37:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B989C619E8;
        Sat, 27 Mar 2021 10:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616841429;
        bh=Mt7kcgav9t3UMu8lOOB6Tru6R5Kg48wvZoEAI9VQWC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DSyPj5WsKtNFR6bG0KEoMU8yTTTOjQ9wGQ6ZjMaPAxEkH4K3DwpCFylYrq47HhSMh
         E5Gdr3RKwmCd6g+pn7sypeylG/54ZovWQyhGcCoCztui8lr25pXoSy7AmpKpNf8Ziq
         9DNhHoNhgUorhPhsldmYaypevoKllJisZweqbh2E=
Date:   Sat, 27 Mar 2021 11:37:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Lochmann <info@alexander-lochmann.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] Introduced new tracing mode KCOV_MODE_UNIQUE.
Message-ID: <YF8K0k1bc3e381qS@kroah.com>
References: <20210326205135.6098-1-info@alexander-lochmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326205135.6098-1-info@alexander-lochmann.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 09:51:28PM +0100, Alexander Lochmann wrote:
> It simply stores the executed PCs.
> The execution order is discarded.
> Each bit in the shared buffer represents every fourth
> byte of the text segment.
> Since a call instruction on every supported
> architecture is at least four bytes, it is safe
> to just store every fourth byte of the text segment.
> In contrast to KCOV_MODE_TRACE_PC, the shared buffer
> cannot overflow. Thus, all executed PCs are recorded.

Odd line-wrapping :(

Anyway, this describes _what_ this does, but I have no idea _why_ we
want this at all.  What does this do that you can not do today?  Why is
this needed?  Who will use this?  What tools have been modified to work
with it to prove it works properly?

thanks,

greg k-h
