Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1A41A2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbhI0WbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbhI0WbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:31:14 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331EC061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:29:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r75so24853079iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mqOH7D1ukF9Zx8b0uf7vcP62TIlQ9RE291MOEYFvaPI=;
        b=5v8EI4K57W2nZC6Fz5gZTCvYGpzpLmIVxBdnAzUCwcOELQ+Z50Fvi0F2ewrLtFDHRt
         vtQkQZUUT9draUGadJ6ZaetWUBTobhsNeKmmxnly90D3cPXzYH+dCrqn7mpikqrckWDt
         WHi7wR55Ek303Gg+2dugwLfcDXsRNH1MLrzdZ6XsBnqq5oBHq+hSOTcA57myq7M9AOAa
         aCJaO2UWkm+hsZKGxK0d0D/TNWYEqb0UDgv+4L/taDU3hH3nbprrs7bGRma0s183dv+l
         EPbxyWPCeAI7d/kBAGPUllWTqDWK0UR5PhnZh81ZPhBozZwXA1lGrbmMOWvdwHaSVxRe
         8BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mqOH7D1ukF9Zx8b0uf7vcP62TIlQ9RE291MOEYFvaPI=;
        b=WqUmVvAN3thQcZpWuEnFIbTejI6TyQ3cOtG1JwPkAtu1OrbiodQWSeq8mtFV46aYO1
         Ye1FDXUjMcW8RZW7U2ZQRDcp6O5Ovx+rPim2rMfQ+LZ1czfv3AU9GRogfKiltSFwrtmF
         tjejrYR/O8oHfkdMkqjCPQ4tTD1R/Uas9NqwIN0ySa535vYRO/DWqtgnGS6hElk/Gk2/
         jygZv/at8Rntf9iLtaDhZgXqhGHSOIm4AmY3R/JTOR0RK8WW+pUHaVRAWHfswfRME3KF
         0MlUb59ezYtLtQXo4X6qIymHPVHfgsmM3a+JhO8wKBIDkEEWg1/VSjQD1tn+axhbY2ha
         puKw==
X-Gm-Message-State: AOAM532dAla6+6cl7eKWLgUfL+hqTn0LL3fAdRq/IfJ1L146GG1hb0as
        96alyo2DDiD0aZJFKUDFlwj730BDCDjZuA==
X-Google-Smtp-Source: ABdhPJx4BepmT9sgpk1hyVciVWTm6ec+ZxPGy9AhD/MitW3pGK1ERf8eVfBwoyEV70Tjv8vb1T8inA==
X-Received: by 2002:a05:6638:164c:: with SMTP id a12mr1841987jat.62.1632781775194;
        Mon, 27 Sep 2021 15:29:35 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b12sm9902455ilv.46.2021.09.27.15.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:29:34 -0700 (PDT)
Subject: Re: [PATCH v2 00/15] block: third batch of add_disk() error handling
 conversions
To:     Luis Chamberlain <mcgrof@kernel.org>, justin@coraid.com,
        geert@linux-m68k.org, ulf.hansson@linaro.org, hare@suse.de,
        tj@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes.berg@intel.com,
        chris.obbard@collabora.com, krisman@collabora.com,
        zhuyifei1999@gmail.com, thehajime@gmail.com, chris@zankel.net,
        jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210927220110.1066271-1-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ee2c245d-7190-b708-4c48-cbee28f56f9a@kernel.dk>
Date:   Mon, 27 Sep 2021 16:29:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 4:00 PM, Luis Chamberlain wrote:
> This is the 2nd version of the third batch of driver conversions for the
> add_disk() error handling. This and the entire 7th series of driver
> conversions can be found on my 20210927-for-axboe-add-disk-error-handling
> branch [0].

Applied 2, 4, 7, 8-15.

-- 
Jens Axboe

