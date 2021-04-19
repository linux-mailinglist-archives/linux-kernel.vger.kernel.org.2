Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6083639FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhDSEFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233922AbhDSEEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:45 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVR03sGz9vGs; Mon, 19 Apr 2021 14:04:14 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Bixuan Cui <cuibixuan@huawei.com>
Cc:     kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210409063855.57347-1-cuibixuan@huawei.com>
References: <20210409063855.57347-1-cuibixuan@huawei.com>
Subject: Re: [PATCH -next] powerpc/powernv: make symbol 'mpipl_kobj' static
Message-Id: <161880479893.1398509.5196822029182381609.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 14:38:55 +0800, Bixuan Cui wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/platforms/powernv/opal-core.c:74:16: warning:
>  symbol 'mpipl_kobj' was not declared.
> 
> This symbol is not used outside of opal-core.c, so marks it static.

Applied to powerpc/next.

[1/1] powerpc/powernv: make symbol 'mpipl_kobj' static
      https://git.kernel.org/powerpc/c/ff0b4155ae9903539d1299a9a4c8717fb7eb6009

cheers
