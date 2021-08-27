Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E653F99E4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbhH0NXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245321AbhH0NXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:25 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CBAC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:22:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0kN1kFpz9t5H;
        Fri, 27 Aug 2021 23:22:20 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <e9fbc285eceb720e6c0e032ef47fe8b05f669b48.1629791751.git.christophe.leroy@csgroup.eu>
References: <e9fbc285eceb720e6c0e032ef47fe8b05f669b48.1629791751.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] powerpc/booke: Avoid link stack corruption in several places
Message-Id: <163007015656.52768.14712592105092490367.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:15:56 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 07:56:26 +0000 (UTC), Christophe Leroy wrote:
> Use bcl 20,31,+4 instead of bl in order to preserve link stack.
> 
> See commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
> in __get_datapage()") for details.
> 
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/booke: Avoid link stack corruption in several places
      https://git.kernel.org/powerpc/c/f5007dbf4da729baa850b33a64dc3cc53757bdf8

cheers
