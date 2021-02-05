Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727A231138F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhBEV3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233189AbhBEV2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:28:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3720C64FC4;
        Fri,  5 Feb 2021 21:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612560461;
        bh=yhmeBeO2q9xijicZxHwk14pnWtru8GjD3VNfn3hof+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jq1wiEBjxnS0B9nj2LF6TPnCa1zsoQ5lcN0dPGqybCOSr2aGcaOohATh0eDj4BAC3
         Ea3s/959s5gHpbtCcFW/UXRJo1D8TsV4jcTkkhI8pSz/rg59ss2BxxzJ9gbuYfH0QQ
         cPJWcRhSVyBPtqf2k6qkGIXgAI0xlG+mvcbUxED98M6kn3hvyY9wm3Kgw40qg5Xo6V
         MavGyes/ngq5FHv78MfXemZ243HgY4++5jpxVIwNcqGAlCLPxAv8tt8X37APea9auh
         eD3F018u2Zad/1p6KpUe8I5vGXFkgSLDSI6xwye1w2oiYyU+vTIb0PBtzb6r+3dup9
         +F9sUFoQijPbw==
Date:   Fri, 5 Feb 2021 14:27:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
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
Message-ID: <20210205212724.GA16835@Ryzen-5-4500U.localdomain>
References: <20201230154104.522605-1-arnd@kernel.org>
 <20210112191634.GA1587546@ubuntu-m3-large-x86>
 <20210203184840.GA1711681@localhost>
 <202102031202.F0AEC4A7@keescook>
 <20210205190005.GB461042@localhost>
 <20210205130223.37e6bf7fb8bfc773db9b5fda@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205130223.37e6bf7fb8bfc773db9b5fda@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 01:02:23PM -0800, Andrew Morton wrote:
> On Fri, 5 Feb 2021 12:00:05 -0700 Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > > > > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > 
> > > > Ping? It is pretty late into the 5.11 cycle and this is still broken.
> > > 
> > > I think we should just do the __always_inline. Who can take this?
> > 
> > This should probably go through -mm, unless we get an ack then Nick and
> > I could take it.
> 
> I added it to -mm on Wednesday. 

Thank you! I did not see an email but it looks like my tag did not make
it on to the patch so that would make sense. It would be great if this
could get into 5.11 but if not, we can always backport it

Cheers,
Nathan
