Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D653FB5C6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbhH3MKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbhH3MKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:10:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F88C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:09:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so9266419wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v05CHMGkNy/7iRKZsqcb072iAMcR/4Py4W7Z6a3AFlw=;
        b=PRZsfWp4uIvlMEd8zyEQdp3H+MRjz4psg405lNjW2xPYzAd7ITYSWIsTHWSpzEv+2v
         t/mnwGLByQblAhZXVo4OcTWDLMlY6tL/ajNMcy84H0Zd56W4aj8ddouXwuM8ScBwOTI4
         wsNP2rUsSd+ef8fx9BZXIaWs0H0ndPKKuJXnjh2SpIg6hO6oH4UZhFoZe+R/T5Bs9EfP
         cw6RAzowgH+GbZqk2l7AkKSrI6wMjWlh72biVrbR1HcLT6tSh/v0ehDBpcAlZ0iD124C
         Sp0Xv/9Y1NsDqqXbWDilB4KmxK3A4IzuMKZnpEO6RiELM1BXLrWRfir4SjWFIBpUhpgN
         xt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v05CHMGkNy/7iRKZsqcb072iAMcR/4Py4W7Z6a3AFlw=;
        b=hufIcBPMtX7c6J/bQN2foelNyzmAAgTycM1w6/nxksonoMQWNqJmObMb293uCqn2ak
         7GlHCVZqovmBXNeE88NRP0Y0g26gPm9HnqfikAOZ6V5tsBvELMv8kKz9q81W9FJ1BBDG
         eyLxQgYhuzOi7sp7VxBudMz9wBrhdjgsHSPFpfmqFM1r2pj+NAQlqtvkNBnKkomWUM45
         7yzi9N+vnnL53mVuuAuiHR/SizW83tx5W2JoSkAL+UiqAItcueZKscHwuz4s/b55cSBP
         vfoOe1QAi/VdIYgadMA/zOoknBPtAaf9GB2oPs5R+KPPNChYe2Kewhdiyn2ou0SWjERi
         L6Jg==
X-Gm-Message-State: AOAM533W231TaNxdjVvDDFzWmFWU4vSIrQUIjCf+UYHx7vIlMM5caq+v
        unc9JKXOllAi2YRRGqF959s=
X-Google-Smtp-Source: ABdhPJxLHc72SK8sGt4caZFSMgEUzyl7jwMEiCsgAu3q+ppOzWXNQYC79UJDO58a4NHQSaLk18orRw==
X-Received: by 2002:a05:600c:a4b:: with SMTP id c11mr21717493wmq.97.1630325362003;
        Mon, 30 Aug 2021 05:09:22 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::16fa? ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with UTF8SMTPSA id q13sm15116117wrv.79.2021.08.30.05.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 05:09:21 -0700 (PDT)
Message-ID: <bf3547a3-bca0-cb81-b086-0d7a9bfe6e7c@gmail.com>
Date:   Mon, 30 Aug 2021 14:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH v4] staging: r8188eu: core: remove null check before vfree
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YSu9GQa1A3s6FYQx@user>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YSu9GQa1A3s6FYQx@user>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 19:00, Saurav Girepunje wrote:
> Remove NULL check. NULL check before freeing function is not needed.
> Correct the indentation.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
> 

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
