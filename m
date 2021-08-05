Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D63B3E1A39
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbhHERSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHERSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:18:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06B4C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 10:18:32 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id v24-20020a0568300918b02904f3d10c9742so2517897ott.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TKSj5MEKQ1gY7W+Z56fm3tBU4l2c5F1+7f+LZW3AUsU=;
        b=zivu60W0yaKjYq5/hhB/huyMwFYdeelDeUjyL0qp3DD+0K7L/go4Z3nDl0GQRtFyKe
         qSffhuvA506oDOgV0MKV0n41Jw8Syhq6XEecfm1IbdfBP0KzK4IWHtg0AOT2wi6ty7ks
         r/YKE9peMteV//iWCIyEXvjfEQc/jOT15hwK2NWoIOlacGShn9+xkUWzJcmivGd1OYlr
         vYEvYjtgN2iVuP1QbzVGlHV1k3NspAppkSSujeiJLeTZdbu5hyyvSOEbrYz5Vt9wFZGH
         O5nIWgLxYXJ/D3yrdoWibTH4/G1yj58wW+ieQ47QA7drwpspMScYTkZhZpJttXBNfmgS
         d3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TKSj5MEKQ1gY7W+Z56fm3tBU4l2c5F1+7f+LZW3AUsU=;
        b=qgjyZTko+zYxYV7iV01za0xesNmNnNalkhRlSkqNOgIMonqXUi/kwmZGoR540EXRMm
         WvK2pw27Yhn1q5UaFlckvS2tpfCm3DOWV6y9tpt7W8TDZdYzDKUROWMMnNj1dqQFOqM3
         kxBIrB9HC2TlxEQzqVj+bbLkVoyeitGij8ufj7Hp5dqJPXx3SHc8qYjy/MALQA6km2s5
         3FmMpusV/e/XnO5L5uEnXbFvVgP6LLcbAi1jiMWaDvuXoRXYVlUCRIUkZrLfaKDCDVZQ
         xh8yJUY/gHcO2Lw9cqqB9vjwzeKVBeYORl/+gt7xDEgGjVf+lwQryrYxiLI0uZlsV211
         btJA==
X-Gm-Message-State: AOAM5336pzCe/oMlJv24zT6tBzxT8OigXQblAPxk062faN1/k0bhohuU
        xCoAImxmejPdjtrF5s/Ok+4ksA==
X-Google-Smtp-Source: ABdhPJxolQGHX33BhFVxOHNUJigO83RZCrOZqwSVJ58y3V/1yWMSlOhErcMobw6CSpIV+zJtbRCO7w==
X-Received: by 2002:a9d:2f09:: with SMTP id h9mr1709993otb.248.1628183912276;
        Thu, 05 Aug 2021 10:18:32 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q63sm887354ooq.4.2021.08.05.10.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 10:18:30 -0700 (PDT)
Subject: Re: [PATCH] blk-iolatency: error out if blk_get_queue() failed in
 iolatency_set_limit()
To:     Yu Kuai <yukuai3@huawei.com>, tj@kernel.org,
        bo.liu@linux.alibaba.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20210805124645.543797-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb9833b1-be92-1b52-86cb-a45a85b18c00@kernel.dk>
Date:   Thu, 5 Aug 2021 11:18:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210805124645.543797-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 6:46 AM, Yu Kuai wrote:
> If queue is dying while iolatency_set_limit() is in progress,
> blk_get_queue() won't increment the refcount of the queue. However,
> blk_put_queue() will still decrement the refcount later, which will
> cause the refcout to be unbalanced.
> 
> Thus error out in such case to fix the problem.

Applied, thanks.

-- 
Jens Axboe

