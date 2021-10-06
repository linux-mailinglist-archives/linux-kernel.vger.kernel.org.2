Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9600424071
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbhJFOvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239088AbhJFOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:51:41 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC58C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:49:49 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l13so3154712ilo.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pbkOIvcrn3Zdmfqjk1oHv0+qr3VlqkBL1bCsO0MwZFI=;
        b=FeNd/puuUesROoShMo9k36CHqh1G5EHyG1Ly/q1AwWzqNPika3PFi5s9iMbWJRTxhc
         VN30bCdXlnefe7elX7gdqhROUM8C9EtWkSlNRkjUS67RljCv/w10L/VdUdQbihCaFIo0
         ycTReHrqyPO6vlcRbW9qvdGyeImNOenINlYDTGaGcjo359WVOXceD3zTbVIpRSL7yTaq
         YSuv3hhevJFWRRstD+Mlq0Wpe+Z681isWH4yoXGitVXo8DaHn+mAQEqMNij6ripVQldh
         MVikeyLsl75TtRe/TjTvUBAOf8iJgZUURpJaqhvnehaXTnmqCRDclm2bqO2QnLDZfrcw
         sHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pbkOIvcrn3Zdmfqjk1oHv0+qr3VlqkBL1bCsO0MwZFI=;
        b=5Hh+tS6MxqigL6JdwSNh5mMJ/sbHBUSGCUSsHYctWtegsLtAlpzSL/V34doOw0gttH
         8nPmJ8bswHNlHVNNdHiBubPnolw5BK5f0gYwqDp3Uk1MayDSh9QexqvtvGI0ECu3gp4q
         eN5Xq81IqavAb2QafxuoEDIM4Rv7xX6JYuxt1JxsG7yiTD6VDJvBv+B0lQyKeRqr/Aqi
         AcRCLI9t/58PvYl8p8Fi1Sjt95UuNHSBgmRNzzbqgArtg/rMdk9PKnTxWZaeWtUHCmDC
         iwrdE8hkpat3NYDcMlkMi9U+zIEc+oRSJt2ZODiEN4dztv5HNuc/f56skZnylUDfm6Sb
         1f1g==
X-Gm-Message-State: AOAM531JT+Dzu//biXzpcIk6cCbZ85Draw27Nch1gIyQaSXywJfNKuLe
        E5hGBv9eak+Rt7fWtLVgWeiSpEnN1vJrVS6F318=
X-Google-Smtp-Source: ABdhPJw6l8TacYXNhNhXHzS5mSyRceSbbhWYJjLCxuBnJaBLUtLUOEjkbKi9BB+tZ1ldt4nR5MvTkw==
X-Received: by 2002:a05:6e02:1cab:: with SMTP id x11mr8030251ill.254.1633531788193;
        Wed, 06 Oct 2021 07:49:48 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l1sm12599506ilc.65.2021.10.06.07.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 07:49:47 -0700 (PDT)
Subject: Re: [PATCH] Documentation: Fix typo in rtrs/rnbd
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <20211006143902.129864-1-sohaib.amhmd@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6034f07f-64f6-a388-8724-41cc4845bc2c@kernel.dk>
Date:   Wed, 6 Oct 2021 08:49:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211006143902.129864-1-sohaib.amhmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 8:39 AM, Sohaib Mohamed wrote:
> Remove repeated worlds:
> - "as as the"
> - "the the name"

Please slow down a bit and check your commit messages for typos.
They've all had some, this one has "worlds" instead of "words".

-- 
Jens Axboe

