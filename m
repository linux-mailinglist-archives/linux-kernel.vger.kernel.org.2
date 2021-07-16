Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595FD3CB586
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhGPKC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234167AbhGPKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626429570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWrxnkLFe/NFRcovJSGie/L+AIpvwaIHXs/9ffCf/OY=;
        b=adfOyvebwJYMEkMujCW6oOBm46iMaij6t5/2pXa8cNj8vttTc0cCq7oVumf0QiqE75EvlY
        cRz4+GYw2glBuqbnPk+7ATZgdTCEWmpTGhObZjj8epWLMdQUCDFaOlou/TJ+SPASoSIweH
        u47NmfvzrLY+kaOZpNFbPPhfVYgMOas=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-dF4lRyb1MlSZiWDQwDu3TA-1; Fri, 16 Jul 2021 05:59:28 -0400
X-MC-Unique: dF4lRyb1MlSZiWDQwDu3TA-1
Received: by mail-wr1-f69.google.com with SMTP id a4-20020adffb840000b02901304c660e75so4557563wrr.19
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 02:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uWrxnkLFe/NFRcovJSGie/L+AIpvwaIHXs/9ffCf/OY=;
        b=c0JnC6r+T+s/8UuJoiXOgSpWxs6F+uANs2uJ79xA8D6I7e9joS3TklgPXOb6h51E/P
         sYpkwAWIo6qig2aXzIycDdkHaT+nyC/S+ipHL3AoQs1W3wd80+vm+nT0MxV6eHQ3Uiuk
         5xg7TAxS73Ri9AJ8v45+JoK5i29M20ZQUeNEekRlFNbldMPqnBiFu3ODeUG8Kmefw70A
         ss7/REFZTdzGPYSk4sWy3trCkN3Z/KQCYWGY+wuP3Lu0ChUQ7jLnUbEEz082SDsvsObm
         FdLrtVeCopSV5Y6sdgQ/AKIy/Vbpm4NDobiXY+1pt5cjZvQI7olc9ahIkTyGDCjKUFku
         MF3Q==
X-Gm-Message-State: AOAM532onwDnflJ7K5P8hAHsfGq9lMw1POf+0M7HsZ/3qlw+81X6fQO2
        Z+yP3gDr0Gcef5aE7sqB4CKQDQY0OJIneEAu3/WxzJYy65WkzNUCg4tEy4aByzfKF9FBWiq4VZY
        fkAW4c0mX4T3QOHcFWHfl9Luq
X-Received: by 2002:adf:a350:: with SMTP id d16mr11417431wrb.207.1626429567341;
        Fri, 16 Jul 2021 02:59:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhmbeTwTI4IQb8fn0UC6V7hHToNpVZe0mkO+T3dyfnTutgDELBDcL9qaRcDvtPP7OR1Srr7A==
X-Received: by 2002:adf:a350:: with SMTP id d16mr11417416wrb.207.1626429567170;
        Fri, 16 Jul 2021 02:59:27 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c621f.dip0.t-ipconnect.de. [91.12.98.31])
        by smtp.gmail.com with ESMTPSA id p5sm10317783wrd.25.2021.07.16.02.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 02:59:26 -0700 (PDT)
Subject: Re: [PATCH 5.10 140/215] mm,hwpoison: return -EBUSY when migration
 fails
To:     Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hanjun Guo <guohanjun@huawei.com>
References: <20210715182558.381078833@linuxfoundation.org>
 <20210715182624.294004469@linuxfoundation.org> <20210716095243.GA12505@amd>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a5539a09-7964-c188-8e58-5173eb587a24@redhat.com>
Date:   Fri, 16 Jul 2021 11:59:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716095243.GA12505@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.21 11:52, Pavel Machek wrote:
> Hi!
> 
>> From: Oscar Salvador <osalvador@suse.de>
>>
>> commit 3f4b815a439adfb8f238335612c4b28bc10084d8
> 
> Another format of marking upstream commits. How are this is number 8
> or so. I have scripts trying to parse this, and I don't believe I'm
> the only one.
> 
>> Link: https://lkml.kernel.org/r/20201209092818.30417-1-osalvador@suse.de
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> Could se simply place Upstream: <hash> tag here? That should
> discourage such "creativity"... plus it will make it clear who touched
> patch in mainline context and who in stable context.

This is properly documented

https://www.kernel.org/doc/html/v5.14-rc1//process/stable-kernel-rules.html


"
The upstream commit ID must be specified with a separate line above the 
commit text, like this:

commit <sha1> upstream.
"

-- 
Thanks,

David / dhildenb

