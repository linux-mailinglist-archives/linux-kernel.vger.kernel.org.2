Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4A363A06
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhDSEFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54971 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237359AbhDSEEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:52 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVY4vwpz9vGp; Mon, 19 Apr 2021 14:04:20 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, benh@kernel.crashing.org, alistair@popple.id.au,
        mpe@ellerman.id.au, paulus@samba.org,
        Li Huafei <lihuafei1@huawei.com>, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, yangjihong1@huawei.com,
        linuxppc-dev@lists.ozlabs.org, zhangjinhao2@huawei.com
In-Reply-To: <20210408033951.28369-1-lihuafei1@huawei.com>
References: <20210408033951.28369-1-lihuafei1@huawei.com>
Subject: Re: [PATCH -next] powerpc/security: Make symbol 'stf_barrier' static
Message-Id: <161880479001.1398509.6935026820404555887.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 11:39:51 +0800, Li Huafei wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/kernel/security.c:253:6: warning:
>  symbol 'stf_barrier' was not declared. Should it be static?
> 
> This symbol is not used outside of security.c, so this commit marks it
> static.

Applied to powerpc/next.

[1/1] powerpc/security: Make symbol 'stf_barrier' static
      https://git.kernel.org/powerpc/c/7f262b4dcf7edf75097c3946e676d6c6d77fc599

cheers
