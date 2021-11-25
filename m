Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20DC45DF86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347158AbhKYRXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241288AbhKYRVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:21:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45FDE61059;
        Thu, 25 Nov 2021 17:17:56 +0000 (UTC)
Date:   Thu, 25 Nov 2021 17:17:53 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Calvin Zhang <calvinzhang.cool@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: kmemleak: alloc gray object for reserved region with
 direct map.
Message-ID: <YZ/FQXS3gWZ2xfEy@arm.com>
References: <20211123090641.3654006-1-calvinzhang.cool@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123090641.3654006-1-calvinzhang.cool@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:06:41PM +0800, Calvin Zhang wrote:
> Reserved regions with direct mapping may contain references to other
> regions. CMA region with fixed location is reserved without creating
> kmemleak_object for it.
> 
> So add them as gray kmemleak objects.

Do you get any kmemleak false positives without this patch? It would be
good to include them in the commit message.

Without seeing a false positive caused by this, I'm not convinced it is
the right approach. You mentioned CMA but telling kmemleak about the
whole CMA region is a pretty big hammer. I'd rather add individual
kmemleak_alloc_*() calls in cma_alloc().

-- 
Catalin
