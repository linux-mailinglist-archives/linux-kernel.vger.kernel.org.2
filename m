Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A012430502A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhA0Dso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389566AbhA0AF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:05:56 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861ECC0698C9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:57:25 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e7so86976ili.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lVlYNjzT7M9XYcY1AJBsYQbJt35OxmXiXtA5/6wzWIM=;
        b=iWXnckihRp8Get7cI4ohFu5NibD7OCV+uXgFGXsXwJRmFd2q6E7KP6HLURTFj7IXMO
         WkJSl6ebXUv8TuBBVmO56nhPBbBLLKKpZ4bxjov9SyZgHZEvn59NAJ0rwaX0fOHpSw4c
         /BUS2rs+Z7demP9nA2H8nsvi51Hsc3j8UgAlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lVlYNjzT7M9XYcY1AJBsYQbJt35OxmXiXtA5/6wzWIM=;
        b=msmZniXo5Y/5c+03Xi2P2/2E9iLokWZb+NMwBf1alj4tlpqzKWcHMOEXkduuotWRAh
         Q0aTVxFecGHQs0WXTPRZtapW4pOyG0iy9qWjmhWafZditX+uUYrFOZJXk4fJWhP0bZaA
         sDMkDYeB5Afyh8vRh9RvD+ye0BGRQr9UzA+nDGeco4iGYsGm3RhPeEg4AvyNGW8WHtv3
         GF/Fxef3s1LdnTMAFB+knc4jQdUO12OZEXj+uagKlwRepRfA6tUnNaJZ0ZB9AD3Xi8q8
         G4Sq+oPgQMfht5MBsjnSjteZCDHeEKNn8h18qu28h0g3QA25ITf1WLlTq9Y4wEzY+hsY
         obzA==
X-Gm-Message-State: AOAM531QZBvVPu9pOsvIyIE0ILhkP5ysKKjka/CPeLXkQ/XtP0TgmDxx
        +5hQyLmXGfA3PhXQAFSkyMDZ3XbFO8Avrw==
X-Google-Smtp-Source: ABdhPJzVArRfuQvkHlaDTxxrT6Xs/nH6XhL/ZWMAK+fcADhTsruLOsFCm1AR07otjR6gcJeMO8HkrA==
X-Received: by 2002:a92:d3c7:: with SMTP id c7mr6691646ilh.137.1611705444561;
        Tue, 26 Jan 2021 15:57:24 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n10sm117380ila.69.2021.01.26.15.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 15:57:23 -0800 (PST)
Subject: Re: [PATCH v4 00/17] Miscellaneous fixes for resctrl selftests
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <434427a6-8bf5-e306-8ba3-91866abd6917@linuxfoundation.org>
Date:   Tue, 26 Jan 2021 16:57:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:19 PM, Fenghua Yu wrote:
> This patch set has several miscellaneous fixes to resctrl selftest tool
> that are easily visible to user. V1 had fixes to CAT test and CMT test
> but they were dropped in V2 because having them here made the patchset
> humongous. So, changes to CAT test and CMT test will be posted in another
> patchset.
> 
> Change Log:
> v4:
> - Address various comments from Shuah Khan:
>    1. Combine a few patches e.g. a couple of fixing typos patches into one
>       and a couple of unmounting patches into one etc.
>    2. Add config file.
>    3. Remove "Fixes" tags.
>    4. Change strcmp() to strncmp().
>    5. Move the global variable fixing patch to the patch 1 so that the
>       compilation issue is fixed first.
> 

Please add .gitignore for the directory.

git status shows:
tools/testing/selftests/resctrl/resctrl_tests

thanks,
-- Shuah
