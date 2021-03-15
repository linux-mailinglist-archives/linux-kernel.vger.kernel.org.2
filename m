Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F0D33C6D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhCOT0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:26:50 -0400
Received: from ms.lwn.net ([45.79.88.28]:44494 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233572AbhCOT0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:26:41 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 304F0372;
        Mon, 15 Mar 2021 19:26:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 304F0372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615836401; bh=4ypd7Vv0Hb8gXQNJjo/Dsc/ltQP9teVcsN2i1wqBic4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ScYBKD4OrYngeT+yCJEC2M1s2Tpbkch3tSGtB0ct9Qvn6ic1Wxzra6byhEpTQ1qaz
         CStKUUSvltra73xasSEAjl3NfrWJ8ZvIL4WqUjvVp0eK3uuQk/5wkvrW1IceTxRc0S
         AuIEgNc3Y9cWeFBQoqGZT6icMP8DEdMFYPTVZc3O2mPyz2ESmIk/z4rGJ9s7CNfL+l
         +H4KV2i53G4Us3iJj4JA413SszYg/2jK2bLU2ZCZZGh478vZYDF4uBpLnZhZ/Laiyr
         Eemb7om7AJ8BN7n6pYusExKNQsOaeDqGgPrw8PQp6/0tmhsUl85jA5xw3TdhvCSCSr
         dWvTHmqgvCW+A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] docs: dt: submitting-patches: Fix grammar in subsystem
 section
In-Reply-To: <20210309130650.2318419-1-geert+renesas@glider.be>
References: <20210309130650.2318419-1-geert+renesas@glider.be>
Date:   Mon, 15 Mar 2021 13:26:40 -0600
Message-ID: <87wnu81amn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> Reword the subsystem bindings section to make sense, from a grammatical
> point of view.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> index 68129ff09967d5d7..1d11c25249ff5465 100644
> --- a/Documentation/devicetree/bindings/submitting-patches.rst
> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> @@ -75,8 +75,8 @@ II. For kernel maintainers
>       binding, and it hasn't received an Acked-by from the devicetree
>       maintainers after a few weeks, go ahead and take it.
>  
> -     Subsystem bindings (anything affecting more than a single device)
> -     then getting a devicetree maintainer to review it is required.
> +     For subsystem bindings (anything affecting more than a single device),
> +     getting a devicetree maintainer to review it is required.

Applied, thanks.

jon
