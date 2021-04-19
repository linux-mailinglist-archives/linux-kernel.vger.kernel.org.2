Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73534363A08
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbhDSEFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbhDSEFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:05:01 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE2AC061760
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 21:04:29 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVW5p1zz9vDw; Mon, 19 Apr 2021 14:04:19 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, mahesh@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, santosh@fossix.org,
        christophe.leroy@csgroup.eu, paulus@samba.org,
        Li Huafei <lihuafei1@huawei.com>, ganeshgr@linux.ibm.com,
        clg@kaod.org
Cc:     yangjihong1@huawei.com, zhangjinhao2@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210408035802.31853-1-lihuafei1@huawei.com>
References: <20210408035802.31853-1-lihuafei1@huawei.com>
Subject: Re: [PATCH -next] powerpc/mce: Make symbol 'mce_ue_event_work' static
Message-Id: <161880479027.1398509.16254201379710862051.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 11:58:02 +0800, Li Huafei wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/kernel/mce.c:43:1: warning:
>  symbol 'mce_ue_event_work' was not declared. Should it be static?
> 
> This symbol is not used outside of mce.c, so this commit marks it
> static.

Applied to powerpc/next.

[1/1] powerpc/mce: Make symbol 'mce_ue_event_work' static
      https://git.kernel.org/powerpc/c/f6f1f48e8b3b242dfa684d6e1b930d239d87533a

cheers
