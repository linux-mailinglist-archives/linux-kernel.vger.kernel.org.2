Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74D43D2432
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 15:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhGVMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhGVMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 08:21:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C799C061575;
        Thu, 22 Jul 2021 06:02:02 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y42so8397297lfa.3;
        Thu, 22 Jul 2021 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X+/8EuKnr0WiRa+IpLSUfHemN9HpTyH+7eqPUn1VpnU=;
        b=lAtW1yyUmUbjlAEpvTdS14iQ+ydMqKAyvcJHKxgx7gdwHhOXE2Fkkle2ZNTmrbhSqK
         1dbtiSi+g5LC4/NwCf0VFIRsfZQWJohZH6afk8QblDiNdDT32e0xgITW5aHrrugjp95b
         msUJIn8m7h2hI1n55/pPdvnKIuSRtrCjMjGFCzoyYZz5F92VlP3xzO/PHIpXnmY8VDMt
         iz1aO1OPgo4Wihy+MyIs29+aynOK+h5T57x4a8jZJleQeH2B8q23WuWfeMyDyXn0674Q
         3BD4epPsIV5xGIVrL+G1DkGSWmdL0VAT0CEbBFjzD4YEuBp2poLzPJtpPlzrNzcYO4ON
         YIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X+/8EuKnr0WiRa+IpLSUfHemN9HpTyH+7eqPUn1VpnU=;
        b=ug0MAwogIr4rBm9PCayAQvREX3wS0VxFTVrEMaEDCA1o5rzt0+zYiXkiAa9//D/5a9
         yBj7IGIr2NktMqZLBnLJeQAaDvSoMPIa/DBpgpTUS1E7ybE3JAv798KZ5iQvFva6yJWa
         7cYKTEeuCqmpa/oFk62RWKIEX3WEHWmgQkoz2yUE15r3Dz3E0dIZXj/pl2y96IGPNSz5
         WvMtv/weBU4PTV8C/Vs5B0kfOGBPVWkqQ+LTxC7KAUqfY79iIQGLQoW3OZOFJeZ3aSuD
         radcXVH+4zi5aMdGmK4F1xwtLvYpuAbEt2L+Eyt8MeyKqG6CkqIHmhCeGmN26M63myI0
         D/hQ==
X-Gm-Message-State: AOAM532K80r8uB/iMPabQtZm28GRRWa5rtTnh/kXiFxfbioJ3zeQGgJD
        3EVv3ORafIldnB7CvDHa96J8ZJgkVMFDeUfS
X-Google-Smtp-Source: ABdhPJxnCpeJOyyO6JKj921J9sX8VVlxQiv73SMI0+EZxpYS6aFP+i9rOgqV+/xH3/q0VBfioC72OQ==
X-Received: by 2002:ac2:532d:: with SMTP id f13mr29358323lfh.123.1626958920631;
        Thu, 22 Jul 2021 06:02:00 -0700 (PDT)
Received: from [0.0.0.0] ([2a00:b700:2::4:1d2])
        by smtp.gmail.com with ESMTPSA id u2sm1976863lfd.43.2021.07.22.06.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:01:59 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] docs: add traditional Chinese translation for
 kernel Documentation
To:     Hu Haowen <src.res@email.cn>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210721142537.29409-1-src.res@email.cn>
 <c41d175c-c665-dcf0-431d-cb186103b6b6@email.cn>
From:   Pan Yunwang <panyunwang849@gmail.com>
Message-ID: <3beadef1-f0a0-50af-64be-2c482fed4aa2@gmail.com>
Date:   Thu, 22 Jul 2021 21:01:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c41d175c-c665-dcf0-431d-cb186103b6b6@email.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/7/22 6:10 PM, Hu Haowen wrote:
> On 2021/7/21 下午10:25, Hu Haowen 写道:
>
>> Add traditional Chinese translation (zh_TW) for the Linux Kernel
>> documentation with a series of translated files.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
> Mr. Pan, please take a review for this work during your spare time if
> possible.


Well done, Hu!

Reviewed-by: Pan Yunwang <panyunwang849@gmail.com>


> Thx,
> Hu Haowen
>
>
