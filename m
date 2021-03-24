Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98125348461
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbhCXWLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbhCXWLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:11:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837C6C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:11:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u20so531463lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qX9o2hvoRyMVUxmDZLUfZ3N0XzXTN7SFV6pvPTRCdsU=;
        b=OVYkcI1iI742KrXVrhj78jS101TiO9qWsd/hpwHAGPC9saJrAywf7EaZab1wF7s6bT
         3TmkflFEOYFeA6vVVZG6/cPoHB7/3MZVp4AOhOHdXzih/mGJTbDSxJFdEIsThPQBGNE3
         /SJge1eLBE74MZkhsmxLxQN4Kz3mJp3iG6LxZgQ+spE3JhPL7WGjeUEP9iQnHwSZ3LPV
         sNY3KpqzS2J0ZtwQZRO2X2O+1WcvKRNrnGNTEtk09Wvje+h5o/SWoQYubgObN3HoRjeB
         VCmwygRH6SGjg3JFN454djx4tnfFhXy7neLqBmwLDft2r7ZRRxAAul4AHfvFVpYq5Ahc
         DULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qX9o2hvoRyMVUxmDZLUfZ3N0XzXTN7SFV6pvPTRCdsU=;
        b=hnj6j2TQ6dABhjB9+qXddXRO0uZtMoP9pTJFnduNwMcZrvFoVL4tIlVZY4hGGCOL48
         q0qJAGROfAQ05w+aL97K9v22T2MVhXQzgA5kIHZhzv2tvbdA+vltGFBNVnlbExMO5E9e
         CJnxk4vsNNBsjq7yGn9e8Rc4+q/ODdvSeg0vn3NprwenydvdV2+1tg2HnogoISZzYxIV
         MVlzaF6zsPvgNN+IRx67xrDC26XFwe01g0lDezOoA+o3vGEf/b32fiPz4QPn+Mzl0l6H
         NLd9xlODLxYTsZjPEsbyXg7Z/UyLAg0Iwz6RKCOpNlgJvK5bAC4rEWZ6rfmU603lZ+8q
         02sg==
X-Gm-Message-State: AOAM530FG261+xp2nw6o/nwFoUn1LrkrKDmJLdJShYaTdfADnaQThdtJ
        BQQ98edQsF6by81DoIGMbuQ=
X-Google-Smtp-Source: ABdhPJwPAKWvfo7wyowkU1IH/y/ZqVNIGhoc7BRI/IMkwQ1gAfFteOljTxSH2yDifNWU/gNRzqc64Q==
X-Received: by 2002:a2e:9002:: with SMTP id h2mr3534838ljg.145.1616623866941;
        Wed, 24 Mar 2021 15:11:06 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id q26sm346138lfm.53.2021.03.24.15.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:11:06 -0700 (PDT)
Subject: Re: [PATCH v7] mm: cma: support sysfs
To:     John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        willy@infradead.org, Colin Ian King <colin.king@canonical.com>
References: <20210324205503.2132082-1-minchan@kernel.org>
 <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
 <0ac4d495-eece-fb71-d334-a46e069b0c35@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0396987d-1331-51a0-83f4-0c49dd3e150c@gmail.com>
Date:   Thu, 25 Mar 2021 01:11:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0ac4d495-eece-fb71-d334-a46e069b0c35@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.03.2021 01:01, John Hubbard пишет:
> On 3/24/21 2:31 PM, Dmitry Osipenko wrote:
>> ...
>>> +#include <linux/kobject.h>
>>> +
>>> +struct cma_kobject {
>>> +    struct cma *cma;
>>> +    struct kobject kobj;
>>
>> If you'll place the kobj as the first member of the struct, then
>> container_of will be a no-op.
>>
> 
> However, *this does not matter*. Let's not get carried away. If
> container_of() ends up as a compile-time addition of +8, instead
> of +0, there is not going to be a visible effect in the world.
> Or do you have some perf data to the contrary?
> 
> Sometimes these kinds of things matter. But other times, they are
> just pointless to fret about, and this is once such case.

Performance is out of question here, my main point is about maintaining
a good coding style. Otherwise there is no point in not embedding kobj
into cma struct as well, IMO.
