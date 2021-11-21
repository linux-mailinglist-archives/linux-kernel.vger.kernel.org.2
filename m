Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9A4585E1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 19:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhKUSUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 13:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhKUSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 13:20:19 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF1BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 10:17:14 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id v23so20325255iom.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=65ULih4jdhx6XkQY8ehRAlPWusFwZCWzdiFX6NIjolQ=;
        b=zsu+Q+VX2+NPXr/UZpR3x8W6pK2OUzMcgE9wIP3twPbveAU5n6DCF9iCldcLy6JDM4
         KH0YOJnq3845kg/IwYFUHqsX+y2rPHel5OGwTXxMdYA8Kc6x7xJv58Gesr5xLxy7I+PO
         Xxzzenfqcv8tOqA/CrwXaq8l4o/W+CFe+aaC3snazzVCEEqHzaiYwaQ274/A1P85Lu0y
         7tYKQsr2c/U1nnczak+Ay6lLm97LUQ0y7uiK6z7pI7EmvgIPFGIJ+JxFWkzi8tgh64Sm
         oCl/PD5AMaMPSPh4nNossSRAURME9mAooZWtYWejKzUlwt32f+0DHAsdChx9WIQtZ8Uu
         FdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65ULih4jdhx6XkQY8ehRAlPWusFwZCWzdiFX6NIjolQ=;
        b=IK0p0Od9bwoNQ2/lgn/CSy/qGWZmsIqUPl7cJBjN7c6f9tWHxthp+2N8/Je1Dy8BTF
         3Ew378fAZ2c1e2mS637gI20m8ljNc+fWpaH4F8X7hDfc1B1h7Hge6tu+hdb2iPcBa5lZ
         R5LM3sL4ooegYim9aXJERi/crLcQXLBFf6ZK6A6ojQhmLdKHGj/nvitEt0oat58rCzfT
         pFQRt8h8IOUNMZEyUtCJuWFiTRWggllJQ7dtiso1o2YASax8pxJZh47h4Zv74v3wsFmO
         Q7k0aELIuvDZu5SlJxwhiL5f9mre/zVKhlF4QCacP0X6TGpWpJY5en4ttIpCHyZ0GXyS
         QUxw==
X-Gm-Message-State: AOAM530DdRKsGD2H02Ll1Z7UvUHL7GYgdbNonVJM9OtLxFD/SjfbiZr8
        o+SPG4TKyFkL//l1ueQ2L8y00Q==
X-Google-Smtp-Source: ABdhPJzw33awYOKSTWKfJtvcy+AEFNV9QEEPzQz4YtCnyDKg7Y8JpBa2tT4xsZNOEkt3tdNz09enPg==
X-Received: by 2002:a05:6638:3a4:: with SMTP id z4mr43190679jap.76.1637518633978;
        Sun, 21 Nov 2021 10:17:13 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l1sm3323116ioj.29.2021.11.21.10.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 10:17:13 -0800 (PST)
Subject: Re: [PATCH V5 07/10] io_uring: switch to kernel_worker
To:     Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
        vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
References: <20211121174930.6690-1-michael.christie@oracle.com>
 <20211121174930.6690-8-michael.christie@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0a69a253-3865-322c-3a6d-6f8bb1c36023@kernel.dk>
Date:   Sun, 21 Nov 2021 11:17:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211121174930.6690-8-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/21 10:49 AM, Mike Christie wrote:
> Convert io_uring and io-wq to use kernel_worker.

I don't like the kernel_worker name, that implies it's always giving you
a kernel thread or kthread. That's not the io_uring use case, it's
really just a thread off the original task that just happens to never
exit to userspace.

Can we do a better name? At least io_thread doesn't imply that.

Also I do think this deserves a bit more commit message, there's really
nothing in here.

-- 
Jens Axboe

