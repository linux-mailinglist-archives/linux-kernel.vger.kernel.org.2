Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD42366EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbhDUPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbhDUPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:16:29 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6BFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:15:55 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u16so25425084oiu.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=43BM1RWeXNmeeSS9PVJMPj0AxRoQfR0CMNvFedQdo6g=;
        b=2MP4GxATv8z+lbdocPj1QM5XxbECXHXeXv5daIIZR4d+LiPzLg0o2HV3aeOybsUM8M
         x1qeuLTLWE95xVzJUx0XJd3VZp/1cLAQs02Dtev12EzxMOX8bq8+927CLJQl/D8LFOrT
         7XzgbISnulEdJRfehkk8bXbBSv/4MhgH1tDpFJFv8lb3Aif2m1/MNPwaUpMyoI2qbumh
         xrEGGqXOEtBp4zbvhDlcfdWZ2vCjEaf0yuHSn2+w8hmHQqIZHy7zuexaj1bVSFhSIprq
         yIFQDQqP9OxfK3kYIXjtPZ5xas1cuv2H8n3n8MZ0OJTVwffG5yth599VbAZ7rqbnDJQj
         dkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43BM1RWeXNmeeSS9PVJMPj0AxRoQfR0CMNvFedQdo6g=;
        b=DMwNPOfI7hA92F8czLb6Y5IiHsWJL9+YjtiHvaU3rOGLPG7ITITsJQ8RKGZX+0pf7Y
         VvNDq06y57pGsVMVNynTkICUQeqazTrExu9cEAa1o8asmx+jTUZDVbLMGA0tNHfNv7SS
         M9lzw6chvt3fVKUyajRkyH0dGbq8JE29spVT+a6Hbc/yGwi0mbCFD7NFjtDFQH4wVplp
         qkfYC5IO07FJN4ccd5tsYVqUUWb6tVm9QOJKig8hwuFd86poQeYH5klBoqtbLvYq0icY
         Os7XTvtie1Y0wsxlHIDS9Or8cxynwYgdGodlBRmUccRXH50qEl5sM64PK/h0x2ZnREG9
         ZIfA==
X-Gm-Message-State: AOAM531DbIUw0g6FGGk/C2ztvddMAQYGhwFX6lYefa0jI3wMPZX3rahF
        u9BbNQiouXhoImTWCJ+ekWrKLA==
X-Google-Smtp-Source: ABdhPJzfGy4O/+HA1Ao/Zzf6QlxmxboWQrb3BWm9jVakgb+joZP/bP3rf5nkvDoHQEz/Ij+2f0gS3g==
X-Received: by 2002:aca:4c08:: with SMTP id z8mr6884712oia.67.1619018154583;
        Wed, 21 Apr 2021 08:15:54 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id z25sm571624otm.34.2021.04.21.08.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 08:15:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] ataflop: potential out of bounds in do_format()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YH/7+65JruUO/wsg@mwanda>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f79a1f7-8b7c-420c-0e70-d3b5880222bf@kernel.dk>
Date:   Wed, 21 Apr 2021 09:15:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YH/7+65JruUO/wsg@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 4:18 AM, Dan Carpenter wrote:
> The function uses "type" as an array index:
> 
> 	q = unit[drive].disk[type]->queue;
> 
> Unfortunately the bounds check on "type" isn't done until later in the
> function.  Fix this by moving the bounds check to the start.

Applied this and 2/2, thanks Dan.

-- 
Jens Axboe

