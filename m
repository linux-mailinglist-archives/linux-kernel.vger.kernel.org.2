Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67783C59C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351463AbhGLJH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354126AbhGLIcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:32:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36C7C061787;
        Mon, 12 Jul 2021 01:29:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso1182689pjj.2;
        Mon, 12 Jul 2021 01:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=53AxaG4tWABZBbJg99NxUsd0zCLnow37/ltA2An2gfE=;
        b=X6NoiOpnCB6DO60lVY3/HVL1mTycidMikYuz5wMEvAI3Fm6vPrRcg0dUMqpS7YZzd2
         wMT/f7BJo0b5P/ujHsufa9xjaCI5qVGB/Bk+dI3rsktV25dGZdykCKGmjC78cI/L+aMO
         TtyfFoCdd3X1ezKyyhpCfNGdWCohe12hpmLVT4DVWtAEjsOPJEyiDkE7xGU5yocVFcyC
         zsQVXZVdqPT1MUvk1EYtEtTG81A3mc7sC5Fchpa/lW2kEI49XMsCtwpKjBr98SR/egNZ
         zyqyZ+WLjeL0Tvn8dXmrYO8InVkmSDF6wwuTj1djMf4qvOCISiL9JmCgzPrbcUiwf2Yr
         72cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=53AxaG4tWABZBbJg99NxUsd0zCLnow37/ltA2An2gfE=;
        b=RdM26UjmB0QxqkIV0I+EE2OGFSDdODf0BeI2VgVvfJsFqiuVCIXHn2NNMMJzE7Ll91
         psW3WIPvYgeX/+iHATS/9iFhFnicltAtGC4gAqTj7eg+PPU6yUt+ej0pax6zOkU29v+K
         6CP+sBu2DpgLvMaoQRXBvDQCYzdH72dBO8cv3HJ/1EyqnFvLjvsB//XYmyOC5osXXQ0p
         O+A75eEhlWG2G1qp7zfn3QWCZsYarqgTc1h6g8Q9Zz1/zWCUKT/0YPhUcuLZaHB/tl/U
         b/V7ZQD+bbRu4odrY39NGVcijNWcN4epIlLVzjw0ZJxVtqb6soHNPnlyLnySMaceyH0Z
         GvSg==
X-Gm-Message-State: AOAM530eeXMQ5QIEjc+mWOVNf7zAu4UrswqdXPA5p27EesdSZ+vsGLEv
        PGhliVY8SKJYtB97lvXwdg0=
X-Google-Smtp-Source: ABdhPJz1fRXGatPhJ05EB+Y18kO9d9DI2Ly3Gpzh15FfCPXHpDxqTajhrCx4zKFIMhU5lGHlgrPgiQ==
X-Received: by 2002:a17:90a:4cc4:: with SMTP id k62mr2427581pjh.110.1626078560408;
        Mon, 12 Jul 2021 01:29:20 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id k5sm14671775pfu.202.2021.07.12.01.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 01:29:20 -0700 (PDT)
Subject: Re: [syzbot] possible deadlock in loop_add
To:     Christoph Hellwig <hch@lst.de>, Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+118992efda475c16dfb0@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <000000000000ec01e405c6c2cee3@google.com>
 <20210710131638.605-1-hdanton@sina.com> <20210712052740.GA8599@lst.de>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <c3d4ebd5-5679-cd81-d1de-4f5f2cbe13db@gmail.com>
Date:   Mon, 12 Jul 2021 16:29:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712052740.GA8599@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 1:27 pm, Christoph Hellwig wrote:
> On Sat, Jul 10, 2021 at 09:16:38PM +0800, Hillf Danton wrote:
>> To break the lock chain, un/register blkdev without mtd_table_mutex held.
> 
> Yes, Desmond Cheong Zhi Xi sent pretty much the same patch on June 18th
> (mtd: break circular locks in register_mtd_blktrans), but it did not get
> picked up.
> 

I believe Miqu�l was waiting for -rc1 to apply it.

But taking a closer look, although the fix for the register path is the 
same, Hillf Danton's proposed patch additionally avoids inverting the 
lock hierarchy on the unregister path. So I believe this new patch 
should be more robust.

Best wishes,
Desmond
