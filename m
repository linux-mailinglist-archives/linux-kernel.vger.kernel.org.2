Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2F34F5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhCaBKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhCaBKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:23 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0153C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:10:22 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XX3LLNz9sjD; Wed, 31 Mar 2021 12:10:20 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Oliver O'Halloran <oohall@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210223095345.2139416-1-geert@linux-m68k.org>
References: <20210223095345.2139416-1-geert@linux-m68k.org>
Subject: Re: [PATCH] powerpc/chrp: Make hydra_init() static
Message-Id: <161715296484.226945.13799552710776744820.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 10:53:45 +0100, Geert Uytterhoeven wrote:
> Commit 407d418f2fd4c20a ("powerpc/chrp: Move PHB discovery") moved the
> sole call to hydra_init() to the source file where it is defined, so it
> can be made static.

Applied to powerpc/next.

[1/1] powerpc/chrp: Make hydra_init() static
      https://git.kernel.org/powerpc/c/9634afa67bfd933b231405d05dda37ffa169f32c

cheers
