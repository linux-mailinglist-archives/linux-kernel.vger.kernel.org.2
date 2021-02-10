Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3831716C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhBJUbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhBJUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:31:05 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606FFC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:30:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id m2so1999911pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PJmyrPMtY2yl3dmSpn8becwEl0NxjN1C6ENVTeSAzlE=;
        b=X7XpCWjvk18kXKw4kgMeu1XUk8U7GbMdhpE5e+l1++YScKxVkxab8MNbcLqNr8wBrr
         ZJZ818OauFIFOg8P7lTA8QQ4ETqmSmWEKzpn0fV3uJFPPt1PO/737jzcipfov7sQK3m0
         SXXOqLOEV46SOP162eAoPlNnq2fEEZr6ePUJuZ3ggRxeuC08BXeJ61psj8R6jcDJqUYy
         +gvEM6tGLocvi2BGtrERzlFYVIAg984r9+5DSJ6uNo1EueaGvzaLwwLhFNU6G60pKHOp
         ie4f7uaIrDinfLIjYZLqb51AVW716iBugIMb+XLb/au/6HDLHquWlyrkTfRDhmb4tCMk
         AEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PJmyrPMtY2yl3dmSpn8becwEl0NxjN1C6ENVTeSAzlE=;
        b=RZC1d1NNA3q9LRgenLHTmY1ZPKOS8Nto9vrzd12eMGd/zKCapDRKoRY4LJsVdyp+aI
         TXd137eA8xcI7Wqcjk7wHYv7XHOUT1rf6WloarbnYr8nnUoNF/tsAlCd9b3zVe1SWVw6
         WqE44cSecfZUGWPIa52iOlvMSo4vngd2R+ZRnZVnfElz+JItydf1Sp4zRch/yWWVSm2X
         FyIrPd6Py+W6QYIlftE+RVRbB7ZC+7YKIb91rUnrrN+w+fdmaqPy+32FkT02B806NPf4
         jqd1ft5KFBxzzJqYs0iVPK24zDp7PgQw7tv118U7QE0CxdnmIyvy7rEnIgQIoKq3fhrA
         Rswg==
X-Gm-Message-State: AOAM5328cmKD9dzcVK49GBGBdHH6inhwnbGz7C819TEk4iCyukmcHB6n
        gx5L6YbwTp4mMkgTZ1gGut+Zd3FLhTU3UA==
X-Google-Smtp-Source: ABdhPJx/uZo8a0fja85mAj0hfq+nTFT8A2F/S0ELEgZ/8HdLoCv/0e1g8z3yendy4HZ4EAakwBh3rA==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr4664275pgj.247.1612989024640;
        Wed, 10 Feb 2021 12:30:24 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21c1::194c? ([2620:10d:c090:400::5:a5c1])
        by smtp.gmail.com with ESMTPSA id it6sm2915538pjb.15.2021.02.10.12.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 12:30:24 -0800 (PST)
Subject: Re: [PATCH][next] io_uring: remove redundant initialization of
 variable ret
To:     Colin King <colin.king@canonical.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210210200007.149248-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7cbce70d-741e-2948-d1c4-9f30a89d029d@kernel.dk>
Date:   Wed, 10 Feb 2021 13:30:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210200007.149248-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 1:00 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.

Applied, thanks.

-- 
Jens Axboe

