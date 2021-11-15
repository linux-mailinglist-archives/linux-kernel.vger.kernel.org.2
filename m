Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2B4501CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKOJ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhKOJ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:58:35 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39B5C061746;
        Mon, 15 Nov 2021 01:55:16 -0800 (PST)
Received: from localhost (unknown [151.82.209.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AA93B845;
        Mon, 15 Nov 2021 09:55:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AA93B845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1636970116; bh=EkLZq6PBm6AVDRkAIfPwVRWcIpEL7HhcYoVskbjHI04=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HeBkeoJIkIUhEigWeFNwwLd66a1FWzPvP3oEEKQzVJ0RlWCrYvLiMqb1XLSE5PNJp
         QZawOC2rpq5Cu7IYcoQ0l/T5NUuyeUC6W0JE0AAoZMcu2A1xxGTWBns96w91X2O/oI
         eHicRrmGRb4eZLBoxI+BmfJ/jRkTXYUHJknQHtNmRgWBdDu7S6Hxb5NNJ9guDj/Hf8
         PGOhQiPc1Db6fQ8qPnKxXBxZcVouWktUyN2HhYhMMxAWxevEq74RMlABJafSlDGk8c
         qAcWCPKrWkBylsYPi9Er2s/euiR9nUhMQNl4X7YKkVDlfJCTsmDf7jlUHyo6Gjt5jA
         TCbE3hWx5urzg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wasin Thonkaew <wasin@wasin.io>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wasin Thonkaew <wasin@wasin.io>
Subject: Re: [PATCH RESEND] docs: filesystems: Fix grammatical error "with"
 to "which"
In-Reply-To: <20211103193354.185647-1-wasin@wasin.io>
References: <20211103193354.185647-1-wasin@wasin.io>
Date:   Mon, 15 Nov 2021 02:55:11 -0700
Message-ID: <87o86llp4w.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wasin Thonkaew <wasin@wasin.io> writes:

> Signed-off-by: Wasin Thonkaew <wasin@wasin.io>
> ---
>  Documentation/filesystems/autofs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/autofs.rst b/Documentation/filesystems/autofs.rst
> index 681c6a492bc0..4f490278d22f 100644
> --- a/Documentation/filesystems/autofs.rst
> +++ b/Documentation/filesystems/autofs.rst
> @@ -35,7 +35,7 @@ This document describes only the kernel module and the interactions
>  required with any user-space program.  Subsequent text refers to this
>  as the "automount daemon" or simply "the daemon".
>  
> -"autofs" is a Linux kernel module with provides the "autofs"
> +"autofs" is a Linux kernel module which provides the "autofs"
>  filesystem type.  Several "autofs" filesystems can be mounted and they
>  can each be managed separately, or all managed by the same daemon.

Applied, thanks.

jon
