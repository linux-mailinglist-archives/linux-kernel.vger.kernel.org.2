Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392AE3BA4A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 22:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGBUaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 16:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhGBUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 16:30:54 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A20FC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 13:28:22 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id l26so10110992oic.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G3oeQWQfQg7R6ZTkuSFwzLdWju3dWQvTVitCiMSYhzA=;
        b=FyILO6ZXBGGJBsNmgS4gCCfKYz8ArhANiGesQ6ixptTTjSgqtT/NGnvn2uxFpob84O
         Sx2eVDvn8yMeU72VCUwKwKlzL8+67cjXQfQu9YRaopoeWTBn9eG0VwGGWmmgRRPFnpgt
         +Q4/MK7Zl7oCSgk/Q95E3RFmY6GTm4Z6PNZGLUurvfSTWKB2whMTi4HriXvtuyrUwM/+
         XeVDCXWR8yNVDUbuoboll9uB2O+VYjfrPpCnyafGSSmC+kZqbpL0JGjgUU6MLuRRzup9
         HWkQuKx5yxSlaluGXuw2WXVo7aMf4GKyjfSK9j/w5gN2rdUK7R2CbjG6T4kOy9pQQrcS
         EhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G3oeQWQfQg7R6ZTkuSFwzLdWju3dWQvTVitCiMSYhzA=;
        b=Dg7REETLzGPq7r6Z7xnyIdZVrGUE2z3erRS4mPPfwuQBNRKpqcSZ7RkVbgCOaViNNQ
         4kNx08aFD4j5lAkF+OegpXbq0lxrS9EAXNkYG1l1pWm3xIg202tlzwyJAmub89LB129O
         1cG7B6OiZ4Q8KnPMjjVZ/JwB6sP+VupL9i5Lvi9K8+qrfKpTpkU6gBCNH5YKDUPMpFGa
         MDkVQB5Rx7Y4g2s4lSjVHtLehEfm56wkyMwT0bBGkcqKUQc+bNyzuPkT0Xyk/ulQbtm6
         JA/1wq1/+np3YLc1XZdhyLt+PaYebE6SrR6AwnULLGHjce8b58oq1uF6cfSp2ny4HwkX
         4X+g==
X-Gm-Message-State: AOAM533FBpAwE657Z1oogqmNj4kBBS3ATEQFw45PktiWngOqMaqP5N2g
        9hwgAYhZackxy2gg6MxJr6LMmH6MIHs=
X-Google-Smtp-Source: ABdhPJynPxNN4TOayB4uOuYJUOVcsddvIpO8SDqE9jSnUSRgcaWYA3OwnY498Dj4i+9OhXOPsKUcCA==
X-Received: by 2002:a54:418c:: with SMTP id 12mr1052171oiy.42.1625257701153;
        Fri, 02 Jul 2021 13:28:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e74sm806771ote.14.2021.07.02.13.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 13:28:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210419225047.3415425-1-dennis@kernel.org>
 <20210419225047.3415425-4-dennis@kernel.org>
 <20210702191140.GA3166599@roeck-us.net> <YN9s5HLjNeb1lxMK@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/4] percpu: implement partial chunk depopulation
Message-ID: <dc349738-544c-34a1-748f-4e1a2c595a20@roeck-us.net>
Date:   Fri, 2 Jul 2021 13:28:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YN9s5HLjNeb1lxMK@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/21 12:45 PM, Dennis Zhou wrote:
> Hello,
> 
> On Fri, Jul 02, 2021 at 12:11:40PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Apr 19, 2021 at 10:50:46PM +0000, Dennis Zhou wrote:
>>> From: Roman Gushchin <guro@fb.com>
>>>
>>> This patch implements partial depopulation of percpu chunks.
>>>
>>> As of now, a chunk can be depopulated only as a part of the final
>>> destruction, if there are no more outstanding allocations. However
>>> to minimize a memory waste it might be useful to depopulate a
>>> partially filed chunk, if a small number of outstanding allocations
>>> prevents the chunk from being fully reclaimed.
>>>
>>> This patch implements the following depopulation process: it scans
>>> over the chunk pages, looks for a range of empty and populated pages
>>> and performs the depopulation. To avoid races with new allocations,
>>> the chunk is previously isolated. After the depopulation the chunk is
>>> sidelined to a special list or freed. New allocations prefer using
>>> active chunks to sidelined chunks. If a sidelined chunk is used, it is
>>> reintegrated to the active lists.
>>>
>>> The depopulation is scheduled on the free path if the chunk is all of
>>> the following:
>>>    1) has more than 1/4 of total pages free and populated
>>>    2) the system has enough free percpu pages aside of this chunk
>>>    3) isn't the reserved chunk
>>>    4) isn't the first chunk
>>> If it's already depopulated but got free populated pages, it's a good
>>> target too. The chunk is moved to a special slot,
>>> pcpu_to_depopulate_slot, chunk->isolated is set, and the balance work
>>> item is scheduled. On isolation, these pages are removed from the
>>> pcpu_nr_empty_pop_pages. It is constantly replaced to the
>>> to_depopulate_slot when it meets these qualifications.
>>>
>>> pcpu_reclaim_populated() iterates over the to_depopulate_slot until it
>>> becomes empty. The depopulation is performed in the reverse direction to
>>> keep populated pages close to the beginning. Depopulated chunks are
>>> sidelined to preferentially avoid them for new allocations. When no
>>> active chunk can suffice a new allocation, sidelined chunks are first
>>> checked before creating a new chunk.
>>>
>>> Signed-off-by: Roman Gushchin <guro@fb.com>
>>> Co-developed-by: Dennis Zhou <dennis@kernel.org>
>>> Signed-off-by: Dennis Zhou <dennis@kernel.org>
>>
>> This patch results in a number of crashes and other odd behavior
>> when trying to boot mips images from Megasas controllers in qemu.
>> Sometimes the boot stalls, but I also see various crashes.
>> Some examples and bisect logs are attached.
> 
> Ah, this doesn't look good.. Do you have a reproducer I could use to
> debug this?
> 

I copied the relevant information to http://server.roeck-us.net/qemu/mips/.

run.sh - qemu command (I tried with qemu 6.0 and 4.2.1)
rootfs.ext2 - root file system
config - complete configuration
defconfig - shortened configuration
vmlinux - a crashing kernel image (v5.13-7637-g3dbdb38e2869, with above configuration)

Interestingly, the crash doesn't always happen at the same location, even
with the same image. Some memory corruption, maybe ?

Hope this helps. Please let me know if I can provide anything else.

Thanks,
Guenter
