Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E439634AC3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCZQFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCZQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:05:05 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D82C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:05:04 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b10so5908461iot.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DyM8mR09HOKJ3duG1Hs3IbvhPdT50cHIKRPlpFE7bRk=;
        b=PlYA5g107/q0IhxLnIi5RbaM5Djf85Bg+Sl4JiXyxHE92v43t11ahb3/98iuIBP/Pe
         J+T+6d0wSQwjUk5Du4ku4tnj21VWQSKwhnELjtJctOIpf8wm9gUtADd2+n2HDdn2H5RG
         WAaI4xn21XSeBXagAd3GynDsUumcrpZnScuZvhXQP6NsLVhtaAw3zhTeorqdBhGnADB7
         r/SMSIas60osEg+jBaKeTCTOaYJr5ZshsqrI9wwFE93aYXUch5H6XfzMrN02wjE7X7Xh
         xdCpPpXOHmq/HWqvebigcLMzXmyakgMj+33wUVVTFQA9K9tdWGGv04SLKfvktzvWlik6
         /r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DyM8mR09HOKJ3duG1Hs3IbvhPdT50cHIKRPlpFE7bRk=;
        b=UBv0heeG95NBAS/b9YZNyI9jajQUGnjR0tseNWV0smLW2/HjHOEa4V4RhV1KTOcbJd
         2a8rDL/TjOOEXpQqnI3jjgINnspXbD9VmTzZy2BASoI+d0O+wKFouVhIcZYTGeLoNYa8
         s6y77/+DfA+0bn2kO0z6Ml7RtNM14TbyqL7Leb+AWlWwGJGenSn47DA3kABGJLlp24iX
         9Z4l/2/jTi9wnab+zDixCK0vHTzO1I1HE9IQ7GZo/VXUvraw5I4jYybIEYM89CPvNmum
         CkvDQl7QY8A80XSgaMcqNYVGEV9b0e5qSdTLJYBJWsKE0pyrMvqOoWD+h/dxtgABSrlK
         SIrg==
X-Gm-Message-State: AOAM532ltBnYobDC3Wj8PfgB4I9IavJlkTuIqqAR4Q2wG+4UUQNKP5NW
        BAUUVA4oxFaGzVXTqrn7soZ+P1B5Afz6BQ==
X-Google-Smtp-Source: ABdhPJy2jPnhi1lfH0pmOKxay7TKLFnWV6o+2WfCCLe+1B/ouV+0+Y1D3D1dB2TalTDDXpzTrJ5N0g==
X-Received: by 2002:a05:6602:3314:: with SMTP id b20mr11000794ioz.78.1616774704004;
        Fri, 26 Mar 2021 09:05:04 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s3sm2897293ilj.77.2021.03.26.09.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 09:05:03 -0700 (PDT)
Subject: Re: [PATCH] Revert "Smack: Handle io_uring kernel thread privileges"
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <04c7c410-08e8-626a-795e-b77db6666804@kernel.dk>
 <cc7dc28e-f812-a719-ce0c-a288d8facf72@schaufler-ca.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33fc367c-ec00-eba5-71a9-59e47eb76163@kernel.dk>
Date:   Fri, 26 Mar 2021 10:05:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cc7dc28e-f812-a719-ce0c-a288d8facf72@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 10:00 AM, Casey Schaufler wrote:
> On 3/25/2021 5:42 PM, Jens Axboe wrote:
>> This reverts commit 942cb357ae7d9249088e3687ee6a00ed2745a0c7.
>>
>> The io_uring PF_IO_WORKER threads no longer have PF_KTHREAD set, so no
>> need to special case them for credential checks.
> 
> Could you cite the commit making that change?
> I wouldn't want to see this change back-ported to a kernel
> that doesn't have that change as well.

This is strictly 5.12+. The change came about from:

commit 3bfe6106693b6b4ba175ad1f929c4660b8f59ca8
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Feb 16 14:15:30 2021 -0700

    io-wq: fork worker threads from original task

So don't backport it.

-- 
Jens Axboe

