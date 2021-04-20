Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5463660D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhDTUYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhDTUYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:24:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C4AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 13:23:59 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t22so27543295pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WRZXjE4aK1HQxoLEc8jiHuo+pQW3WFAMQ4pM5BS+HIE=;
        b=i7NhxbFFUtsIx33i/FDG8VCTFQK25b4tHT+SFTrHcJTz73Km74+clEBbSLeVqZ8HDJ
         6WoTt4cIE9mpgqrflsao9s/pdE65Tt1amzudx8m58AbzPsn37iqob8Vbc2I+LzA1IvJa
         y7a9NUJ/Y7gU/BYaFc3HgJX3ez+o5+/yJOs8J0G7JOdIAZyEY9ZxHedLfnextU+paIqk
         BsCu1vJe1102KqNIRoQuj2jcVFL3h+uMr5wHcNEkbC5ZeanEMVkHeGBarGnOqi2zV00O
         mklwh9Nh1/4sr4RPsMC0vs/fmDG8OKsToiBqpzOGlCo+JjH28aXDT4ticgGWYA4QIjG4
         HjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WRZXjE4aK1HQxoLEc8jiHuo+pQW3WFAMQ4pM5BS+HIE=;
        b=RSlH2ajMs75wATKx3x0ychC9peKa5ftSrAvd1P/rL/x1US4zE07YuctjvYMvPSUXqn
         SFAT51gQjQRjrHOVRt0j4pOMQb97KiCUqZQYJlJHteRf7v2+ZD/K7YPKlxmkfIFjw8A0
         olGBrRXiLPA4WwlLgF4n6/sNe0kCaO96ar2OkYTD81IPNCmeoYAlwQY8dcj8K830La1p
         Xuh0h+G6Nr7YYJUC3nif80OQw7K0+v2VEz9RONsErYn94jdi56M/R0Bck05mU9vnwWod
         vBSyh2qxzGKxOdv2OznzG4fchX8Q7PQTyOq285YdXNxSWFCIO1SYs4SCb1ku08SRPfZU
         aGWQ==
X-Gm-Message-State: AOAM531zMdgDRc22C8+I8M9EqWkc1iD12fkjeYcnRWb9Yg1GNR7FnIQj
        LWhBMRR8TIejz1+TBH9CkBw+QA==
X-Google-Smtp-Source: ABdhPJwh9ZPPndH2NPXK2stdybN9bF8jCj7nLnvQhAQB2Rz/jX8y2GZ9xbzE/3HN6LsNQUbUKItmgw==
X-Received: by 2002:a05:6a00:170c:b029:225:8851:5b3c with SMTP id h12-20020a056a00170cb029022588515b3cmr26662434pfc.0.1618950238524;
        Tue, 20 Apr 2021 13:23:58 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a20sm6941312pfi.138.2021.04.20.13.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 13:23:58 -0700 (PDT)
Subject: Re: [PATCH 092/141] libata: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <e3498b34cae37d0f93db5824e5f61b183a7293f1.1605896060.git.gustavoars@kernel.org>
 <07757a90-7682-47e4-f6ab-a07b1658280c@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2cb77fac-21c3-6ba9-2f8f-0ff154ad4459@kernel.dk>
Date:   Tue, 20 Apr 2021 14:23:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <07757a90-7682-47e4-f6ab-a07b1658280c@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/21 2:11 PM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?

Applied for 5.13.

-- 
Jens Axboe

