Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA24111D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhITJSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbhITJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:18:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D8C061762
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 02:16:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k23-20020a17090a591700b001976d2db364so12162601pji.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Wbc3Zmo5GIb9tDLFhXIckh5fijk1uzMZpJmzD8Arsds=;
        b=HPs3d/f7BQhbNwPPGYOziP13Ojx87lUr1OPvrIeM7KatPRlMjxkyZThboMnPOqfjQ7
         c6aWMvbkA4A/QQinMgQT8DsSWqJHk267bMEr2qHO0afGLDOeDgplupibVhTOvjvgtAZG
         5SyUa3bmINK/LdHf/pjzsuts7dO+7Vw3X3qSFlB4jxarDj4YEHwOC6f/4CAOKyLFKYKr
         bQ6Sz5AjPJkISfY/pxNrtNkOuxgNl4fYwdERnv20gFfWTfWBPFOaGo1VtFnKgvaor1SU
         WmIP6fwvGp7oLx6lEdh2IZDRmpjSGdkmQyhNoEF0hoAHwlVNLuxlErqjZ3DAZap1VlpC
         fFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Wbc3Zmo5GIb9tDLFhXIckh5fijk1uzMZpJmzD8Arsds=;
        b=zywJSniiC6iwaY75QB95Yd7JW4XdBV45ooQB7Uyw+3FX/JglE8shVvm+grzCgVSKyy
         Bx1wEHzIx8P0fh/SyzH8+gPX5hBcMYWxUbf4CpxzrsDEJasoG131fOqkZu5QscOe/m5u
         D6TgYtUW4xE9aViHp+0f1mVGnua1jHTpC52G9VBPqauF1C9WAdcx+G1TVs9T9h0pw7Eq
         TwrZ+Bf/0f12Xf+EtSEHBxAUJE84otgvhF/gIQj8awFneRRIFAbLKNL/IJ4G8k1XsZvG
         yliDsQdOShHKT4xLHCXkXRkJXcFTtRHVyC0kuO1RQoBt05KK6v2awjQBLyImBiW6Yz9l
         xCfw==
X-Gm-Message-State: AOAM530GJzce1qGCKPsZnwVzaY9iXMjlFOtmM+QRn6ScLrsn0hl6yEHU
        Jur+rotRVN3ZsVZAc9+trvOcA/7vs93+rCZk
X-Google-Smtp-Source: ABdhPJw7nqDCi95G5lXn/pYixX+X1ZmQCo/nPOIWn3qSz6jYiD0XB/LmgHm6BRXp/sU9HPFjzHogpg==
X-Received: by 2002:a17:90b:1089:: with SMTP id gj9mr28433015pjb.228.1632129413439;
        Mon, 20 Sep 2021 02:16:53 -0700 (PDT)
Received: from owniadeMacBook-Pro.local ([103.97.201.31])
        by smtp.gmail.com with ESMTPSA id 130sm13754532pfy.175.2021.09.20.02.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 02:16:53 -0700 (PDT)
Subject: Re: [PATCH] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210917061432.323777-1-o451686892@gmail.com>
 <20210919163511.9f82c3634cf48d3769ccab42@linux-foundation.org>
From:   Weizhao Ouyang <o451686892@gmail.com>
Message-ID: <e889b501-3b15-0ce6-afc7-58a9666688e2@gmail.com>
Date:   Mon, 20 Sep 2021 17:16:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210919163511.9f82c3634cf48d3769ccab42@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/20 07:35, Andrew Morton wrote:
> On Fri, 17 Sep 2021 14:14:32 +0800 Weizhao Ouyang <o451686892@gmail.com> wrote:
>
>> After related migrate page updates, sync up latest migrate_reason to
>> migrate_reason_names, page_owner use it to parse the page migrate
>> reason.
> A slight problem.
>
>> Fixes: d1e153fea2a8 ("mm/gup: migrate pinned pages out of movable zone")
>> Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
> d1e153fea2a8 is from May 2021, so a -stable backport would be appropriate.
>
> But 26aa2d199d6f is only in 5.15-rc1, so no cc:stable.
>
> So can you please prepare this as a two-patch series with the first
> patch (which fixes d1e153fea2a8) marked cc:stable?

Okay I will send v2 patch soon.

Thanks,
Weizhao
