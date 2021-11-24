Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA3545CA75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhKXRCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhKXRCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:02:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5EDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 08:58:58 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so3303371pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 08:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bcwPH4IUoxYLEAvc9qYsPemmMLu4axjVofjC0wCYAEs=;
        b=31HuU+axyab1DhMZw5WtnTUehA2XT1JBW9iMQzIVTKT7O3Xw+jUylpQnUZtoJY0LoK
         Ag/T6K7Tjx3WVWXODhgN2+pMa6/xPet55YpQKMcK1tUBRXAUYP7bbreTwZvbg89D5EIy
         JnoHQD1Z2QFffgKQyjnTFjuR6bGLyQ5CoEOjbAmOFCt6nKueReyk3O94Q8zYReuO97vQ
         7Gl7Wwq+iUEIWajoacZvaH+sR90CBMSefT3hP1EEqNG3754ZXD5JzlIMTmN2YouJeMHz
         0dTRPVxkPAD/eTrZNVSZk5Te05oM1+GczEkf4sbg1TvnDWK2BZnsBFKaPNl0Dm4FZbZa
         /PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bcwPH4IUoxYLEAvc9qYsPemmMLu4axjVofjC0wCYAEs=;
        b=XxsR2TniUPDnRVvL//QM1KcdIyXAdJDXi/G5bIbWWGz5nV8i9S+6H88hdMfRuEpBuK
         L0ccujfE+gbXD00vDZHOmVWAKSUdodxZBxma6nE10eI/ewYgRLOc/BRLoTo7L44rxWvh
         8wFtJl3vTg+uu3VoQ1FzVT9612yeFLCzuAlg2HbTfD6BkOzwaRqBZymPJwzkPtLRzx+Q
         xjaQ+tI2ZqZdvQ5gGesS2Gs+IHhHN8eo72aheJb65cz9uCh5Tc+/KFBcpxoLyoJ4s1Nx
         yVOX08QKBVXukRuMj2iCn9CCY3sRWCauSjqJEGKbiLVYqskco+hxpcapY0BNVEUhRqgF
         pKvA==
X-Gm-Message-State: AOAM531//zNH/ES4D8KNSIpeczB9syL0NnqfWD1jebxzOJ7Ei812KKVJ
        a6uhFUfVrEuj8qkdipX6VjUW++Gg83ahcw==
X-Google-Smtp-Source: ABdhPJzEpalf2hzWtUEu7Y4rrBtxJjGeJfr/so43vKZ4pg4A2oCP5oLhI2IKs3bTRwsBnUne/Wao8w==
X-Received: by 2002:a17:90b:4f86:: with SMTP id qe6mr17360458pjb.224.1637773137608;
        Wed, 24 Nov 2021 08:58:57 -0800 (PST)
Received: from localhost (c-73-53-62-83.hsd1.wa.comcast.net. [73.53.62.83])
        by smtp.gmail.com with ESMTPSA id p16sm301942pfh.97.2021.11.24.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 08:58:57 -0800 (PST)
Date:   Wed, 24 Nov 2021 08:58:57 -0800 (PST)
X-Google-Original-Date: Wed, 24 Nov 2021 08:56:59 PST (-0800)
Subject:     Re: [PATCH 1/2] riscv: dts: unleashed: Add gpio card detect to mmc-spi-slot
In-Reply-To: <CAEUhbmWZL3QoS_qNe8xEPrBWm0+hLauLAhm9-Wxt2jSDntP=5Q@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        david.abdurachmanov@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, bin.meng@windriver.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bmeng.cn@gmail.com
Message-ID: <mhng-83f9d74d-b137-4e1b-91ed-580e02a20243@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jul 2021 06:40:03 PDT (-0700), bmeng.cn@gmail.com wrote:
> On Wed, Jun 16, 2021 at 3:46 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> From: Bin Meng <bin.meng@windriver.com>
>>
>> Per HiFive Unleashed schematics, the card detect signal of the
>> micro SD card is connected to gpio pin #11, which should be
>> reflected in the DT via the <gpios> property, as described in
>> Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt.
>>
>> [1] https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
>>
>> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>> ---
>>
>>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 1 +
>>  1 file changed, 1 insertion(+)
>>
>
> Ping?

Sorry I missed these, and thanks to David for pointing them out.  
They're on fixes.
