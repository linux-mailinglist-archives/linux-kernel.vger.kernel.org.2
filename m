Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B681460CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 04:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbhK2DEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 22:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244829AbhK2DCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 22:02:03 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18443C061759;
        Sun, 28 Nov 2021 18:57:12 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so11348998wmd.1;
        Sun, 28 Nov 2021 18:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9AsJNoK7rAciESn25LHlxP2wCJ43zmCSYQcAT99BBd4=;
        b=htvwyxeWFujBvpV38LdgUriE31SgAwI4A6ut9fRWCTcnco0y1zb/hHmGxyzBW+2waO
         0QXXYRoBIGdsVIU2l2juztuHrFYtKlnAviVM8fyp9vUrNrHky+T1et0lT//KCq5tVfCg
         XAA0aTHyPI/j7adUHsIyq5GQ03aLeRX4ArhoY0umSYJRQLy2QZTXMXHdAEWkgfhv189A
         QpORCdpX+UvE/Zte0nIKMn13OFukv1x6Tfmo8dP0WaLCsv5DbeD41HKsEpVioMYz4HW2
         1Azkylfj7chjrrBZQ5kUq650UuT3jfTRIV5ZAHZu7i3wbGG8SyNXmKbY1RISrnZXRSQI
         Bcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9AsJNoK7rAciESn25LHlxP2wCJ43zmCSYQcAT99BBd4=;
        b=5CxKN5QJ7ira6EE7xl+SuFjPOIvTTJyGGl4xwBbk52JFmnuLPLUrtsOkADS+PRwnfj
         zpuPNl+d18tmAdeJgs9yzR/UlbQLtSjEOww3xRkSkLXFrGB6Yi0kO/Z6m6gZVT4D8HbQ
         jYSroeLrDjKryc9mMAf6Fv/dM70E0hHKF1pth4f8qw0DBk+TYystr2xPQljvupWTvsgL
         +Izg0O8HO+zT71OlJOONfrBrpjQbFRv6G+Pa2a6hKTpj1v9tPvIMehCq0r6DIN0Vz7kw
         11EZed1MYW9FE3eOQKpZ+BOhHISXycZtlmZ0pO5caJg1tkHCuSP7UIUgYh1rGLGiZaYT
         6/Bg==
X-Gm-Message-State: AOAM530pIdGrlmcxNuDq3kn/lkzpcrLifVkdJp4bLII0b9vCO2m5xtUj
        be7/YOLSCzEMZZjkS3fE9VMrf+fu9FdXyw==
X-Google-Smtp-Source: ABdhPJyeVYyegMaoemnDktJuPvMIAA8nNsXhR7d0KP0KX9y4TS0Kk1Qh6YBr9tQBppAwiNHh5JRk0w==
X-Received: by 2002:a05:600c:a55:: with SMTP id c21mr33724060wmq.191.1638154630689;
        Sun, 28 Nov 2021 18:57:10 -0800 (PST)
Received: from [192.168.123.240] (static.235.156.203.116.clients.your-server.de. [116.203.156.235])
        by smtp.gmail.com with ESMTPSA id n2sm18220351wmi.36.2021.11.28.18.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 18:57:10 -0800 (PST)
Message-ID: <aee858af-f0f7-1da6-5976-cf0057092afa@gmail.com>
Date:   Mon, 29 Nov 2021 10:55:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Subject: Re: [PATCH 2/3] mm: page table check
Content-Language: en-US
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
 <9e0014e8-e251-360c-ad82-334ad0f28303@gmail.com>
 <CA+CK2bDiWc2y=CW6d=6raaf9Haq2vuWQDTQZ-aAyLDdpq5aQPQ@mail.gmail.com>
From:   Fusion Future <qydwhotmail@gmail.com>
In-Reply-To: <CA+CK2bDiWc2y=CW6d=6raaf9Haq2vuWQDTQZ-aAyLDdpq5aQPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/29 00:57, Pasha Tatashin wrote:
> This commit by itself would not cause the freeze or BUG_ON(), but the
> next commit which enables it on x86 arch might.

Yes, you are right. At the commit 
"[1e67abff1820489435aad3fcf258708c21c283ef] x86: mm: add x86_64 support 
for page table check" my system starts to experience the freeze.

I can now reproduce the freeze by following the steps below:

1. Open 20 YouTube video pages, and a YouTube Music page.
2. Play music in the background. (The step can be omitted)
3. Run `git clone 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git ln`

git will never successfully clone the repo because the system will 
freeze during the operation.

I also tried adding `page_table_check=off` to the boot option but still 
experienced the freeze. Perhaps the option is of no use.
