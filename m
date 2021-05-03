Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18BC37234E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhECW56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 18:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECW55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 18:57:57 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10785C061574;
        Mon,  3 May 2021 15:57:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BB5B68B2;
        Mon,  3 May 2021 22:57:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BB5B68B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620082623; bh=z941Lu+/CtawpFMt/mj1RUwC1eDTMB9N3idI2b0h/ZM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ITwzPHCQdv/nKgjoRbfUERj0a5rzB4MEnHbVuj3bHNwKn35gg3uTeTUa31TsDqW6U
         sm+9GmGgSZmU2LqjGjWmBm+exk+J8bK1i24te2b0LK1vWsSS29Du2KLovDjQqqJJco
         E1Fhs5fr4BQCr026+9OWeL8EfXWFVRxGKSMcxpb6XkdXkD4yIXzWvy0tduorOIi2z9
         XkmaqpU1DWK29K3ohT8s5EjUro7RzsA7O9jNwukz8WQpbuJK0l0OJNUmTLQQ0ds/MN
         J2iOb0XsNH59nLVfTPrzBWCHJqBH3QW3kKiDlvk8NEe9FhJaZK2Jagv9Aa3DpUETYi
         s/WWXAvMCICPQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Anatoly Pugachev <matorola@gmail.com>, linux-doc@vger.kernel.org
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: correct URL to bios and kernel developer's guide
In-Reply-To: <20210428104851.GA10572@u164.east.ru>
References: <20210428104851.GA10572@u164.east.ru>
Date:   Mon, 03 May 2021 16:57:03 -0600
Message-ID: <87a6pbh1ds.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anatoly Pugachev <matorola@gmail.com> writes:

> correct URL to bios and kernel developer's guide on amd.com site
>
> Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 0eee30b27ab6..f2fff6020439 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -285,7 +285,7 @@ Description:        Disable L3 cache indices
>
>                 All AMD processors with L3 caches provide this functionality.
>                 For details, see BKDGs at
> -               http://developer.amd.com/documentation/guides/Pages/default.aspx
> +               https://www.amd.com/en/support/tech-docs?keyword=bios+kernel
>

Well, that will work until they change it again...

Applied, thanks.

jon
