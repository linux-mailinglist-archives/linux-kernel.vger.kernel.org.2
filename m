Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BF54607C0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358615AbhK1Q7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242013AbhK1Q5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:57:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F91C061574;
        Sun, 28 Nov 2021 08:54:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d9so10436574wrw.4;
        Sun, 28 Nov 2021 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=LH8D9bP/9l2bU5zzThI8m7kpqrod1CwWgx1BtYpUQ8I=;
        b=MLz3piXw/MQZTHwmwhes+y4XM3RzN+d+93Il+hRoq3xWDAZb0rIwl1u1VsWRRl2CrY
         OGi8HlCRjIWETcfKTVdojZAF1wCLIBka8UgGBTLI1mjS6l3HpIFpI2YYMUQ45nSJQcA7
         +ny22jtOfRUkBnxLooH5jfqCTg9TuVVE2DnxzhlmyCiOBeIzrYTuXNiQYAbbeKef0lsa
         0Rqhz4VgUkyZroyezI+HAWigifmfpspnN6/3L8GZtuIkruAGL03Z9ycnL5Nh4RVZmy8j
         Y2WwhKBlkpUHNGZKRU3G7lh0j7lRWYfyX3DYaLEPmsfIX2FSzyJ9EW2rNf5qe7rprjuP
         7L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=LH8D9bP/9l2bU5zzThI8m7kpqrod1CwWgx1BtYpUQ8I=;
        b=TcI53uCBnPoAmQAggF98D1R82QwCi2X+/UArR7npRJLloVFmfuMJIGOhJA9n3XTfUT
         0LPcGWNzpnrvYESScRIbV9334xyf98eaTmnBLFtuiXyZXRAOSf8Poh4iWGeFoig8aNIs
         P9t+0F/vePR5Cp1Ouir4sVaTqO3r0FxfH6RYVKolPtJBgZ9Xe2y6sOd5V5XcBU3lLbOi
         95SoY03VHcvXL4VhiHFg4MlT+gwPLJPFF+WqXXVb1NoB68YyaDcBBTt4ASJHWwK2gKTt
         DVDEQmqySw6XoAEqaXB0N/ci6UcvAG7i0sm/DBT8vGRDNfirTQ4rC7zttP0cYtvP0OAp
         06RQ==
X-Gm-Message-State: AOAM532zRuD2boKDoO5gvUvfEnETm2Bt5DNBXfcQTBvADjP89n4ZEi4j
        QdMfEeya/O/B5DNDIXj/Ido9zAS3LjU/4Q==
X-Google-Smtp-Source: ABdhPJwySl4AMDThHKvqvV1FjlJfbSGBbnLzvSENAavewxfhjHlfgQuJAdK3rot3yh2jdIbMfFNfqA==
X-Received: by 2002:a5d:584c:: with SMTP id i12mr27855182wrf.95.1638118474049;
        Sun, 28 Nov 2021 08:54:34 -0800 (PST)
Received: from [192.168.123.240] (static.235.156.203.116.clients.your-server.de. [116.203.156.235])
        by smtp.gmail.com with ESMTPSA id b188sm12185807wmd.45.2021.11.28.08.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 08:54:33 -0800 (PST)
Message-ID: <9e0014e8-e251-360c-ad82-334ad0f28303@gmail.com>
Date:   Mon, 29 Nov 2021 00:54:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Subject: Re: [PATCH 2/3] mm: page table check
Content-Language: en-US
From:   Fusion Future <qydwhotmail@gmail.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
 <20211123214814.3756047-3-pasha.tatashin@soleen.com>
 <6d82e674-76dc-f3b0-2e53-a92eeb249eff@gmail.com>
 <CA+CK2bAX2XmMrt9RBGiUV7LG_sbpB7ov6bxMVjr5FSBVirE1CA@mail.gmail.com>
 <7d339956-27fb-4eb6-bd73-791807ddef56@gmail.com>
In-Reply-To: <7d339956-27fb-4eb6-bd73-791807ddef56@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So it could be when memory consumption is over a certain percent, the bug will be triggered.

Bisected and at the commit "[04ce8955fbe4d84376b92b875c42942489fcf3c5] 
mm: page table check", the system still doesn't encounter any freezes. 
So it's not this commit that introduces the bug. Sorry for bothering.
