Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372D73EA8CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhHLQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 12:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhHLQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:52:24 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840D5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 09:51:59 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bj40so11335877oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3nZhQBQZAFuZeyMMh9wAk0QRVnEl4mK3J5oxqpsPDGA=;
        b=s44o90YdwWv47AUg9xZNd+Q1YhF9J/90SzniZZIOLTAw2mhEr3imCqGbgnQ2r9VJF0
         XRjp89OCwbrLpRTaESbByW9lUndobbcnxxV2bKGnxCUtgxwOnXsKDNVElxSNy4HbTUDP
         w9hJy9th8Ax/Eufq8/E7YaO1+b7LDTpiCzA1nIOuLwdczmeOOihq76m1+dvCdM+aeJZU
         07tK4v3FccaPmZybaVLfYGy5vhMUaRGpsnbtWSHjhtLBerURt1Bsy1uIWC4G2/z6eDzx
         JQ+f41I9UZ//xoovNLJvGGEle/q63fYoferhXG/me0PQcxhxJfTnf7miMEgLBLQplObS
         LOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3nZhQBQZAFuZeyMMh9wAk0QRVnEl4mK3J5oxqpsPDGA=;
        b=b9ARGjx7q92fyAialGwP3mg26Mpzb82RsUzFa4JRoy5Xo/riXWIpg51UAxiA4TB03v
         uFvPux6eAjOYo1YzW7eS1GJF7vTGpUKE2rOoh+vkCzj0DGjYn9OCHyEuIiI0wtRink7b
         OxB/5Pjg9arbMx07CYn3e+e4hMvIurU2NI70fpafmuDvgANY8Oo8n/I4CZTi9+8bZMAO
         9Lg3XK3+UvQ0gwUSi0PlNPzpSZ1MazVyZKdlSuVOULwLsiyERp5Kbq32/au+08AURX9/
         YqZLk1NI/vslWExsMr56iKchuAIh9fZ/3zfm+4maIrXKAJfMm07/5ULIPqx62Yyc/d+G
         RehA==
X-Gm-Message-State: AOAM532qC1P4/P08HCLtFyT9CB6dcx50IHPdn57dzdYAl4PC9TlSraHY
        nKescEZIohbxktREJJhJQ4agbt/d0wk=
X-Google-Smtp-Source: ABdhPJz28+uja9Jx05gFq3wV0qI/AUpOEgCmsPRXN39vcPrrGRgh/R8G/+44iGp8LRFdvmytuF/T2w==
X-Received: by 2002:a05:6808:10c8:: with SMTP id s8mr4150838ois.92.1628787118660;
        Thu, 12 Aug 2021 09:51:58 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id bi18sm748321oib.54.2021.08.12.09.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:51:58 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove cfg80211 residuals
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210812132725.18404-1-fabioaiuto83@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <c2abe840-98b4-cddd-e427-2243d456ec19@lwfinger.net>
Date:   Thu, 12 Aug 2021 11:51:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812132725.18404-1-fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/21 8:27 AM, Fabio Aiuto wrote:
> remove cfg80211 implementation residuals:
> an headeer file and build condition in Kconfig
> file.
> 
> Signed-off-by: Fabio Aiuto<fabioaiuto83@gmail.com>
> ---
> Dear Greg and Larry,
> I thought that cfg80211 had been implemented.
> Should we add a TODO file telling developers to
> do it in the near future? Is that a condition
> for mainlining r8188eu? If so please drop this
> patch and sorry for noise.

I thought so too, but something has gone very wrong. Please hold off on this 
patch until I figure out why cfg80211 is not being used.

Larry

