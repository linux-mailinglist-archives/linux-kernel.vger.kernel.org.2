Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D955308575
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhA2GEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhA2GEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:04:06 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7912C061573;
        Thu, 28 Jan 2021 22:03:25 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d15so5931119qtw.12;
        Thu, 28 Jan 2021 22:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DIdLn4LpSYK2hrD9Gw5z2fpkmte7sT90Jw8a/2a6yn4=;
        b=qkjyKi6ps0zkbxxxuMxD1N1iSJw5nHSolpBHyAR8XQ06DZ6Uim7EFuLRUNNdV+fCKW
         z+sWfnF7Mgr7dhGYAvJTtHBjy6dsrDOR7BA2//Lz2KCes549qmkZHQ36lc30ATshM2AO
         O/hDB1QkykNanr06mxGkzCokbkA1pN+1wRn6ovY8QT8/wc2LT+sZWVj7Wk7xPTWlRAop
         8bICmiVx+xffOEd9ce5JqYghBOShW5RbC5MFnkT/giTj0SMbBbpZU5kYt65xGvwKwFfI
         JJkDQsE7wYK+9M1MtfvPT+UQ0Nwjb1VObTa0YIbVIu9Wwm4tR4MP7cyyLUGFK/E7jrsX
         D7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DIdLn4LpSYK2hrD9Gw5z2fpkmte7sT90Jw8a/2a6yn4=;
        b=PFCkT3FgDp6HCjUdH/Jeycsbh+DeRt6HlU6/kYukDNCFALCuwC7icLVqPRUNosKS72
         ZSEQ9Ui6MXpXzEPIwUEKpzNIE6L0L7OAydnW1G5mbjt2viIpOmT/pOjtOY6lxscVgUPR
         3YYq/TDl7YPG4duTdGHI+qu1nMii1HMROn6J3HW0leZnoFjJdIoCBDwd8ufT2Qc7NWqD
         zvllATbhQduBn/xtD2vwI2jFJJJ1w173qcIYkGQASzk7PFWBusmt6cOZ/pIwmXzQGFYI
         EYasC93JaQjictErWqzJmkjd2KF2NHp1e4+r+XnffwegRrzlmpkw/WsEyYEOLLgHG3IC
         BfHg==
X-Gm-Message-State: AOAM533Y/p2GLrc6wipU/+JZziBsB97Au4saPhwhTByPKuPcu1msAykK
        hQy7Hx9dztE1mXvkkzO1xUI=
X-Google-Smtp-Source: ABdhPJzb9dBR3oFY+cUI1Dcx8jFyCRRwpacL22QgCiQwalHgYdNpDx+osw/ta/qIZo5cMEAkrTPNlA==
X-Received: by 2002:ac8:4d93:: with SMTP id a19mr2924481qtw.28.1611900205090;
        Thu, 28 Jan 2021 22:03:25 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id q4sm5289491qkj.5.2021.01.28.22.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 22:03:24 -0800 (PST)
Subject: Re: [PATCH V6 2/6] scripts: dtc: Build fdtoverlay tool
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
References: <cover.1611312122.git.viresh.kumar@linaro.org>
 <2dfec4acb1bfbab08b431908ace0a77cc3279434.1611312122.git.viresh.kumar@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1f6408aa-9900-fe4a-d885-028ff8329707@gmail.com>
Date:   Fri, 29 Jan 2021 00:03:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2dfec4acb1bfbab08b431908ace0a77cc3279434.1611312122.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 4:50 AM, Viresh Kumar wrote:
> We will start building overlays for platforms soon in the kernel and
> would need fdtoverlay going forward. Lets start building it.
> 
> The fdtoverlay program applies (or merges) one or more overlay dtb
> blobs to a base dtb blob. The kernel build system would later use
> fdtoverlay to generate the overlaid blobs based on platform specific
> configurations.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  scripts/dtc/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> index 4852bf44e913..5f19386a49eb 100644
> --- a/scripts/dtc/Makefile
> +++ b/scripts/dtc/Makefile
> @@ -1,13 +1,17 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # scripts/dtc makefile
>  
> -hostprogs-always-$(CONFIG_DTC)		+= dtc
> +hostprogs-always-$(CONFIG_DTC)		+= dtc fdtoverlay
>  hostprogs-always-$(CHECK_DT_BINDING)	+= dtc
>  
>  dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>  		   srcpos.o checks.o util.o
>  dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
> 

Please add this comment:

# The upstream project builds libfdt as a separate library.  We are choosing to
# instead directly link the libfdt object files into fdtoverly

> +libfdt-objs	:= fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror.o fdt_empty_tree.o fdt_addresses.o fdt_overlay.o
> +libfdt		= $(addprefix libfdt/,$(libfdt-objs))
> +fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
> +
>  # Source files need to get at the userspace version of libfdt_env.h to compile
>  HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
>  
> 

