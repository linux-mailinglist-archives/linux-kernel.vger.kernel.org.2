Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6AB32DD51
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 23:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhCDWrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 17:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCDWrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 17:47:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CF0C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 14:47:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c16so158373ply.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 14:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HFfwnn5BGnj6lZefXJEkfr7vPyB8Dkp7abcc6SdDlYI=;
        b=WgxwJExOIn6eugkg/pZg+incPPZLBJfb/Y4pa/OhsUMLDZHd1D+EwBni/AtbCojRru
         GuuG7p/7zBe4ca6nbwEYrVyldVy7osuitSlS4KILQwAqaxZusYVd3t60YBq4LYt648tn
         NhJyzg6cQepWy0fvSqk0KthugasTCgRlARJHTgKQahxIED6Qhwt1yqHtfjFSc95ZdJWb
         ZKf2mx4+Y+UKYUbl7Eg7VQz9jF2DIO0W5ivroSbeDqKdFXcWIHLbpAPAhyVDMFk1NApK
         0mEOkwMi/cr3MmdqIabQcVW9NQQcONF0c1WibKnTt1ZepYaem8jW3ST5SqXvhuWbsz1r
         PzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HFfwnn5BGnj6lZefXJEkfr7vPyB8Dkp7abcc6SdDlYI=;
        b=RKSIXOARO5affFPY5guEGK63WR5XKxg7ihWNt9wdfX/h+QIgy+xA1lGSz2RXbv9sBP
         qYUBkC0SadNsDFNz4OlFihsC6zG9VkRnSYSsF3fCmvDn2nCZQVnA8+pcuCBjsW1MAR9I
         5o0YEWlVXRfA/KCB6Sqe7AA31cI+TPrWz1F1gtwAxxMND426LGrr3ZUtQUow9176657e
         a6MH/WbMS82eSD3jBYB9srDMihSjDomK6FoG+897KqjsSZMAkH8NKANK+Ciom5A/PKjh
         BkO9aE1X13xIkj/kpYerkg0sircZ2sIUrUX4ouq4hdVhtK1jVkGCrq2lmJUJo9yqQEQU
         I/fA==
X-Gm-Message-State: AOAM533xx3gxrEBMGHyk4KZW8xvZ2Efg/CtgmMpGzGteSmmuWwy3FDUS
        ySfYuyt/U0M6h/1HfH/6CN0EuQ==
X-Google-Smtp-Source: ABdhPJxSrdbS7FGzExZA10eJ89/F7b1iiJEmvNOWpbxQyL7eUbONZgemK7U2guCsf+5XFa8SXZegUw==
X-Received: by 2002:a17:902:7887:b029:e3:8ef0:9a9d with SMTP id q7-20020a1709027887b02900e38ef09a9dmr6023162pll.2.1614898041454;
        Thu, 04 Mar 2021 14:47:21 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b17sm371469pfp.136.2021.03.04.14.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 14:47:20 -0800 (PST)
Subject: Re: linux-next: Signed-off-by missing for commits in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210305081954.2cfe52b5@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <14a25035-02ee-aa0f-5bc3-6b791e5e9aac@kernel.dk>
Date:   Thu, 4 Mar 2021 15:47:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305081954.2cfe52b5@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/21 2:19 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   1b40fa66ac2b ("io_uring: reliably cancel linked timeouts")
>   42699d33e969 ("io_uring: cancel-match based on flags")
> 
> are missing a Signed-off-by from their committer.

Fixed up, thanks.

-- 
Jens Axboe

