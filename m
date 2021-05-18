Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180CE388131
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhERUSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhERUSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:18:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7F5C061573;
        Tue, 18 May 2021 13:16:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v9so14418009lfa.4;
        Tue, 18 May 2021 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ui4HvF4u1ZthW3m3DADtHzNkQGkWW15sCYUwiAwHHtM=;
        b=QY8KI5SkijQDHWUSh6NjCZVWCit3PJKggENgPaultVTQGTHvJFpwd+6MgITaEiH3XV
         Yo65zXFEZ1rIwaYayWBbHc0hY4xYJZZUS+BdjpA6YgfIx6XaKDqJ3APS74Zl4ZwDOWRj
         WUWBx4qR7xH0Ty1UeOmvhNR5IDFEPjz5RIiPyLYiRrO8LNEytcMQsv8QAFfAOJ++lyGb
         Okx13wNQ2O8tP/7zXRJtRKl2g9p9PoPRxQz2VNnXkdBcCE2wNBX2Aqod3Q8nqVZNtb2V
         mt/kUQAuF6ucW3VvCqEu/ZhQV+2CpcCym8Qm5eVAzf7LGI5wzj4fi3sSadLFX81IGbh6
         u6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ui4HvF4u1ZthW3m3DADtHzNkQGkWW15sCYUwiAwHHtM=;
        b=TyNdEDv2Ua9zA0mCO1LJ8eG5OxULNOd5OFAiPpJXwSbHgEcK8w247ethobfEgAvEUR
         kMGMaKpkyVbYLhmqe53KgIERTbXrUoezuKeaMc2UBMqErD/mI6gvIoDkkrvgnRPztZCt
         0kaWCc40vgwaLSmhLdq4szJnNWTvfyCnyxRoHozkQ3lL3KbVJn2zKt/qZgBaukXpgHbB
         aYTA04jCdMurCj3JK3jDz8M/SrQ1NYoGJFAk28C79h3qpcCBphtNT2d0pUxl8HytK34K
         HZRNyBuaYcFnD2WLfXyabfo+4FT7KTIu2Q4xCHHCLaLshfsKBeuEgfJ+0ECs7sxGYgwR
         NSrQ==
X-Gm-Message-State: AOAM530kpEqWAx0OisPabpJXOdPLKZAC+yHN2R3pJ0PcSI77apdlorjk
        5pre6MgL+1dGOJotkPVuTRjGJ/gkFVk=
X-Google-Smtp-Source: ABdhPJwumgr0EHheLLwl9qxBxvMiocUPyDDh+EIaQhWDXKIyelERgEZBrtVFTFIX3dxFZ1qMGk2Zhg==
X-Received: by 2002:a05:6512:acc:: with SMTP id n12mr5558086lfu.9.1621369009646;
        Tue, 18 May 2021 13:16:49 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.googlemail.com with ESMTPSA id a6sm3434048ljp.76.2021.05.18.13.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 13:16:49 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] ASoC: tegra: Unify ASoC machine drivers
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ion Agorria <ion@agorria.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210518001356.19227-1-digetx@gmail.com>
 <20210518001356.19227-3-digetx@gmail.com>
 <20210518180949.GA949047@robh.at.kernel.org>
 <20210518183455.GE4358@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b924f76a-56dd-5ca3-229d-293f7ff1e81a@gmail.com>
Date:   Tue, 18 May 2021 23:16:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518183455.GE4358@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.05.2021 21:34, Mark Brown пишет:
> On Tue, May 18, 2021 at 01:09:49PM -0500, Rob Herring wrote:
>> On Tue, May 18, 2021 at 03:13:56AM +0300, Dmitry Osipenko wrote:
> 
>>> Squash all machine drivers into a single-universal one. This reduces
>>> code duplication, eases addition of a new drivers and upgrades older
>>> code to a modern Linux kernel APIs.
> 
>> Nice, I never understood why each codec needed it's own machine driver 
>> (and typically in turn compatible string).
> 
> It's generally the clocking configuration, things with fancy clock trees
> don't play so nicely with generic systems where we want to configure
> them at runtime, or things with complex routing in the CPU where we
> only recently started getting bindings that were functional enough to
> use.  Tegra is fairly complex internally.
> 

This is true, but still it's more optimal to use flags in a single
common driver for the minor differences rather than to duplicate 90% of
the code. In practice majority of tegra boards are derived from the same
reference design, thus the h/w configurations are mostly the same.
