Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BDD43702F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhJVCs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhJVCs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:48:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D27C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:46:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id o133so2359031pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y8CVbuJdv6pcQlvqtBOqCo8DJXJOq4fCIL+NtdfhBGM=;
        b=cftdgf3yXhUa5cMUgwewdt14ugyS+jkcnj2eELRaNzj6L8DX2rXdE65uRu/ZEWExJS
         aropop8bBJ0KYZyaAu0zj+4CeQlTp7FHbIfwqeit+uM6GKxwfasRcx4zhPuyRS+mwOww
         BmrDYvbhwFM5Y7eTF7QW72dFy7/cIjwnP6eoxJeXBIYA4Vm91a7xL8ZLeupdfw3VJK1F
         79ysaUnW8BOvRj5il1bkkD8fextqBA/okoI19VmYTcRGEZKVvZxGWXoiec5GfIwLCT9f
         +XcF1BhJyNnd1s4tIyy38XYNa1VzJ/EJ1zOgNMMGkZ1lD9jQiPQK90aMI4VLkUEslt5M
         n/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y8CVbuJdv6pcQlvqtBOqCo8DJXJOq4fCIL+NtdfhBGM=;
        b=pT9DdULakYvxsnx/I90SRq+WAsvHUdtD3QAPDB3D09NTWRIFpkI3hd0xqlYTiQfPTL
         liYoNBB6We5f9y9YPLe97wZ5htv1D3cRVA521CSF/BMfciTW9x8ML5ngA0B3lES/pmCD
         3PeNXSU/siYr4XweY34ZJhB4w0M8fNJ1Zr/gLBrvZU4aJNxpkyavgGlIe9+4y9nyAcPs
         Dkgob6g/NWs3Rg4o+/YfKqlcHRSXjbPHlrSDMIlvA/qPL+gtoykBhfbewY4EjNoZe9oU
         ygYELV+h6jzMqQgzjzDVzF/fBYslx2H2hbwkmaIKEAMMR9KU+E9gLXXyvxYSmvbUWSPf
         gLnA==
X-Gm-Message-State: AOAM531+iyuYdSKbvEZwVFB7QSS4rpdt/AiK/TP4gtGueHqbCQHZSdSm
        6tAdFk3RjMCaINGDh//8l5s=
X-Google-Smtp-Source: ABdhPJx9EcbcCW71a8YRsTc0x4Qwz1p6/OkqR6GKBaDKwAiEYKD21xM2xRzjGcxZYWBd1RovCW1G5w==
X-Received: by 2002:a63:ef58:: with SMTP id c24mr7225301pgk.299.1634870769622;
        Thu, 21 Oct 2021 19:46:09 -0700 (PDT)
Received: from ?IPV6:2405:201:d007:e827:d9ab:a6dc:54b8:e75d? ([2405:201:d007:e827:d9ab:a6dc:54b8:e75d])
        by smtp.gmail.com with ESMTPSA id x20sm7138393pjp.48.2021.10.21.19.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 19:46:09 -0700 (PDT)
Message-ID: <9f205c0b-2684-eab3-caa3-8222060723ad@gmail.com>
Date:   Fri, 22 Oct 2021 08:15:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [Outreachy kernel] [PATCH 0/4] staging: rtl8723bs: core: Cleanup
 patchset for style issues in rtw_cmd.c
Content-Language: en-US
To:     Kushal Kothari <kushalkothari285@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        fmdefrancesco@gmail.com, marcocesati@gmail.com,
        straube.linux@gmail.com, philippesdixon@gmail.com,
        manuelpalenzuelamerino@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, mike.rapoport@gmail.com,
        kushalkotharitest@googlegroups.com,
        outreachy-kernel@googlegroups.com
References: <cover.1634845504.git.kushalkothari285@gmail.com>
From:   Praveen Kumar <kpraveen.lkml@gmail.com>
In-Reply-To: <cover.1634845504.git.kushalkothari285@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-2021 01:27, Kushal Kothari wrote:
> These patches make changes to clean up style issues identified
> by checkpatch. 
> 
> Kushal Kothari (4):
>   staging: rtl8723bs: core: Remove true and false comparison
>   staging: rtl8723bs: core: Remove unnecessary parentheses
>   staging: rtl8723bs: core: Remove unnecessary space after a cast
>   staging: rtl8723bs: core: Remove unnecessary blank lines
> 
>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 75 +++++++++++-------------
>  1 file changed, 35 insertions(+), 40 deletions(-)
> 

Please update the history against these patches and whats new in this series.

Regards,

~Praveen
