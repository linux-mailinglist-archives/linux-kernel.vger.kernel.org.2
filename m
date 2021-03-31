Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F030F35021B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhCaOZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbhCaOZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:25:37 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20480C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:25:37 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id x16so20276080iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QKM1KBpwdWfXmEe1cOmN7X4QKIh8vDWv0b5KGq3lEcA=;
        b=xp6VypXqelyMspbzxn6Sz5PzLKJr8ewO/TG2Zjmduk//3EQm+3iK7X7Aat7tbCf2Tu
         UmDrC+d6O51VhpkSU/zSebahFMV/zctyShQI+/HFU458vIzD5WSq1PJCa37JoNV7Cqr9
         FD5v2HffyIfNROgTqtEqvhgjli9jDHOdwNLdFn+Qb5nBCf3Ps2AYuBY01feMsQWrU1mL
         eAAXcb563h9+yzA8ZN8EKE3qnjxecLJWdaHC8kNHkaT4kx7GLdniUy+h5bIh3RJSZfQr
         CFD0ZLkqHEaEIAV+H81i+RPuGfnYmY9T+WtftiAuoSbX5MLvoFp4Y/TjDpy8cp7yRuc9
         Qf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QKM1KBpwdWfXmEe1cOmN7X4QKIh8vDWv0b5KGq3lEcA=;
        b=aj1nD1ChDfgtnapF+Yj6rrHTu1XsYOgwPHUxtV5F27lnC53ST+YYYqSxe8C1/iekca
         jhO3s3MbBGJuht4+PF+4UB675YjnNJxgVj0t0jgpQBQXIHc/6q9GweyUoxv8A/wfgeup
         Z4me4o1Wptto0jTErkDik10G7nMK/QNl77KgBslJZKmYNBrZ8QO5VrMBT6qM6OHVHWf4
         yybx8Fv6PSEpmEOzrc6RBNC7wCOK9BbtjsAPEBFw9c5BNZiThGVBnvF5wWRFQlk5jYlO
         0+DmR/s/nVawUO+iVH3Fk+9GprQGiBKfbenwQbURFdXlGkM1dYimbjOsKwR8f+lb5GTi
         wMkw==
X-Gm-Message-State: AOAM533bVWvS9X2yYVpOmtwTFi5tDOW5LkcvFLi86qVVaWGQloHWFnF0
        e4+8YFDabQIJ8XQPlUfYxKRj2zpF0Ov70A==
X-Google-Smtp-Source: ABdhPJxnx0bOKy5DP8rPdxHuyc6WeTVAOcNc4pzbM4RGqOIjzCU0a01NopZ2mP7lfHVQutS5cKuTow==
X-Received: by 2002:a6b:d20e:: with SMTP id q14mr2564285iob.200.1617200736525;
        Wed, 31 Mar 2021 07:25:36 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d12sm1136898ilq.51.2021.03.31.07.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 07:25:35 -0700 (PDT)
Subject: Re: [PATCH v1] ata: ahci: Disable SXS for Hisilicon Kunpeng920
To:     luojiaxing <luojiaxing@huawei.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org, john.garry@huawei.com,
        yangxingui@huawei.com
References: <1615544676-61926-1-git-send-email-luojiaxing@huawei.com>
 <c1ef5207-96a4-e7f1-68ac-f95ab0b0f5d2@kernel.dk>
 <06094d83-2083-09ad-5948-718cfbe4579b@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fb3fbf1-dbfd-fddd-f7ad-8545584d3e59@kernel.dk>
Date:   Wed, 31 Mar 2021 08:25:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <06094d83-2083-09ad-5948-718cfbe4579b@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 5:29 AM, luojiaxing wrote:
> 
> On 2021/3/12 22:27, Jens Axboe wrote:
>> Is this controller arm exclusive?
> 
> 
> Yes, our SoC is base on ARM64 only.

Applied, thanks.

-- 
Jens Axboe

