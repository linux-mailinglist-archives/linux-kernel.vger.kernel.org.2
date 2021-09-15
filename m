Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13340C0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhIOHrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:47:20 -0400
Received: from verein.lst.de ([213.95.11.211]:35237 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhIOHrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:47:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B15D67373; Wed, 15 Sep 2021 09:45:58 +0200 (CEST)
Date:   Wed, 15 Sep 2021 09:45:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu, hch@lst.de,
        liush@allwinnertech.com, wefu@redhat.com, lazyparser@gmail.com,
        drew@beagleboard.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, taiten.peng@canonical.com,
        aniket.ponkshe@canonical.com, heinrich.schuchardt@canonical.com,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC PATCH V4 1/6] riscv: pgtable: Add custom protection_map
 init
Message-ID: <20210915074557.GA20024@lst.de>
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911092139.79607-2-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 05:21:34PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Some RISC-V CPU vendors have defined their own PTE attributes to
> solve non-coherent DMA bus problems. That makes _P/SXXX definitions
> contain global variables which could be initialized at the early
> boot stage before setup_vm. The patch prevents compile errors.

That sounds way to nice for someone who deliberatly ignores the
specification and should definitively not go into the kernel
commit log like this.

> This patch is similar to 316d097c4cd4  (x86/pti: Filter at
> vma->vm_page_prot population) which give a choice for arch custom
> implementation.

How?  To me it looks like a bad duplication of such functionality in
a way that totally breaks abstractions.  architectures really do not
have any business changing protection_map.
