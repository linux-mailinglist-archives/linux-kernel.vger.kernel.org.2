Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3951A40760F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 12:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhIKKZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 06:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhIKKZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 06:25:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC3AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 03:24:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b6so6367296wrh.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YqGDZZMJKPugLbHU1Z+KSXD5nBkqoBERs7vHAT2/hzo=;
        b=Q3l5j9tTDRzH0acAC7NMkA87vTfP4ro0ABYJMQakGilztDnr3CkxusgQKX7HvQNAXT
         DVza84wZe+jYqKzSiq0mU+89Q0RbjbmGKF5Y5iOtRqMeJ0KeGimOUI3oZb0JKyNWa1Q2
         rMWintNWJy243GdKTPUdn5PykLQqmvGqB3RgP5ar0wqlqTm9iLH0wa8D3uE0227MTDdj
         DGvDGamsp+WH9QzV7HweU+X3u+K1hk6yRX4S42LExH3rnE6qvs5k23wZJRlp7q4/YsNq
         Es6YtM0pc/0s20yv5ITHqCFwZ08O79zHLaDlWVueM/s8YN+jaQ1d9wP4f3hvtIMgiem5
         PqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YqGDZZMJKPugLbHU1Z+KSXD5nBkqoBERs7vHAT2/hzo=;
        b=Egcos64J7fJkwVWeKhcs8HGDPouPvuZwVu28Z3E1Db4X+CRj47bxJ8PTNU+kY++HLt
         6iasGQ6owScksSp5Hix5br6+J6ao4kRsDcKdhao4AH4LqiLCXWDke8kYiVAoWAiWvIWB
         +Tov+C+VisAkhFv1I0UxPy1GWdF3HrEgV1fRolilES3rqNW0cIGU0FJhHKJVygrkTrFo
         SO0D4RYSuPY4qZvC723VRXKzwo4TklmZHn7m3RfIY0Cq8FknPiju3lLXGW4arYbdrI9n
         CCvLkVZxlwfyinQVbuSe+GhPeOf0apEAn34JtVFGxqEYq7HBL3s7EaxzVfio73K6To7H
         de4A==
X-Gm-Message-State: AOAM5338p3wUabRQE3dr6i7g40N2RjwoRLDi5okV2nWb0thMddrnj4er
        WcQnmxaUVNV6goOY7FSL26UuEBliBFlBNw==
X-Google-Smtp-Source: ABdhPJyWawzrPoeggbJueCiuR65y3mZN0kFClQFojNFf0Y5ecIXX1lCT5YBC2k4SQ3hHh7qDvMGKPQ==
X-Received: by 2002:adf:ee49:: with SMTP id w9mr2476358wro.158.1631355850945;
        Sat, 11 Sep 2021 03:24:10 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::8fe1? ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id u2sm1213238wmj.29.2021.09.11.03.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 03:24:10 -0700 (PDT)
Message-ID: <296aa357-1bba-4136-c651-a18d04c8d32a@gmail.com>
Date:   Sat, 11 Sep 2021 12:24:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 0/7] remove pointers from struct hal_ops
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210910205033.3778-1-straube.linux@gmail.com>
 <1858319.rr7sHpn3up@localhost.localdomain>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <1858319.rr7sHpn3up@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/21 11:38, Fabio M. De Francesco wrote:
> On Friday, September 10, 2021 10:50:26 PM CEST Michael Straube wrote:
>> This series removes some more pointers from struct hal_ops and
>> removes the function rtl8188e_set_hal_ops() that is empty after
>> the removals.
>>
>> Michael Straube (7):
>>    staging: r8188eu: remove mgnt_xmit from struct hal_ops
>>    staging: r8188eu: remove hal_xmit from struct hal_ops
>>    staging: r8188eu: remove read_bbreg from struct hal_ops
>>    staging: r8188eu: remove write_bbreg from struct hal_ops
>>    staging: r8188eu: remove read_rfreg from struct hal_ops
>>    staging: r8188eu: remove write_rfreg from struct hal_ops
>>    staging: r8188eu: remove rtl8188e_set_hal_ops()
>>
> 
> Hi Michael,
> 
> This series is good.
> 
> Furthermore, I compiled the whole series with gcc version 11.2.1 2020816
> [revision 056e324ce46a7924b5cf10f61010cf9dd2ca10e9] (SUSE Linux) one
> patch at a time. There are no errors or warnings at any time in any of the
> seven builds.
> 
> But, unfortunately, I have no time to test. So the whole series is...
> 
> Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Thanks,
> 
> Fabio
> 

Hi Fabio,

thank you for the review. I have tested it on x86_64 with
Inter-Tech DMG-02 connected to a CCMP network without any
issues.

Perhaps I should have mentioned that in the cover letter. ;)

Thanks,

Michael

