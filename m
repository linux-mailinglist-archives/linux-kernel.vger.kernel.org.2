Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B161F3ABC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhFQTYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:24:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:53142 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231593AbhFQTYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:24:12 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 912031F59;
        Thu, 17 Jun 2021 19:22:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 912031F59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623957724; bh=8XV5uuo2SyFjV+1k9vRtS3CPPARtnY7eD16ygceAdEo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cC3TzDzol2e8yeIeUo4h9QfRoutk6FXJJLw4y9gMcE/9I1Brmvm1tEoa7+XuWM8T0
         WRjKfSGtEbCJ+0teCmREBtyMSx6exqzLwg8+yg9/KZBZiuHYh82mYPbOPEfBRLAz+L
         jZMEPW95qi1kWZ+IV2gbZOCiFdWVr9brIbLOcP+cbaxKwrsLYrqL3JPKgUBbvoSxm0
         5DyRvIA0ujZg/cYnZzRdAOKha8YNeDPUt0ARpXR82yAh4KZESUDvX9ZBPh0Bi5e+T+
         IfSr+RuLWWVjpL7+uyzrrV4Ur0Nesel28mHHgbhF95R9Ov97Jzpc+cntivjhGegyE9
         amvbhRbQpr7wA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hao Chen <chenhaoa@uniontech.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Chen <chenhaoa@uniontech.com>
Subject: Re: [PATCH] Documentation: ACPI: fix error script name
In-Reply-To: <20210617023300.30114-1-chenhaoa@uniontech.com>
References: <20210617023300.30114-1-chenhaoa@uniontech.com>
Date:   Thu, 17 Jun 2021 13:22:04 -0600
Message-ID: <87tulwthyb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hao Chen <chenhaoa@uniontech.com> writes:

> The correct script name should be 'divergence.sh' instead of
> 'divergences.sh'.
> I didn't find divergences.sh in the path of acpica/generate/linux/.
>
> Signed-off-by: Hao Chen <chenhaoa@uniontech.com>
> ---
>  Documentation/driver-api/acpi/linuxized-acpica.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/acpi/linuxized-acpica.rst b/Documentation/driver-api/acpi/linuxized-acpica.rst
> index 6bee03383225..cc234353d2c4 100644
> --- a/Documentation/driver-api/acpi/linuxized-acpica.rst
> +++ b/Documentation/driver-api/acpi/linuxized-acpica.rst
> @@ -276,4 +276,4 @@ before they become available from the ACPICA release process.
>     # git clone https://github.com/acpica/acpica
>     # git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>     # cd acpica
> -   # generate/linux/divergences.sh -s ../linux
> +   # generate/linux/divergence.sh -s ../linux

Applied, thanks.

jon
