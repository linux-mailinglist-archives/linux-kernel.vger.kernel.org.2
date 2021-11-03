Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA36443DDA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKCHzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhKCHzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:55:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8397C061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 00:53:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z200so1219697wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VPh4Dp+YKR59+rlQQnZun9Wq0rnlFLvRuPBwa+z2RvM=;
        b=Bvs59YztcKrQgr/3MlFXaNRvNjo3nIrK+STERsF0DOCNPqViLk7I5MkvstnEdP9yHk
         tGarK71Fb/8M8fSU6GeJavnGlCz85SClNxIUtABsNC0Jht1of/BpWbTqduvu6Hgsafis
         qkEbXjsFKUIyLeL2SxUDgecrCw+vEYLGOvyfN+iMHisrHMv2dfpsqjstkgiUVfThiJPF
         5h0d8hd7b85U65GKeFfjGDLbjOB2REbRkt8VLI8UcoAp02DORXpHk/vm6CGAom9+CrQ8
         bsRcmnxgH+SNWNbPLUGfIKvyXApSN6a86dl2+JpPI0/uJwbyJyKlAubUeaF5mmF017U5
         j7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VPh4Dp+YKR59+rlQQnZun9Wq0rnlFLvRuPBwa+z2RvM=;
        b=pukeKokI7z59nnTy+xC2eqmUvV1qQdlpw1xXWRlveSInHHSCByx78ATpT1CjsS24NA
         1nz6AUOt5WBSjlCZ+LzwZ0urAnTwQMVMIsj3wFCRpDOANUVgGWqPxisVvyFtGG4flduL
         qylSBCfSNUUourn0wr+8mQo630Wd69BnS2DKXSIfTee8MCXvWApWuNfVWTAyLB9q1BoW
         DED0PV1YtbKi0kbhIkYUPQpacoVN3CliXJ0Ar9jT4thm6dLpL0LjXaq9umuB9TQMj8j0
         JwekN5zo1ipW6L+oyGjWz7RIzso3ocGBQHSEj4oZ0Ex99+64zJ30pObGJ8FTugoQX6H3
         /SEQ==
X-Gm-Message-State: AOAM531ZQ4MGoql3vY7v9OMmJH/hOsL8MuI8iaNHwa9yMRI15jfEoa8r
        5k1pot7qCAzjS9xM6NRd73plULZRLeoLlQ==
X-Google-Smtp-Source: ABdhPJypsAKICi5O+rUKAdmond76Pe0yRzhI6Its+Jwd5+oXnfb+g1mW5wvyHbF0a11pZZmnTYw4mg==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr12877614wms.81.1635925986247;
        Wed, 03 Nov 2021 00:53:06 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9646:a63d:c457:d22e? ([2a01:e34:ed2f:f020:9646:a63d:c457:d22e])
        by smtp.googlemail.com with ESMTPSA id z11sm1190976wrt.58.2021.11.03.00.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 00:53:05 -0700 (PDT)
Subject: Re: [GIT PULL] Thermal control updates for v5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
 <CAHk-=wijOKZNA0Ahd0fNDDa8pc6abv9wUHbxBf8giOeERHkW0g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <60950c33-a5be-c465-cb5a-9e33b13a1ee4@linaro.org>
Date:   Wed, 3 Nov 2021 08:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wijOKZNA0Ahd0fNDDa8pc6abv9wUHbxBf8giOeERHkW0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2021 01:07, Linus Torvalds wrote:
> On Tue, Nov 2, 2021 at 12:55 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Daniel Lezcano (3):
>>       thermal/core: Make the userspace governor deprecated
> 
> This one is very annoying indeed.
> 
> How about making that "pr_warn()" be a "pr_warn_once()"?
> 
> Because I don't see the point of
> 
>     dmesg  | grep "Userspace governor deprecated" | wc -l
>     19
> 
> almost immediately after boot.

Is the platform with 19 thermal zones and default thermal policy set to
userspace governor ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
