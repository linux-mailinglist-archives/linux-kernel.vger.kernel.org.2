Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D540741A30A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhI0WeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbhI0WeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:34:02 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C88C06176C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:32:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y197so24765425iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UmxU11hST5wQMMsZTOdrPPgQ47TLPa20pybe++XQYM=;
        b=DYK0QeVSPErU0fdUHY9fTGU4W7LYS3OpstW7jKN2zQIGz6Fg75r2GHQ3mNhW9RIn1l
         +/XX+0IaT+QuP2WnY1RDSSQe/LzU370EV/dACbM1CoHg6kWxfp4JKYe9NsSJNOZspcJv
         79kSmVRSpqY6HusQwOsl5Cca71RoZZnxCQ7faeNT+onSgNJoOacMUCqYfldqMMFZnJn1
         op2n2nb0dzUlxGLwnR76PnSZAQEAPJSGaPxLjQP0iN7EFQdPXw6p08Wye3gAirxio6qw
         Ay8cPI17oe8ngWi6HmVYmshTvXlSdR08xlvJOMOinmATWt5vmC9kQdW4ky3oHMIbMIRb
         tKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UmxU11hST5wQMMsZTOdrPPgQ47TLPa20pybe++XQYM=;
        b=3iqCTRwnJ6hWuxpZZWAJ3bfNOHoLt05lN+hWRuIHmHpI0a2ISn33XxJul2FA0Ks1ys
         ywp3HZ0YlGhS4+H9O41hszKt6izItnU8iaonmywtU7e3cqscWTJqBwcu0omVXmsFYUCx
         WZ+AoZM2YupXNDGky9B2wbUUayLCGIs46Aegd9Wfk0SwQEpPs+X8B/VY0iZEx1MtRXtZ
         +ilhxOyiv2q9TGla6QHGyR0O40i4/ycoxffMHqjuGm3GMtAbpSyTgbq7k4z54Zo5nvR6
         fn1TzrYKQjLov181I8nLVh8sm697bbpsVJ1AsHXL8v7E470kU0ztIp+UgjEQ6UezyeoL
         oJZw==
X-Gm-Message-State: AOAM530baB1E9IrEom1eM8aTjPOrEn5Ew6lnI0QjvSd9t6sMF9c4zITy
        KocIZDeJM6sZ2w2TEQB81apRQJm8GPMUzw==
X-Google-Smtp-Source: ABdhPJzCRspGfuZEaibKYg9STMBXwDX6ihxLpFk5STZ/wJRDMFJCRfEhMCvkyfG9LlSO8u6kMpd4Fg==
X-Received: by 2002:a02:3f4f:: with SMTP id c15mr1841581jaf.1.1632781940669;
        Mon, 27 Sep 2021 15:32:20 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id p4sm9291645ilj.26.2021.09.27.15.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:32:19 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] block: 5th batch of add_disk() error handling
 conversions
To:     Luis Chamberlain <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
        chaitanya.kulkarni@wdc.com, atulgopinathan@gmail.com, hare@suse.de,
        maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        colin.king@canonical.com, shubhankarvk@gmail.com,
        baijiaju1990@gmail.com, trix@redhat.com,
        dongsheng.yang@easystack.cn, ceph-devel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, oberpar@linux.ibm.com,
        tj@kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210927220232.1071926-1-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <25afa23b-52af-9b79-8bd8-5e31da62c291@kernel.dk>
Date:   Mon, 27 Sep 2021 16:32:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927220232.1071926-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 4:02 PM, Luis Chamberlain wrote:
> This is the 5th series of driver conversions for add_disk() error
> handling. This set along with the entire 7th set of patches can be
> found on my 20210927-for-axboe-add-disk-error-handling branch [0].

Applied 1-2.

-- 
Jens Axboe

