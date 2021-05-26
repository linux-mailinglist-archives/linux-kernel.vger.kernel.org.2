Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ADC391B35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhEZPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:09:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52038 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbhEZPJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:09:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out1.suse.de (Postfix) with ESMTP id A511C218CE;
        Wed, 26 May 2021 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622041676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZiam42bncJAQSsIfF2pfnFWeccnnWh5QphZuv6aT6o=;
        b=Ulha/uzmJ0nYbeHSMNAz8Vp5AYs17BOmR4OLDQnjF0w9FXkRoTWI9zbTd7azRP6043aryA
        CGrZA9KhC7eragM8Z6UJSCWUkvMQHGWckWRZdKydSpph6rKLtexjczXYI/a3kN9G5/qCg9
        hb0hXG4ljSQSk51OJhknfMzagTHlcPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622041676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZiam42bncJAQSsIfF2pfnFWeccnnWh5QphZuv6aT6o=;
        b=jZYjPcGzaojQftlmA9AFeijJA8zASNIQkTFw8oFWzfz/SWlcP231p6vr9gtJTSmzJFdkG7
        Zv85nTywJfSaXnCA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 8677A11A98;
        Wed, 26 May 2021 15:07:56 +0000 (UTC)
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <YKys873HUNp/ZMqV@kroah.com>
 <7324d56f-c5fe-05fa-55f2-7dd2dbf9bce0@codeaurora.org>
 <YKzlia5b/vaDaul9@kroah.com> <371e20a8-6b07-1eaa-d587-3b444d03ba2f@suse.cz>
 <544e7eaf-ceaa-0ff0-15c3-b615db7e1b00@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0d39e26f-b641-e142-6c90-7f4bcf91fc21@suse.cz>
Date:   Wed, 26 May 2021 17:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <544e7eaf-ceaa-0ff0-15c3-b615db7e1b00@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 5:06 PM, Faiyaz Mohammed wrote:
>> How about simply replicating the empty function in
>> include/linux/slab_def.h
>> 
> Yes, we can add empty function in include/linux/slab_def.h.
> I will add in next patch version.
> 
>> We could do the same with SYSFS, except the SLAB (and SLUB w/o SYSFS) versions
>> of sysfs_slab_release() would not be empty, but just call
>> slab_kmem_cache_release(s);
>> Then we could get rid of the #ifdef's completely?
>> 
> Is it okay, if I raise separate patch for sysfs by adding empty function
> in slab_def.h?

Yeah that would be cleaner. Thanks.

> Thanks and regards,
> Mohammed Faiyaz
>>> greg k-h
>>>
>> 
> 

