Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE4A3AC20D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhFRE0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhFREZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:12 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445E3C0617A8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:23:03 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4N62hdz9sWk; Fri, 18 Jun 2021 14:23:00 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Finn Thain <fthain@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <a1456e8bbd33ef702e3ff6f14b1bf3919241c62b.1623398307.git.fthain@linux-m68k.org>
References: <a1456e8bbd33ef702e3ff6f14b1bf3919241c62b.1623398307.git.fthain@linux-m68k.org>
Subject: Re: [PATCH v2] powerpc/tau: Remove superfluous parameter in alloc_workqueue() call
Message-Id: <162398829913.1363949.18107899985945378048.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 17:58:27 +1000, Finn Thain wrote:
> This avoids an (optional) compiler warning:
> 
> arch/powerpc/kernel/tau_6xx.c: In function 'TAU_init':
> arch/powerpc/kernel/tau_6xx.c:204:30: error: too many arguments for format [-Werror=format-extra-args]
>   tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);

Applied to powerpc/next.

[1/1] powerpc/tau: Remove superfluous parameter in alloc_workqueue() call
      https://git.kernel.org/powerpc/c/ddf4a7bcd09439e82c4d6f959f4ff6c53f07466f

cheers
