Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B007138263D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhEQIJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbhEQII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:08:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EADC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:07:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l7so5767439edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KZ25JSlKoGQcpZCaAqDffBlnrBeLLc9uTdHuPv/cgEA=;
        b=UUpF7mXBjSFpueXZHanKn0ARsJo+8PH/asLzmd3nPa1Q+grFw1kN3kR3bNFtXlXdy8
         VYEvXNAthZ34gXNUBuoAZILuRzLEX2SDSXX4FFB9f+d/isfXc7Yz5hT461mPTpz4i6yB
         j3RJWKzgPVVgsTeMfj6OXf6pjxi5CiB7RKY0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KZ25JSlKoGQcpZCaAqDffBlnrBeLLc9uTdHuPv/cgEA=;
        b=MlYvkUOSXDVPS2af9KzrKI6Bo2Jt6eyILeUDAWFl4gIVhDYn7etjPuZUKsrlLGlMMi
         yGGph4P1M21EhMWUwC6x0OTKngIX5UZ+qVFkEpfp9f3pJTe5dqMTcAFXd657LfTwfzKZ
         qIObLGzTZ8BZ6W25U2HUMxb/NbTq3gEPAKw66Y0kMGaWYwNDO7zDf8wVSXoJcPohkzZi
         QbhXTcnoF9SrU2Ec8dB5VX6A4qgdb1x0UnYwfr+u4OauiRZARgKymfaozdzwm0LFZva2
         BpU8Mq1l+51CsWf95GkXshePdWP3mnKRjMg1JLuNRMGOZiPZ65oEd16RzMR9K3MygZq2
         BsKg==
X-Gm-Message-State: AOAM532B4dcciJcezXnKO1qQ2HW/oFQ334D8HEm816HF07UDy2lFM3Tb
        WuTFPJaTewgoC//V4s2tfuaxIskZgJ+tkw==
X-Google-Smtp-Source: ABdhPJw7H7hEDTf+NVFoyU0DELq9/PVpKANQqDuwmqgsOSN+A+OeE+k2/gjSq9rZX1+FZMoQOBkrDA==
X-Received: by 2002:aa7:dbcd:: with SMTP id v13mr69745532edt.59.1621238860247;
        Mon, 17 May 2021 01:07:40 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id cf15sm1981303edb.62.2021.05.17.01.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 01:07:39 -0700 (PDT)
Subject: Re: [PATCH] [v2] printf: fix errname.c list
To:     Arnd Bergmann <arnd@kernel.org>, Petr Mladek <pmladek@suse.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210514213456.745039-1-arnd@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5459852d-6c0b-2b8b-a05b-868f046b6233@rasmusvillemoes.dk>
Date:   Mon, 17 May 2021 10:07:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210514213456.745039-1-arnd@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2021 23.34, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> from EDEADLOCK, and remove the -ECANCELLED bit completely as it
> 
> diff --git a/lib/errname.c b/lib/errname.c
> index 05cbf731545f..6c5c0aa4de75 100644
> --- a/lib/errname.c
> +++ b/lib/errname.c
> @@ -21,6 +21,7 @@ static const char *names_0[] = {
>  	E(EADDRNOTAVAIL),
>  	E(EADV),
>  	E(EAFNOSUPPORT),
> +	E(EAGAIN), /* EWOULDBLOCK */
>  	E(EALREADY),
>  	E(EBADE),
>  	E(EBADF),
> @@ -38,8 +39,12 @@ static const char *names_0[] = {

somewhere between EBADF and ECHRNG I'd expect a hunk dealing with the
ECANCELED stuff

> -	E(ECANCELED), /* ECANCELLED */

but I only see this removal?

Otherwise looks good.

Rasmus
