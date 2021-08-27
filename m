Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17A43F9BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhH0Pj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhH0Pjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:39:55 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DBC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:39:05 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h1so12125399ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aJjrhfVKj3vxQ+lx3HC3TkHGZ1lkkMCuCZabHXAHjL0=;
        b=hMNRm1wDJUk1V37+niYoqO3547B+bg6cY4zxnTm/kdKHeqV+3iC2+f3y1YDd/okkQB
         xA2as3iRdhVgX6o6susy5xB6kjt5tkLf9kFixk1zp18B5zPc369rQagCBc6gnX1eGgU0
         xLHmlYEW8pj+PLU6I7RM+6p+s9mj5NCB2BSRZVGxVJOsUinT0drPH2y+gI54KRf/3a+K
         DSQVmH6RSLFnu933xCgAOiupsdixIq/z01uICQr/AkAmuPfRjbGX2t0veBjoQx6QrAdY
         wUYuTSJpW1cDglD+z9XIPifDsViD0qEtclKfxuN6bATijT1/f05Jyvhi7kQ4sHyAJeJZ
         l8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJjrhfVKj3vxQ+lx3HC3TkHGZ1lkkMCuCZabHXAHjL0=;
        b=ZK533VT2ayrV1f81+88Azu3BdMXgf7YQzCThwZvoHMr9Agde1YIlm92DSkQgtkJ127
         713GBw9TAeE9B4OnsGAPMs7lwf2bgXqTURPGLCqKP9GHWdTM6MTrG45KZvUW8ovINI/U
         ZhPUgnMgCo5KXxQvjpppQ/zvLG+7AnIix7yHdSXozJRWCX8BTNMRkKT9sDrLlsH0HK25
         00PjbMQBHBktyJKT9BrYy/UvqWsrUeno9dwslxKdfm+w95Lq+Gz0vnVvmGuDdlotEQ8D
         blkhBsaOiDg4Z3v3EOC98Hh4DrQzRKvxCui9VvXT575LBYAF9m2Vi6LUkXl4ZrnX6MdD
         4b9A==
X-Gm-Message-State: AOAM530V+lRNkVodJP+M2ywfUSXA8kSZG1JJha+c8UFJNQqgS1/8H8Db
        CqQiCKIs2TYtZYOk3neOwIY=
X-Google-Smtp-Source: ABdhPJw6Zoc+6q2/rnqmd1L2cSRdqXdC9d3DG0edcULART9zgQzrYoiKdfMInv1PE/7wJDpPIFI4cA==
X-Received: by 2002:a2e:94d0:: with SMTP id r16mr8433182ljh.403.1630078744106;
        Fri, 27 Aug 2021 08:39:04 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id j1sm719729lji.124.2021.08.27.08.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 08:39:03 -0700 (PDT)
Subject: Re: [PATCH v3] staging: r8188eu: Provide a TODO file for this driver
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210827100813.18610-1-fmdefrancesco@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <dc56ba64-182c-2e9d-0be5-c0244c8270cb@gmail.com>
Date:   Fri, 27 Aug 2021 18:39:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827100813.18610-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 1:08 PM, Fabio M. De Francesco wrote:
> Provide a TODO file that lists the tasks that should be carried out in
> order to move this driver off drivers/staging.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v2->v3: Added a task suggested by Dan Carpenter
> <dan.carpenter@oracle.com>.
> v1->v2: According to reviews by Fabio Aiuto <fabioaiuto83@gmail.com> and Greg K-H
>          <gregkh@linuxfoundation.org>, remove "[] is currently in development...",
>          indent and properly wrap the lines, remove the unnecessary last paragraph.
> 
>   drivers/staging/r8188eu/TODO | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>   create mode 100644 drivers/staging/r8188eu/TODO
> 
> diff --git a/drivers/staging/r8188eu/TODO b/drivers/staging/r8188eu/TODO
> new file mode 100644
> index 000000000000..98f918480990
> --- /dev/null
> +++ b/drivers/staging/r8188eu/TODO
> @@ -0,0 +1,13 @@
> +To-do list:
> +
> +* Correct the coding style according to Linux guidelines; please read the document
> +  at https://www.kernel.org/doc/html/latest/process/coding-style.html.
> +* Remove unnecessary debugging/printing macros; for those that are still needed
> +  use the proper kernel API (pr_debug(), dev_dbg(), netdev_dbg()).
> +* Remove dead code such as unusued functions, variables, fields, etc..
> +* Use in-kernel API and remove unnecessary wrappers where possible.
> +* Fix bugs due to code that sleeps in atomic context.
> +* Remove the HAL layer and migrate its functionality into the relevant parts of
> +  the driver.
> +* Switch to use LIB80211.
> +* Switch to use MAC80211.
> 

I think, we can add an entry about error handling. There are _a lot_ 
function calls without proper error handling. rtw_read*() calls are on 
me, but others...




With regards,
Pavel Skripkin
