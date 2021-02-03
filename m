Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D625E30E2C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhBCSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:49:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhBCStY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:49:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 910D464DE1;
        Wed,  3 Feb 2021 18:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612378123;
        bh=XKJddM4Inmkq4KHX8HcKQt/b0ST36GmjTbUJvWsFPEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qG6MVI5QKtlfKG59JK4dlrshVDoU5GrypplHguciDCYsSA05Nv42GHR1zf5kWOmDo
         uaqjGMYTFGprge8U9k8NPAnSlcZ4EScKgyZ78jHBDeFfVu8saJ+86mkoSEPZVI034O
         SAVJXN3R6MpqCI17EKTJgw4j88MdF1OB5PItvWqO4leBYuJhxRKf8tA0KmeLa4qo4Q
         L6H3oKDckOyxw+SF9lrkGTSSGATSuzUXd06/4gin7hkfiRPGLads5kEb5jpm37ispN
         zrXdnZw0x38PoXhK4ZNtg+2eQlXYqBqaHe0xgFF6jQdq5FLkgIgEjwapW/VT3qgqbK
         e+wZNWpnknc7A==
Date:   Wed, 3 Feb 2021 11:48:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mm/mremap: fix BUILD_BUG_ON() error in get_extent
Message-ID: <20210203184840.GA1711681@localhost>
References: <20201230154104.522605-1-arnd@kernel.org>
 <20210112191634.GA1587546@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112191634.GA1587546@ubuntu-m3-large-x86>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:16:34PM -0700, Nathan Chancellor wrote:
> On Wed, Dec 30, 2020 at 04:40:40PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > clang cannt evaluate this function argument at compile time
> > when the function is not inlined, which leads to a link
> > time failure:
> > 
> > ld.lld: error: undefined symbol: __compiletime_assert_414
> > >>> referenced by mremap.c
> > >>>               mremap.o:(get_extent) in archive mm/built-in.a
> > 
> > Mark the function as __always_inline to avoid it.
> > 
> > Fixes: 9ad9718bfa41 ("mm/mremap: calculate extent in one place")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I would like to see some movement on getting this fixed in 5.11. As it
> stands, this is one of three __compiletime_assert references with
> CONFIG_UBSAN_UNSIGNED_OVERFLOW. If we want to keep the BUILD_BUG()
> around, I think this is fine. Alternatively, turning it into a runtime
> check would be fine too.
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Ping? It is pretty late into the 5.11 cycle and this is still broken.

Cheers,
Nathan

> > ---
> >  mm/mremap.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index c5590afe7165..1cb464a07184 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -336,8 +336,9 @@ enum pgt_entry {
> >   * valid. Else returns a smaller extent bounded by the end of the source and
> >   * destination pgt_entry.
> >   */
> > -static unsigned long get_extent(enum pgt_entry entry, unsigned long old_addr,
> > -			unsigned long old_end, unsigned long new_addr)
> > +static __always_inline unsigned long get_extent(enum pgt_entry entry,
> > +			unsigned long old_addr, unsigned long old_end,
> > +			unsigned long new_addr)
> >  {
> >  	unsigned long next, extent, mask, size;
> >  
> > -- 
> > 2.29.2
>  
