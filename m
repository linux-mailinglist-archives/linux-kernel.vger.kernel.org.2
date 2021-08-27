Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8FD3F9596
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbhH0Hxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244501AbhH0Hxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:53:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1E2C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:53:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l2so4504982lfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CNvP38919NyhYWdPvANs9XQ0JxJiZcSEJqLPjWrVUWQ=;
        b=Tnv3DVrGcNckVz8XtZvqs/b8pmFGa9HRRpLAMqh7XMTxrziE6rO4GPMZuHmewSXng9
         r4mQTizQtjXRP57vTO/4UXAZsSK1SZ2hZ68zr67uYLT/Ti+WljX2j8GCv3LCprmPjwd+
         TQurj9cW3LEI0QpQZwZAI9rH4osDX6Qpc2DSka8QLONBq7nSlwiBs1Sre4MVlA48yhMp
         8Gy7FFJunEeoJp4oNTFRnbcTKuWHa4pv5sh/9gF4awqU1ZaKTlvyV+o00mjaDqmaCo8Z
         RXyEYEelzlYv8f8MPyE4NLVs3EQ+q2GZNPt5J/TL6oh/Jc01TZpCci9ktm9+Wd5qrrYS
         cQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CNvP38919NyhYWdPvANs9XQ0JxJiZcSEJqLPjWrVUWQ=;
        b=sp2kEG0ZqqjYb9ksca6BvsnsK+eXj/5jDYteLhB5cJgD70WbCHS0dMjT9xzXtOPcAC
         iXS2lvB6jvKoJNPeznWPhtFazaGXfKKvAThXjnSpq4Gh2FDtKrtrZZHbYPImB0MYcLZ2
         J3g6E8uAkSPzpuRDO6Zb+agRHODHh7QCroY0ZEQeVBPzRHBLFpigwFWZ2PA4sS9FP2Pg
         X38jxX8Hd4SzKxI/0q1jbN0arRJFHChr7b3qMOFW0007kFyFviG3FNHcjNDPFs7igp0z
         iccXgbZ4y2uHWyj51jCwWEPzkWjqlyAN8rI317NidxSsAe/L5NhSFQn1NAbebsCL3ihD
         L1fA==
X-Gm-Message-State: AOAM530bFk2PVgJzzR0Kr2I4uyYcd1qs6I9d5Qm04LhZbcU75a3mJOUq
        66G57zitfgo82f3Xl+stVf/4vuavUgA=
X-Google-Smtp-Source: ABdhPJx9tOaBiX7tYrgwNmZO9SllbNtR/3bB3XSzcJcW0qweu9tw9NUbf0G9doOjqIDTLFeRVXHlHg==
X-Received: by 2002:a05:6512:96b:: with SMTP id v11mr5816665lft.121.1630050781849;
        Fri, 27 Aug 2021 00:53:01 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id m16sm521307lfh.243.2021.08.27.00.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 00:53:01 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] staging: r8188eu: avoid uninit value bugs
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <CAA=Fs0=gX66TW3qoHYWcoSsvai6YZn=U81a34V45oij7NrMJrQ@mail.gmail.com>
 <cover.1629789580.git.paskripkin@gmail.com>
 <20210827074932.2qkpvmakwqqxo6hc@kari-VirtualBox>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <ae721297-68ae-dde6-d9e5-5963ebcece07@gmail.com>
Date:   Fri, 27 Aug 2021 10:52:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827074932.2qkpvmakwqqxo6hc@kari-VirtualBox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 10:49 AM, Kari Argillander wrote:
> On Tue, Aug 24, 2021 at 10:25:45AM +0300, Pavel Skripkin wrote:
>> Hi, Greg, Larry and Phillip!
>> 
>> I noticed, that new staging driver was added like 3 weeks ago and I decided
>> to look at the code, because drivers in staging directory are always buggy.
>> 
>> The first thing I noticed is *no one* was checking read operations result, but
>> it can fail and driver may start writing random stack values into registers. It
>> can cause driver misbehavior or device misbehavior.
>> 
>> To avoid this type of bugs, i've changed rtw_read* API. Now all rtw_read
>> funtions return an error, when something went wrong with usb transfer.
>> 
>> It helps callers to break/return earlier and don't write random values to
>> registers or to rely on random values.
>> 
>> 
>> v2 -> v3:
> 
> Hi Pavel.
> 
> If v4 is needed can you please send it without replying to old message.
> This thread is so hard to follow because always new version is answer to
> old subject. This depens a little bit how you setup your email, but some
> of us is grouping all emails in same thread and this thread is out of
> control :D
> 

Hi, Kari!

v4 will be posted soon, yep. I will post v4 as separate thread :) It's 
unreal to follow the discussion for sure. I often spend about a minute 
to find an actual mail to reply xd




With regards,
Pavel Skripkin
