Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8978639BE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFDRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhFDRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:23:57 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47AC061766;
        Fri,  4 Jun 2021 10:22:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EF22B1C19;
        Fri,  4 Jun 2021 17:22:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EF22B1C19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622827331; bh=5beoc1vSwfRqBt/kmvxdgzvPZJJRboeoFAS23CYi3sE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NXhnmWfQUD4xC1Wap1rgbZG7yTHafMdlhTlud8BbLMRMiMqZja9qtyrq6klSacV/z
         EBPasKLidXc3FONWRjSd8uOKIaRTjLe6Af7xa1EekjR/o0ZBjuhnG9DhvfEs0gTfCR
         rSEj36b46nGX+9GywBeWljv08BIW7ni3+RxuDZF37N1q5fvY2loMIKWxmNrS9QaP3O
         KA5cm6J+7rSkioY9tKKa+DSdfAp8ewu3qGc9Md4gPfg8Y+tMoIczZ6dWQTqYCc2bvU
         wwckOownQiS1eXDmGuOR9860xk6de3En6nuVPCM8wtJfLbevCV4aiGL3iHNQYg9v/p
         Ysy5z5IpSjYng==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: networking: Replace strncpy() with strscpy()
In-Reply-To: <20210602202914.4079123-1-keescook@chromium.org>
References: <20210602202914.4079123-1-keescook@chromium.org>
Date:   Fri, 04 Jun 2021 11:22:10 -0600
Message-ID: <87im2tzgsd.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Replace example code's use of strncpy() with strscpy() functions. Using
> strncpy() is considered deprecated:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/input/joydev/joystick-api.rst | 2 +-
>  Documentation/networking/packet_mmap.rst    | 2 +-
>  Documentation/networking/tuntap.rst         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon
