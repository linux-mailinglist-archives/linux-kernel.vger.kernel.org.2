Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D4133EE21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhCQKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQKMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:12:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CD2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:12:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u4so1502770edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g6jWkldAHO5fX2fG11foqEywJJvIYAjFVfktp5dG8UE=;
        b=dmWU5CkJN4qow5UZOOVDkEx2U/1U2Td7MwDJq8e/465o/XY1/bklUN4eFHZyMj9Em4
         y+MjuRKKxuVY++jC+LMab0eIS7ngeRN2FEMbMzpwNGG26bGp8ieVxWYFqceptZ1KWUjz
         g5utfiSnjU5NJO5sNoXcXxlPTavsPz7n98QRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g6jWkldAHO5fX2fG11foqEywJJvIYAjFVfktp5dG8UE=;
        b=VNvH51ue2naFk99VeG+jJyoE85HWj1aTQloiPsysG7UNi9W4+iGipv73wHpEulOJA3
         NIE4CZMesKnk2wc7cp6tre2lV1iO1xriBOJ6EXtdJQsQTzX3JOwIIo9UvrpzfqDhagEE
         tQBRXnOc5udFaNzmmLDlZYPIOFy0jQta9NrSO9I6pCp8VBVE2pqi0SXXVwCK0OGMJ95g
         fpvVoE7UkwrO8Dg2lUNGYDMyDskKf75tlRf/Opc3Lg0Q/cqQQNkJO3Dy+xxZlCTnYcil
         /wQeiq65xpuUpE1aBqjgaiPSNIIUqiSxoZi5Jztn49eq9pochyUbjAvpRTkj6XbkWUU8
         FBEA==
X-Gm-Message-State: AOAM532QBQOPqCLukRBgV1bLQbewlKKxidxId7ezY7M641+YXgUAYxwe
        3t6MG0noi6xOtqWSgzM4h8Pe2Q==
X-Google-Smtp-Source: ABdhPJwU+dmqZqqJcrlBnwk2GG7j9R7yBflLt8u0uwaTSwxwQTw1HuU1HGn4BQglcxrKOhmq/1fALQ==
X-Received: by 2002:a05:6402:17d6:: with SMTP id s22mr40687326edy.232.1615975965680;
        Wed, 17 Mar 2021 03:12:45 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id si7sm11098174ejb.84.2021.03.17.03.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 03:12:45 -0700 (PDT)
Subject: Re: [PATCH v2] Increase page and bit waitqueue hash size
To:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20210317075427.587806-1-npiggin@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <89cb49c0-2736-dd4c-f401-4b88c22cc11f@rasmusvillemoes.dk>
Date:   Wed, 17 Mar 2021 11:12:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210317075427.587806-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2021 08.54, Nicholas Piggin wrote:

> +#if CONFIG_BASE_SMALL
> +static const unsigned int page_wait_table_bits = 4;
>  static wait_queue_head_t page_wait_table[PAGE_WAIT_TABLE_SIZE] __cacheline_aligned;

>  
> +	if (!CONFIG_BASE_SMALL) {
> +		page_wait_table = alloc_large_system_hash("page waitqueue hash",
> +							sizeof(wait_queue_head_t),
> +							0,

So, how does the compiler not scream at you for assigning to an array,
even if it's inside an if (0)?

Rasmus
