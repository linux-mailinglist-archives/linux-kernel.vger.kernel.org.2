Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061C935B8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 04:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhDLChB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 22:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbhDLChA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 22:37:00 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA1CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 19:36:43 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id l76so8239813pga.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 19:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pXGUTCuwQEYmj1uTHhPOB9cfdu3ZZBqB6U+/rfdEAR0=;
        b=aP4RlfXUP3gMHGZUAbY0r962xDlEkBPZcayRWgzCUro9tXIvBJ3fPKESsBB0ldceKs
         AmJH1tN7YVQ09KITLCK0ySl8D7JYfNUZrsmhSX33SiJ1+34zm7bJ27zw+z3GWA21eJGr
         NFXHjuBe3yJWqsNEkwYNmTnmZEFs7bZZq6I8ftUkDJTw/GLSWVA3dtfrsS+jvGAfh/iI
         gbyi77/Hp/T/d1030CYIiQnKc/89sk0EiLUFQaXtkk1UezkG+GQtbm0m751xV3as7EWj
         rXECirW1OoNCA8vGawjDYS5jyoOLHfHZC5l0DOJzyJ0RV/QOC8Jv/x+vJpIow6aTyUeF
         mZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pXGUTCuwQEYmj1uTHhPOB9cfdu3ZZBqB6U+/rfdEAR0=;
        b=RA/zilLz6rDhvqYUGjWI5v9/oTyaTMWN6ntxCRVSBf+dh9OEc0kqzGdhwu0m4EwV1Y
         7fIA3M+xCI9/Pm3Dw17h59bJU9EInMSlcSHFAykzOFKGJ143GzbLJ4+Hia2JiX7dIMAa
         LywpgZSNn5AfNskBobBY6l9Ee5AlFEYA9f+CAjbD0xrtIsFAOuGi44SNmGIPEr4FwraK
         igqymWwr7A24YQqtjgB6mrhqlkKYXWEUCoxQ8ZcjQvN88MvLUxT4aU+pRUHQ09v4i3ga
         Ty9ad0EDrKdK8aWDnCqn2UKXtJx7NthtYtT7+GTWyAKJ0bItGrE2q93cuz9E+TtASq6U
         m0GQ==
X-Gm-Message-State: AOAM531mm/9fWrSHb3aB0viZq1LeUHJDb52Qhc1V28gtPfZe3hCsRBW8
        HM1PFhBYB5cqTmYp/CeJ6R/XrA==
X-Google-Smtp-Source: ABdhPJzb1E3KCGKLsAtn2eoYWgujQ33fMAWmRNqizdMU3kzh6KdnKp4++JGJFkl7CCK2Jik6xLUBBQ==
X-Received: by 2002:a63:fd44:: with SMTP id m4mr24865907pgj.233.1618195002955;
        Sun, 11 Apr 2021 19:36:42 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w67sm9656066pgb.87.2021.04.11.19.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 19:36:42 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commit in the block tree
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210412083404.2d0dcf7c@canb.auug.org.au>
 <0aa24415-74c5-1adc-6e27-edf37285de4e@kernel.dk>
 <02ac7276-e3c7-79b2-b3b0-361bbb884d16@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d2d4d147-65f5-a039-ac2b-ad2eff8c0db4@kernel.dk>
Date:   Sun, 11 Apr 2021 20:36:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <02ac7276-e3c7-79b2-b3b0-361bbb884d16@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/21 8:26 PM, Sowjanya Komatineni wrote:
> 
> On 4/11/21 7:14 PM, Jens Axboe wrote:
>> On 4/11/21 4:34 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Commit
>>>
>>>    6fa6517fe62e ("ata: ahci_tegra: call tegra_powergate_power_off only when PM domain is not present")
>>>
>>> is missing a Signed-off-by from its author.
>> Sowjana, please reply that you're OK with me adding your Signed-off-by to that
>> patch.
>>
> Sorry I should have checked that. Thanks Jens. Sure I am OK with it.

Added, thanks.

-- 
Jens Axboe

