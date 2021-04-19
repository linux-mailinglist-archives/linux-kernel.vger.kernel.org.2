Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44DF363A09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhDSEFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237468AbhDSEFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:05:04 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVl0sGnz9vH5; Mon, 19 Apr 2021 14:04:30 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     benh@kernel.crashing.org, mpe@ellerman.id.au,
        christophe.leroy@c-s.fr, joel@jms.id.au, paulus@samba.org,
        Pu Lehui <pulehui@huawei.com>
Cc:     yangjihong1@huawei.com, zhangjinhao2@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210408062012.85973-1-pulehui@huawei.com>
References: <20210408062012.85973-1-pulehui@huawei.com>
Subject: Re: [PATCH -next] powerpc/fadump: make symbol 'rtas_fadump_set_regval' static
Message-Id: <161880480163.1398509.9529896301333711688.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 14:00:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:20:12 +0800, Pu Lehui wrote:
> Fix sparse warnings:
> 
> arch/powerpc/platforms/pseries/rtas-fadump.c:250:6: warning:
>  symbol 'rtas_fadump_set_regval' was not declared. Should it be static?

Applied to powerpc/next.

[1/1] powerpc/fadump: make symbol 'rtas_fadump_set_regval' static
      https://git.kernel.org/powerpc/c/59fd366b9bef2d048af763e27cd1622ee5a1dfd4

cheers
