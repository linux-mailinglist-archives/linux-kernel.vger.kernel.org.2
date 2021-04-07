Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94835707C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353636AbhDGPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343796AbhDGPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:37:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494A8C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 08:37:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d8so9523688plh.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XZHl0DPkMcLP0P1/y3WpjH/RZmQz07faw2FNRkfeBdw=;
        b=fpZwxvdEx+vtHQlda4AEgeah85XG1y+u6pkdtmEQSnqZom9fYduFqe9xeAyhpIanGg
         qe5CzUe0A6JZNUQ2SeWSRJrnuN35O0sa1/Xj3ROdDWW7k9rFRLZf41Pl8fPoTWl5JrNn
         YsM5sni/NZ+hdAMY7unbI+yNpEMG29sGFmtsyR+YFdI4VnMazSL6CEtmCLOb6d+Ra7uO
         Rs8JqDPPqFbttAihsoJT/XGdb1OEfGuCIovxvfNCLYg1JlINL09dJfMBcynvwwYtyNSI
         vhaAzL1ml24URQ4IYL4Sa40DUXYsg+JrFdusxQ2PRmxOnNgZOr+tr5UuXHFVf15xmRRr
         YuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XZHl0DPkMcLP0P1/y3WpjH/RZmQz07faw2FNRkfeBdw=;
        b=UuXnT5FSMWLYYiw/KuO2r6u7KpYg60uyAGY32HGMGcAqDSG2mNcCD1YY6NSVhBzz9A
         AxXYr2BaDg33xbs5a4QCLhgLBGN1X6dkv276g9DdGIlmaL+g0uM8a9eYv0EKujFBjRbs
         FbrJwyVE+ob6h0haMGoKuROmbPC1G6GabOOxrDefvu2/nbZ1JdbLxo9ZwSw8VfhLjaWh
         YQdey1wl7NI7uJcF7vqcYig0tq67YhH8n97GA10glT6WS//wiFCBSOm+xE/LLp9iZ+i4
         AjF0HJe+SmNIqBmEgOixvPQoZdG8qEda6JcRVb/GpBX1bDcd7HrGSXO/c1oVftInY3tK
         jaVA==
X-Gm-Message-State: AOAM533MlDUwduiOaE997g0p4XfwzEJAvK1yeEJnbrJjacH6hFpLOvr9
        H10QRU8G9hmrTefuNwxKcnkYF3eUqeIqsQ==
X-Google-Smtp-Source: ABdhPJzXeLKf+f3mZfVqDcFMMrdyS3DUH5W5xx5btodBEUaPck7c+x2Sa4eDBOiJM60QZAOfT9U5Jw==
X-Received: by 2002:a17:902:708b:b029:e6:77ca:3cb6 with SMTP id z11-20020a170902708bb02900e677ca3cb6mr3468808plk.84.1617809834532;
        Wed, 07 Apr 2021 08:37:14 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id f6sm23119365pfk.11.2021.04.07.08.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 08:37:14 -0700 (PDT)
Subject: Re: [PATCH] task_work: add helper for more targeted task_work
 canceling
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <b036dde8-d025-5a9e-6a4c-60b4ce2d47b2@kernel.dk>
 <20210406174729.GC13270@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8436db10-1db6-a756-b060-7ec3222f2e55@kernel.dk>
Date:   Wed, 7 Apr 2021 09:37:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406174729.GC13270@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 11:47 AM, Oleg Nesterov wrote:
> On 04/04, Jens Axboe wrote:
>>
>> +struct callback_head *task_work_cancel_match(struct task_struct *task,
>> +	bool (*match)(struct callback_head *, void *data), void *data);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Feel free to ignore, but how about "typedef task_work_match_t" ?
> 
> Either way,
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thanks! I actually didn't add that deliberately, as I think they just
tend to hide it. If I see the above, I know what the callback func
looks like without having to find the definition of task_work_match_t.

-- 
Jens Axboe

