Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4B1329FFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575059AbhCBDwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:52:49 -0500
Received: from ms.lwn.net ([45.79.88.28]:42812 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238351AbhCAVyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:54:55 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D4422C4;
        Mon,  1 Mar 2021 21:53:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D4422C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614635621; bh=WDfz7/obBnIb/M5rsUr/TB5yXS8WrBNTeFUuidofv0g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jr4HsxUY6CHDbjHG6FYMz1lm9IWnsH7z34xdFPr0tu4dYcRexKrx2BlqJ6gY6Irya
         rf5gn2w0At/EvR2iVqzRQwG3uQhCBuK1HKUd1zXorMwUXK+pUX3EapprlglXRNK47l
         T4dfhO99JO7Kd7hb7mQrR5icOMRqg9SXtrXTD0EsktqtmhlkkLqLuGnmHZNVPZRb+r
         REc+74PuVYv7fQ2tZYodP0LOJOojYZMLllV2Pq0GwEfrg1ZAQEUkgoz8fQmovYZpJS
         cgNNb2G9lDGQ1m28kvWoMMpXKxCCYCLsLjg/NKXkDGmM0X79GPILjtIoCRhbbfu54z
         hT8WsA1BnF1tg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] docs: driver-model: Remove obsolete device class
 documentation
In-Reply-To: <20210225091124.686078-1-geert+renesas@glider.be>
References: <20210225091124.686078-1-geert+renesas@glider.be>
Date:   Mon, 01 Mar 2021 14:53:41 -0700
Message-ID: <87lfb635i2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> None of this is valid since v2.5.69.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> I started updating the document, until I realized that all of the
> typedefs, structures, functions, defines, and sysfs layout have been
> renamed, changed, or removed.  So I think it's better (for an expert in
> the field) to start from scratch.
> ---
>  .../driver-api/driver-model/class.rst         | 149 ------------------
>  .../driver-api/driver-model/index.rst         |   1 -
>  2 files changed, 150 deletions(-)
>  delete mode 100644 Documentation/driver-api/driver-model/class.rst

Yay for deleting old useless stuff.  Applied, thanks.

jon
