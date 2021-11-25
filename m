Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128B745D28F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 02:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352841AbhKYBu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 20:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352759AbhKYBsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 20:48:17 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367CCC07E5C9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 16:56:49 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id e144so5482542iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 16:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YQECEZaOSnuAkiPU2V5NI9wzqYl9rSxziHehNSDY9mc=;
        b=yEj/CgFCl/hr7Oo3i9m5Nq1jZp8DDu5fJZn9grSTIdtkREa9BgrmMdMoxW7Hk9w/Rc
         4RSM6Ui1OmasykZGf3GtxV+dvcW7MOBJ6E5EgQpZ1Aq9n7pNRrRnz2v0LcCrhTqj6jcs
         +tetlBrOZb0QPcTsvZGx8HRaGIzbm1pTvGMym5EdjReNaHQz+eluzHtkLsnGNv/Mjjlz
         pXCuS+S2f7gm8dXB+TjZnZtVlxV8L1Eljkt4Wwdf2qLnTFjQHh/AwAZo7+vcmOiR49g3
         lNaAtKzbQIFdxFnLWPt3ZElqk3LTjgc0qB4a9DwG3BYAFBnSPpVs4BkOzf90NrKorDtk
         +8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YQECEZaOSnuAkiPU2V5NI9wzqYl9rSxziHehNSDY9mc=;
        b=ayBMRti4Cnxup/Kk+J1Gf32kNYTsy2cmhNVvlBHGtxgWXLUR0PtueMpijj4ur/IkV1
         ZbX6iFzc7IRhRzbWD+PetUL9PiJPbKdFxYxZXX80CTvcFIVZqnfwZd6D+grwtG402vFL
         A7nwDjpzOy9XFL1gIwW1+ML0JBHF8gPY4Y/V9KnfmaJ0UvUs0xVFUatCGbmVRgsNRnZa
         wO1SSSZfzu32Lu7Y8BBpK7cZdz6kDVJeAnzseZR+ppK1iAbAINdLMtx2xqdE7bJzbpsc
         EsVfHrvB5CW8RxKnEugS3VEWI4NOpCca1WcbZdkHhUMEe7Ggz9fuy+1lr0g6at65tRNj
         KHcg==
X-Gm-Message-State: AOAM530nOINGgbvsHbxQQodO6hZLTx51Wq+y3Py3ZDmguyUGW0/FpOOU
        xNX7x8y3MeWO641/77UO1bYWjA==
X-Google-Smtp-Source: ABdhPJwWVqRdKf3NBnTqyTGlkAHlIY6XUp+YcgmQT7OkghhTzfdemlFqdTBdXPGbLVqoNQM0fCzxnw==
X-Received: by 2002:a05:6602:19a:: with SMTP id m26mr19954552ioo.162.1637801808369;
        Wed, 24 Nov 2021 16:56:48 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id v23sm778469ioj.4.2021.11.24.16.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 16:56:47 -0800 (PST)
Subject: Re: [PATCH] block: fix parameter not described warning
To:     davidcomponentone@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <3ece7228314e89177d022cd514215d8c76485fb8.1637735436.git.yang.guang5@zte.com.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0145c2a3-4648-ef7b-6f7f-d15a95231327@kernel.dk>
Date:   Wed, 24 Nov 2021 17:56:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3ece7228314e89177d022cd514215d8c76485fb8.1637735436.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 5:54 PM, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The build warning:
> block/blk-core.c:968: warning: Function parameter or member 'iob'
> not described in 'bio_poll'.

Can you add a Fixes tag as well?

-- 
Jens Axboe

