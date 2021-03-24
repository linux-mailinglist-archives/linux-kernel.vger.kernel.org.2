Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2986334722A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhCXHNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:13:13 -0400
Received: from verein.lst.de ([213.95.11.211]:35696 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235726AbhCXHNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:13:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1FC2268B02; Wed, 24 Mar 2021 08:13:06 +0100 (CET)
Date:   Wed, 24 Mar 2021 08:13:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        paulmck@kernel.org, ast@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, hch@lst.de, m.szyprowski@samsung.com,
        song.bao.hua@hisilicon.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: make map_benchmark compile into module
Message-ID: <20210324071305.GB647@lst.de>
References: <1616552258-22282-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616552258-22282-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:17:38AM +0800, Tian Tao wrote:
> under some scenarios, it is necessary to compile map_benchmark
> into module to test iommu, so this patch changed Kconfig and
> export_symbol to implement map_benchmark compiled into module.
> 
> On the other hand, map_benchmark is a driver, which is supposed
> to be able to run as a module.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Nope, we're not going to export more kthread internals for a test
module.
