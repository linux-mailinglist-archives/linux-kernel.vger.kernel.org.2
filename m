Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA433C6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhCOTaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbhCOT3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:29:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227D7C06174A;
        Mon, 15 Mar 2021 12:29:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CBDA8372;
        Mon, 15 Mar 2021 19:29:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CBDA8372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615836592; bh=YGwB17DyHiwXuCM/3j9A6hWkbkG7nsKbAZr4BdwUMEY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dRl2ZiJjZ6Xsnyyg20r1F6Josdjljbzb6LifEyPlxEaWidtd3DDDhHqEZSBfCTxng
         B0v5tdoMv4HkkNw3BqpwYm5S6mNd2z3W8MWb5eesOM+sRO2T4PvCOFFUqA5TWo4NQJ
         fNi4Z6GYfUiBKWVUYX0R9nH+acNAApgTwKJopwUxZkQOJyqx2Iopt2I5j+4FCfedlJ
         RR5TWDHzdLfhoGYPQ6vI2ANUllO2oswBhbIozGWKu7IH5AmFxfeonIvpdBfZ0Gj7DE
         NB4FmZxvIH7lShuCC8N80TFAmqf2BHVBqwVB3TDPvEDxkN9iH6p/tg8rXwLqa5717a
         fBpju68NjWznQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wren Turkal <wt@penguintechs.org>
Cc:     Wren Turkal <wt@penguintechs.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Expose the bus kernel docs to the build docs.
In-Reply-To: <20210308191417.4750-1-wt@penguintechs.org>
References: <20210307031611.GU2723601@casper.infradead.org>
 <20210308191417.4750-1-wt@penguintechs.org>
Date:   Mon, 15 Mar 2021 13:29:52 -0600
Message-ID: <87sg4w1ahb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wren Turkal <wt@penguintechs.org> writes:

> Before, the bus type related APIs that were defined in the
> include/linux/device/bus.h were not referenced anywhere in the docs, so
> I linked it to the bus types api documentation.

This should really be phrased in the imperative style as described in
Documentation/process/submitting-patches.rst.  I wouldn't ordinarily
reject a patch just for that, but...

> Signed-off-by: Wren Turkal <wt@penguintechs.org>
> ---
>  Documentation/driver-api/driver-model/bus.rst | 8 ++++++++
>  Documentation/driver-api/infrastructure.rst   | 3 +--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/driver-api/driver-model/bus.rst b/Documentation/driver-api/driver-model/bus.rst
> index 016b15a6e8ea..c53b01e95fd9 100644
> --- a/Documentation/driver-api/driver-model/bus.rst
> +++ b/Documentation/driver-api/driver-model/bus.rst
> @@ -1,3 +1,5 @@
> +.. _bus_types:
> +
>  =========
>  Bus Types
>  =========
> @@ -144,3 +146,9 @@ sysfs directory using::
>  
>  	int bus_create_file(struct bus_type *, struct bus_attribute *);
>  	void bus_remove_file(struct bus_type *, struct bus_attribute *);
> +
> +Functions and Structures
> +========================
> +
> +.. kernel-doc:: include/linux/device/bus.h
> +.. kernel-doc:: drivers/base/bus.c
> diff --git a/Documentation/driver-api/infrastructure.rst b/Documentation/driver-api/infrastructure.rst
> index 683bd460e222..eb2a2c9e3c0c 100644
> --- a/Documentation/driver-api/infrastructure.rst
> +++ b/Documentation/driver-api/infrastructure.rst
> @@ -41,8 +41,7 @@ Device Drivers Base
>  .. kernel-doc:: drivers/base/platform.c
>     :export:
>  
> -.. kernel-doc:: drivers/base/bus.c
> -   :export:
> +:ref:`bus_types`

Rather than inserting labels and making explicit cross-references, it
seems better to just let automarkup do the work for you.  So instead of
the above line, something like:

   See also Documentation/driver-api/driver-model/bus.rst

Thanks,

jon
