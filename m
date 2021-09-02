Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE43FF2D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346635AbhIBRwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhIBRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:52:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F26CC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:51:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d5so1899562pjx.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w3erfZ98bTWqGgs/cNXgGGDKhIj2fFDLW/9VUyS1D5Y=;
        b=HZ7R/ImWm3dIk5AWdIoBe7M/Tf9kkV2hX8X7BbK3WRd+oqyAyirxcg45CG9Sbx4TOj
         GRXBLi1xZEYDWDLp5O/EcKEG5ADd1ZSr3BK5GJGWg5XuZlXzNNB1+gX7f5I+x32N5T5x
         8tKPjhHhlMV7GqVHaimGepx+DA7Jl2U/cMWSMoJj+z4qa++fLBiiQ5K2YqsMe5XU02ON
         Vd2MOeOr1UvL+7rkACj/mPZMbmjoTQirbftthXhutyjgkk8gg/zuS8OuvlU4RwJEz+mn
         FT6DP0/Q0puMUucUngQUovv2gBNmoQBlP48H3W3HmnoaNS2n4NsIoxAbvRNUSlPxzEMP
         28pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w3erfZ98bTWqGgs/cNXgGGDKhIj2fFDLW/9VUyS1D5Y=;
        b=sHOtcBIsQJnJFuH+hVop9dtoVxR54XHpV8oPgO5jtKChpgJQMlVqUqBsuFFZTF8NXA
         6kcM0iy8UrsjVeCwEdHQENQlcF6/R3IIoMz9zAQaqoDBK67+5eufwVnjt1QY6JQUqL+k
         c7qh5jBCtF9YaVrrU/Cf9nJlo/MCjjo72OFOM9MRoI3XAJ91/B1tmPMZsteKDL6EsSbo
         j61KoMa1KD5I5SSE6S9lEBzhQzkYC7lY3JOh7Wmxw5zFRolD0NZRIGEw3VElYFpx6KZc
         39hvY5RW5fszqZUh6MtH3XmhWQeqKKEK2/g2Skv/Uzhoizxnr75Ah6KkFaWUHVfwzRkN
         0Aww==
X-Gm-Message-State: AOAM532e9vm0a5PBgYjKj6/7Gp6GyuvmDAu/dU43pW9iIbKV6aewYdBn
        pxiZa3jtbAMepv+YJqg8WBaiKw==
X-Google-Smtp-Source: ABdhPJxz2D16swtH7T1EhCN8vRgROTUqu5EuC82EPgq1tZIkVYwUellFUFh0WQOrOIZKA41y3B4yMA==
X-Received: by 2002:a17:90a:b785:: with SMTP id m5mr5306630pjr.213.1630605100717;
        Thu, 02 Sep 2021 10:51:40 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x13sm2973468pjh.30.2021.09.02.10.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 10:51:39 -0700 (PDT)
Date:   Thu, 2 Sep 2021 11:51:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
Subject: Re: [PATCH 0/2] coresight: ultrasoc: Add support for System Memory
 Buffer device
Message-ID: <20210902175137.GC1078000@p14s>
References: <20210719111737.47891-1-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719111737.47891-1-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:17:35PM +0800, Qi Liu wrote:
> This patchset add support for SMB(System Memory Buffer) device, SMB
> obtains CPU instructions from Coresight ETM device and stores these
> messages in system memory.
> SMB is developed by Ultrasoc technology, which is acquired by Siemens,
> and we still use "Ultrasoc" to name document and driver.
> 
> Change since RFC:
> - Move ultrasoc driver to drivers/hwtracing/coresight.
> - Remove ultrasoc-axi-com.c, as AXI-COM doesn't need to be configured in
>   basic tracing function.
> - Remove ultrasoc.c as SMB does not need to register with the ultrasoc core.
> - Address the comments from Mathieu and Suzuki.
> - Link: https://lists.linaro.org/pipermail/coresight/2021-June/006535.html
> 
> Qi Liu (2):
>   Documentation: tracing: Documentation for ultrasoc SMB drivers
>   coresight: ultrasoc: Add System Memory Buffer driver
> 
>  .../trace/coresight/ultrasoc-trace.rst        | 193 +++++
>  MAINTAINERS                                   |   7 +
>  drivers/hwtracing/coresight/Kconfig           |   3 +
>  drivers/hwtracing/coresight/Makefile          |   2 +
>  drivers/hwtracing/coresight/ultrasoc/Kconfig  |  12 +
>  drivers/hwtracing/coresight/ultrasoc/Makefile |   6 +
>  .../coresight/ultrasoc/ultrasoc-smb.c         | 722 ++++++++++++++++++
>  .../coresight/ultrasoc/ultrasoc-smb.h         | 142 ++++
>  8 files changed, 1087 insertions(+)

I have started to review this set.  Comments will follow shortly.

Thanks,
Mathieu


>  create mode 100644 Documentation/trace/coresight/ultrasoc-trace.rst
>  create mode 100644 drivers/hwtracing/coresight/ultrasoc/Kconfig
>  create mode 100644 drivers/hwtracing/coresight/ultrasoc/Makefile
>  create mode 100644 drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.c
>  create mode 100644 drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.h
> 
> -- 
> 2.17.1
> 
