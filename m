Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967773F99DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245408AbhH0NXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245362AbhH0NXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:22 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1280C0611BC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:22:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0k649z0z9sX3;
        Fri, 27 Aug 2021 23:22:06 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <4be53b9187a4d8c163968f4d224267e41a7fcc33.1629451479.git.christophe.leroy@csgroup.eu>
References: <4be53b9187a4d8c163968f4d224267e41a7fcc33.1629451479.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/audit: Simplify syscall_get_arch()
Message-Id: <163007014928.52768.7742174951233487740.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:15:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 09:39:14 +0000 (UTC), Christophe Leroy wrote:
> Make use of is_32bit_task() and CONFIG_CPU_LITTLE_ENDIAN
> to simplify syscall_get_arch().
> 
> 
> 
> 

Applied to powerpc/next.

[1/1] powerpc/audit: Simplify syscall_get_arch()
      https://git.kernel.org/powerpc/c/770cec16cdc9d15555e67896dd2214a4fec9a3fa

cheers
