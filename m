Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E17C41A3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 01:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbhI0XZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 19:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbhI0XZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:25:40 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E63AC061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:24:02 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 134so24927490iou.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aiFGagUTxQBnltkSEFIoIU5oY0RjA6yVWSQ2liMMneI=;
        b=j4l4cerZxmvRBFo9+l9BQYL6AkzAopJsl20GWDSIrISjgLNhwhyUQDgcFLI87OvTcL
         t/He9yZhqI/cPodGu+OkbgGmH1S7L95w9IwBPy2eDb5ZhrO4OA22DQ6orSLthPUp8xVZ
         oIIr58M8MAbD2pjlXaHNHESM9fKnM1zfg80Mb2N1pp9d9BpGhpxkwS7as7y454k+B0ye
         LufmIqZDO3GmPh+zxBgitFrPpt5gouRgTIBta571rDslFpm75wmx5PtMFvZKfisPb48N
         6e4Pw3KgnWYPremFqKZ5Zf2mk39T9srpZap80F9Oudy/lbsB3AgEF4sONU54MRun0xf/
         Kvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aiFGagUTxQBnltkSEFIoIU5oY0RjA6yVWSQ2liMMneI=;
        b=2A7LriRmEFgPWl4BV/CrWO08blDwoFyUP3Zxvqeq0ifHm33qoXSDUTgb91BxXxsLlw
         5GB+Xn6nEVBjRPLeg6aSLNkUjs6b8/xQokJyiTagSX3xPXJp30V2oFzN4WdD3B82a1zs
         PzPdpINBSeuijyjRxbAnf4KZcitZKC+BX/biXawxwJwkf0F3fjEnwOGl59DKVzRD+Szt
         U5iONEy2vqJC86QCykpJKPauQ28aeYBGhxF/YPAydNbtUAnAXW+8/eAm3WbHOa0uENVo
         SwblPx8L0T804PD3Lg1V1cNLLM6yolKREPapRLX7zitzRaD6SyOEi2Xq0SW8RffUMlj5
         FvfQ==
X-Gm-Message-State: AOAM533Kz+ZYLzo+oX+fsZfjsijUaHbbnVzZPJOQcpyMrz5N9t5qqf/r
        iWmBqHCWpm5FcgoFnBm6eDe4t3sQd3fiyg==
X-Google-Smtp-Source: ABdhPJzcHoH9jP9w7ZB7Bz7huhMzmKrPerS4qwZbTDMWfRTFVmKbhCBMUPsYmvpBiIoTu14VNW/P4w==
X-Received: by 2002:a6b:6f0a:: with SMTP id k10mr1611488ioc.101.1632785041193;
        Mon, 27 Sep 2021 16:24:01 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o7sm10361931ilm.9.2021.09.27.16.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 16:24:00 -0700 (PDT)
Subject: Re: [PATCH v2 06/15] xtensa/platforms/iss/simdisk: add error handling
 support for add_disk()
To:     Max Filippov <jcmvbkbc@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     justin@coraid.com, Geert Uytterhoeven <geert@linux-m68k.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, hare@suse.de,
        Tejun Heo <tj@kernel.org>, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        Chris Zankel <chris@zankel.net>, tim@cyberelk.net,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-um@lists.infradead.org,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
 <20210927220110.1066271-7-mcgrof@kernel.org>
 <CAMo8BfLX84HBuVe=FyqWkVU5Ek-aKFk++omnqsmf9wO6fdVpMQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7889116c-c01a-a041-89f3-4390b16c6ac0@kernel.dk>
Date:   Mon, 27 Sep 2021 17:24:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfLX84HBuVe=FyqWkVU5Ek-aKFk++omnqsmf9wO6fdVpMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 4:50 PM, Max Filippov wrote:
> On Mon, Sep 27, 2021 at 3:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> We never checked for errors on add_disk() as this function
>> returned void. Now that this is fixed, use the shiny new
>> error handling.
>>
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>  arch/xtensa/platforms/iss/simdisk.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>

Applied, thanks.

-- 
Jens Axboe

