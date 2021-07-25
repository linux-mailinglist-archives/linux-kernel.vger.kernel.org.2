Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E73D4FF1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 22:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhGYT7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 15:59:19 -0400
Received: from ms.lwn.net ([45.79.88.28]:41964 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhGYT7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 15:59:18 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 615A12E6;
        Sun, 25 Jul 2021 20:39:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 615A12E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627245588; bh=hxyBfpapE4saUxSqIX5rdRRgIZ4B66krlK1oq/pp36M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CR/66uZ3+aJ/fRlIx1WA0FOphcuNsxaaoTia8rAXgcf0SQMSomI9PsqJ42Jo0UHXl
         J0K76xu97bSnlz92R6CpJJ4jUW4EcaLisY0SnAdhcq4Rvjl/86nCr08JLlgx9l+GIH
         TwUHEmMImT0PCTUSLfsxg1ra3CH9WwVzZV3lA2D6YePPzC5hhCZ7E7cz02sK0Jp21h
         ZekjkPXtsPTtbetvHLwEtiC1aVgM5KhhDN8HmXVCCFOal/x4JOS4ZQJ1yvYMK4BIqg
         znH/8BpjfNmT0s8nuLMau1NKQ7Qern210NngxcRKTLzhiA+ZVGY0BfQUZ2Qk2I3c5t
         6vMsSxIikOqzA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Vineeth Pillai <Vineeth.Pillai@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] admin-guide/hw-vuln: Rephrase a section of
 core-scheduling.rst
In-Reply-To: <20210721190250.26095-1-fmdefrancesco@gmail.com>
References: <20210721190250.26095-1-fmdefrancesco@gmail.com>
Date:   Sun, 25 Jul 2021 14:39:47 -0600
Message-ID: <87a6maunzg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:

> Rephrase the "For MDS" section in core-scheduling.rst for the purpose of
> making it clearer what is meant by "kernel memory is still considered
> untrusted".
>
> Suggested-by: Vineeth Pillai <Vineeth.Pillai@microsoft.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  Documentation/admin-guide/hw-vuln/core-scheduling.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> index 7b410aef9c5c..e6b5ceb219ec 100644
> --- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> @@ -181,10 +181,11 @@ Open cross-HT issues that core scheduling does not solve
>  --------------------------------------------------------
>  1. For MDS
>  ~~~~~~~~~~
> -Core scheduling cannot protect against MDS attacks between an HT running in
> -user mode and another running in kernel mode. Even though both HTs run tasks
> -which trust each other, kernel memory is still considered untrusted. Such
> -attacks are possible for any combination of sibling CPU modes (host or guest mode).
> +Core scheduling cannot protect against MDS attacks between the siblings running in
> +user mode and the others running in kernel mode. Even though all siblings run tasks
> +which trust each other, when the kernel is executing code on behalf of a task, it
> +cannot trust the code running in the sibling. Such attacks are possible for any
> +combination of sibling CPU modes (host or guest mode).

Applied, thanks.  I took the liberty of reflowing that paragraph to keep
the line lengths reasonable...

jon
