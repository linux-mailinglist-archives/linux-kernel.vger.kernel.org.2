Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DFF3839B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbhEQQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbhEQQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:25:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604EFC030CCE;
        Mon, 17 May 2021 07:53:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b12so372671ljp.1;
        Mon, 17 May 2021 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W+IBFI3907TKPQl0quSZrdhLR5RSLqOADK2+CwwUs5s=;
        b=N4ZOP5ZtWqwqOTBI/nKUZqLD+AbBAwirkL901g1LQTxY0SQUZwO4SLyDFNrm486T4M
         iZJEvBuv3c/hOPKeaCADo2LfawJ7S4aaOdOluNou4j0pocOQHC6LpXkJWam4U4umijD0
         5HHD52ywpJblkld9EXThareKV7GnS2LiO/Pwq52JTKErcCnI2QiplksFs9EsWbtR1b8x
         a6oRwJVSZ+KfPVtxpsssEQKfPgHGVP7f5NK029NlAagrHxAOn2x7yadEWYBvVvp16GLs
         h/EMyr83b8Kx7yBqDwCq4XMAS8DqjE4cCJzfVny7/q2EIuN0gfES0x+Mpk85HXLc2DNw
         7Npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W+IBFI3907TKPQl0quSZrdhLR5RSLqOADK2+CwwUs5s=;
        b=FEU7CBU3YGf7Ckymr6sf8OjXqZKRlFQF4ja3IX96aznvlO5uvxV8nfOmolx82+cXDJ
         YihjigbCX/7wTToCnzUiuyJoABrTyzHu8zcDlpLNytYDweq33RDLYLWyudim1RH8Wym7
         JgUwzya1FgScpdtTbEyrw8iexgghAlUJCc3JXKTnPtoCtn33h6KtrxNiYzlxY+KP5XOc
         +lezBMe1YHKRnN+NnA45CC36+wDk7wqyb5tQqDY7MAZPJwP7m0WZQoWwo5653dsHNd9i
         ltnM8vQV419CCjDL9ZzORP+8nQIBSijVbrg3GhIXTpRQNFNyGa5oxvZUtBqKHq6iVy+e
         3oeA==
X-Gm-Message-State: AOAM531xzf7k9mbUiswlClcMqt6H66nKMOADi8j2RrGeE23Z2G0+zhsC
        7npm5GBL36w39C0C5MxbNxSxraKcZW0=
X-Google-Smtp-Source: ABdhPJx7nSuHx4yEG4qov7yWix+16QxW6P6Eu9y2WcAymTsYGc1WntuxuvDZFKKbYqGlbiininBTDA==
X-Received: by 2002:a2e:8797:: with SMTP id n23mr29636210lji.248.1621263204824;
        Mon, 17 May 2021 07:53:24 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.googlemail.com with ESMTPSA id s1sm2004248lfd.270.2021.05.17.07.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 07:53:24 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] memory: tegra124-emc: Fix compilation warnings on
 64bit platforms
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210516161214.4693-1-digetx@gmail.com>
 <20210516161214.4693-4-digetx@gmail.com>
 <ae6dfddd-0e08-bb40-fd4f-36276be30cef@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <82c4f44e-df09-88c8-113d-c3aa8389945b@gmail.com>
Date:   Mon, 17 May 2021 17:53:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ae6dfddd-0e08-bb40-fd4f-36276be30cef@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.05.2021 17:24, Krzysztof Kozlowski пишет:
> On 16/05/2021 12:12, Dmitry Osipenko wrote:
>> Fix compilation warning on 64bit platforms caused by implicit promotion
>> of 32bit signed integer to a 64bit unsigned value which happens after
>> enabling compile-testing of the driver.
>>
>> Suggested-by: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> The patch was not suggested by Nathan but it was:
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Nathan however provided analysis and proper solution, so co-developed or
> his SoB fits better. This is not that important as comment above -
> including robot's credits.

I'll update the tags in v3, thank you.
