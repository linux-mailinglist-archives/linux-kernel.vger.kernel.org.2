Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62BF3A04A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhFHTul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhFHTug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:50:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B960C061787
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 12:48:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e7so11267739plj.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K5WXhta2hCvJCRnZxcFPHzW1hODRuLylvsgvFrxcdI8=;
        b=k9yN+YUOYtNiWTpQetmutyMY4TiQY0hcTj8XyoEuovjugiQpy0pawNzpKKtZ/EYYBq
         elkGTK10FDO+NCa3sTKIs36/IuFbkhbW/nIMLR9Y5+XDuI9GXXBt4E8QJXuDycOK+D2c
         II2tozs5FygeqUtrO9PIvxh21Dfyz3y3uXOt848cLDB6/76fK940tPqy1SpXg016/jBA
         VcYCCEgGKTc4v8LoQPTJUNnG9XIWQnkQrxgEX0eJTwfl2JNwSTE8dGk4Otc07aS71XxQ
         6eUUVw43patXbugvdQaAzQbBr0cgEE102IqvKOW+H4UqVj0lt478x8g/jbI7hdm6pi1e
         Ohhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K5WXhta2hCvJCRnZxcFPHzW1hODRuLylvsgvFrxcdI8=;
        b=SNN7Oxc5QAmBOi8xoB+6OKGhc05IUm4F4DBDCop49xBfIhTzFBzg9nvzsUoaL8L9Cn
         1vQNKxaDBeBQ9+LkdYoZE2LwLssz9OaHcv7W4JFI8p/Ex4ZtpFGS/laIvL5wJAjDj7tI
         RdZC98Lyogw+zjNgY62lkYqaNkS+7GvELS2Gy6RhUF3a9IwFOXMjgK2oI9uAxKDRlDbJ
         yzM5xBcEAjM7uMpsAGaZNp/YQqqqUQO5F3XYKRh+LWvohXvLp2ErURa7xtOHUCPlZCEx
         VvBp3QjgxoYp/h7eO6PhgXPMFKW6IwwUKZc1ry1pz9EyW97kcN5VqA73VXSym9qB7FHu
         x5TA==
X-Gm-Message-State: AOAM532yHLDEmUdCLYNTOSiu0/XqtIrCbVKCx8YTcCLclnfs/U8KBxZn
        PhyNi/1SVRhkH4NtAPlHmy0=
X-Google-Smtp-Source: ABdhPJwPIah+u/a73BfUqZM/c5h4HSfphEqcCnK7E9btJ+VBGieAbsby5weaQ00N2dJYWUsrGN9HXg==
X-Received: by 2002:a17:90a:de15:: with SMTP id m21mr21036268pjv.87.1623181722023;
        Tue, 08 Jun 2021 12:48:42 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r92sm3269852pja.6.2021.06.08.12.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:48:41 -0700 (PDT)
Subject: Re: [GIT PULL 1/1] bcm2835-dt-next-2021-06-08
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210608100543.691185-1-nsaenzju@redhat.com>
 <4f3bf1bb-1544-85f4-0539-033f36f86d19@gmail.com>
 <e032ee6b46097ded860e680e913827d0a3a1938b.camel@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f60d1679-51d8-c6d3-9793-4d5e08ee6f71@gmail.com>
Date:   Tue, 8 Jun 2021 12:48:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <e032ee6b46097ded860e680e913827d0a3a1938b.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2021 11:33 AM, Nicolas Saenz Julienne wrote:
> On Tue, 2021-06-08 at 07:21 -0700, Florian Fainelli wrote:
>> Hi Nicolas,
>>
>> On 6/8/2021 3:05 AM, Nicolas Saenz Julienne wrote:
>>> Hi Florian,
>>>
>>> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
>>>
>>>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-06-08
>>>
>>> for you to fetch changes up to ca5909b7fa6af9c7b9a215a8708926e44345a220:
>>>
>>>   arm64: dts: broadcom: Add reference to RPi 400 (2021-06-08 10:44:36 +0200)
>>>
>>> ----------------------------------------------------------------
>>
>> How about:
>>
>> https://lore.kernel.org/linux-arm-kernel/1622981777-5023-5-git-send-email-stefan.wahren@i2se.com/
>>
>> can you add this to this pull request?
> 
> Sure, I figured that since it's a DT binding it should go through RobH's tree.

Since RobH acked it this seems to communicate that other subsystem
maintainers that they can take the patch via their tree. Thanks for
issuing a v2.
-- 
Florian
