Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE2412A21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 02:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242546AbhIUBAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:00:44 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55374 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243191AbhIUA6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 20:58:43 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mSU5i-0003wa-Vb; Tue, 21 Sep 2021 08:56:59 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mSU5V-00067s-Fx; Tue, 21 Sep 2021 08:56:45 +0800
Date:   Tue, 21 Sep 2021 08:56:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [linux-next:master 3857/7963]
 arch/x86/crypto/sm4-aesni-avx-asm_64.o: warning: objtool:
 sm4_aesni_avx_crypt8()+0x8: sibling call from callable instruction with
 modified stack frame
Message-ID: <20210921005645.GA23480@gondor.apana.org.au>
References: <202108160330.T1EbbpCi-lkp@intel.com>
 <CAK8P3a3qhfxUC-7y-_q35-tNrs2L93htjuVzSukqZO0hDhOAuw@mail.gmail.com>
 <20210920175656.cjvrr4wn7a3k6tnx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920175656.cjvrr4wn7a3k6tnx@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 10:56:56AM -0700, Josh Poimboeuf wrote:
>
> Indeed!  This looks completely broken with CONFIG_FRAME_POINTER.
> 
> Needs something like:

Please send a copy to linux-crypto.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
