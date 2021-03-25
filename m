Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA52349897
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhCYRsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:48:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:44788 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhCYRsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:48:14 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3E5AE31A;
        Thu, 25 Mar 2021 17:48:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3E5AE31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616694494; bh=1B890Iy2jDxHXnAfsSRVgQsOzs8wckrMqh8VbJvh/MY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Tteod0QDH1rCSgf1AUuTLlve0npQBxvY/lUJq2h3zTcrQce2ZfbA19LpyoBNqGivg
         mSNP5OIee3NzAEY4M9eD8UrKuWQkfa84KwVtuTj9xwIOeC1pweyvpMUOmh+ZW9YcIS
         6n18ZWU6BMncWl3VAHnm4dPuD3Eit64aDXXEGgnwul9UYP1Wg2DKppjN1u3lSGJUhT
         jd8oNQWA3xh4YlaqjL5b5rObM+owYmYLQO3yJFOspXcLvL34DRK2PlLF3w6XZXdTzN
         L9RL5Cg5ztgtg6tgDpgWCbvvpNxiM3IOSY+6SFgFvcLBjmU7lYka9sgqORgefFmTyA
         h8NiaDRnhLwHw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>, mchehab@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH -next v4] docs: document all error message types in
 checkpatch
In-Reply-To: <20210322082139.33822-1-dwaipayanray1@gmail.com>
References: <20210322082139.33822-1-dwaipayanray1@gmail.com>
Date:   Thu, 25 Mar 2021 11:48:13 -0600
Message-ID: <87sg4j15wi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dwaipayan Ray <dwaipayanray1@gmail.com> writes:

> All the error message types now have a verbose description.
>
> Also there are two new groups of message types:
>
> - Macros, Attributes and Symbols
> - Functions and Variables
>
> Rearrange the message types to fit these new groups as needed.
>
> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>
> Changes in v4:
> - Use lore.kernel.org links
> - modify explanation for DEFINE_ARCH_HAS
>
> Changes in v3:
> - Add more explanation for LOCKDEP
> - Minor grammar fixes
>
> Changes in v2:
> - Replace 4.10 kernel doc links by latest
>
>  Documentation/dev-tools/checkpatch.rst | 318 ++++++++++++++++++++++---
>  1 file changed, 280 insertions(+), 38 deletions(-)

Applied, thanks.

jon
