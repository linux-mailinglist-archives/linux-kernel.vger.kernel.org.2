Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7182C40C48F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhIOLsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhIOLsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:48:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34470C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:47:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t18so3497282wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Rd3hprGUgWmyfJvv1oVwA/PAdgALCOp/mN/hEBiQcRY=;
        b=V+MFauo1AQjpA+2UwC7e2kze0t/ZKs5lX82aPOiGKDlCfHMZzAKmkydf9CR7+Od7SB
         67wGHTdheRRV3MP+CdfyxHmyfCsqEacoGvvEQ9Q0edRJBIa8NUyzG8kIjpRTnx4s13rc
         mDQTfeQ1IA4UYHjcI/v1YccZLJCw+kF2oJAzD6Z6fbABVHq1QQ4ZV2gDPwS7ESrgRMum
         pcaU/ipji33F/JE/XKn0G03LbQHNkzNL7iL5bUcCizLyXn1hoOtV0Nf/pLunNkRnkAtA
         G7TD0M76pWLpJBmmWEvri0CYbOzrXoRflqzHqBYXmVOttw5yahqATjDU0kkt6JhWZL8Y
         bKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Rd3hprGUgWmyfJvv1oVwA/PAdgALCOp/mN/hEBiQcRY=;
        b=A4i7qebwQS+OJzC8vTteDl3qAhPuEKivRK9/3VQtxjORmlmZLRKKUppDoLJ8t6Tmr7
         l4/D2vVC3ggfDxE9FbBFDrncWMh3h5Htz2j2XEd8N6EQQqFtHWk4f/8O6eS/RLYcB1Cb
         RUveE4vTGPv+QFAqGNMCEFYsBDKH4QP4pix5p9gT/sDCuj6hQZglaVKX7SiQCLgB5THk
         jcwsQIe9g0mHJrWKnfGErh58q203Ges3BFvL6QL091DPVNyxH91PFOaREgqYU8YSad5o
         QfjtoGVZ+UtsxWsBS6b/0+v6ww0dwwZxzvkIsbeggygs0URHG12ysWnUmTHnzPLIkKb6
         HmRQ==
X-Gm-Message-State: AOAM530A5HzpZCCLo2Wzlhh//O6v7Z+DGqSHEx3o2EmtpQsKgHJZbxfI
        qClm/WUT0UOyTomHBDMg4Ko=
X-Google-Smtp-Source: ABdhPJw2AcPgaxu2NmFlPoU8WbyQQ+p+Tczq8dH6o8GcWk25V4UH5lrnx7zcughAUwxir68NtEpH5A==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr4718448wrd.24.1631706436828;
        Wed, 15 Sep 2021 04:47:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:d03d:8939:3840:1f95? ([2a02:908:1252:fb60:d03d:8939:3840:1f95])
        by smtp.gmail.com with ESMTPSA id b204sm2703850wmb.3.2021.09.15.04.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 04:47:16 -0700 (PDT)
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
 <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
 <CABXGCsOPLH2DkZ09PDXSxStin6JJb_m5bJuQWmXooBLaSJ2Ezg@mail.gmail.com>
 <dcbb87cc-c95d-ae58-d601-413a6277a7f8@amd.com>
 <CABXGCsOQ8uXY85zrCOOd611gDj3AhtqH4=LcYHD=T9jVEzkuig@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e120f0a4-7600-c938-ac9f-cce6a714da4e@gmail.com>
Date:   Wed, 15 Sep 2021 13:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABXGCsOQ8uXY85zrCOOd611gDj3AhtqH4=LcYHD=T9jVEzkuig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 15.09.21 um 12:36 schrieb Mikhail Gavrilov:
> On Wed, 15 Sept 2021 at 14:55, Christian König <christian.koenig@amd.com> wrote:
>> Yes, absolutely. You should see GPU resets and recovery in the system log after that.
> Unfortunately, not one DE will survive a GPU reset. All applications
> will terminate abnormally in fact this would be equivalent to reboot
> (and denial of service). :(

Yeah, very well known bug in the DEs.

The OpenGL robustness extension and Vulkan specification are pretty 
clear what drivers are supposed to do in such a situation, it's just not 
very well handled in userspace.

Regards,
Christian.
