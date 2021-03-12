Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FB13396F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhCLSxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbhCLSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:53:12 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59085C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:53:01 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s7so12348296plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4lnxveEJ/0ZKlbul4AkdRbzETouaO+1JW1spiBW8ehI=;
        b=g7ECqI3a3+o2sGXX/XLkecd+qRB7jy07detu5ysXiCWsWZRQlW36mV/mpnHpeRUV2e
         96flARGCs1u7qPUrBPnGMKsHREUIgX1qR+ezAldlSRbnvJyrEopC9FaAcc2RFpkevMc7
         jaIlyPRaOqgqvTnhi6X9EAHnlWs4x7BglhW6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4lnxveEJ/0ZKlbul4AkdRbzETouaO+1JW1spiBW8ehI=;
        b=osl6i9rH6Y+wlbMKCCvNo9v0f0nRnrJDpXCJ9MAO/7dewnh7ldCzFlvDGMIXNYRrJO
         d6I4sniYxMINu8Weal+hMKS3GphrfAygQpGWHfysAEICe/JUTSe4ez6NgIukr/3Du3JP
         H/ooIwoxqNHPXP1ziarESVg3ZRhJ1sEkJMkey6WEiM/ep85TQyLoeGreUa9rksy3VYZn
         QWfRO9FBClunId4sJckgQ/GMOET4iBzLrjyiPA5MAaavaWRGglJ+sVak5SE1OneZGhc7
         a6CaBPVCrpNrXWr3iEBBI3Pk2gNhc5q2FdUHfkbpAE0HDf6cNothkfvHMaKCI/CPSxYw
         kWQQ==
X-Gm-Message-State: AOAM530WjOgLpNsKqd1VL/GdsRTI5m7IreB0W56xegjjZvSDsZ1bwq0e
        aCSq99B3TkLW3COecAwb50jII072SYvlCA==
X-Google-Smtp-Source: ABdhPJzIK3/zcsP1TXvm2aWXTGtveRpCxedeg7bNwF+dueqAOaOCNWvyJk+0QCrzytMON1/F3YT+Sg==
X-Received: by 2002:a17:90b:4a4c:: with SMTP id lb12mr15505099pjb.133.1615575180327;
        Fri, 12 Mar 2021 10:53:00 -0800 (PST)
Received: from braindead.localdomain (c-71-202-115-154.hsd1.ca.comcast.net. [71.202.115.154])
        by smtp.gmail.com with ESMTPSA id k3sm5798446pgq.21.2021.03.12.10.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 10:52:59 -0800 (PST)
Subject: Re: [PATCH v3] Expose the bus kernel docs to the build docs.
To:     Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210307031611.GU2723601@casper.infradead.org>
 <20210308191417.4750-1-wt@penguintechs.org>
From:   Wren Turkal <wt@penguintechs.org>
Message-ID: <c94755bb-abde-4abb-1303-731592bec570@penguintechs.org>
Date:   Fri, 12 Mar 2021 10:52:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210308191417.4750-1-wt@penguintechs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew,

I hate to bother you, but how do I know if this patch is acceptable or 
not. I am not sure how this is tracked.

Thanks,
wt

On 3/8/21 11:14 AM, Wren Turkal wrote:
> Before, the bus type related APIs that were defined in the
> include/linux/device/bus.h were not referenced anywhere in the docs, so
> I linked it to the bus types api documentation.
> 
> Signed-off-by: Wren Turkal <wt@penguintechs.org>
> ---
>   Documentation/driver-api/driver-model/bus.rst | 8 ++++++++
>   Documentation/driver-api/infrastructure.rst   | 3 +--
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/bus.rst b/Documentation/driver-api/driver-model/bus.rst
> index 016b15a6e8ea..c53b01e95fd9 100644
> --- a/Documentation/driver-api/driver-model/bus.rst
> +++ b/Documentation/driver-api/driver-model/bus.rst
> @@ -1,3 +1,5 @@
> +.. _bus_types:
> +
>   =========
>   Bus Types
>   =========
> @@ -144,3 +146,9 @@ sysfs directory using::
>   
>   	int bus_create_file(struct bus_type *, struct bus_attribute *);
>   	void bus_remove_file(struct bus_type *, struct bus_attribute *);
> +
> +Functions and Structures
> +========================
> +
> +.. kernel-doc:: include/linux/device/bus.h
> +.. kernel-doc:: drivers/base/bus.c
> diff --git a/Documentation/driver-api/infrastructure.rst b/Documentation/driver-api/infrastructure.rst
> index 683bd460e222..eb2a2c9e3c0c 100644
> --- a/Documentation/driver-api/infrastructure.rst
> +++ b/Documentation/driver-api/infrastructure.rst
> @@ -41,8 +41,7 @@ Device Drivers Base
>   .. kernel-doc:: drivers/base/platform.c
>      :export:
>   
> -.. kernel-doc:: drivers/base/bus.c
> -   :export:
> +:ref:`bus_types`
>   
>   Device Drivers DMA Management
>   -----------------------------
> 

-- 
You're more amazing than you think! ymatyt.com
