Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922F43BA259
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 16:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhGBOvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 10:51:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36465 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhGBOvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 10:51:07 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lzKT4-0002yl-1L
        for linux-kernel@vger.kernel.org; Fri, 02 Jul 2021 14:48:34 +0000
Received: by mail-ed1-f69.google.com with SMTP id w1-20020a0564022681b0290394cedd8a6aso5175558edd.14
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 07:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E3fm4PSTtOv+VeUKIOpm5uwdfF3VUPJyTCLKCZ6r/jg=;
        b=SWbYdTtzmiP5X4BN+PPRTX5Z+qj7VSfSlpbTzZJMuJvPXizvPGbFFKP88SC2Ecgk/k
         3GY2yL+IwOVPg8Tep7x9s+LryX6rnOWTqzZgNm0VNis1nnWTbyS6YSUWCA9hMmcunkn5
         xgSsgXrQvcdc5tu+cE53XsEe9wdq+C2mViy5DVKJQzsfHSfD3/LV89HfPgNb45HbpiKM
         HEuL469U5jH/W2uN4Deh9LTVEoSqRIgFoRnclZY3S8jSVnI6vyD3MDCPMlt/XKsm7xEl
         97cWxzr/SDTQBWYhvnirApAqsLLY8gkXYWMMNozVKwJMkFsNfYPgosNrDlnF1bm69oo+
         ojJQ==
X-Gm-Message-State: AOAM531CoIeJ0ksJMQ+QjbWB8Y2bQeS0pUa79AZ+k4Sni612uYW6xhGP
        G7Ioy+NuNyJy+DmeI2zaAhfIzvGe/luFayiGW4i2r63eYizBO4qNgMHG9ibxtaniXOgxlu9oJZN
        ax848cGm14ZJRoC+4QpwMGfg87/vjz61HYAgQO7orEQ==
X-Received: by 2002:a17:907:3faa:: with SMTP id hr42mr60772ejc.129.1625237313609;
        Fri, 02 Jul 2021 07:48:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1rEKL5Sk3ceYHgC0DEX16Oa7GmwYVxNFSfGc1NYAIUVgHauj+BPRu6HmN+WHkoay4zgEsQg==
X-Received: by 2002:a17:907:3faa:: with SMTP id hr42mr60765ejc.129.1625237313487;
        Fri, 02 Jul 2021 07:48:33 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id k21sm1438873edr.90.2021.07.02.07.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 07:48:32 -0700 (PDT)
Subject: Re: [PATCH] selftests: memory-hotplug: avoid spamming logs with
 dump_page(), ratio limit hot-remove error test
To:     Paolo Pisati <paolo.pisati@canonical.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210630145740.54614-1-paolo.pisati@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1881c379-d752-6850-1a1a-fd217eb4a661@canonical.com>
Date:   Fri, 2 Jul 2021 16:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630145740.54614-1-paolo.pisati@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2021 16:57, Paolo Pisati wrote:
> While the offline memory test obey ratio limit, the same test with error
> injection does not and tries to offline all the hotpluggable memory, spamming
> system logs with hundreds of thousands of dump_page() entries, slowing system
> down (to the point the test itself timeout and gets terminated) and excessive fs
> occupation:
> 
> ...
> [ 9784.393354] page:c00c0000007d1b40 refcount:3 mapcount:0 mapping:c0000001fc03e950 index:0xe7b
> [ 9784.393355] def_blk_aops
> [ 9784.393356] flags: 0x3ffff800002062(referenced|active|workingset|private)
> [ 9784.393358] raw: 003ffff800002062 c0000001b9343a68 c0000001b9343a68 c0000001fc03e950
> [ 9784.393359] raw: 0000000000000e7b c000000006607b18 00000003ffffffff c00000000490d000
> [ 9784.393359] page dumped because: migration failure
> [ 9784.393360] page->mem_cgroup:c00000000490d000
> [ 9784.393416] migrating pfn 1f46d failed ret:1
> ...
> 
> $ grep "page dumped because: migration failure" /var/log/kern.log | wc -l
> 2405558
> 
> $ ls -la /var/log/kern.log
> -rw-r----- 1 syslog adm 2256109539 Jun 30 14:19 /var/log/kern.log

Makes sense to me and looks better choice than to disable the test
completely (as other choice...).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

> 
> Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
> ---
>  tools/testing/selftests/memory-hotplug/mem-on-off-test.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Best regards,
Krzysztof
