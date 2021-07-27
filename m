Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C143D705D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhG0H1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbhG0H1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:27:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D730C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:27:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so818119wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/JSQ9iAjUmvupL+O78RhX2jsG+c9d9EoH88rPq/rjwY=;
        b=MTjJPnQ7jIjwmGh+kHSHpRA0mgzWSELrY4nPdNz+uA5HruEGW8kfcRv/3tqN+rdGNC
         sGvKEPM6IyFrAxtdKlAgG7ixar/tGfpxS1G9OzIdrC3CH9lQFfeZ/svmv1G1XbV43byu
         WIlCpo7A/IPHpJBXcvER+tYTS7OCf457s+97mnkWsVwHwfWDFuC3QF5bEOrejSUM4vA1
         l/dp7bn+s+M+8Gz01JLbxJkr56GAcPY+jEJ5Ej6xSOEt6KTlKWGA8GAOM38ki15hcZLr
         vC4zGWiv7N2TlxvbijWysir7ybaVSOgtycLYep0uGrak6FsuNTF6pQLprwFVpZ4HZ/4Z
         257Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/JSQ9iAjUmvupL+O78RhX2jsG+c9d9EoH88rPq/rjwY=;
        b=bjUG1/FgvJ/zjg/6AZf2Wndih2FcqtepCY4wi70D5ijV75eo/6Nt+KzktZDQIukGfU
         mYDzOTzC1hOWxSivnmG7Imbi0rHxUyj5/gR8Ey8iaOF0MOY0Zlghd9OAgEOyDvNGlzto
         SaWRchy3DdFxyeaRs2/wLySUcn+zKQ8A/Td2oFtcrfouOixyaLmcdJwhBRLnWO5buxpr
         ayV+1mw39gdMXfB6EcFrEtjuyDp2zVHlGROh0+ZrT7bnKl+4eYROVYTHVgm+nIYn0psF
         uPnF6wssEWuX2NXBwbse/5WKSyuwwukeFl4vsPtwmdJdsYIovf4TEEs2fF9WETj6ZKqf
         u7og==
X-Gm-Message-State: AOAM533QySGGA1W1O07y2n1cxfPD002ealU384k5ukVE5QGuzwMH8rPU
        VkSVsP7jljZaLFHMA2endyY=
X-Google-Smtp-Source: ABdhPJzFxtTUEQw7/j6HB8bB8Flr+dY/G9bAiwtewrF9JoJG2lL6JpgpSO/eK2cZ5dgIna33W+hR7g==
X-Received: by 2002:a05:600c:19cb:: with SMTP id u11mr11067316wmq.175.1627370870229;
        Tue, 27 Jul 2021 00:27:50 -0700 (PDT)
Received: from [192.168.178.40] (ipbcc187b7.dynamic.kabel-deutschland.de. [188.193.135.183])
        by smtp.gmail.com with ESMTPSA id t16sm1736564wmj.16.2021.07.27.00.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 00:27:49 -0700 (PDT)
Subject: Re: [PATCH 2/4] configfs: Fix writing at a non-zero offset
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-3-bvanassche@acm.org>
 <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
 <d12f24b6-7066-f9bb-1b88-6cc23c9c45c1@acm.org>
 <4055ca70-7669-d00d-7c08-86fe75a3d377@gmail.com>
 <618b2bdc-282b-0a1d-1fc5-020cf80d7a7e@acm.org>
 <c9cb1f3b-0b3b-c571-4a51-e647f3c1e90a@gmail.com>
 <ab190c50-8c87-b215-1432-056c81bcd656@acm.org>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <fec30933-46b1-1085-1af1-1fd0d2265981@gmail.com>
Date:   Tue, 27 Jul 2021 09:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ab190c50-8c87-b215-1432-056c81bcd656@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.21 05:17, Bart Van Assche wrote:
> On 7/26/21 5:54 PM, Bodo Stroesser wrote:
>> The new behavior can also cause trouble with existing store handlers.
>> Example:
>> The tcmu attribute files cmd_time_out and qfull_time_out just take a
>> string containing the decimal formatted number of seconds of the
>> timeout. Each number up to now had to be transferred in a single write.
>> Assume the old value is 30 and we want to change to 19. If userspace
>> writes byte by byte, you end up calling
>> store(item, "1\0", 1) and then
>> store(item, "19\9", 2).
>> If these quick changes do not cause trouble in tcmu's scsi cmd handling,
>> then think what happens, if userspace is interrupted between the two
>> writes. Allowing to split the writes cause a loss of "atomicity".
> 
>  From Documentation/filesystems/configfs.rst, for normal attributes:
> "Configfs expects write(2) to store the entire buffer at once." In other
> words, the behavior for partial writes is undocumented. My changes
> preserve the behavior if a buffer is written in its entirety. I do not
> agree that my changes can cause trouble for existing store handlers.
> 

I agree. I was not precise.

What I meant is, that changing the source code in such a way, that
writing a buffer in multiple writes works in general, could cause
trouble in case userspace uses this.

But for special syscall sequences your changes still change the result
on existing configfs files. Example:

1) userspace program opens qfull_time_out
2) userspace program writes "90", count=2 to set timeout to 90 sec
3) userspace again wants to change timeout, so it writes "55", count=2

Before the changes we end up with timeout being 55 seconds. After the
change - due to data gathering - we finally have timeout 9055 seconds.

BR,
Bodo
