Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBFB374A12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhEEVXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhEEVXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:23:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4671C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:22:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q2so2946133pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lRrs2h6PYWOQiHGqjGTK6nlAVuLIqZncxm9kgYyNI7U=;
        b=EFwj/wQrYT++/CD9E9kGtybNTBfbhmqcNUsueI1xCskY4twn3pTRh7fhm5TC/nUcsK
         3sYDQj64bvUFZsavlvxltbHZADq+f6z0uUJpJkCaccyTrrOQgtBEfh0fdFU890lj+Dcl
         cMcSALn3PmGTTmmnDXFeuVZgHXiyf05Z0wYExIIN9GkWD+Lf02SRa1QcpCkPWQRFBW3v
         mxR0FYjD7qAV59GMNxq0tXnKA5KiyQqu1PTLVFFMPlZ1RhBCC4j41l7u4neBJnr0LyEN
         0EZ04aRi8pgnTCVAxxrql/dkVDLHUg3qasXrZQr0QN0bAhqzv47h8N7JYF/PUe2mHAeD
         hrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lRrs2h6PYWOQiHGqjGTK6nlAVuLIqZncxm9kgYyNI7U=;
        b=RHvgoIJEW79b5xR5M94qEZzXLdGXu3ME3e3QnAETHpL68NdDvfCl/F15bR42V3Ku3I
         reAMHanHy+PdZk8FPGkWCdchKhqxYPL6xtYOfqHH0FWVoss/g2QwH4hhK8Y0+lpRrqrB
         NyuHJ6VRgl+dxnKbuotMdbhOxVWTZ31VKmN9ORp8WD8odNfVrrVg4BENRMGxVard1nCm
         u5AzkyYdwfU4jidOEZvLZ9bwGsYOod1NV4eHXyaLTYXEesTD+D3BKGeQN1FXWWr7ZEmj
         5LbMAb7d3A1xXpxhopWGL+ZNSoJLu26ga4UmRql3wDr+s9w586OBP+NxLWgjoIQ11sl+
         K7ag==
X-Gm-Message-State: AOAM532u3ELWC9rPJdrbeCDku8nVT/BCjv3J0bf8/DQvvjDU1XFmTNsn
        h4f2D/SdxNDZTcBvJTW8/exWqmD5tvW3KQ==
X-Google-Smtp-Source: ABdhPJz6gBU0DMtJcux8r6vyoyEetfVoV9hEhub5DJUEs5DabvHX8GzMo0qi+slbigN0kkVXdOkSvQ==
X-Received: by 2002:a62:b40b:0:b029:27f:b12e:d67e with SMTP id h11-20020a62b40b0000b029027fb12ed67emr752075pfn.51.1620249763832;
        Wed, 05 May 2021 14:22:43 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a190sm138323pfb.185.2021.05.05.14.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 14:22:43 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: add io_uring tool to IO_URING
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210505053728.3868-1-lukas.bulwahn@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b922729f-4e92-3d5c-1577-0d0a67df4104@kernel.dk>
Date:   Wed, 5 May 2021 15:22:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210505053728.3868-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/21 11:37 PM, Lukas Bulwahn wrote:
> The files in ./tools/io_uring/ are maintained by the IO_URING maintainers.
> Reflect that fact in MAINTAINERS.

Applied, thanks.

-- 
Jens Axboe

