Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FD0458D17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhKVLQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhKVLQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:16:30 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E4BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 03:13:24 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 200so15012400pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 03:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=THyRIGQMr4e4CRGAXQuyM0mH8V3kmSkfUH3tO5o4spk=;
        b=Z/SjnblTI87YAS5xhCfXl5KTKhxBR+NIPBHNSSHU0k59clV4gQ5zdDSkucY0d6dVQO
         L/QO/VuaVjbv5WMsyZAkrgGd5z42FDUmglEQNSiB6fRnt4z12nPCzs6budHAFhbsABTZ
         v1mTYSfuvUkTc7/mFw5cwV/5mtoYoX2tvoMXwg3N+xnpw7gRiwaBwnvF8zFuW8kxmros
         8ZvlIDzVJwYXmzG9tT5eCylLW31QOrMIJ8JdL5p1m1GHubUVCaMORXyKCy7wmxE9y+Bk
         JUjFhD309HT0IG6DbxkqeXzWVUR2WUt2SytCvVKNuSr5ZMBEYFs8YXOJzUR3bhs1+ScL
         mKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=THyRIGQMr4e4CRGAXQuyM0mH8V3kmSkfUH3tO5o4spk=;
        b=b5c2xtwhnYE10nD+Gq0sBacm6taIvD/614r2504NTYHsvEvlHVaydSYVprAEwaqEwl
         KSx1Duhq4nsQKjB67TCFrRdQQhpkMUG/EFVD7Rolite9gXALRCJIKf3NtH0YuKfFMunE
         VNUWDIql/542rOqUOVUHBfQ2+f0Diy8xZuHUFg7yQz7BdEf96u8vz4+Xf/tC2mQV8Jtb
         tfZFznj/mRvRlhp6ysDFuJIJFvKliIE+Hk32F6+o+yD74yi0QpA0DVzYuEJGs2la3fl4
         7/xmRatgr3QQaAUcld/GT9u8CucFV7wfCMLU9+PhrqYuWMgFyzulZITGufet628qehkx
         NlNQ==
X-Gm-Message-State: AOAM5306rcxNwFyLuH8TFGszbxvwLe1iSLqy7frw6VWu21QhfMX/RaOI
        AD88uf3DilWAXGYq4FP3Xw0XdOJZfT0=
X-Google-Smtp-Source: ABdhPJzm1d3F/5vs9jsi6S/pI34Jkj5sbTxKBN02K107AXIiQyxcfxH4hhktrichQGDi6++7gojnZQ==
X-Received: by 2002:a05:6a00:124a:b0:4a0:b9d7:66bb with SMTP id u10-20020a056a00124a00b004a0b9d766bbmr43379139pfi.15.1637579603670;
        Mon, 22 Nov 2021 03:13:23 -0800 (PST)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id j7sm8148200pfu.164.2021.11.22.03.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 03:13:23 -0800 (PST)
Subject: Re: [PATCH v3] watchdog: Add warning message when the newcpumask
 contains nohz_full cores
To:     frederic@kernel.org, pmladek@suse.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20211118031046.32632-1-qiang.zhang1211@gmail.com>
From:   Zqiang <qiang.zhang1211@gmail.com>
Message-ID: <c4adfc53-9471-6cb9-c263-5f462469db1a@gmail.com>
Date:   Mon, 22 Nov 2021 19:13:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211118031046.32632-1-qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/11/18 上午11:10, Zqiang wrote:
> The watchdog default is disabled on nohz_full cores, however when
> override the cpumask, if new cpumask contains nohz_full cores,
> add warning message.
>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>   v1->v2:
>   if watchdog_cpumask became empty, set housekeeping_cpumask.
>   v2->v3:
>   only print a warning when a nohz_full CPU is included in new cpumask.
>
>   kernel/watchdog.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index ad912511a0c0..37a978d8ff06 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -629,6 +629,7 @@ static void proc_watchdog_update(void)
>   {
>   	/* Remove impossible cpus to keep sysctl output clean. */
>   	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
> +	WARN_ONCE(!cpumask_subset(&watchdog_cpumask, housekeeping_cpumask(HK_FLAG_TIMER)), "Enabling watchdog on nohz_full cores\n");
>   	lockup_detector_reconfigure();
>   }
>   

Hello Frederic

Can you give some suggestions?

Thanks

Zqiang

