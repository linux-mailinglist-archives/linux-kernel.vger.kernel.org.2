Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF73AC20E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhFRE0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:26:10 -0400
Received: from ozlabs.org ([203.11.71.1]:55715 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231903AbhFREZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:13 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4R16CSz9t0T; Fri, 18 Jun 2021 14:23:02 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, paulus@samba.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        weiyongjun1@huawei.com
In-Reply-To: <20210601085319.140461-1-libaokun1@huawei.com>
References: <20210601085319.140461-1-libaokun1@huawei.com>
Subject: Re: [PATCH -next] powerpc/spider-pci: Remove set but not used variable 'val'
Message-Id: <162398828887.1363949.15561402899101847554.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 16:53:19 +0800, Baokun Li wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> arch/powerpc/platforms/cell/spider-pci.c: In function 'spiderpci_io_flush':
> arch/powerpc/platforms/cell/spider-pci.c:28:6: warning:
> variable ‘val’ set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction.

Applied to powerpc/next.

[1/1] powerpc/spider-pci: Remove set but not used variable 'val'
      https://git.kernel.org/powerpc/c/f377f7da26d2af87e2ddc39190546f62ecdb2bd8

cheers
