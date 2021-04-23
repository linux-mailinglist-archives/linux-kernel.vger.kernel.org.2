Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3607936952A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhDWOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWOzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:55:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A31C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:55:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so1397149pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=indv+sTzB8V0DaD9jhIsOZ/lTdYunjH6lFec8oQTNTA=;
        b=CY/l+ZK6CBcdE+VMkEdKAXrdGdKPfMd4pNAkB3nRn3FI8dRRE6ElWJ2wMHNtckPGGf
         XE+RN1jmRXwNJroy9TveVPLb12mmv0gyS1ZMHPb+goyHgsap/vrFVh9GKw3rSXZb2Ujy
         WZbX4E/QAdUVPswsmELdRHrvh5aK79suXSGKxPqIdCZbSJDtHrPthsLdEW+Tp8ucnV//
         7obWn45XyiVKrtZm9kuzRmCZUJka58xgI6LU/grTRZ6zYqRJYCK1HaChWHCsiml0+WcD
         fu6rxfGUbtM2acSzk/kqaENbfPPGCsMTfzbp151VedLl/PyKtQczl2nAqzd7Un8SFcYg
         FK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=indv+sTzB8V0DaD9jhIsOZ/lTdYunjH6lFec8oQTNTA=;
        b=XahSWYfXq/v+kRyPmC8LBd2qN5qKYpaYEivAWcI/PY9WVbui3ml0kcOBcQK0WhT1kn
         Rb+Pi+RIPgdMTEbFgBKr5Pf4xZ5TpMo9QMkGgbED1AYS16ESF0rhgGSHQ3WjSuc8y3lK
         983QAT9A5JReiAYsYMb7scGfVE4of/huCD3kldJvSgYXcNne3YdAa8Uf2eEEQ7cYaWGe
         mzTuowj9WeGpxbsJdWqlFnrNVAT0JJawXdiVBDd618f2NCB5vhSwo97DSk32wyZc06PP
         1tIxXm7iThtXAl2To4NEHo1DJrKpBJpad05DslXOEPz77XP31U5zgGUM71JxQPMwfc26
         czCQ==
X-Gm-Message-State: AOAM531fDGJFUznPvIfu8jqWlePVclQ2vsbPCw8sODl8Bk2GW3ggkZCF
        BCBXQs3gLEECfA31dK99fpltO9jw15hjpBVd
X-Google-Smtp-Source: ABdhPJx41vTAtKsA2s8JOSnczAwo6pnS0GAJbGKaYwtgKtOo9RGGNzzDPVubuZimCjCPRO41vmNl4Q==
X-Received: by 2002:a17:90a:5b0a:: with SMTP id o10mr6021566pji.82.1619189717650;
        Fri, 23 Apr 2021 07:55:17 -0700 (PDT)
Received: from ?IPv6:2600:380:497c:70df:6bb6:caf7:996c:9229? ([2600:380:497c:70df:6bb6:caf7:996c:9229])
        by smtp.gmail.com with ESMTPSA id i14sm4869853pfa.156.2021.04.23.07.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 07:55:17 -0700 (PDT)
Subject: Re: [PATCH for-5.13/block] blk-iocost: don't ignore vrate_min on QD
 contention
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com, dskarlat@fb.com,
        dschatzberg@fb.com, linux-kernel@vger.kernel.org
References: <YIIo1HuyNmhDeiNx@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aed2c239-8169-d30f-1410-ac0b5ae10cf1@kernel.dk>
Date:   Fri, 23 Apr 2021 08:55:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YIIo1HuyNmhDeiNx@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/21 7:54 PM, Tejun Heo wrote:
> ioc_adjust_base_vrate() ignored vrate_min when rq_wait_pct indicates that
> there is QD contention. The reasoning was that QD depletion always reliably
> indicates device saturation and thus it's safe to override user specified
> vrate_min. However, this sometimes leads to unnecessary throttling,
> especially on really fast devices, because vrate adjustments have delays and
> inertia. It also confuses users because the behavior violates the explicitly
> specified configuration.
> 
> This patch drops the special case handling so that vrate_min is always
> applied.

Applied, thanks.

-- 
Jens Axboe

