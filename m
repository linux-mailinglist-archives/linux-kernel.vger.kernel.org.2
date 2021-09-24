Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01499417574
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345318AbhIXNYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:24:00 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37204
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346095AbhIXNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:23:48 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EABE840192
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632489729;
        bh=Mg2O9eM4FPNUQ8524p/AvYAdfivT/+F7MZSftO3MHYE=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=gjPmCI7yLRT0flSO5TCOfzQHBzvNBi6ZCTQDOHTJDIgh6qv+1cajmSALwmOFhFKsl
         bD2HU6u0oQ4i4tMBM+LdFAKafNm1a1P2+L8lYO0c4GphFEfViNLgAYLkReT8D2sjNY
         urS4nBjHmevAH8k76kobH79KOMT4+Oo8LZCqDc3Hci12dnoOZkXNazok6hiefNiNhj
         F10wUqDF86Qz2WFgj6C4OgRPLy5VCP7GOaMFFZX0ckBo6Yhk43GmC6Q5xGb1LZGTkB
         Uo695Xvc5winu/bavMXNc2uJW0FLWw5uiOtoGZjKRxDH0Gplc6G0E7JUgWzslUnLHQ
         qUI4rb+Tb+TMQ==
Received: by mail-pl1-f200.google.com with SMTP id m5-20020a170902bb8500b0013a2b785187so3086814pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mg2O9eM4FPNUQ8524p/AvYAdfivT/+F7MZSftO3MHYE=;
        b=wTt06YtQlreb2P1LM0pLxFMEMQ1z/86HK1E60rMMxCxDSNLIYlQ58WsnBG1aJIM3kA
         FJA00RzhVxB+7kRS8fZSlBAj5NoRoo3lr3U2VN9ju/djhBU4SHFJkvB3IQ3kqPd0WDrP
         YbHQ1h6PDwpKlmdR+BLZJNRdap4Y0ZOwMCCDzAvxYulTb+n5clcva1JGaHMtvr5zUI4y
         aef0BifiNU6Il9kF8IK/QtLacCs+kLnCLQEhmtfw4FbLWlKkOwio0c9B/c4UawK5GaJL
         t2MpS902kKsAA61dTRiOjgF0IJqvT+NoQIqIs86MjI7K/VbNN7Hvj+Qwin4NO9mHvfQA
         cEpA==
X-Gm-Message-State: AOAM533YLMLxGj+KteVnk7mcVL/2xuCVCwKP2HLmk/WA99GCCcQCAM0Y
        1hsIOg21UUB7NaXRZO9pPKB9JnK8ml9r5STYEdFzmns8XAci5dzo0z0TggxPZUEXIW+vbZR7lJP
        AWGeYbXbwE3QHTZF+DzWZTAM6HRAg2//9HYldEfCN8A==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr2834107pgm.312.1632489728398;
        Fri, 24 Sep 2021 06:22:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrsbemDf6YEETOobTzWrqVFIfJ4YqeBUKhDDr4LxllywoUDi/h1Sln0LKHMV+8uFyB1KEvtQ==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr2834093pgm.312.1632489728147;
        Fri, 24 Sep 2021 06:22:08 -0700 (PDT)
Received: from [192.168.1.124] ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id 11sm8627885pfl.41.2021.09.24.06.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 06:22:07 -0700 (PDT)
Subject: Re: Boot opens CD tray
To:     linux-kernel@vger.kernel.org, Ken <kennethcelander@gmail.com>
References: <bbb0df1d-1e40-fbdf-d9aa-281ba77b4b6d@gmail.com>
 <20210923123407.GA19709@1wt.eu>
 <3e2fe30b-4c58-3164-2e2f-283f34ebe396@gmail.com>
 <20210923130909.GB19709@1wt.eu>
From:   Tim Gardner <tim.gardner@canonical.com>
Message-ID: <cbe5d19b-745d-c795-afa9-e568afa93efe@canonical.com>
Date:   Fri, 24 Sep 2021 07:22:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923130909.GB19709@1wt.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/21 7:09 AM, Willy Tarreau wrote:
> On Thu, Sep 23, 2021 at 08:03:49AM -0500, Ken wrote:
>> The CD/DVD is a SATA ASUS; connected to a ASRock 970A-G/3.1 motherboard.
>>
>> The changed "driver" has to be in the kernel, if it changed.
> 
> Sure but I mean that it will help narrow the problem to some subsystems.
> Unfortunately we don't know what patches your distro kernel applied between
> the two versions, but if you can figure that out from their changelogs, it
> may help you narrow this down to just a few patches. These ones would
> typically have "ata" in their subject line (sometimes "sata" or "libata"),
> that could significantly limit the number of possible candidates. If you
> can't find this there, you'll have two possibilities left:
>    - either retry with an official kernel from kernel.org
>    - or report a bug to your distro
> 
> Willy
> 

It appears to be the result of a stable update that has already been 
corrected: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1942299

rtg
-----------
Tim Gardner
Canonical, Inc
