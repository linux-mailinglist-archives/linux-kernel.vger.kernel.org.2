Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA963AC210
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhFRE0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:26:18 -0400
Received: from ozlabs.org ([203.11.71.1]:34195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231985AbhFREZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4T20v6z9t14; Fri, 18 Jun 2021 14:23:05 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, trix@redhat.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, agust@denx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210601190200.2637776-1-trix@redhat.com>
References: <20210601190200.2637776-1-trix@redhat.com>
Subject: Re: [PATCH] powerpc: 52xx: add fallthrough in mpc52xx_wdt_ioctl()
Message-Id: <162398828853.1363949.2617045934377270438.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 12:02:00 -0700, trix@redhat.com wrote:
> With gcc 10.3, there is this compiler error
> compiler.h:56:26: error: this statement may
>   fall through [-Werror=implicit-fallthrough=]
> 
> mpc52xx_gpt.c:586:2: note: here
>   586 |  case WDIOC_GETTIMEOUT:
>       |  ^~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: 52xx: add fallthrough in mpc52xx_wdt_ioctl()
      https://git.kernel.org/powerpc/c/b629f6c0ab8668a186fda2627296d0cbcc45a368

cheers
