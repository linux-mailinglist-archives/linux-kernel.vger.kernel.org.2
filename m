Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091813F69E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhHXTcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhHXTcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:32:10 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7348C061757;
        Tue, 24 Aug 2021 12:31:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9FCDB50E9;
        Tue, 24 Aug 2021 19:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9FCDB50E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1629833485; bh=wEib72W3RhRTZhXv5w6Wk1JJhCa3oQ2BXfVgq/fWCDI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=O7VH9bsvy+0L3tyvMNaIOm9U9CPLb7TUA3Zu8JN/MQYPeDdTiex2J1+1XFJcJE5ge
         MV591oX/jMbx+0QmPcQMf9NXV03yu7Qj78qPdKcq0MZKQJLKIy7C6H/3v5iBM5FIRW
         fXgrKUdtrIPgbOlYpqHrpD9l1XNh/jkoy84htbu+XriR8zdFEWpUP96HTz3flXh+SV
         +BoNHW5tVcaXzBcK5S0TKuNNEgV8N4T4gAquRiXCrKGrpshjCsVNxkDC4FXs6KgJZ0
         ikfeNr/zpKqmX/QbRP2wc4PvBp+9XR0onzF7OUVr0KjLjl8merMv65H5lf1jvJOMak
         CYZDPp2C7rK5Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, npiggin@gmail.com
Subject: Re: [PATCH] Documentation/features/vm: correct huge-vmap APIs
In-Reply-To: <20210817091621.16799-1-mark.rutland@arm.com>
References: <20210817091621.16799-1-mark.rutland@arm.com>
Date:   Tue, 24 Aug 2021 13:31:25 -0600
Message-ID: <87wnoaljw2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

> In commit:
>
>   bbc180a5adb05ee8 ("mm: HUGE_VMAP arch support cleanup")
>
> We replaced:
>
>   * ioremap_pud_enabled() with arch_vmap_pud_supported()
>   * ioremap_pmd_enabled() with arch_vmap_pmd_supported()
>
> Update the documentation accordingly.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/features/vm/huge-vmap/arch-support.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon
