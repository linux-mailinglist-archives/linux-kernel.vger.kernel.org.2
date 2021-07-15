Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30FB3CA172
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhGOPau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbhGOPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:30:49 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26216C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:27:56 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so6635192otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Ds+bjf4PfC5bkHeufgUSDHW7WzmtQEzph79Y9c1bnI=;
        b=wrUsu36HrQdl+V7iK7ZHXGh+4F7c8wbFcjZL3//oQHTOw8l/GCCxfy4z89+/0Q7hMl
         G3q1mXMeOGTxJfu6XPnJGMJq81B49B5/3AgqtLOOEDvcIP/6crj0gXUCRZQxI6uQ72df
         JQaRz+6WQmhnxiEygMEEIP3IBQphJACO4NPiJ9LnrSxY/o726btX7I6uAq9MftR0ukkH
         hccp9q+KbKGEiGnN8Op7oC94xl/XL6V/R20fPrhsGvH8UtizCZyHd0B5PETdQe7GljXT
         Hx7rCnkPH21oh5En8qyckiYVXCo4ErPD0GPVj/8XXx0/nd23NKHY9E6YgFKKw04kDAPX
         O0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Ds+bjf4PfC5bkHeufgUSDHW7WzmtQEzph79Y9c1bnI=;
        b=f0cM12JUgLRxvAPlTaUHQ90pSzTh3UnAqGQGoA2kwreAlJX2Z/p1FzaEnscJKbO4Ym
         sQJvuDUmv+x3LublAg67IWFS4RNmk1wCdOMjCfyg99Q0Y4SZR3Y1Vl97YRa/oIuym2OQ
         EzsPX8Rq7GzPY2E9l2SS920FHBOS62I4B7nC0qoJJMM8bRqKotcelKfI6B5HEfu3dRn5
         XFR1qiooP9mMP4hRnPih2sSE6lNO+Xx2Cn61ZCah6SKCfTgbc2XZFjUpuit/dF1wYGmG
         8HPM8UPiERp5k50bBdWdezqaUm4FZbzGdf/8UCDg5UxrkcMccG446pRf6Nz8dX2svatW
         PH/g==
X-Gm-Message-State: AOAM531seNmfL80xWt5L+nuhT85v0VoQCaB8WmTgukGyPITU77Eai/VO
        i3ItVVmUfKe9u32U0VMPE+uauQ==
X-Google-Smtp-Source: ABdhPJwBhTMxIAVGPIlv3Hn+mnmRz9ROUHjlWhdzsEg4nEHfoNurmtDg6LRKABg7fz6E19dZE9KWbw==
X-Received: by 2002:a9d:4e03:: with SMTP id p3mr4201481otf.214.1626362875425;
        Thu, 15 Jul 2021 08:27:55 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r9sm1128074oos.7.2021.07.15.08.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:27:55 -0700 (PDT)
Subject: Re: [PATCH stable-5.10] io_uring: fix clear IORING_SETUP_R_DISABLED
 in wrong function
To:     Greg KH <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20210715131825.2410912-1-yangyingliang@huawei.com>
 <YPA2kfnTb5VtSTMm@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d9aa268-fd78-17ec-df0f-00daa1138a72@kernel.dk>
Date:   Thu, 15 Jul 2021 09:27:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YPA2kfnTb5VtSTMm@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/21 7:22 AM, Greg KH wrote:
> On Thu, Jul 15, 2021 at 09:18:25PM +0800, Yang Yingliang wrote:
>> In commit 3ebba796fa25 ("io_uring: ensure that SQPOLL thread is started for exit"),
>> the IORING_SETUP_R_DISABLED is cleared in io_sq_offload_start(), but when backport
>> it to stable-5.10, IORING_SETUP_R_DISABLED is cleared in __io_req_task_submit(),
>> move clearing IORING_SETUP_R_DISABLED to io_sq_offload_start() to fix this.
>>
>> Fixes: 6cae8095490ca ("io_uring: ensure that SQPOLL thread is started for exit")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>  fs/io_uring.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I need an ack from Jens before I can take this...

Ack, that looks like a bad merge. Fine to apply this patch, thanks.

-- 
Jens Axboe

