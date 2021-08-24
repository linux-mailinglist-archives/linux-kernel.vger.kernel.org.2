Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E963F5C51
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhHXKm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbhHXKmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:42:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE8FC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:41:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so1531885wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5rDmhIw6VgN9dJ5nGPffKFoni3qJUX9jTAANRGcjZ2o=;
        b=YgLXGaQpZBMKnEU+ZfWneSFhG9KqP7L2XH1a4tFQ/Okmsg/6TOCrc3Pau30Xn12GeD
         Dhpk0P520kQHQIBmayDgFN/WaBXtOUxdx3a3ZOUsxqmUWQXNPtctchz6d34gGbLWDvtJ
         RmrJZ2Hvb1ZccmvLPZ28cfrqLKj4fwk70sZNcsJKqM1HppgZc5JTz5MgYyu1YWLuRAEL
         VUpVjxHq+Fw6/LQ+nXvIAynwjF1LsxbQjRsZxspYaOcy2dDASJnOM7JuO1RlM8cW6pDS
         LGaXGijKfqpc//33hnH5NWZuL1MB75nuEVc7IkInwTX5FJtj+tmYe4SNQVVwO8fv7qPL
         27kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5rDmhIw6VgN9dJ5nGPffKFoni3qJUX9jTAANRGcjZ2o=;
        b=tbgASaOLvCb5cqnU3e6T5xXSQ0yi4+P5U6SHGTjJ0njHc4q0ysrQmO70NiOH04xjd+
         J2sltTxbIH5d3RS8TKCnwMpT4zh+CqODeXcs21Q6NwFo8hFO9p1HR1QP1dnB5CnraUzF
         POgf9/VEpiMzaXRKBqO08J6txnadgRci/R2Bu8c0fVby+njuDYdGuwBrHyTE1GIhH5Yh
         6ofXXjxmRTj+i6CEhnRn014b5vqgdx8pqR6EykJfK84ipq07q5Gs0Kr4PP3W/rONG4yJ
         quKLf7s1WnvgPvGidWMF8QejCMlUQ67zHqUklQxhdtxCDtI2ZmJpdz8oJZvMQ4h1M3gP
         j0uQ==
X-Gm-Message-State: AOAM531r3Csd/Vt0wPI6YxcXnomkfLx7jU5FBkLKFlOHRoRIFzhPnJ9s
        K12vH6lp2shJgYpfuAACXAI=
X-Google-Smtp-Source: ABdhPJxZ7vOstgAq9fZdvAEstw2edJalQi43WfTs9VFGrWdlDkYjqBFvYJq1C8P2kRJy3X29XJgrvg==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr3451832wmh.188.1629801710436;
        Tue, 24 Aug 2021 03:41:50 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::5d87? ([2a02:8108:96c0:3b88::5d87])
        by smtp.gmail.com with ESMTPSA id n4sm3118612wri.78.2021.08.24.03.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 03:41:50 -0700 (PDT)
Subject: Re: [PATCH linux-next] r8188eu: remove unneeded conversions to bool
To:     CGEL <cgel.zte@gmail.com>, Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210824063443.59724-1-deng.changcheng@zte.com.cn>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <e851f9b3-768b-c628-a066-9c0529803db3@gmail.com>
Date:   Tue, 24 Aug 2021 12:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824063443.59724-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 8:34 AM, CGEL wrote:
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
> 
> Found with scripts/coccinelle/misc/boolconv.cocci.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>

Hi Jing,

thanks for your patch.

Just a minor issue:
Perhaps you could add the patch subject to the changelog message.
I'm not 100% sure if that's a requirement, but common practice
in most cases and nice to have.

Aside from that:

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
