Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC43EB95C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbhHMPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:44:57 -0400
Received: from ms.lwn.net ([45.79.88.28]:41974 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236919AbhHMPo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:44:56 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BD906385;
        Fri, 13 Aug 2021 15:44:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BD906385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1628869469; bh=RVDS4amGP7ioflmfiU6sdMVFaxdxocLjvCtU764fm50=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cJNzzI3KwzA2NOTsrfmf7cGnO1eBpmbSg3FmcV9Dd6PIyetQ6JteUhCfb6mBcR3vj
         BA4kkyo29eaA5S6oFS2G4Wk4wljlf3N/eLZqpuzQ2+J0DlUqd3NZyeWWXBdqCUm+eP
         HjF3AnVn0Tf1phYBYJKAgyz173uNPePCCOj49lNRm7kIjXLJP+bpvEjmM8AzxQCigy
         0Z8qDZeB4+pQQseOH7SGJzhf8db6h/tCu/QlaGyTFGQZcm/MXaNkyzXR6p5AcauahJ
         MMUPJWhF6OepvSHZT7h97WSi2AKWOiDHOv9oiY/iFOzPgsVeYQ/trYvvvFuVAS4Yna
         q8LjpMEB0bw/Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] Documentation: in_irq() cleanup
In-Reply-To: <20210813144713.85598-1-changbin.du@gmail.com>
References: <20210813144713.85598-1-changbin.du@gmail.com>
Date:   Fri, 13 Aug 2021 09:44:28 -0600
Message-ID: <87o8a1xsbn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changbin Du <changbin.du@gmail.com> writes:

> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/kernel-hacking/hacking.rst                    | 2 +-
>  Documentation/kernel-hacking/locking.rst                    | 4 ++--
>  Documentation/translations/it_IT/kernel-hacking/hacking.rst | 2 +-
>  Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 ++--
>  Documentation/translations/zh_CN/kernel-hacking/hacking.rst | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
> index df65c19aa7df..f514cec8e16b 100644
> --- a/Documentation/kernel-hacking/hacking.rst
> +++ b/Documentation/kernel-hacking/hacking.rst
> @@ -77,7 +77,7 @@ fast: frequently it simply acknowledges the interrupt, marks a 'software
>  interrupt' for execution and exits.
>  
>  You can tell you are in a hardware interrupt, because
> -:c:func:`in_irq()` returns true.
> +:c:func:`in_hardirq()` returns true.

While you're in the neighborhood, can you please get rid of the :c:func:
markup?  We've not needed that for some time now; simply saying
in_hardirq() is sufficient.

Thanks,

jon
