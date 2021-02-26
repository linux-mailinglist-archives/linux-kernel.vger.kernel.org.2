Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A17326A40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBZWv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBZWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:51:18 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C616FC061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:50:37 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id x9so6263391otp.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FVaorLf6cYpgwAX1Zd+PAdGIFbAbkDLp5X5cbNNtpWI=;
        b=d+4DXdNi3Hsf1qtaCslXgCnjYIRyaDj8f8bfyqMMcqVJbpzwWO09DmL46UwpdtZrjJ
         vcMov54SHAgxr2pMUT7pNRPLf9LT6hVWeCjlE3DJGEkOUgVLsLQ0SP+hdAOhy7M+xAfW
         THkJAqyMf7xPoBkpiM4msxG/kbe+4b/eToH4MbYYFMqe1L2jOL2VLLU4GdyLytwdt/hu
         4riO33xmrmts6mZL91cgEy4lKDN28cLKiK50M7H5I6X902Bf0JYk4O2nmylmQHjOTIfo
         UQaBHH15nGuSDwPf1rrfHfSd9hEHLRjj1AIe0Lr1b8/LRU4I238+07wZLNOsoV6TKEsm
         veSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FVaorLf6cYpgwAX1Zd+PAdGIFbAbkDLp5X5cbNNtpWI=;
        b=ihVik1n3gnpC2SCA+LgAM3+gyLgsQ3Mf+/S0H8o/xCqowQ7c+uwN7n2//h+eFPReqB
         596qQ+SX7xqeRN3y5rMoI8KxKVAZUjEnLH5jzO/ToaA2amSJj0Nj3RHfM3Q/6+xQSe/L
         rheaKqLpiMNX8EEQ9bA4RHDBR7Jw2iFao7KERxNR0XbRohXLIdFeCznKJQVMg1tmZ9vd
         XL0UHvuRnKpQ3JQVUYexP9gvxWF/dmuUn+WWrWUmOiIXOTc5QTWdCTJsSv9oP4H3vg5R
         X8jYugA+NMjL5rN9NCFDIhImhOP4JrTNwVMVNPZhZW31J8HojnP2PJkKiU1n7MMj/mg0
         +UQQ==
X-Gm-Message-State: AOAM533eW7XYdLG9aZKHsbcFZvkL06S6TFbxJ56Vvy59EC+N5V1NzuEB
        mzFTvUOnovF2NWyi1nTSxHsy5Q==
X-Google-Smtp-Source: ABdhPJxkfATb74vHEI7DysbxiEX6T4pY/s82kdocO+CCdgFkE47lbzUNeVp/UlhM7T2U92yE9ArjiA==
X-Received: by 2002:a9d:2945:: with SMTP id d63mr4076467otb.70.1614379837232;
        Fri, 26 Feb 2021 14:50:37 -0800 (PST)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id r205sm1949094oib.15.2021.02.26.14.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 14:50:36 -0800 (PST)
Subject: Re: [PATCH v2] block: Add bio_max_segs
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210129043857.2236940-1-willy@infradead.org>
 <20210226203819.GH2723601@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <307e1cef-0932-b7f2-4d65-42983e3e0d1b@kernel.dk>
Date:   Fri, 26 Feb 2021 15:50:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226203819.GH2723601@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/21 1:38 PM, Matthew Wilcox wrote:
> 
> This seems to have missed the merge window ;-(

It ain't over yet, and I haven't shipped my final bits for 5.12 for
block yet... I'll queue it up.

-- 
Jens Axboe

