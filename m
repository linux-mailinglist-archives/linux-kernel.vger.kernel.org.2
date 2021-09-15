Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDD740C0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhIOHts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:49:48 -0400
Received: from verein.lst.de ([213.95.11.211]:35280 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhIOHtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:49:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A2A768B05; Wed, 15 Sep 2021 09:48:27 +0200 (CEST)
Date:   Wed, 15 Sep 2021 09:48:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu, hch@lst.de,
        liush@allwinnertech.com, wefu@redhat.com, lazyparser@gmail.com,
        drew@beagleboard.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, taiten.peng@canonical.com,
        aniket.ponkshe@canonical.com, heinrich.schuchardt@canonical.com,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH V4 3/6] RISC-V: Support a new config option for
 non-coherent DMA
Message-ID: <20210915074827.GC20024@lst.de>
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-4-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911092139.79607-4-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 05:21:36PM +0800, guoren@kernel.org wrote:
> +	select DMA_GLOBAL_POOL
> +	select DMA_DIRECT_REMAP

No need to select DMA_GLOBAL_POOL when DMA_DIRECT_REMAP is select.

Also a patch just to add a option that is not selected and won't build
if selected does not make sense.
