Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28CA34F5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhCaBK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhCaBK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:29 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E756C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:10:28 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xf4KNvz9shx; Wed, 31 Mar 2021 12:10:26 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     kernel test robot <lkp@intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210318234441.GA63469@f8e20a472e81>
References: <202103190721.joUfcBzf-lkp@intel.com> <20210318234441.GA63469@f8e20a472e81>
Subject: Re: [PATCH] powerpc/iommu/debug: fix ifnullfree.cocci warnings
Message-Id: <161715298004.226945.14572289924746154784.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 07:44:41 +0800, kernel test robot wrote:
> arch/powerpc/kernel/iommu.c:76:2-16: WARNING: NULL check before some freeing functions is not needed.
> 
>  NULL check before some freeing functions is not needed.
> 
>  Based on checkpatch warning
>  "kfree(NULL) is safe this check is probably not required"
>  and kfreeaddr.cocci by Julia Lawall.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/iommu/debug: fix ifnullfree.cocci warnings
      https://git.kernel.org/powerpc/c/bbbe563f8490958861777d98871e16960163ea1b

cheers
