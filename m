Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8964607EB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358726AbhK1RRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358755AbhK1RPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:15:07 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E5C0613F3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:11:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso9849631wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/BxCr/w+l2bdFSYByk/AHxwMpqs21Y+yuV2W/kHzL+I=;
        b=KDecI5aLdOlhDki13ybUHu9/Y5J42QKcMIpHg1aLjEGz0t9QCWaLz0oYLY5JFI3s+Y
         1CTnFAXVhjHQbCpYlylaGh+ORIqLXog3xdg3xTn95XE6H4zUjCkuAgXhMjOJNwMdxz8K
         PVM77gNXx7mLBq2Bb41e0b7bwCP1aPjQsn4ZZlcgtk47m70Dn6ZGG9BV+h6lsUg1BlMx
         0FuuwAGufbL9bfr9TmcTYmabyJ38GxyVzsMjDsmbey/7EUxNAT5uS8302U/Mb3G1pHn6
         N81zgoC40RLMDYXZG+NBp58GOgw/fdBQUSIvtJd5K8Aam+012KsgLW96w+L9B9ucDTd6
         2bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/BxCr/w+l2bdFSYByk/AHxwMpqs21Y+yuV2W/kHzL+I=;
        b=SK/CBU9v5ZhGAGtCvdwmsPjxFPVdOpBkYsP8Nv/FCqCOfaWpzNpYvrqPZvBU5ruh22
         nXJR7qg/G+7pONIi+x+S6KgOSLWP/57xQs31z54GVDdIHsVfu0vsDq2+3ESUdtRfZa2Z
         Ybg+7voqoOOpox8+IR9PLvShC89oDOnUwWud6gBZsk+7CLqaiApRjzx/FTnMW6sOKb0t
         AALGCwbkPKfrl2S6z8mpnlDMCfl4v6lESA694lu+mBD0wTsTKStNSe4Hh2CQjpIx+2jn
         kjdxsVEJbU0rDTY45xrEI+IlO+vthPn3evyUP42ZK/MPBX88WwrZezbqkiQln8HZqtLl
         HZYQ==
X-Gm-Message-State: AOAM532bJ/hro/5iP6pppc28pojQ4bT44K+TK1VBAQn+QR41gnJXZEf2
        72jlzbduY2rUngO3Xm/GQuk=
X-Google-Smtp-Source: ABdhPJyFIfFjI5xFlN5Ci7B73zmINwCcGloWUFgH5wF3Pb6tZe5a5qqLcHjtMCvyKhag9Gjn7Uz/+A==
X-Received: by 2002:a05:600c:3c91:: with SMTP id bg17mr31130727wmb.80.1638119497259;
        Sun, 28 Nov 2021 09:11:37 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::ac86? ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id r7sm11120728wrq.29.2021.11.28.09.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 09:11:36 -0800 (PST)
Message-ID: <1634f480-db75-48aa-7050-8720d60ab7d4@gmail.com>
Date:   Sun, 28 Nov 2021 18:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/5] staging: r8188eu: remove more usages of rf_type
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211125195936.10060-1-straube.linux@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211125195936.10060-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/21 20:59, Michael Straube wrote:
> This series removes some more usages of rf_type to get one step
> closer to remove rf_type from the hal_data_8188e structure.
> 
> Tested with InterTech DMG-02 on x86_64.
> 
> Michael Straube (5):
>    staging: r8188eu: remove rf_type from rtw_update_ht_cap()
>    staging: r8188eu: remove rf_type from issue_assocreq()
>    staging: r8188eu: remove rf_type from storePwrIndexDiffRateOffset()
>    staging: r8188eu: remove rf_type from getTxPowerIndex88E()
>    staging: r8188eu: remove TxCount from getTxPowerIndex88E()
> 
>   drivers/staging/r8188eu/core/rtw_mlme.c       | 12 +--
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 25 ++----
>   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 85 +++----------------
>   3 files changed, 20 insertions(+), 102 deletions(-)
> 

This series is outdated an can be dropped.

Thanks,
Michael
