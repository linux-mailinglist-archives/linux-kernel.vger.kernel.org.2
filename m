Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16A5442CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKBLmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhKBLmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:42:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E93C061195
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:39:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7GF3VQrz4xdp;
        Tue,  2 Nov 2021 22:39:01 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Leonardo Bras <leobras.c@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     kael_w@yeah.net
In-Reply-To: <20211014075624.16344-1-wanjiabing@vivo.com>
References: <20211014075624.16344-1-wanjiabing@vivo.com>
Subject: Re: [PATCH] powerpc/pseries/iommu: Add of_node_put() before break
Message-Id: <163584789302.1845480.1021784539653281831.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 03:56:04 -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> 
> ./arch/powerpc/platforms/pseries/iommu.c:924:1-28: WARNING: Function
> for_each_node_with_property should have of_node_put() before break
> 
> Early exits from for_each_node_with_property should decrement the
> node reference counter.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/iommu: Add of_node_put() before break
      https://git.kernel.org/powerpc/c/915b368f6968122fcab31fd6441ed4ba7cc7574c

cheers
