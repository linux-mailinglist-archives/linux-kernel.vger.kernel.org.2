Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61023363A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhDSEFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54461 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237471AbhDSEFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:05:05 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVl5gQ4z9tl3; Mon, 19 Apr 2021 14:04:31 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        alistair@popple.id.au, maddy@linux.ibm.com,
        christophe.leroy@csgroup.eu, ravi.bangoria@linux.ibm.com,
        rppt@kernel.org, paulus@samba.org, john.ogness@linutronix.de,
        jniethe5@gmail.com, pmladek@suse.com, Pu Lehui <pulehui@huawei.com>
Cc:     yangjihong1@huawei.com, zhangjinhao2@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210409070151.163424-1-pulehui@huawei.com>
References: <20210409070151.163424-1-pulehui@huawei.com>
Subject: Re: [PATCH -next] powerpc/xmon: Make symbol 'spu_inst_dump' static
Message-Id: <161880479868.1398509.405544111450941367.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 15:01:51 +0800, Pu Lehui wrote:
> Fix sparse warning:
> 
> arch/powerpc/xmon/xmon.c:4216:1: warning:
>  symbol 'spu_inst_dump' was not declared. Should it be static?
> 
> This symbol is not used outside of xmon.c, so make it static.

Applied to powerpc/next.

[1/1] powerpc/xmon: Make symbol 'spu_inst_dump' static
      https://git.kernel.org/powerpc/c/f234ad405a35262ed2d8dd2d29fc633908dce955

cheers
