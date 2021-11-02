Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CCD442CE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhKBLlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:58305 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhKBLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fp65cxz4xdM;
        Tue,  2 Nov 2021 22:38:38 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Bixuan Cui <cuibixuan@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     benh@kernel.crashing.org, paulus@samba.org, ivan@de.ibm.com,
        mpe@ellerman.id.au
In-Reply-To: <1635406102-88719-1-git-send-email-cuibixuan@linux.alibaba.com>
References: <1635406102-88719-1-git-send-email-cuibixuan@linux.alibaba.com>
Subject: Re: [PATCH -next] powerpc/44x/fsp2: add missing of_node_put
Message-Id: <163584792552.1845480.16701207323198181302.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:12:05 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 15:28:22 +0800, Bixuan Cui wrote:
> Early exits from for_each_compatible_node() should decrement the
> node reference counter.  Reported by Coccinelle:
> 
> ./arch/powerpc/platforms/44x/fsp2.c:206:1-25: WARNING: Function
> "for_each_compatible_node" should have of_node_put() before return
> around line 218.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/44x/fsp2: add missing of_node_put
      https://git.kernel.org/powerpc/c/290fe8aa69ef5c51c778c0bb33f8ef0181c769f5

cheers
