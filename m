Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7484D334175
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhCJP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCJP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:26:22 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1AAC061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:26:10 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id p10so15882260ils.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0j+bHu3iXH8HjnjVM83afjyL/KXBL2oPI3bv48YdxXw=;
        b=ZQiRmhgRiDJM1ExEBOq9yi4Apm/6NTwVfFVloNORnQ2cRtlhBji3yuxdvhH5TxZYYf
         nlbz12Ei6H6RjF9X5prZwHq86Jy3vrJxnLP2GweM4GLocgAJGFJwaI1ic47udFXS0NqP
         wHxm0UojBmGq8cA73wvCz3HTnI4972hf0pjuPprCeIyF9/Z6vt7kb+TglvIc+x72TJuH
         Ihjz8Ud+/v/zOZaDcIfGLj0heCW8t9l0sMcb79dgaiobwOdwNtLDui70g5EB8DK7aiwD
         qDUht7Opqwv7chiRUL2mmGw8vyxqOgjxGkP1dnyzZGgBcc55MqFE20RB5EASQb64kKNU
         d3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0j+bHu3iXH8HjnjVM83afjyL/KXBL2oPI3bv48YdxXw=;
        b=qeqaqX6WCYBpsDJ0DmImKYmAK/3GUvb6NmAn1QCTR8VJy7plHAKQz9osrMmIhMKOzm
         xzFEj6ozKQ5SB2LTHPK6dSVdtteT4ROYpN08DKUnTHaLI/kvlUPeQW3R6ygzm/rQfOJt
         dzpQn3WAllwIVS5EaJOCV2j6Ya6s47LoEiRsPrQ9OSyydFLeyPFmC58lDR7Zdn1gIWft
         d8YiKeKlw/X6+mYwlNucPijxADL84coWiHnHdzO+7AniRa2o+WX1WFsGaNyGUwJHlcDW
         TnCg6Jwu0tmBRJXHjJEgE0m/1Wki+qpjh4Luxq3Xt0N0EJzd1wHwi9JcgNBcYmfDqhQ+
         r0iw==
X-Gm-Message-State: AOAM530yglCKCGA0w03eEVOAb4+MOJQhZCIok060Q/urXhV3bMNuuAs9
        H+++qDF7CATj9nSR+soQLcuiRkBPZhHC0Q==
X-Google-Smtp-Source: ABdhPJxpUkLNtdjCX87kdRLr6TBMJO2ghMIEJX8R88HRRF8L5KciBAuoui/STuMaqArpTkHC5a5EEw==
X-Received: by 2002:a05:6e02:18c9:: with SMTP id s9mr3075571ilu.265.1615389970003;
        Wed, 10 Mar 2021 07:26:10 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n7sm8971398ili.79.2021.03.10.07.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:26:09 -0800 (PST)
Subject: Re: [PATCH v2] block: rsxx: fix error return code of rsxx_pci_probe()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210310033017.4023-1-baijiaju1990@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <746df289-a8d9-9b73-d37d-cffe44b36bc9@kernel.dk>
Date:   Wed, 10 Mar 2021 08:26:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310033017.4023-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 8:30 PM, Jia-Ju Bai wrote:
> When create_singlethread_workqueue returns NULL to card->event_wq, no
> error return code of rsxx_pci_probe() is assigned.
> 
> To fix this bug, st is assigned with -ENOMEM in this case.

Thanks, this looks much better. Applied.

-- 
Jens Axboe

