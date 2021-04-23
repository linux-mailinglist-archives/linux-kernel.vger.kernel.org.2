Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F56B3694E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbhDWOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhDWOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:39:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F796C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:38:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o16so11711401plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jZFgm5N6/Y10vZ8zzUrUrLAgBX0ZnJqU/nldAdzP3yo=;
        b=H/nmXg8/E0ixgUmYWTeY4T7YAZm8nJu/6lIcOOdwl6T70IErQa+C+/nmEvciFrZODG
         AsJ4tFpgqQ0PTC2/cmPf/j1lvnz9r0WpuqObAFthhmfELinTytl4QuQNEyuwUGjvWA/0
         nOl/T3edHRIK2QAMCfIfwK8Vd1o0YrK9nBFdK4lHBYD7qwdS5Yi9SxWX+JZXJaU33uqG
         I7mmdZMntHU3YYNNDVftRW88zuQlsa0R7sLuEdNNQodd5OsvPDyri0OPxpnx/xfEq+xL
         oUvlsRtVT5woum7/h3hOovTdLgRYFbDYkrFKHhvv10+VmkEV83Jtpw17XVFnDrbpy/ck
         wr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jZFgm5N6/Y10vZ8zzUrUrLAgBX0ZnJqU/nldAdzP3yo=;
        b=IrBcpnG7yLakk8crwvuK4RZeQ8YiZX9pvTClKY+wyT+2CV7iKgrJRVQNGpL5Q3FxJk
         nCJSgeDU8/NVFBgnzeVmDMcD8OFux8NHXYJmvNcIU6PuMApKFRByZeXCUdOpaQ4eEHA3
         XIg3TrLVHwQhkv08v1jFUt97cgVaC/Lgdo3V9a2xL6WgeXoajcK1xhUzKIcvpd2VF5nt
         0RS1438Sf2N1qPnEtPa+/cqcNm27ieJedrQ4aPTM0MCkIng9gRmy8g+xdhAOAedDbaDq
         eV/askZdkkKBYgjDJ8sLRxlCPNh/alAaRHUhRgPkvCHdwtC9ewI+jpSrg3FO0Y+J+Kvq
         TOxA==
X-Gm-Message-State: AOAM5318/X6yzEBMhVPpCwBdAUK3Y9Ovnz7thmwcjitFf/M17jlZ0PPa
        3lw8hkEZRXbpEU/k+3SbtimP+w==
X-Google-Smtp-Source: ABdhPJyApPsxtWTYYWCXzKz557925Zf6L63RYJC9BWvrJOHfmAHWI1srr7XxQ0QJxLF8UJlCjNCjtA==
X-Received: by 2002:a17:902:c14d:b029:ec:acd9:d5a0 with SMTP id 13-20020a170902c14db02900ecacd9d5a0mr4006024plj.60.1619188704858;
        Fri, 23 Apr 2021 07:38:24 -0700 (PDT)
Received: from ?IPv6:2600:380:497c:70df:6bb6:caf7:996c:9229? ([2600:380:497c:70df:6bb6:caf7:996c:9229])
        by smtp.gmail.com with ESMTPSA id ms9sm7952480pjb.32.2021.04.23.07.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 07:38:24 -0700 (PDT)
Subject: Re: [PATCH v8] bio: limit bio max size
To:     Changheun Lee <nanich.lee@samsung.com>, bvanassche@acm.org,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
References: <CGME20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a@epcas1p1.samsung.com>
 <20210421094745.29660-1-nanich.lee@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f881b00-e434-d713-8cfc-18162a16f7f7@kernel.dk>
Date:   Fri, 23 Apr 2021 08:38:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421094745.29660-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 3:47 AM, Changheun Lee wrote:
> bio size can grow up to 4GB when muli-page bvec is enabled.
> but sometimes it would lead to inefficient behaviors.
> in case of large chunk direct I/O, - 32MB chunk read in user space -
> all pages for 32MB would be merged to a bio structure if the pages
> physical addresses are contiguous. it makes some delay to submit
> until merge complete. bio max size should be limited to a proper size.
> 
> When 32MB chunk read with direct I/O option is coming from userspace,
> kernel behavior is below now in do_direct_IO() loop. it's timeline.
> 
>  | bio merge for 32MB. total 8,192 pages are merged.
>  | total elapsed time is over 2ms.
>  |------------------ ... ----------------------->|
>                                                  | 8,192 pages merged a bio.
>                                                  | at this time, first bio submit is done.
>                                                  | 1 bio is split to 32 read request and issue.
>                                                  |--------------->
>                                                   |--------------->
>                                                    |--------------->
>                                                               ......
>                                                                    |--------------->
>                                                                     |--------------->|
>                           total 19ms elapsed to complete 32MB read done from device. |
> 
> If bio max size is limited with 1MB, behavior is changed below.
> 
>  | bio merge for 1MB. 256 pages are merged for each bio.
>  | total 32 bio will be made.
>  | total elapsed time is over 2ms. it's same.
>  | but, first bio submit timing is fast. about 100us.
>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
>       | 256 pages merged a bio.
>       | at this time, first bio submit is done.
>       | and 1 read request is issued for 1 bio.
>       |--------------->
>            |--------------->
>                 |--------------->
>                                       ......
>                                                  |--------------->
>                                                   |--------------->|
>         total 17ms elapsed to complete 32MB read done from device. |
> 
> As a result, read request issue timing is faster if bio max size is limited.
> Current kernel behavior with multipage bvec, super large bio can be created.
> And it lead to delay first I/O request issue.

Applied, thanks.

-- 
Jens Axboe

