Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7280330527E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbhA0DQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbhAZUQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:16:31 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A1CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:15:51 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n25so12206487pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=06+ubIgKMIeLEqYAAy1hLMJ9omPIgHFObEcRyFWsADI=;
        b=Utr+B5OAzdKhhz5EGabcKcobLEE6Jc49WHmq9EekPmZkliRbYSCmycJJ4k/3972jS/
         mtzxx518O4DPgHlhiSq6Lod24kJISggu6C9sFHaxoAzU1kZGJ+6cVDCznE2V8h56MmwW
         VxA58fMR8VR9AIsOkwvLgn5SLJPxJcFD1zwAB0toQTE0UCXyE+9ZtmyMkncYlwmiF8rM
         w5fcwy01eV4TIcTMCgSUW65SlALAHm8iJWfSBOKxwAllByh4hgccYiCs3UOp4KbHAATH
         lVPryd4G/JWFjMnWzQhsBS65H35+BcA2YEMH5rdFchoMTCrM+jFABYJu2UG3ESCRGiZh
         6Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=06+ubIgKMIeLEqYAAy1hLMJ9omPIgHFObEcRyFWsADI=;
        b=qNakp9t/UasSCvThFxitrSiCp8+Vc54UI/3L32Zfn3c8+NYw4d+c62E9OaCsisGWBs
         1ZGBDLiXkVtglXZi7j27qkY/s59sn0pxMHmALUlbbhGOz7lB/oQZ+4RxHXjPqBfCGLm3
         eVrdjCqJFpqH9oHg6JdbdiOeb5uyCviLbJWxZiYDevrvd8D8NpVCCZ7Cesnxadt8mTh7
         rVMknrwc689GBfMLIuHeiBvS864o44Fs7bxMOguHhjLhiEamU6zmKnxWZo0JUhjjNuYu
         elAgb09hUG2KuxfFyrLzzFDmV3AXCexs/skoyqEkQhiUD0M/32tHk4qpVfcfoJvkjq7M
         YoNA==
X-Gm-Message-State: AOAM531LsuwpsQoBMDESb/6OYjE5JkhRGv4NPVY8JyAVwFhbqSkYh2lf
        6IAVKLLnm6DhKXaa1Nmx/KnGfi/YTeZlMg==
X-Google-Smtp-Source: ABdhPJx/1yUxPh2gfLhOqBFgIvxnIWgvc5XMNUWEeCV8wEDO4gdFudTA2m4bCmTT0WPGjuYhDK1NiQ==
X-Received: by 2002:a63:171d:: with SMTP id x29mr7237046pgl.168.1611692150816;
        Tue, 26 Jan 2021 12:15:50 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id z6sm8474406pfr.133.2021.01.26.12.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:15:50 -0800 (PST)
Subject: Re: [PATCH] rsxx: remove redundant NULL check
To:     Yang Li <abaci-bugfix@linux.alibaba.com>, josh.h.morris@us.ibm.com
Cc:     pjk1939@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1611222202-114248-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f70a87c9-8319-45cb-b105-296bbdbe3115@kernel.dk>
Date:   Tue, 26 Jan 2021 13:15:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611222202-114248-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 2:43 AM, Yang Li wrote:
> Fix below warnings reported by coccicheck:
> ./drivers/block/rsxx/dma.c:948:3-8: WARNING: NULL check
> before some freeing functions is not needed.

Applied, thanks.

-- 
Jens Axboe

