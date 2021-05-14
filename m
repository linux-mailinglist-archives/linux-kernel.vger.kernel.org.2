Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDE8380D50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhENPhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhENPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:37:40 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F53C061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:36:29 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id o9so116714ilh.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4/GUoS/s/pmKCrrW4dpmT6VyHP1dRyQUpvAxP6l+m+4=;
        b=c/J6awobOutwsD8qM65lKbpitWshdM0Z3jJuwxILQ6ZhdwOTgg7+Q4QqgKLGH09LiQ
         eYe6ECuHYExhZOU1TzMshCSmCu5Z5pVwlAvAtpfyLXNrCQNwttgPE0vvS197KKDfxZvA
         hlcp0d2PbZxB/7DNYSQC4dmNbOZzr+/+hIUGgvyYder5bqiKqyWjVH0HDtA05YAU1uvd
         EnRvJFEOUeRGGvFNRMKXVl0xdUwP9ZU8YGE4Mq9ab49QmEmSvL6Zk3RQIykZsGlSvvrr
         IJj5nwwSk+pwSYxxmSq/wtplyXwYrB8jHSGEB06BvGG2zwpQSZTxuv7/T5ZSIjDEylUs
         974w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4/GUoS/s/pmKCrrW4dpmT6VyHP1dRyQUpvAxP6l+m+4=;
        b=COiFCkSVBFGAUBKB7m8QfO1wdCFLWQmW9LREcM+CQ2uGr35vPBnYPyUHkTCXaBciKT
         epGbCgb59USGcoaJnUjjaer7HJBVxhi/cNT96Zo0TgikRDHokOG/dIBzP5QrQekkMS6A
         TNlsNfcUWU9dPifbI++Bm5y0E1y5qRdXts4hgrduA35l6bFsAYBbJksA9JCgJYEzZTb/
         ccZJlXriiOAt8pygAmK6Zn0r8Jb/2mppP5SLeVwxXD3zCEX0E42PEue+lZF+gDsjs8Qv
         yaIVcFegv5+j0ZKaERiu13lIZXKXq+ILbEttyrCHhrDLd4OoDT202F/zOvuLZ9+iFKfR
         xIiA==
X-Gm-Message-State: AOAM531ostS6V5LLDIz8t0XjrycfoWkFYIzVzny/U3cX5MadAxnpj6/N
        f3mxbQNfKNjCN47eLpQjiNoE8w==
X-Google-Smtp-Source: ABdhPJyvIbSzncjDIb1dxsq2wEqhStDkWRXqtgyPV4HOJ6yW8EigZ4R0exjw+BiFUMHrrJ7pt2CVxQ==
X-Received: by 2002:a92:d1c4:: with SMTP id u4mr30973664ilg.286.1621006588857;
        Fri, 14 May 2021 08:36:28 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n184sm2922523iod.0.2021.05.14.08.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 08:36:28 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] blk-mq: Request queue-wide tags for shared sbitmap
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com,
        kashyap.desai@broadcom.com, chenxiang66@hisilicon.com,
        yama@redhat.com, dgilbert@interlog.com
References: <1620907258-30910-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d136383-7728-e680-7d1a-71c9f180fb28@kernel.dk>
Date:   Fri, 14 May 2021 09:36:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1620907258-30910-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 6:00 AM, John Garry wrote:
> This is v3 of patch/series. I have spun off a new patch for tag allocation
> refactoring.

Applied for 5.14, thanks.

-- 
Jens Axboe

