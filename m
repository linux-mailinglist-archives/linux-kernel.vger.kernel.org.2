Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3737E39CEEE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhFFMPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFFMON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:14:13 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9697C061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:23 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3S67zcz9t1r; Sun,  6 Jun 2021 22:12:20 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
        YueHaibing <yuehaibing@huawei.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210514071041.17432-1-yuehaibing@huawei.com>
References: <20210514071041.17432-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] powerpc/pseries/memhotplug: Remove unused inline function dlpar_memory_remove()
Message-Id: <162298131833.2353459.4514813747754717384.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 15:10:41 +0800, YueHaibing wrote:
> dlpar_memory_remove() is never used, so can be removed.

Applied to powerpc/next.

[1/1] powerpc/pseries/memhotplug: Remove unused inline function dlpar_memory_remove()
      https://git.kernel.org/powerpc/c/9b373899e9606d252364191ce2b385043a8808bc

cheers
