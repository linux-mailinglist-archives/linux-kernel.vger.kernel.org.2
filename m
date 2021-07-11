Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F213C3E0E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 18:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhGKQqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 12:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhGKQqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 12:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626021797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4H/aSCSDYFzuJZ4hm8xQrB/5Bg7sdnlywCKPCNdNXn4=;
        b=eqIh7hr6qbhR4ji5Tp0y1Pr3MxglLFQ+ofl3qbPKKrNb5KGZAF5WbnZ51iHJ/XyrHeb63O
        +vSD9cCoIiy3FAnNAdjXjEAo+LdEhCPx8FlvEqBhzwi30kb/yZER1oKQQ9fAzjWFPGV0qn
        2UP9kKuGWdUtocTycvHH5FPwTCM9vFk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-WU-LNO7fNOqPrYOpdplOEQ-1; Sun, 11 Jul 2021 12:43:13 -0400
X-MC-Unique: WU-LNO7fNOqPrYOpdplOEQ-1
Received: by mail-qt1-f198.google.com with SMTP id t21-20020a05622a1495b02901e65f85117bso6169024qtx.18
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 09:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4H/aSCSDYFzuJZ4hm8xQrB/5Bg7sdnlywCKPCNdNXn4=;
        b=YCMSkuMnupFuFii+QXB6FwJ8a1C4ph/xToyGPw8gDjn9L7/V/hSwyzAsadSgyh0O2T
         NfSHE36hre1ZwsllcmWf2VCXMFqsJjRr/9uiCTIE87UGXqAAEnzfdMvvLribhjUfFT/T
         eyMbhqwODfri3CcQtsPcXuecv5UNqqjDznWbNr+qYKFrCYodjL5C3D1LvwsqgnsN0/fF
         gyRZuVdoanMErYp6gPRsTpP73Sdd/KkBt09DnJ9Osz4TNc9VenO7Ts7Ob/qTThpId1CI
         QgiLufVvP0fulEAtKPkM1DZrBlUwNNLyIAmsxT3Iwgq5b3QBvYmyMF7167giDQQVJ85Q
         HGbQ==
X-Gm-Message-State: AOAM531eCMDypPzWe03JsnCesXZHLENc2FugxaF+nnVNorqiRDYtWXxz
        0V389ugHkUuJuebhdc4s1OwMjmwWGdg40aNz0I0lpocr0AbGyYb05zEusB6AJ8iNb4fnkeepdZV
        jKiaOwJQG1zCupCslxeYCmq/Q
X-Received: by 2002:a37:b6c1:: with SMTP id g184mr48253651qkf.270.1626021793255;
        Sun, 11 Jul 2021 09:43:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUo1axhWm2BapHi3vq5Ra5L0jpR2fx8u8WheJ9S4TBKadMdskdJIq5LFY3LrxXmmBcfTuNkQ==
X-Received: by 2002:a37:b6c1:: with SMTP id g184mr48253632qkf.270.1626021793096;
        Sun, 11 Jul 2021 09:43:13 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 71sm4651827qtc.97.2021.07.11.09.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 09:43:12 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH v1 1/3] locking/lockdep: Fix false warning of
 check_wait_context()
To:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
References: <20210711141430.896595-1-sxwjean@me.com>
Message-ID: <07878d21-fa4d-fbf5-a292-b71c48847a5e@redhat.com>
Date:   Sun, 11 Jul 2021 12:43:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210711141430.896595-1-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/21 10:14 AM, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
>
> We now always get a "Invalid wait context" warning with
> CONFIG_PROVE_RAW_LOCK_NESTING=y, see the full warning below:
>
> 	[    0.705900] =============================
> 	[    0.706002] [ BUG: Invalid wait context ]
> 	[    0.706180] 5.13.0+ #4 Not tainted
> 	[    0.706349] -----------------------------

I believe the purpose of CONFIG_PROVE_RAW_LOCK_NESTING is experimental 
and it is turned off by default. Turning it on can cause problem as 
shown in your lockdep splat. Limiting it to just PREEMPT_RT will defeat 
its purpose to find potential spinlock nesting problem in non-PREEMPT_RT 
kernel. The point is to fix the issue found, not hiding it from appearing.

Cheers,
Longman

