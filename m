Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F2F3C414B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 04:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhGLCrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 22:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhGLCrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 22:47:00 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A690C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 19:44:13 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id x10so1883711ion.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 19:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cGFiv7gjKS/coi5aJJpg41m9zEcOwLxKxLukz6tL1x0=;
        b=DLgbISg7gyCl7ZXor+S8BkOAEUD6oyaPTrkxn0BWknkR/xC3kQQKr636HJWGVCA35f
         2vAfRgTpm4Nr7ZkaZRAutdCktOdCb1OZsCSR1O2nCOHdDONtOmUy4HZ3Bms7fMAtrBfb
         JXGf3BTiRvF1LYrM8vQAN86AvyBXsuUDA3n7BN31haXQxPwsnRog60ZhrJS2EbQfIEYL
         9qf/EBm3YMDm0p7GT/Tj7ouT524NmrbHlAFQ25Hdwbq+J9HAUiN14QKB5x30n38wZpqa
         ICpRzREnlHrOFc+5BvvL856Qm9aIqkxf5A1sgAlVUv5t6sjVN41OELIrGXrap358t7U5
         hO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cGFiv7gjKS/coi5aJJpg41m9zEcOwLxKxLukz6tL1x0=;
        b=nLbIe70oxedwsL/+w/qow8V+yElYzr5pg2hzMctV7V1RH7VFk88pmuNkEZ+Q5C2AxT
         tEUL8Q3R+t9yMzg6PVBqXozryVZy4z6U+tH4yAN6TKO9MciVMSvxKVZsfwz0ehy3WaLO
         jfS8FeJRR6t0I6/cHxoI3zWuyULhYKzxy+SPLIO3tCtx4lHwVC1EVPR8yksIkWUeKIwd
         0Fodz8si3Qik/cDnTsHU75VdTAk9ryqE8kyXrCCj/gmOss0c2+At9zyNiXf9p6i6GtYw
         Ht50UQ0hnurbBs25JHDu+QOg1K4MCzshIheQj1owaX19SoeFZLhR/uKRFWx2XuK2fUs6
         KbMQ==
X-Gm-Message-State: AOAM533F8Wly05Gef9GSgrDn5bNLZrUyUpcmp4Q9rHzZwgrXEHPffrJm
        oILc0tUw/JvFGKSL1OJtgPVv7Q==
X-Google-Smtp-Source: ABdhPJxmwkVyegwrxSnmiyTCxVLd+xZASrnHAbbn5aSBQUnBSirKoWr/P152+mgIu53A0zPrU8//Aw==
X-Received: by 2002:a05:6638:3181:: with SMTP id z1mr4565512jak.100.1626057852476;
        Sun, 11 Jul 2021 19:44:12 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id b9sm7489447ilo.23.2021.07.11.19.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 19:44:11 -0700 (PDT)
Subject: Re: [PATCH] task_work: return -EBUSY when adding same work
To:     zhenguo yao <yaozhenguo1@gmail.com>
Cc:     oleg@redhat.com, linux-kernel@vger.kernel.org, yaozhenguo@jd.com
References: <20210709122712.42844-1-yaozhenguo1@gmail.com>
 <872612b5-b9c6-43aa-a167-1c204d0f1c5a@kernel.dk>
 <CA+WzARnFgohHZ=BhL4OaCagB_c1uB6a=Bv7vM_zRUJeANHksEg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <db2410e2-1f1a-b396-10d1-1df3ec061b78@kernel.dk>
Date:   Sun, 11 Jul 2021 20:44:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+WzARnFgohHZ=BhL4OaCagB_c1uB6a=Bv7vM_zRUJeANHksEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/21 8:13 PM, zhenguo yao wrote:
> Yes I hit this condition.  The caller is queue_task_work in
> arch/x86/kernel/cpu/mce/core.c.
> It is really a BUG. I have submitted another patch to fix it:
> https://lkml.org/lkml/2021/7/9/186.

That patch seems broken, what happens if mce_kill_me is added already,
but it isn't the first work item in the list?

-- 
Jens Axboe

