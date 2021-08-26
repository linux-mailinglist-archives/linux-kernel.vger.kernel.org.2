Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EDA3F900B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 23:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbhHZVMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243671AbhHZVMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:12:18 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF72C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 14:11:31 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso5247360otv.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nMZfMGCf7gEgKHWB3C2579v7LEh9Aqv/g0GiXmajcO8=;
        b=VeAYrG7JhdG9lEaLgS+Dk01I/olhHr0XeClaFGGoHuiNnYkYVQ52j6jbfDuE/czUVA
         owDsOiYaj27UeRyXeJv7i3p4ccmiua1G9O3N+1oZs8NfzqRq+zVaTz4qZ1KJFp2bZW8+
         e7aGNw31la5nGQ20hdtNkxpU8neUgqZjo7S74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nMZfMGCf7gEgKHWB3C2579v7LEh9Aqv/g0GiXmajcO8=;
        b=mCNi4cFq3QmDH2X/I9Clq3zAh1iikWiSpn0uH/i/A5C8zDCHcXkwWQzYckTezVGsbH
         UOPr6H7nxZIddipd1YEzSU5RzQ3NoXbH4yKmTB8sZLP8ItRz43Yv3i30u5kj3ghGTmZ5
         pDUbnveWwl/VII01lnxH6/VeLxVtlnKzAxxwa0tHpXXnPuP0aXQIYEukwuez9+AsAcuK
         VRZdHsapW5bbWPd0QJZYiRyVjxG/0AZr3IiB78PvXM7NWuMhWjqAvyymezNUjxVhJ+ck
         j9MRsKLyO5jUJhktkgtMgnEkB5230y7SExibJVdLTePbeF753S6M6lUDtApSCEZE9FPU
         kROg==
X-Gm-Message-State: AOAM5335vjMjEDDa1L+WhPEMRjsaZGdlBvxwTsmQlalmgMrmF4UTDIZf
        fXsirnkQS4Wmxe3vibk9vs8hgA==
X-Google-Smtp-Source: ABdhPJyKZDOGl5fi2xMFbJRUiuvQnXN5rxY8OeWvFk7Qi+6N0Fgqg8TQRq0VO9vUwYRDKp/uyvN0Aw==
X-Received: by 2002:a9d:6398:: with SMTP id w24mr5079936otk.140.1630012290267;
        Thu, 26 Aug 2021 14:11:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u27sm830726otj.6.2021.08.26.14.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 14:11:29 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] selftests/wireguard: Rename DEBUG_PI_LIST to
 DEBUG_PLIST
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     philip.li@intel.com, linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
 <20210826015847.7416-4-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0df0882e-53e5-e407-ed29-e21da7965bc4@linuxfoundation.org>
Date:   Thu, 26 Aug 2021 15:11:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210826015847.7416-4-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 7:58 PM, Li Zhijian wrote:
> DEBUG_PI_LIST was renamed to DEBUG_PLIST since 8e18faeac3 ("lib/plist: rename DEBUG_PI_LIST to DEBUG_PLIST")
> 
> CC: "Jason A. Donenfeld" <Jason@zx2c4.com>
> CC: Nick Desaulniers <ndesaulniers@google.com>
> CC: Masahiro Yamada <masahiroy@kernel.org>
> CC: wireguard@lists.zx2c4.com
> CC: netdev@vger.kernel.org
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---

Can you please state what you are fixing and also keep the sentences
75 chars or less.

Where is LKP warning? Include the warning and explain why this
change is necessary.

thanks,
-- Shuah
