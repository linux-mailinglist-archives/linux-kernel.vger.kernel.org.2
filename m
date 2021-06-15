Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432253A8B37
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhFOVkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhFOVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:40:08 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F7FC061760
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:38:03 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso348281oto.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ktvid5LXIM7drztkwdX9ozDIlIDeMyLQZst/rY14IM4=;
        b=zD1aW/O4VDuKIIKdFuwz2Ojl7wf3CLuun/3va6xMimNA6l8jhK6SPx2l8+AWtJNAKp
         BhsSSs78peO1Fd/zmAZIhyfwOYNzotlnR6FYf6A86m2vhSJJDIE/regKtTzQRYtet52U
         TfsTx8jGr/P7ajZMHEoeizhVU9l22/k86jbVbhvZceGzDIc0sTVpiBIldvz/lyBubWlL
         ETdEkf4HL30x3OPOnJxR9xtnsdm7jC/EFJ5BnfUAMYX8j+3A2rK8gHr4M2UxkoO1mIAM
         ZV2+fzIcak2q4i+rNRHLQKcT1WcU+cDjIJUIcX8H1yrOKPFnVdiF/+45TCpzMqEssVpY
         IxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ktvid5LXIM7drztkwdX9ozDIlIDeMyLQZst/rY14IM4=;
        b=dFypvkF/Doq40fk3Zn81xKC6OV5RNMBsg+6uPc7Rx34ScOBXjc89fveMdtNTKddD1q
         2shUhxmEYvsOXVvmx93H7goU4Ae+KOGO1a7R4PsSGnsh9FgaazNvCcGqOMzQVOzas/ZO
         pUFYJKtBaXQYVmNRTNBW+EfCWqr+bf8BItJTFZs4HBVnoQFfJJ/d4WYzZe8se+EIq2zg
         Y/EEqIRSlLHzGF5nySANZpQ8DOcHEbSqTPVorbnBJI5rGnkYVDCWVlLb9t2LKHvawMmf
         /tsuRfefrUzKBDWiZ2YX4TKwn+G2ItG+ZbK6U3PeeW06RSUpIYiQQA0mR6olKQrMt3JF
         nMgQ==
X-Gm-Message-State: AOAM531Wu1uc+8XiyZhWKpE76rhIJ/zVILuQlILPErJTeS6p3wbLehW+
        dnq3UZqkCWbEQR+AWCdR85ocalL9pwB3Mw==
X-Google-Smtp-Source: ABdhPJytngzhKqyqU5m/g9kKa33OJYlC3KL/VMY2NdSzLTOIkMokegs/VZiBqv1cSCyDJRGsl5rMzg==
X-Received: by 2002:a9d:355:: with SMTP id 79mr1071698otv.101.1623793082643;
        Tue, 15 Jun 2021 14:38:02 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id d20sm42457otq.62.2021.06.15.14.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 14:38:02 -0700 (PDT)
Subject: Re: [PATCH] io-wq: remove redundant initialization of variable ret
To:     Colin King <colin.king@canonical.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210615143424.60449-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <532fcdf3-2b7a-a9c6-039a-5dcfb32a61e1@kernel.dk>
Date:   Tue, 15 Jun 2021 15:38:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210615143424.60449-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 8:34 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never read, the
> assignment is redundant and can be removed.

Applied, thanks.

-- 
Jens Axboe

