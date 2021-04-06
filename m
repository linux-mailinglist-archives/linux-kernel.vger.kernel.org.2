Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E670E355C84
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhDFTpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhDFTpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:45:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E9AC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 12:45:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d191so7917418wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VxjAsv2lS45u88VYl/Ft34pezIndysKO7t4ScHYx7y0=;
        b=Q2+p/w4chlXvSK0D1dnFBP9YOviJkh4M3AD6jqbAJdh0PvUPahDhte2vRkHekDD6k9
         Edg8BD1CJ0Ax8QnaI1NR7j8EHnZVtaOsnpSgdG5VLWaUwlgct0Ws961dX/Ao4keVRGax
         OvVzm7fm27WROD061isVXJ0C8wTjOwdErFIPDDc7z9P3r7sQfKSEDTr/PdusgWkcWiU0
         0C46M74aXX3cY935CtSZborooeBXnBOhz40gQbmcB9MX5zn8SGQ0hac+E9P4HCCRE0Ty
         0ZYgjIZPrF9GhC2nKKKGUBmDDtYjEtVhcYe/QO1EM4x/WP4ThPQ0K7L/JFV4fo18Z8mD
         EyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VxjAsv2lS45u88VYl/Ft34pezIndysKO7t4ScHYx7y0=;
        b=TkRajp9ATuCq4qXKXavQTD2V8nHG/7iDfnVeGqutdUreDXp0C+4uinsypTNWFfyWZM
         /v+RnplAck4O3HohImUoQPM9toLhezBGGteQO/7rXPL4+CMFWqlYVHexJZDxKuoxancI
         Jjrha6NREIoBcb3fs0thCcdKWPfzf8yQ863W1htq1p9Pp1XTsVcLvgutVDMIICjVlcN2
         oEis7qIoLNaTbdzhnCyYyo6SWRL26k5py6z+ypj2cunNJr84tKqtHyLRsmk0Mcd5tNrD
         nnobK1ouCbDt2PEfMpUihqiujVlrNl/1RSBKdXk458InLxqDb1XGXAOg4QzjRHVhJ666
         pjfA==
X-Gm-Message-State: AOAM533r7Tab4Uq1Rx46OPGIQiNZqM4v8LckQ8XaAtT8J89rQhTQUFLX
        WgPjCVvdYVNy9rrjWy0Hspx6Kw==
X-Google-Smtp-Source: ABdhPJxbt2VqNOSCRyIyj1bIAgmjAlVLqrDBh+Q1AwQy0wqqPJDsFuO9IeZifjXD/CbdxOw9+gcnew==
X-Received: by 2002:a05:600c:4f89:: with SMTP id n9mr5711921wmq.133.1617738308699;
        Tue, 06 Apr 2021 12:45:08 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:90c5:36a9:5586:99b9? ([2a01:e34:ed2f:f020:90c5:36a9:5586:99b9])
        by smtp.googlemail.com with ESMTPSA id 187sm6550429wma.0.2021.04.06.12.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 12:45:08 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: power_allocator: maintain the device
 statistics from going stale
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210331163352.32416-1-lukasz.luba@arm.com>
 <20210331163352.32416-2-lukasz.luba@arm.com>
 <b27e0c79-de27-f9b1-ad16-17825b302615@linaro.org>
 <1f0710d5-cd78-dfff-1ce2-bba5f6e469b7@arm.com>
 <1a0b6e4a-1717-91d6-a664-d50e6aa8a809@linaro.org>
 <d74b8e8e-64b0-d724-d572-f98eb597a60e@arm.com>
 <cbc40019-8b2d-5d14-f0fd-b0018fb4a1f6@linaro.org>
 <f7dfced2-23f6-8d3e-d23d-291de368f472@arm.com>
 <7660a09b-51f8-c6f2-5678-77b6bff97af6@linaro.org>
 <d1bacbb5-9a45-b06d-b646-11ba77510dad@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fce446fb-e53e-40a3-d0a2-175cda0f73fe@linaro.org>
Date:   Tue, 6 Apr 2021 21:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d1bacbb5-9a45-b06d-b646-11ba77510dad@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2021 20:38, Lukasz Luba wrote:

[ ... ]

>> But there is still the polling delay because the governor is IPA in this
>> case? There is also an additional trip-point0 which is not a target for
>> a cooling device, just put there to ensure the IPA has enough data when
>> reaching the second trip point which is the target.
> 
> It's just a configuration which was there for years. Some who wants to
> use IPA have to be sure that it has this 2 trip points: switch_on and
> control. If you are talking about a new design, then it's not for this
> patch. The complete re-design of DT thermal zones, sensors, etc is
> a huge topic.

Right it is not for this patch. Just pointing out there is something
wrong from my POV when polling is used for sampling.

[ ... ]



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
