Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A0A37546A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhEFNHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhEFNHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:07:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84ADC061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 06:06:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b25so8154287eju.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWJg+Vt3Q8NVH2ewzCg+bN0L04a/eNeDOHTWG7S8+10=;
        b=TEUqXuWA7rir5GMdojTKBQi0ozHKO/kw2Kyn2TmsraaXDBG0RE/vEg0hCoiED19Ysh
         YemqzZVLc/nzKTawNq7bAwRzhgOvdyzbCQtBOE8B2RGxOXGZWra//4uGWU9VIUIW0lRm
         bSZZlnXHg+plaV5Aza1BbWzs+BJ6laNTL5IRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWJg+Vt3Q8NVH2ewzCg+bN0L04a/eNeDOHTWG7S8+10=;
        b=NF+ilg1pKRvBP9H1GnB1SgL3uukghhECt1U6Rij2xY8ORgaJ1VU6+UBWbPUn3UnsIi
         ruMV3MIAgPgFK/YPsYoXeFuzl9ujiQw/I+jv7TJ3LvFYRNuG1wiqhxJv3F91jnlukPMB
         Lmsgyrt//zCoQSmVu+VuiibDWu/EUZofj4VRs8SAx1Lkf4uEgqWSIAZWwtNbaiWdrr80
         rqrZc1UfDrpmbEgwYDxkiUzupue0c4pf+HPyXwQ4vA5vDUy0eRQ5JrJrH5OAr+uPVebA
         r/VzJDKBY5VqgptaKQVvslHEySZICaRNQ9m+PUSUbX+Kt+wfOC9BQVHzRpkv05PjM6g7
         +hUQ==
X-Gm-Message-State: AOAM530/4kTd+emzzgpcUiaObZ7b28WslPfbNzleD0wHNbXZoDONOfoZ
        KOLUspovn6hVeV5vvtjQYtCefjiiPXDIRIYS+qY=
X-Google-Smtp-Source: ABdhPJxGoEZFw1zzzvPrZ6QjKuGkiPMEf/oV0Q5C+88F8WrG/wmLZSf6SCZIQjq46irVRTAM2LD5iQ==
X-Received: by 2002:a17:906:46d0:: with SMTP id k16mr4295291ejs.105.1620306379262;
        Thu, 06 May 2021 06:06:19 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id l26sm1368799ejz.27.2021.05.06.06.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 06:06:18 -0700 (PDT)
Subject: Re: [PATCH] docs: admin-guide: update description for kernel.hotplug
 sysctl
To:     Jonathan Corbet <corbet@lwn.net>,
        Kay Sievers <kay.sievers@vrfy.org>,
        Greg Kroah-Hartman <gregkh@suse.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210420120638.1104016-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <58ed4157-b8f8-be1b-65f7-89fc2e318a43@rasmusvillemoes.dk>
Date:   Thu, 6 May 2021 15:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420120638.1104016-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2021 14.06, Rasmus Villemoes wrote:
> It's been a few releases since this defaulted to /sbin/hotplug. Update
> the text, and include pointers to the two CONFIG_UEVENT_HELPER{,_PATH}
> config knobs whose help text could provide more info, but also hint
> that the user probably doesn't need to care at all.
> 
> Fixes: 7934779a69f1 ("Driver-Core: disable /sbin/hotplug by default")
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Ping.

> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 1d56a6b73a4e..c24f57f2c782 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -333,7 +333,12 @@ hotplug
>  =======
>  
>  Path for the hotplug policy agent.
> -Default value is "``/sbin/hotplug``".
> +Default value is ``CONFIG_UEVENT_HELPER_PATH``, which in turn defaults
> +to the empty string.
> +
> +This file only exists when ``CONFIG_UEVENT_HELPER`` is enabled. Most
> +modern systems rely exclusively on the netlink-based uevent source and
> +don't need this.
>  
>  
>  hung_task_all_cpu_backtrace
> 

