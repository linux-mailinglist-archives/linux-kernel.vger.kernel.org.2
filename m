Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03EA3AC20F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhFRE0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhFREZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:14 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687DC0617AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:23:05 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4R526yz9svs; Fri, 18 Jun 2021 14:23:03 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, jk@ozlabs.org, paulus@samba.org,
        arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     weiyongjun1@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        yuehaibing@huawei.com
In-Reply-To: <20210601085127.139598-1-libaokun1@huawei.com>
References: <20210601085127.139598-1-libaokun1@huawei.com>
Subject: Re: [PATCH -next] powerpc/spufs: disp: Remove set but not used variable 'dummy'
Message-Id: <162398828869.1363949.8342892140049622633.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 16:51:27 +0800, Baokun Li wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> arch/powerpc/platforms/cell/spufs/switch.c: In function 'check_ppu_mb_stat':
> arch/powerpc/platforms/cell/spufs/switch.c:1660:6: warning:
> variable ‘dummy’ set but not used [-Wunused-but-set-variable]
> 
> arch/powerpc/platforms/cell/spufs/switch.c: In function 'check_ppuint_mb_stat':
> arch/powerpc/platforms/cell/spufs/switch.c:1675:6: warning:
> variable ‘dummy’ set but not used [-Wunused-but-set-variable]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/spufs: disp: Remove set but not used variable 'dummy'
      https://git.kernel.org/powerpc/c/911bacda4658129bee039dc90fc0c3f193ee2695

cheers
