Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB433D5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhCPOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhCPOdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:33:22 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43413C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:33:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n132so37380807iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q/7bUx2ojAKrW6WgffbugKW8m/FPOBCZYXbC80AEUMc=;
        b=z76CH+WeqlQ+pu7RK+WzjqujAOQ6/CmXvi4GjO0DCt3fs5AYzWpny3D1bjIokaY/pC
         JA3rYTf4VVtgGp3EdjZ78U9ODvIVKbq5hBBWF6VDrqqVuGrScMLGFVToGl3B+E+njJGO
         QpvtNAWnjUJUakiX5mY5bypyERM2o3TTfIa79bYsVMew23xqPtea7cPnWoQ1QtEPI63C
         coIscGADK9JfYQyGe6Qv9ozlIFwHwszMW50AXhUyBVEAnaSM6GiEfoq6xEI9668T9t5M
         8o1IFbAf89Mf+YxlXhe0kYgymsD+N4lCX0jPg8BfgvJdzlYX/UwHVXE9PaQusIxkVlmF
         uy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q/7bUx2ojAKrW6WgffbugKW8m/FPOBCZYXbC80AEUMc=;
        b=TIpCgaelGWLjsJtLXUSZLjmOZ6RrBvqNN1dMCsH5kWm5vYImGlNN1BQFhdGMaBxx34
         iRrWrQqB+xyavu3jPGSSz5AaEe+ASvJ+qBzS1CafJOAjYH1WYk3GZbDDWwNC+r03uE0F
         bPhb/oVCy0/lvyq3qydGm6zwhcWX8auV7JouKcto/Et3QlBB9IimmaIctj3xXnaSgxRi
         Fte3Yv1WXY8GirEFNcQSrn+IFFXOUpHH3AZ9ToTnH0W+r96HIzYppbI+uyEZC69UmDut
         Vm9qCimI94xRNDjjtM+4m8UIBtrlZFXZyuEF4SdyHuZZnhz0xWd0i7u+Nn1OdhDljVeE
         r9Xw==
X-Gm-Message-State: AOAM5337NYb3lQicu0gnStUR24KCidZmPG3TJ/ktvDPa43JUhlxfcNNq
        Dianu14PNM6Gw6S2dZd6DeUIXw==
X-Google-Smtp-Source: ABdhPJwPO1EQcYJZ3fJbKhMNm75wFqtlTEhkQOWrkrVPpM2B92os95Di1BLlnJW0D1fpwToyGzkhIA==
X-Received: by 2002:a5e:8d05:: with SMTP id m5mr3570773ioj.114.1615905201756;
        Tue, 16 Mar 2021 07:33:21 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d22sm8423199iof.48.2021.03.16.07.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 07:33:21 -0700 (PDT)
Subject: Re: [PATCH v2] task_work: kasan: record task_work_add() call stack
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
References: <20210316024410.19967-1-walter-zh.wu@mediatek.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7d5b6e38-2e11-06f7-0a6b-356bdda0cd5b@kernel.dk>
Date:   Tue, 16 Mar 2021 08:33:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316024410.19967-1-walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 8:44 PM, Walter Wu wrote:
> Why record task_work_add() call stack?
> Syzbot reports many use-after-free issues for task_work, see [1].
> After see the free stack and the current auxiliary stack, we think
> they are useless, we don't know where register the work, this work
> may be the free call stack, so that we miss the root cause and
> don't solve the use-after-free.
> 
> Add task_work_add() call stack into KASAN auxiliary stack in
> order to improve KASAN report. It is useful for programmers
> to solve use-after-free issues.

I think this is a very useful addition, especially as task_work
proliferates.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

