Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D33E3410FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 00:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhCRXZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhCRXZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 19:25:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C186C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 16:25:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k4so2065222plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QtnQZOyIZCvE0Y7ux5E6kcTfdD4EQX6LF9CRIGEtYY0=;
        b=ZMC5AgP4oHsqRaEbVGHnCJWJacbxUjRNsEyZ/+kmIY2vImJs4BmijM188BLvO5Axuw
         7wNiA3BEjcD1j780tIL2d74cmCW21tsCz0nvw8fkfZzXMJDFX751e13eApI/OQ1v7+UZ
         e68dqGhEyKDXHGTs0jegfNcQrFXFzSgdNLL4ftWJ74Jw0hWZH1hG0tKj6ycJx3012fxA
         KwNiqU6EjPKzJaVFmLtNGTiRQlOfdmlazflDVWNGMTYOvon/RC4DwI43BSMhmzgLsWtE
         z/0E1OjI/0ycvfOWsvCG4+dwluIFB18ClWClEgUzD7FyjWmd846vmkhhNv8CCXX1Zi95
         HHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QtnQZOyIZCvE0Y7ux5E6kcTfdD4EQX6LF9CRIGEtYY0=;
        b=CtFWk8yBz5xEqmzjkTOExOb8WrJbkySLwfFhOSqof5wQ7lXdoGA0O7zZUT9W4P7dhL
         WKzCc91Y6xiuyeOvUmpG50SWDxRO7FJdsu+qSSE1N1GBJRFJw1Ei6Fn4hq9UsvxXJsPX
         k1hFwd6jFNX9CH02qqK6IzOTOkRApI8OLGUFIItoGMqUFSMu4LduI6NXBPyY8BAMwvPu
         guY49OKQ/tWtoJFaBXlObTkDZp7U4OIkOlKLYLSwcNseILK6AJkas8fm0eAZIVExlMex
         Fo2F3pjx6UzrU74XxHNcMXbkfXQpCQC2owES4c9q5adLsh42upkNQNHmQvYsXNZfaWvV
         ji+Q==
X-Gm-Message-State: AOAM531EnfgM5pEouRBebgHwrIBljmXxXcXq13HeiqILzIe9cA8tnfLi
        Nn0tXDjcPnjN9VG/YQicUnIv9RMImHSNAA==
X-Google-Smtp-Source: ABdhPJySOgsCTP/8v6KiQ6v1oJdZVbjCLdieOlDyUHPL3izKDHBTcmSe1T5RlDC4BFvESgicTA8fkQ==
X-Received: by 2002:a17:902:a617:b029:e5:b41e:4d7b with SMTP id u23-20020a170902a617b02900e5b41e4d7bmr12105973plq.33.1616109910646;
        Thu, 18 Mar 2021 16:25:10 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f2sm3540207pfq.129.2021.03.18.16.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 16:25:10 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commit in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Stefan Metzmacher <metze@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210319101654.638e8e95@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ced6739-4458-2b5b-af5a-d3aa9d37656d@kernel.dk>
Date:   Thu, 18 Mar 2021 17:25:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319101654.638e8e95@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 5:16 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   c2c6c067c050 ("io_uring: remove structures from include/linux/io_uring.h")
> 
> is missing a Signed-off-by from its author.

Stefan, let me know if you're OK with me adding that, not sure how I missed
that.

-- 
Jens Axboe

