Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543C745D79E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354340AbhKYJxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348796AbhKYJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:51:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158C1C061748
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 01:48:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J0Cjs3N6Cz4xcs;
        Thu, 25 Nov 2021 20:48:17 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Jason Wang <wangborong@cdjrlc.com>
Cc:     benh@kernel.crashing.org, michael@walle.cc, paulus@samba.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, andrew@lunn.ch,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211114115616.493815-1-wangborong@cdjrlc.com>
References: <20211114115616.493815-1-wangborong@cdjrlc.com>
Subject: Re: [PATCH] powerpc: tsi108: make EXPORT_SYMBOL follow its function immediately
Message-Id: <163783298962.1228879.14308676036786907622.b4-ty@ellerman.id.au>
Date:   Thu, 25 Nov 2021 20:36:29 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2021 19:56:16 +0800, Jason Wang wrote:
> EXPORT_SYMBOL(foo); should immediately follow its function/variable.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: tsi108: make EXPORT_SYMBOL follow its function immediately
      https://git.kernel.org/powerpc/c/a3bcfc182b2c968fd740101322bd128844724961

cheers
