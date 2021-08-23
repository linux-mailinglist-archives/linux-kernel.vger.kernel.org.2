Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1D53F46BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhHWIlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbhHWIlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:41:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A66C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:40:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k29so25055949wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8YbZ6EnieJwLfzvh2I8z0yFpVKK2fILyd5OU4iRqLnY=;
        b=DQwIsyRCbWyKCN5dTdL84j8eKjM8PixnU0XWIF5E9w88cK7sZ4x/qEgbsbLfL93Kvl
         K2Yc3J7SF8UTlRPUURYIMUi0OeW8tsqdU4oN9dCtbUPP2wPyGiPuKy8A/QsJmrjqnar2
         K6r9N3exn6fpVb/AllJ1yU/wHfDuC/tEyoKIrPeWwkGZOJUcCp/LL6H2SZrlygZELQVe
         VrxxAkFE4mz6sOhVlgEHuPSAqLhtdMeJpM19fMGeGXoGbiymwjGJr9+r43bGjYwVo7Nx
         jMiZifCYYIpRz5lDf0jwTQD4y6lVquurnkEwImB0tEoz3SfkZokfkqWWEjtrgwzq5N7p
         YLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8YbZ6EnieJwLfzvh2I8z0yFpVKK2fILyd5OU4iRqLnY=;
        b=AjQoPddq9rNB84AtjhVCAIv4SUjAZiWLpDETk08KvGFJBIMme5Fqh87gNwNpnIIa71
         3zfxNUTGP5OGxSIAT5nzm6h9v4tAKg6L/0fk57WyFynSRC6fHG+1XjJTp/hkZe0t0Vel
         tyzZikrmRc34JFdPrh/IqKd88km+fr3o5hKkuAzJRrS0CCkMW4v8/xLfLKRoP34yRzIR
         /r501vTDMSGeIqq0f/LsNUtvzF/A2eeMSFZXzScoowIWUgRpmRNZJGfVNM++efIDth8F
         WW8Dk3C4XbkyMwPzBCM4g/bXBs8lt6pYKCJlb5nxIme4ZMQu2hupGUJOv958dZXdHJq4
         wEkw==
X-Gm-Message-State: AOAM5315l6dP+krfzsKwrs4bYsgF6p/b7AGp8L6sTMQq4VAg4CQKS5Li
        NSTi4MFofflQA/LklV464BdSQA==
X-Google-Smtp-Source: ABdhPJzL2jd89F5hSs8TRFT7YjYOrLvPQ5ahvcDBNmnq6H3m3GuuLODSBZ+7dJ+Gozv045u4T3KbHg==
X-Received: by 2002:a5d:63c4:: with SMTP id c4mr11694732wrw.27.1629708047510;
        Mon, 23 Aug 2021 01:40:47 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:fe2d:133f:1574:bbe? ([2a01:e34:ed2f:f020:fe2d:133f:1574:bbe])
        by smtp.googlemail.com with ESMTPSA id b15sm14724177wrq.5.2021.08.23.01.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 01:40:46 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] Add a generic virtual thermal sensor
To:     Alexandre Bailon <abailon@baylibre.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com
References: <20210819123215.591593-1-abailon@baylibre.com>
 <f7d1205b-e859-e059-c835-c09a85c8c480@linaro.org>
 <df9ad6a9-4cf9-dd41-8876-d19bef03d6a5@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <87f1e4aa-1c54-e5ca-7bb6-e0638e4c1b4a@linaro.org>
Date:   Mon, 23 Aug 2021 10:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <df9ad6a9-4cf9-dd41-8876-d19bef03d6a5@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2021 09:35, Alexandre Bailon wrote:

[ ... ]

> I am not really satisfied of that patch but that the simplest way I
> found to do it.
> How would you proceed to get the hw sensor from its device tree phandle
> and id ?

Could the function 'thermal_zone_of_get_sensor_id' help ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
