Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8C3FCFC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 01:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbhHaXGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 19:06:02 -0400
Received: from rosenzweig.io ([138.197.143.207]:44836 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240560AbhHaXGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 19:06:01 -0400
Date:   Tue, 31 Aug 2021 17:32:07 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Support IOMMU page sizes larger than the CPU page
 size
Message-ID: <YS6f17iFVq9wYPFN@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828153642.19396-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Some background: On the Apple M1 the IOMMUs are hardwired to only support 16 KB pages.
> We'd still like to boot Linux with 4KB pages though because that's what most distros
> ship these days. This patch series adds support for that setup to the IOMMU DMA API.

This isn't just a distro issue -- efficient x86_64 emulation will rely
on 4KB as well (Rosetta, FEX, ...). Telling distros to use 16KB kernels
for Apple parts is just kicking the can down the road -- we want this
series even for kernels we build ourselves.
