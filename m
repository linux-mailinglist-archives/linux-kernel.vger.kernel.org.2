Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4AF42C003
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhJMMbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhJMMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:31:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09AEC061753
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:29:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v17so7746651wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jxXON34bwb9U7480ZI8tD9t7EEtIFIeyXWCvuOY9nFo=;
        b=VC+P5UlQ+oa8RbtjkI6ihbKMfbye3hyLHafy4vC6TZ/b2HfnrH7nV5364N8CnXHH1o
         GbrzBKBdRPPQwEX23FzhzFYs+Z/tTPuDETyDVqrmCttOwI/ei3kS9hWtQLQwrHOOqLQY
         7QVhHDvwEkBleqiz2KkdOF//mFKsb9feT36V6YQo1YENKhAt7e+1sGujzR09uh0pts6/
         IPzecce4A3D3bTmbWBNYJDdOgBeQtnep1bknl+zPOpw3Rro+Gzg7ki4oajHI0OLuU7qP
         y0yXUzV0jHJTZs31IUWS/8z+loY+KCEqCzPKP5tdrM02RliDA8izTq7dD3tMiygPax1t
         I5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jxXON34bwb9U7480ZI8tD9t7EEtIFIeyXWCvuOY9nFo=;
        b=TqfeetGNOnPprIEtxTG9APLnFyzkv9Msp6VSLJUKtB0ZyY2Cgv0jSNVPsKlK5/obmE
         NLHC+ukcVVl1qTh9QqhSyy37WdpkFCumglsvk8fFjh1Mu/A4MyJcTat5ejsX9yUqPd0H
         9DP922kLRpJ7g0W1aoeacC49ML0I2YjRbL6rmci9FK2d58B/LQbhLmJO7C4fOFQ+doDE
         HCm3K5Hhdn/I6FBAGPrcnU6J0VwdpvuBXVctL49mbgHGgnCN2YgegUnJNG9dl6ENBNEL
         BZDCHzIu9ixZ3It3MUZyOdTDrhp5lSKx/igDc3Iq+zYQz+TaL1mGR75h68vkbvKXN10d
         vvLQ==
X-Gm-Message-State: AOAM530sr3t3wSEWdkAS/hfBYUy/kiLvt8iD4iuEmJbJ/3bhw3qT1lBw
        Hd5JCZW68tn1Y1PtWQj1uFnYXA==
X-Google-Smtp-Source: ABdhPJzl6+sUsuUybRUSH6RZdbmAHK1EefCNIcA8VP9VCCbH04KII0GFLfkdnJcYa7FxDnWPNabdHg==
X-Received: by 2002:a7b:cf29:: with SMTP id m9mr12651264wmg.64.1634128158449;
        Wed, 13 Oct 2021 05:29:18 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:cdb4:f738:2bad:740f? ([2a01:e0a:410:bb00:cdb4:f738:2bad:740f])
        by smtp.gmail.com with ESMTPSA id v3sm13427135wrg.23.2021.10.13.05.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 05:29:18 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2 4/4] bpf: export bpf_jit_current
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Luke Nelson <luke.r.nels@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20211012135935.37054-1-lmb@cloudflare.com>
 <20211012135935.37054-5-lmb@cloudflare.com>
 <836d9371-7d51-b01f-eefd-cc3bf6f5f68e@6wind.com>
 <CACAyw99ZfALrTRYKOTifWXCRFS9sUOhONbyEyWjTBdzFE4fpQQ@mail.gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <1792748b-9204-c96e-b9c6-367eb19928cb@6wind.com>
Date:   Wed, 13 Oct 2021 14:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACAyw99ZfALrTRYKOTifWXCRFS9sUOhONbyEyWjTBdzFE4fpQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/10/2021 à 10:35, Lorenz Bauer a écrit :
> On Tue, 12 Oct 2021 at 17:29, Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>>
>> Le 12/10/2021 à 15:59, Lorenz Bauer a écrit :
>>> Expose bpf_jit_current as a read only value via sysctl.
>>>
>>> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
>>> ---
>>
>> [snip]
>>
>>> +     {
>>> +             .procname       = "bpf_jit_current",
>>> +             .data           = &bpf_jit_current,
>>> +             .maxlen         = sizeof(long),
>>> +             .mode           = 0400,
>> Why not 0444 ?
> 
> This mirrors what the other BPF related sysctls do, which only allow
> access from root with CAP_SYS_ADMIN. I'd prefer 0444 as well, but
> Daniel explicitly locked down these sysctls in
> 2e4a30983b0f9b19b59e38bbf7427d7fdd480d98.
Even after this patch, bpf_jit_enable is 0644.

In fact, if you have CAP_BPF or CAP_SYS_ADMIN, this value has no impact for your
programs. But I you don't have one of these capabilities, it may be rejected,
but you cannot read these values, which help to understand why.


Regards,
Nicolas
