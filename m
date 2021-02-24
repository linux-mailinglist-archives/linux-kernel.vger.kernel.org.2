Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F384632362E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 04:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhBXDrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 22:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhBXDq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 22:46:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66755C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 19:46:18 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v200so466523pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 19:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=peRxfJ9C3IZO0c7bG0x9AxPdKACtkCjqiet+LT3yHzY=;
        b=fsjdZIxgdTwB8oTvogm8JDtMaJ+0FAvKcs9Qln6KoXmttxii/7muAZkfRWOA3jI6XN
         m/BMvpT45eMtCEQ3SEGoqc+pMeaXPePeclDsHH5+Zx8kKB3GTRwoiZDmT0cEYkWt4y3F
         CpSHhqRsU0W70PWUhsqnLlpzc2YcWQ4RhoChiMWB5hV5u11EeQD1pBqInjIHA7bG6H9d
         HpFqmaJ5vnkQpfORKxNf9jhH8g50mFmmIHvMDHTumOKTyhWajAsAQc3LuQy9seuOrThm
         Oe7puHUYj99h4Y4mOXTbkfa8FdtJ94EWqg8vvkEK2a2diwIomAH/xXwS4UJzr96gUKA3
         U/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=peRxfJ9C3IZO0c7bG0x9AxPdKACtkCjqiet+LT3yHzY=;
        b=GSPBZy4dx9w5oJyihto7eGC7SlDiWjPdrVV6wbXivp7Gx0i5SIFolIgZI4X1VSF6xs
         o/AJDTbSAp4HJQQPLfLpnQ79u3jtUV7DVOjBv8tzujlJBzMi91d8vlUsPHjBe1HMBKh8
         oqy8+Iy7k2+UyRruk+EhjyXhBLI0dda+I2IUisF2fTiq7dJ5D+hOvaNmQngMhDNxpju8
         pbJeowWJ2HRgnGuEcWo1DHQEs7rs1pv/C/AskxaZ59/Wb+BumobHF8S9vrC6eYP4p842
         5N/Zw3CZwYN6U5z3od48l+lEILir+8MDSQC7XerpF5FBprvMaCVb1m6NhqkWioXDvIKk
         pTVA==
X-Gm-Message-State: AOAM533xjS8ZBnRVhie1d/GBrd5mbHR91RPzu9un3qyOv9LKLZZawJs9
        qAu1GyIbd2MI1N3kGAawLjqjquSz/Bw=
X-Google-Smtp-Source: ABdhPJz2EjcrvKemDGHKbz79qyhOLNvUh+tpZ1tGaf0gLinfyCQP8O4tsrcO294s2iUQJght7Ml2Ww==
X-Received: by 2002:a63:5fd7:: with SMTP id t206mr4860193pgb.54.1614138377627;
        Tue, 23 Feb 2021 19:46:17 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l11sm648463pfd.194.2021.02.23.19.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 19:46:16 -0800 (PST)
Subject: Re: [PATCH] nand: brcmnand: fix OOB R/W with Hamming ECC
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20210222201655.32361-1-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <32837cb2-f7ba-d59e-de66-051019b21e89@gmail.com>
Date:   Tue, 23 Feb 2021 19:46:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222201655.32361-1-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/2021 12:16 PM, Álvaro Fernández Rojas wrote:
> Hamming ECC doesn't cover the OOB data, so reading or writing OOB shall
> always be done without ECC enabled.
> This is a problem when adding JFFS2 cleanmarkers to erased blocks. If JFFS2
> clenmarkers are added to the OOB with ECC enabled, OOB bytes will be changed
> from ff ff ff to 00 00 00, reporting incorrect ECC errors.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Should there be a Fixes: tag provided here for back porting to stable trees?
-- 
Florian
