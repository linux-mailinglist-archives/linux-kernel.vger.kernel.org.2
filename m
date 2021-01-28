Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB276307833
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhA1Oev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhA1Oef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:34:35 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B510C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:33:55 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i63so4093226pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3UJyCYyHELMaW+UVSUKIODWe8UUnEGgoP936EHMWBTE=;
        b=s/8G0pIfrzxemzeiVD4GkxI82+AzGvnsibV4H6ZREvhKAErR0KW0yF6f6G5MIp+ODk
         ABEm1aKAvUVJgyz+u6grfty+wsKgHlPEw11ngoZfP6Xemg19u5GNEPM6fah1KAQB7Sp8
         oXAPsFAqF0AWwrNEV7DNiL/RuDSPjd/SkiPhVdCOXPAq+cdWlAuvZo1m+CoqvVT5fFkE
         +mxqzgsqUuuzNWeUp+7zOWKQCn5MzMa/cB6yN6H8uCRA+ZbZJy/6AD2aBZO36uz/PT8z
         ja08dRmsk+qBPTSyDcOEuhxrz0M3eWb2dBdwGHM6HE/P84WBdVfjsW8BlI+NQU3rraut
         Z93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UJyCYyHELMaW+UVSUKIODWe8UUnEGgoP936EHMWBTE=;
        b=caSIVmplWPRh/crvC0TXW4jqp0x2LBAB7K5sxmwUs4BGCfJ8XXgYcJYuA07494Wff5
         WSMSC5mcfakVZ2N1u8p3hruYmqCDEdDwMfZy/2saPqCFwOb1wK3awD7sDRgU3vuaxFxC
         Yz52wcPx0ITRMG6UxfZVKD41SK29xKkzTl7thu28qp0ZpGhc2x3896CmxvzH7tv5slUt
         sCbxBVxWSYA7hIs8oRyCw3BAYdx4x7yHBujR6kyesRHiEspMGMYAWocTd3P9Xx2sNbym
         Uh/WH71XsTC9aJHdn8qZRHFraMipteLjkaVRQJBi1yWRZNDGvPw6LKygYx5dyblJvXDU
         wAXA==
X-Gm-Message-State: AOAM532ReYRvYoq37syXswzyaF/MmcK600fqcinfSn1TBnRDT5BjVg6B
        qA/Ij1sip/+RU/weMrrTCKBhko5H5APVRA==
X-Google-Smtp-Source: ABdhPJxF6U0Qzrc8Am006a3Fus+0a0hD/R4ejx1kyG1ZkdEuhQ/QEtJnyhwAAJwDlgcfuFPqTdCl1g==
X-Received: by 2002:a62:ee09:0:b029:1c0:ba8c:fcea with SMTP id e9-20020a62ee090000b02901c0ba8cfceamr15832892pfi.7.1611844434516;
        Thu, 28 Jan 2021 06:33:54 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 130sm6178975pfb.92.2021.01.28.06.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 06:33:53 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: Remove obsolete macro
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2d053708b596fe148c1d9e63a97117c150a0004a.1611818240.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd20b274-2fdc-7046-6571-d11e0a8cf0c4@kernel.dk>
Date:   Thu, 28 Jan 2021 07:33:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2d053708b596fe148c1d9e63a97117c150a0004a.1611818240.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 12:18 AM, Baolin Wang wrote:
> Remove the obsolete 'MAX_KEY_LEN' macro.

Applied, thanks.

-- 
Jens Axboe

