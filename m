Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AF1454CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbhKQSXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:23:25 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59793 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239931AbhKQSXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:23:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3EDD83201464;
        Wed, 17 Nov 2021 13:20:11 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Wed, 17 Nov 2021 13:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=t6XcJhp+2vBfE6NrxYwXwZsNDc9o
        GAJ6HShxyu3Uu0M=; b=USsjOfF1YD6OT23l86ZZZ7Ro3ix9fiDQ5Rre/7/yd+g0
        c+s2FFJJlUvNlYu2b1vJsi2n8I/779VQArh8lJhArx4Kz2Jy5trBbE70N6fVKXjQ
        TZbAzYKoAMIe9T1C5vdZCi9g4S7ie5qW9ONQyNQQTRozEgLfiHtQ/vMV5qYYhfJz
        JTlKGAwxMGHfPC5XG2+pHbKkO35NgngwPIm1GBhgZNWtRBKhxfJNyljPpiAm0jzf
        G0CSc/2tCk4gDo4uslbSRYt5rTp60maNoMbC5PSxbQCnZs7WUJBBLQdCJbkLb6Ez
        t7/IuldOwq5/Tc/29FQcqinbLhrDKQglUDr2bsT0kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=t6XcJh
        p+2vBfE6NrxYwXwZsNDc9oGAJ6HShxyu3Uu0M=; b=coIxL/IodzfoaU8r1N9Inn
        CESwjNZbOr08aShc8gjxnNnU1g8jugGMXJQKi+9hzAQzG60ldUb2t6QjEtGfZ6kY
        8km2/DBslArshbykY4KvGRDbJ7EumUkxTo7OBZDty/RqYDk4LzYsWUlXO9yU+8iS
        Mt/r8JxlKblYAw8B/fc7fsvIpXsgM50Ng4tqZUFwE+Zw1cmxKq/ClKgOlJfWzDCv
        yAKKq8z/IIwHF8Ul8rWFGRiLF7c53RT2jciM7FZZYiBeHCFrMor3wC4FAmuyxEzT
        oYp8TtTG2H6uZeK5dQBkp/M8zIciR+muWS3CPk8qSiUNR+uiNB/vbVtP9aWlE3Qw
        ==
X-ME-Sender: <xms:2UeVYZDRM8hipnUZM0-b8300EZ211RDqrfbGwbTKYNBsJIwi_x223g>
    <xme:2UeVYXi2DSVfnqJ8vxA1xWsNlLPzT-NgpevnEf3ejODyWGYS1BG8kc6VV8HEsR3MO
    gOzdvUSlOJlo8Ygm-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:2UeVYUnZxlaZfT0z9-vgyO-xK-BXGxEF4YoB0TJhiax_Ed24dB6UuA>
    <xmx:2UeVYTyGEXzk5hO1Y2iyj7Yt0cu2ULN0KJNT9Wvz1tNlENBTC1tqtA>
    <xmx:2UeVYeTTo5V8B8I-AE2urJs1IoNVFkR4vFCTk1JgZ_CT9X9yOcRv_A>
    <xmx:2keVYUNWlYQuZ1_yyzMU6uc79H-KqavJONDkQan5SrU-kJKVujyI8g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ED4B8274036A; Wed, 17 Nov 2021 13:20:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <7bac877d-1929-4caf-be8d-8405c5cfd3ba@www.fastmail.com>
In-Reply-To: <20211117151450.207168-1-marcan@marcan.st>
References: <20211117151450.207168-1-marcan@marcan.st>
Date:   Wed, 17 Nov 2021 19:19:49 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] usb: typec: tipd: Fixes for Apple M1 (CD321X) support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021, at 16:14, Hector Martin wrote:
> Hi folks,
>
> These two fixes make tipd work properly on Apple M1 devices, in
> particular in the case where the bootloader hasn't initialized
> the controllers yet.
>
> We normally do it in m1n1 (so the machine can charge and so bootloaders
> get working USB without needing this driver), but that was causing this
> codepath to never get properly exercised, so we never caught it. I

My boot process usually is iBoot -> m1n1 on nvme -> m1n1 chainloaded over usb.
I thought I exercised this path by turning off the init in m1n1. I didn't take
into account that this would only affect the one loaded over usb and that
the one on nvme would still intitialize everything.
Thanks for fixing this!

With the Fixes tags feel free to add

Reviewed-by: Sven Peter <sven@svenpeter.dev>

to both patches.

Sven
