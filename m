Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD52370967
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhEBAV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 20:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhEBAV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 20:21:28 -0400
X-Greylist: delayed 2549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 May 2021 17:20:37 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BE1C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 17:20:37 -0700 (PDT)
Received: from [2400:4160:1877:2b00:fc5f:fa70:7483:1006] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1lczBQ-0005em-Kb; Sat, 01 May 2021 23:38:01 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1lczBK-0005aQ-5j; Sun, 02 May 2021 08:37:54 +0900
Date:   Sun, 2 May 2021 08:37:54 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: Very slow clang kernel config ..
Message-ID: <20210501233754.4he27eoteqvplywu@glandium.org>
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RDNS_NONE,SPF_FAIL,SPF_HELO_FAIL autolearn=disabled version=3.4.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 06:48:11PM -0700, Nick Desaulniers wrote:
> On Fri, Apr 30, 2021 at 6:22 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, Apr 30, 2021 at 5:25 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > Ah, no, sorry, these are the runtime link editor/loader. So probably
> > > spending quite some time resolving symbols in large binaries.
> >
> > Yeah. Appended is the profile I see when I profile that "make
> > oldconfig", so about 45% of all time seems to be spent in just symbol
> > lookup and relocation.
> >
> > And a fair amount of time just creating and tearing down that huge
> > executable (with a lot of copy-on-write overhead too), with the kernel
> > side of that being another 15%. The cost of that is likely also fairly
> > directly linked to all the dynamic linking costs, which brings in all
> > that data.
> >
> > Just to compare, btw, this is the symbol lookup overhead for the gcc case:
> >
> >    1.43%  ld-2.33.so             do_lookup_x
> >    0.96%  ld-2.33.so             _dl_relocate_object
> >    0.69%  ld-2.33.so             _dl_lookup_symbol_x
> >
> > so it really does seem to be something very odd going on with the clang binary.
> >
> > Maybe the Fedora binary is built some odd way, but it's likely just
> > the default clang build.
> >
> >              Linus
> >
> > ----
> >   23.59%  ld-2.33.so          _dl_lookup_symbol_x
> >   11.41%  ld-2.33.so          _dl_relocate_object
> >    9.95%  ld-2.33.so          do_lookup_x
> >    4.00%  [kernel.vmlinux]    copy_page
> >    3.98%  [kernel.vmlinux]    next_uptodate_page
> >    3.05%  [kernel.vmlinux]    zap_pte_range
> >    1.81%  [kernel.vmlinux]    clear_page_rep
> >    1.68%  [kernel.vmlinux]    asm_exc_page_fault
> >    1.33%  ld-2.33.so          strcmp
> >    1.33%  ld-2.33.so          check_match
> 
> 47.61% spent in symbol table lookup. Nice. (Not counting probably a
> fair amount of the libc calls below).
> 
> >    0.92%  libLLVM-12.so       llvm::StringMapImpl::LookupBucketFor
> 
> ^ wait a minute; notice how in your profile the `Shared Object` is
> attributed to `libLLVM-12.so` while mine is `clang-13`?  Clang can be
> built as either having libllvm statically linked or dynamically; see
> the cmake variables
> LLVM_BUILD_LLVM_DYLIB:BOOL
> LLVM_LINK_LLVM_DYLIB:BOOL
> BUILD_SHARED_LIBS:BOOL
> https://llvm.org/docs/CMake.html
> 
> I think those are frowned upon; useful for cutting down on developers
> iteration speed due to not having to relink llvm when developing
> clang. But shipping that in production? I just checked and it doesn't
> look like we do that for AOSP's build of LLVM.
> 
> Tom, is one of the above intentionally set for clang builds on Fedora?
> I'm guessing it's intentional that there are packages for
> libLLVM-12.so and libclang-cpp.so.12, perhaps they have other
> dependents?

Have you tried building clang/llvm with -Bsymbolic-functions?

Mike
