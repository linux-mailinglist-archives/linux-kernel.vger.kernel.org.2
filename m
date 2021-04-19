Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E99363A05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhDSEFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbhDSEEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:51 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA42C061760
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 21:04:22 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVW1MKxz9vH8; Mon, 19 Apr 2021 14:04:18 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>, brking@linux.vnet.ibm.com,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210408201915.174217-1-leobras.c@gmail.com>
References: <20210408201915.174217-1-leobras.c@gmail.com>
Subject: Re: [PATCH v3 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes present in LoPAR
Message-Id: <161880479738.1398509.9530172524794582983.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 17:19:16 -0300, Leonardo Bras wrote:
> According to LoPAR, ibm,query-pe-dma-window output named "IO Page Sizes"
> will let the OS know all possible pagesizes that can be used for creating a
> new DDW.
> 
> Currently Linux will only try using 3 of the 8 available options:
> 4K, 64K and 16M. According to LoPAR, Hypervisor may also offer 32M, 64M,
> 128M, 256M and 16G.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes present in LoPAR
      https://git.kernel.org/powerpc/c/472724111f0f72042deb6a9dcee9578e5398a1a1

cheers
