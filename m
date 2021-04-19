Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65381363E81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhDSJba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbhDSJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:31:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A75C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:30:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w8so19321819pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xSJyOBHu78Kak9+awi1Z3ydokklJB3m48+P9VEYpazA=;
        b=QHd+LiEVf4dJ8dlCyZiExD9pR7dIW1n8qvgMrjrd8LNY4rOVnAZ0hN2L37ggxaLtym
         XVp+9qkWCOSoh4nlAccmVdoMHuIlcwzH8Mb8z05LW/o050Iekx3+mwMJ55xdZ0GZ6WIu
         6FDnEp79wRPEiD9KNaccfgx1FSApcjO4m7H4S9ZhQqHhIyNColZ9a3xKHd5L/iiIUmJG
         5fHDVpMceVTUBuYl76FrdOnYCbaA96An/WOi5t5K/2Tiu/A/FofZwjMw99zyQbbi3deD
         2W9Q2lsdAK/DfqRGIPb9yyeGeJrDHc1ECFojW75TsL3YYgjfyUlYrEXwcVxvDYFD5r73
         apzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xSJyOBHu78Kak9+awi1Z3ydokklJB3m48+P9VEYpazA=;
        b=UgN4d/GyLHUeD1BiW7zEKW/hlha5qTHt56PBzP6PE1GvEsQ/9eSt8Qs3EbjIL8wgAr
         4F4lM+YZwx986xyzO86nPiA/dKeDr0CqM626kptzADjoSMHGcixvvQDiNBf8g5uxvqnA
         oOmr9LgGeaq+c9H98tmkC3KfrcrhcEXJjuGhkIYgGOrDgaJqgeh3trD24ntBPz/3iHyS
         JXYhVJhv+kZdZdYhFpCWdktww8xWj5vknnnYL2NHLGWjP3fO6Ln2l1e3aA/CN2JDhrcF
         g6g7OK58md7zU6erXLh/Ft/KMGDzeU5aA0R2BgrPyjCjpWJCGTqEe/L8P6scNz1GaBF3
         NIxw==
X-Gm-Message-State: AOAM532WHClLIHLrswWZNd9wzRT8+KaR5JDmUQc15jviVjMqLlA/kcUb
        Vx3/Ih1LvuoymQ5OfBCoy5HOw8btgHk=
X-Google-Smtp-Source: ABdhPJyOnkx+fq+oW0EbP8UKVxfxiggLsjsL77VIc9yAqUids/nvq9LUi1x8w7rxeZe/4/dRBTrWVw==
X-Received: by 2002:a63:5214:: with SMTP id g20mr11089898pgb.158.1618824657041;
        Mon, 19 Apr 2021 02:30:57 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 11sm15560833pjm.0.2021.04.19.02.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 02:30:56 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/2] delayacct: refactor the code to simplify the
 implementation
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
References: <1b0063b922ba18e36a55286a6c23fd74d71b21b0.1618275619.git.brookxu@tencent.com>
 <20210419070106.GC8178@balbir-desktop>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <eaa0dcbd-999a-eba0-0553-781ffd6be401@gmail.com>
Date:   Mon, 19 Apr 2021 17:30:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210419070106.GC8178@balbir-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Balbir Singh wrote on 2021/4/19 15:01:
> On Tue, Apr 13, 2021 at 09:37:26AM +0800, brookxu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> The existing data structure is not very convenient for
>> expansion, and part of the code can be saved. Here, try
>> to optimize, which can make the code more concise and
>> easy to expand.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> 
> The approach seems to make sense, but the test robot has found
> a few issues, can you correct those as applicable please?

OK, i will fix it later, thanks for your reply.

> Balbir Singh.
> 
