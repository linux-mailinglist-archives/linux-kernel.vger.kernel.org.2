Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70935A097
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhDIOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDIOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:02:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1797C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 07:02:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h20so2808891plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/hyU5Hg3QS5M0nJuXFPoAFAqRmr31/8ghnomOL7zLEY=;
        b=Zsb3DZ8DqONAYhLhPc/vlhQSj58YY3Fe1a9oTrZDOkvZzuwYD/e9iUvuMZs9we8qVs
         nFz7FPBTfST58+N+CGxGuFRm3FmlBOhakywuIziYORos1+2jE6eP+X4A2/MMMedujG7y
         25ZfNdLye5iCDf60PdPLnFvFWaMhxwx4VjcASlagPOsJwW7CnagVNzMtD8kOhXvsUSl1
         rLtLJrhRfAZmMvBtYwQXvkVk0JOPl3oJiBWdGwbNfYHGlXgZFv9MWbSoDO1l77VRdgiY
         GCinYA1wFcqpXb+6FdR9MASLP5QAl9JcGPFgU5rU8QjXgTcxOGv2+/z5GlcbG2eu+uJ7
         Rr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/hyU5Hg3QS5M0nJuXFPoAFAqRmr31/8ghnomOL7zLEY=;
        b=nel6+Gv67iWmS4ovTgE2X8OVh8enQegaNmuqDruXLwRTkwLIRgXBFtELCt2Y9XcxXO
         qo1ZqujhW7QBQXIikjgfcMVN1dHArXYnH1QkuQM1kEP2pNNW1qPZxhnThTNBHusVY68v
         cyf7Dcs1xCI3h7LWKJIr0L6UN0ooe31zLBfcvo4S3x9L4WvYD52/viXhPOySNTydD5ZC
         BftZde2abZm181Po0tEy0uGwoPBPgbCwpZP4INNPFQbAokRNorBjXU7fpVBko7ASLIgY
         53BRIBrcMDmFNjzKN5GMbHE5FGfy0xExAaZoBSaND1qtOcKfVsNa+RPpf4VMbc+0ZW6h
         Usug==
X-Gm-Message-State: AOAM530kg16uQJDhKXH2h0hd4k8krViUihCmdiTZG2QjJCnM1ek8S/tu
        JqD97H+BY/E26l7YP+7xImeE8A==
X-Google-Smtp-Source: ABdhPJx0deSfTRg0UGucuEqeb9trWN/xZJxdFKHIBzE1YwduY5Vd/FXwOjQr3NETq0ZENtY8AsQWAA==
X-Received: by 2002:a17:90b:b09:: with SMTP id bf9mr13678508pjb.17.1617976958473;
        Fri, 09 Apr 2021 07:02:38 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id r22sm3100073pgu.81.2021.04.09.07.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 07:02:37 -0700 (PDT)
Subject: Re: [PATCH] pata_ipx4xx_cf: Fix unsigned comparison with less than
 zero
To:     angkery <angkery@163.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
References: <20210409135426.1773-1-angkery@163.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf8a5938-eeff-5cae-8bb5-c3488d904980@kernel.dk>
Date:   Fri, 9 Apr 2021 08:02:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409135426.1773-1-angkery@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/21 7:54 AM, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> The return from the call to platform_get_irq() is int, it can be
> a negative error code, however this is being assigned to an unsigned
> int variable 'irq', so making 'irq' an int, and change the position to
> keep the code format.
> 
> ./drivers/ata/pata_ixp4xx_cf.c:168:5-8:
> WARNING: Unsigned expression compared with zero: irq > 0

Applied, thanks.

-- 
Jens Axboe

