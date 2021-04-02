Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B87352ED8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhDBSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhDBSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:00:04 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206E8C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:00:03 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f19so6085670ion.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BFK8O3WQDC/M3xNQ5jj1jPcFnLd/RsWWduVYJodGfgs=;
        b=Fg+LZ/bWuSp3caeP2E/PMSIh1TMI/fM6q3Idcoe6k/lNQl2ksGVDTf/JXO/goUN+Kq
         vMIqg9+4U1YSfKE8URkqr83NYZPP5X9p/tXVE3sMrD5LPBtpjFi3zkBRZXlVTIjSm9Q/
         2hcYG9pFKPGNi7a+xDAEEnI/ECn46t1ZUCDlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BFK8O3WQDC/M3xNQ5jj1jPcFnLd/RsWWduVYJodGfgs=;
        b=DuUdbT8gWfa+YvwhX5+AKZxJ7jigVw6FtNV3S1HRA0I4xCFBg6K3ihVK3cQ524wze7
         6PkVmt/VnJmdxppxl0Ggh4qrDT8ZPp9KE/N+Zyt3CaKuxdcVb0x0mog1y0Wnd0vyqHui
         NmNdps4MIYPh8tNjb2YDKfs07RaeeOmqQSn+JtcPlhom5KVZ/VFsU80hoBAAsJ2brOYB
         cCEth/3kDUYAFppmchIslQloTObsshUXT/+Y/FtH52J+MisFOoQ97IupYzhsgiUkd8X3
         +DGKGXXdepo8XBcbuPoRoSafLn/QuT+vO23i2wRXfqXu8oUgJyUnGuLCNUWv6FiSrHlH
         Wamg==
X-Gm-Message-State: AOAM5315gwemSTKgvwrDnOJjsAdvkjqrJ5XOq+bp15S3u6d0tXzT4jXC
        Qp33rltL7mudtCh/q9hFhlF0xQ==
X-Google-Smtp-Source: ABdhPJzAWExjZyPWCkQZ61xvtoYqEUWyPA7vvyPakTjAoToxiOIqcD2CDsH/duO6QxS0Soh8ILSxtw==
X-Received: by 2002:a05:6638:329e:: with SMTP id f30mr14077021jav.121.1617386402538;
        Fri, 02 Apr 2021 11:00:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e2sm4758575iov.26.2021.04.02.11.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 11:00:01 -0700 (PDT)
Subject: Re: [PATCH] kunit: tool: make --kunitconfig accept dirs, add
 lib/kunit fragment
To:     Brendan Higgins <brendanhiggins@google.com>, dlatypov@google.com
Cc:     davidgow@google.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tytso@mit.edu, Shuah Khan <skhan@linuxfoundation.org>
References: <20210222225241.201145-1-dlatypov@google.com>
 <20210402093228.755260-1-brendanhiggins@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <38510e93-843c-b0e0-5ad5-4953660de79b@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 12:00:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210402093228.755260-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 3:32 AM, Brendan Higgins wrote:
>> TL;DR
>> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit
>>
>> Per suggestion from Ted [1], we can reduce the amount of typing by
>> assuming a convention that these files are named '.kunitconfig'.
>>
>> In the case of [1], we now have
>> $ ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4
>>
>> Also add in such a fragment for kunit itself so we can give that as an
>> example more close to home (and thus less likely to be accidentally
>> broken).
>>
>> [1] https://lore.kernel.org/linux-ext4/YCNF4yP1dB97zzwD@mit.edu/
>>
>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 

Should this be captured in  documentation. Especially since this
is file is .* file.

Do you want to include doc in this patch? Might be better that way.

thanks,
-- Shuah
