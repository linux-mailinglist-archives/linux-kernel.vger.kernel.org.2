Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2AA442CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhKBLlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhKBLlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2A4C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:38:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Ff1ZQ4z4xcr;
        Tue,  2 Nov 2021 22:38:30 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <3cd40b682fb6f75bb40947b55ca0bac20cb3f995.1634136222.git.christophe.leroy@csgroup.eu>
References: <3cd40b682fb6f75bb40947b55ca0bac20cb3f995.1634136222.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Mark .opd section read-only
Message-Id: <163584789099.1845480.12874546703415674660.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:30 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 16:43:54 +0200, Christophe Leroy wrote:
> .opd section contains function descriptors used to locate
> functions in the kernel. If someone is able to modify a
> function descriptor he will be able to run arbitrary
> kernel function instead of another.
> 
> To avoid that, move .opd section inside read-only memory.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Mark .opd section read-only
      https://git.kernel.org/powerpc/c/3091f5fc5f1df7741ddf326561384e0997eca2a1

cheers
