Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535F137ACA2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhEKRFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhEKRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:05:06 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3820C061574;
        Tue, 11 May 2021 10:03:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D7EF4BF;
        Tue, 11 May 2021 17:03:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D7EF4BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620752639; bh=jhHj1OrFaSajf+GTqsAGMNP6qfJhYZW7T49Hk6PMTfI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tiWuI7ZoTQf2NDCjVjX7gggToVewaeq5yTHC+YQPCecOg8rau6cEA2/wD/BkSl289
         wGwpp1zN+2ldrduwpB6WErhw7mYq+mW8mZnOlhWvuC0IOr5HaR3sHSVZ592zh5qHcf
         D0fSx/GgsE25H0DK75A4NyeP+6lHHwH/Z+CTGSIuDP+gLe3V7AxtSP6mjTDpbci79p
         2bh0sz6K1tQbusLhBiRbz37fPSOVIbfOy947zGKtG7ctUypVBPgAQQHQlBL883URHL
         kYZnN8PvdbNlJ7sJb8DDQgsvBLSkGR1+Dg062xF/QTeWUzAzUxEsRYXNAz4JGTY9K6
         zOPWTVPN5eZZw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Remove link to nonexistent rocket driver docs
In-Reply-To: <20210511134937.2442291-1-desmondcheongzx@gmail.com>
References: <20210511134937.2442291-1-desmondcheongzx@gmail.com>
Date:   Tue, 11 May 2021 11:03:58 -0600
Message-ID: <87bl9hdwxt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com> writes:

> Fixes: 3b00b6af7a5b ("tty: rocket, remove the driver")
> The rocket driver and documentation were removed in this commit, but
> the corresponding entry in index.rst was not removed.
>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>

Please note: the "Fixes" tag should be down at the end with your
signoff. 

>  Documentation/driver-api/serial/index.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/driver-api/serial/index.rst b/Documentation/driver-api/serial/index.rst
> index 21351b8c95a4..8f7d7af3b90b 100644
> --- a/Documentation/driver-api/serial/index.rst
> +++ b/Documentation/driver-api/serial/index.rst
> @@ -19,7 +19,6 @@ Serial drivers
>  
>      moxa-smartio
>      n_gsm
> -    rocket
>      serial-iso7816
>      serial-rs485

Otherwise this looks like a good fix.  I've applied it (with Fixes in
the right place), thanks.

jon
