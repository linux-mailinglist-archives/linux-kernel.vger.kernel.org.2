Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04363B2391
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 00:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFWW0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFWW0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 18:26:32 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE48C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 15:24:13 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i189so5426432ioa.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rarFiEcktOV4PMyvDV95VcjSVtUjs4RdLS31HBip5uA=;
        b=lE18ucs7drfzcX+0pjDbjf8JgBhEqOnLDKsssvstFzfaLG4LXqUhNmb23n2OZm1CLW
         5t4kdONyJzEb5dcke/lmdRBs5T3a3UFcCGh4xZMhNgx7kpgoWZVHfuuuqCSXCUlBZY9B
         X12yTjz32/pvuyfob3DXa6+5Na58NQXckEia2kAD0lyvMQGf0MWhira1HTjvFXXQLwXi
         0aAED1oC2VMRSdseHbd28orq3+1n4VoQwdfrc4qMHIe2xHBM6Fc4OwPQUV5S7osjO3Rf
         q7oJVXKbb2mDbKR2YIGLt1m/r2KmgvwX6bNJf+IQRKJd4NtGFeiGkW8jFzKrdulyZWvk
         nVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rarFiEcktOV4PMyvDV95VcjSVtUjs4RdLS31HBip5uA=;
        b=tYCLjmvGWo80APyoMdQZ3W1xo3qMf+eFX8WRoxUDZq1g9b5mdvNrvWpNcx1SzD401O
         CNl6CocZuOoaLBoOSowrZNHcVVdctypAzdJ+qXTnxFmWA3KQMTwfzmtJ0GrrQ8yAHKuD
         12DYSEhlTq+iTXeVKq/dZfQCuG0CfYxd5hndl62NniDKJPtwZdbs1HMAQzCng4wLWCyW
         Zfp6Aq0P8Dk1Tq3aNIqPdrc6pBwdG3EumsXvmdoZNK7amQXhitRf7a1eRporIDn5hgqP
         3OYx6XYmnf8F8QHBgFWouCJ+O4zMKQ6cZDOpLQoG11rUozW9Fd1jrxVOvursY8faS/iy
         rsvA==
X-Gm-Message-State: AOAM532Wwwlgnvfo6nppv2laJu5O0KRCM4TAOwpvmKlrSjmN47s5YyTS
        dbnRraGIbcjaMqc85KNb/93DDlajlkbxPg==
X-Google-Smtp-Source: ABdhPJwUZbCdMymItjEzWVPFYctd082FTIQe8OkbfvcjtyCef5RL0iJF8c+C8d4s/rDpQAyCEg8muw==
X-Received: by 2002:a05:6638:379d:: with SMTP id w29mr1727299jal.2.1624487052609;
        Wed, 23 Jun 2021 15:24:12 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id b23sm168772ior.4.2021.06.23.15.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 15:24:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Minor SQPOLL thread fix and improvement
To:     Olivier Langlois <olivier@trillion01.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1624473200.git.olivier@trillion01.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4b52e6b-2e03-58e4-8732-595c59adefbc@kernel.dk>
Date:   Wed, 23 Jun 2021 16:24:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1624473200.git.olivier@trillion01.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/21 12:50 PM, Olivier Langlois wrote:
> I have been investigated a deadlock situation in my io_uring usage where
> the SQPOLL thread was going to sleep and my user threads were waiting
> inside io_uring_enter() for completions.
> 
> https://github.com/axboe/liburing/issues/367

Applied, thanks.

-- 
Jens Axboe

