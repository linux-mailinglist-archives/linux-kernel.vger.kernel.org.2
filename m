Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0E8401F43
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbhIFRlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbhIFRlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:41:00 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B96C061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:39:55 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s11so7416603pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wjvFTYIOQu5JpnWulQor+MKslL15Jby4pzZwJkGRjYk=;
        b=JsMvTblEw7sRMqIVdz9109X4ygsnO2pqxmvofkl60pfIbKVrI/G8YT0ebKbOSXa4zI
         RHek3D9Oh4VDShtwiUDl21JWlZTHtip84VS0NVCILTxKDKey7+2LoKjeN4Ys9VM7tPPu
         3g2k34tVKkulSjkDP8kaOhxBIi9Spy1vL3eHE6OPl9EVrRd1g01rGQLf/Mgq7cJf9EJ1
         r2S3a1bEa89RCQXWllSDYBm6QcwbL7/E+j/RtYKt21Nc1qAF6vlR2GHDBnXwI+I0Pqid
         9EH6UhH3LSBbxl77HDlZIYTedt6vQgGdqz1oXksQVhDU0HMxs40lFErV5qLf9iusJXJ8
         RWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wjvFTYIOQu5JpnWulQor+MKslL15Jby4pzZwJkGRjYk=;
        b=GXnYssWrJ1hPPHfFyKfAvw1FL95B1RIKq7O4rZvCa2AdhXWVDQEko7qF/EtbCBZCM+
         AdvXSqSFhPQf3SpDo+y5cFjCDAmVBIYQcP7C0RyAYjZDjV/7HDIUOERMdbD/kSoehsLv
         dEBLPs0ykz1edNBkSw+pFe2SavRz/Qj728a/8QKMhMmnsGJg5CwyutuQQ3AhmC3qjQB7
         gj+uRbqroP1fsgGIkRjxlysxcifVbx+a2uB2Ntq04jysTQNSk2uoxX6w6xVWKbyrihkq
         XWZBcpdHAoL0HhcNJIyVOYJVyqFasaqzLm0qsiUXSRRchXy2TKp5JMg21ttKNbsVzV6t
         OViA==
X-Gm-Message-State: AOAM533/Fbi3OTCbtFjw0Fgf2GW48u/+ZPIQbBlEeTpQnjO+pIX8Gy3k
        Utun1ExYC2j8cNiHl3pGg7qqCt7KLaFyYg==
X-Google-Smtp-Source: ABdhPJy7yCgToYkUtil623uPqlk6pPPmH8NpPm+QQvyPW9eOJSorqbgU1RfIklWKfoPsII/RU/oXWg==
X-Received: by 2002:a62:8305:0:b0:3f6:72a:92ee with SMTP id h5-20020a628305000000b003f6072a92eemr12724485pfe.19.1630949994992;
        Mon, 06 Sep 2021 10:39:54 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id h127sm8198084pfe.191.2021.09.06.10.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 10:39:54 -0700 (PDT)
Subject: Re: [PATCH] block: include dd_queued{,_show} into proper BLK_DEBUG_FS
 guard
To:     Julio Faracco <jfaracco@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210906163831.263809-1-jfaracco@redhat.com>
 <56e17907-83d7-7b45-8b0f-5d80d9005c70@kernel.dk>
 <CAHtYXivVcodcR5b2aYnFvhgAJ7yEr0+jYzPZ+w-JxRRzuWJyfA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55ccc07f-154e-a1b4-31c5-dd99c8e7d09d@kernel.dk>
Date:   Mon, 6 Sep 2021 11:39:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHtYXivVcodcR5b2aYnFvhgAJ7yEr0+jYzPZ+w-JxRRzuWJyfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 11:36 AM, Julio Faracco wrote:
> Thanks Jens.
> 
> On Mon, Sep 6, 2021 at 1:44 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/6/21 10:38 AM, Julio Faracco wrote:
>>> This commit fixes a compilation issue to an unused function if
>>> BLK_DEBUG_FS setting is not enabled. This usually happens in tiny
>>> kernels with several debug options disabled. For further details,
>>> see the message below:
>>>
>>> ../block/mq-deadline.c:274:12: error: ‘dd_queued’ defined but not used [-Werror=unused-function]
>>>   274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>>>       |            ^~~~~~~~~
>>> cc1: all warnings being treated as errors
>>
>> This is like the 10th one of these... The patch has been queued up for
>> about a week, if you check linux-next or the block tree. It's going
>> upstream soon, in fact it was already sent in yesterday.
> 
> I noticed after seeing the same patch earlier this morning, but it was
> too late to undo.
> Discard my patch, pls.

No worries - fwiw, the fix is upstream now.

-- 
Jens Axboe

