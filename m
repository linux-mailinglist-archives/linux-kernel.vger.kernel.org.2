Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD6F441F17
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhKARVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:21:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:53364 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhKARVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:21:48 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B25EB7DA;
        Mon,  1 Nov 2021 17:19:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B25EB7DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635787154; bh=W1VBPrgIwTLYR6IucWEejHcqZPKiwUe3RWwN7QzUVl4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V9lSA+vlYs0JhcnArZ+y9KA7/QQbGTxpyAxIXUE+lCpW5/Xox42DDDGL/dwQKf6Rh
         UBu31wyaYs7nw4NxAnPqYPpFGd2lxMMh6sq1rtzr825EgmZNafqG6psuvw/XoXeCvl
         Et5tMCefJ7XG+YKUFPJQxZBHMqNlI1XaEXsEJS0S4v5T2mpJEDoEhoNfpJVcqbKnJV
         mI0PNxKkIIfGvsIpwL/FaokxnBu7VrDd22a37QTe/xmOc9sXq7FklyZPAfEgbwksg/
         SoWwAtxEolv2fo+e4LXLgAtONI34n1FBC8bamlQLYNBdxLzaboQ9Gg9MLz8LcdLukL
         qPmmagaraS/Ew==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Colin Ian King <colin.i.king@googlemail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: Fix typo in documentation "boo" -> "boot"
In-Reply-To: <20211028182451.baizgvczghh37zfl@begin>
References: <20211028182319.613315-1-colin.i.king@gmail.com>
 <20211028182451.baizgvczghh37zfl@begin>
Date:   Mon, 01 Nov 2021 11:19:14 -0600
Message-ID: <87k0hr6bfx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault <samuel.thibault@ens-lyon.org> writes:

> Colin Ian King, le jeu. 28 oct. 2021 19:23:19 +0100, a ecrit:
>> There is a typo in the speakup documentation. Fix it.
>> 
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

But ... we just got a kernel named "trick or treat" and now you want to
delete "boo time"? :)

Applied, thanks.

But, Samuel, while you're on the line, whatever happened to the RST
conversion for this document?  I'd sure like to get that (and the
associated license change) merged...

Thanks,

jon
