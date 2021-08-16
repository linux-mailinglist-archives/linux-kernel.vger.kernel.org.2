Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0F63ED029
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhHPIYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231716AbhHPIYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629102233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XePXIUWQuyu3Re8GYDCaNWiGT+mm8bsw0DIVjtODpjc=;
        b=Q+SVHoGsW0HMDaavcBFk/400MVCCPmv0/n+CFE9AWrOled5qe6fKIA8km7MHP0b2yc8FpB
        uNCbIfgiJ1yb3ODJGtpszCTpSgWZa6ab08hDwm6YwS8OpNj7ukJikCdkFtILiAAJTLCmLb
        36FjpPxLumOQOTdcqLmWDdzqnliINbU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-6Z4RMIzQNMqAzTZrDrQ3uw-1; Mon, 16 Aug 2021 04:23:52 -0400
X-MC-Unique: 6Z4RMIzQNMqAzTZrDrQ3uw-1
Received: by mail-wm1-f72.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so5933726wmj.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 01:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XePXIUWQuyu3Re8GYDCaNWiGT+mm8bsw0DIVjtODpjc=;
        b=uoBRu5Tcg6prDQBeU/vaRGeTfIhnAZORtSLL1dbtylnMiBquGGtx+iR0LlJUJj18TT
         qNdwEN92DDzzji3FpD3YUC6H9T7vPGdPEHFbRJwH7a2oyT8doYC0V46OLTmRHKJUC/nO
         ao6NCshTd4ZZRlisrcoo0s8MqaoqgObYazH73uIrSroinrG7fy2MnSM34d73/VMujxqI
         Yt9AzNlzkoZ5Tx61PH3cNhkxLMpYo51QmkRvk6pJhmcLaKgzXq6/0wD8f91yBEB2JqUe
         9YZqtzHbdqNTNsYhSzMM08WdBTeCZo29kf1FBUYoI0+TX63wF679GbJzTHurWYzyV0lL
         qi+Q==
X-Gm-Message-State: AOAM530BGP3oCODlOFxJEwwF6vw9jeQV1kiPEcOGRppn9ukEEYN9v2mf
        Qu1KoWReqIznzXl7bjqhw12uNd8lG97J6ae0fVIlEd8b57x7iVLpHpesPfkodXVmueq3oV1YlKP
        x30eS/73PLlgcmLA3TJWyS5vTP5qwiV6IaLWjRdgBAa/Dbseun6koI5oUrFRH9H5p6f8I8bsy
X-Received: by 2002:a05:600c:3793:: with SMTP id o19mr9444754wmr.53.1629102231142;
        Mon, 16 Aug 2021 01:23:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9uZFJbVvynlFhQEDIq3zra3/5Kbt66ggKycJUWqI8INp/MnDFkNfFDWBzlOsQRtE/e01TPQ==
X-Received: by 2002:a05:600c:3793:: with SMTP id o19mr9444730wmr.53.1629102230872;
        Mon, 16 Aug 2021 01:23:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id k17sm10494178wmj.0.2021.08.16.01.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 01:23:50 -0700 (PDT)
Subject: Re: [PATCH] mm, slub: add cpus_read_lock/unlock() for
 slab_mem_going_offline_callback()
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     qiang.zhang@windriver.com, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210816074605.30336-1-qiang.zhang@windriver.com>
 <ef944ea5-c3cb-24e5-1ff8-b8e1008fa6ed@redhat.com>
 <20210816181751.17f98cc2@canb.auug.org.au>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e9b22a8a-e5d2-955f-65b9-1e30efe24f81@redhat.com>
Date:   Mon, 16 Aug 2021 10:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816181751.17f98cc2@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 10:17, Stephen Rothwell wrote:
> Hi David,
> 
> On Mon, 16 Aug 2021 10:04:13 +0200 David Hildenbrand <david@redhat.com> wrote:
>>
>> On 16.08.21 09:46, qiang.zhang@windriver.com wrote:
>>> From: "Qiang.Zhang" <qiang.zhang@windriver.com>
>>>
>>> The flush_all_cpus_locked() should be called with cpus_read_lock/unlock(),
>>> ensure flush_cpu_slab() can be executed on schedule_on CPU.
>>>
>>> Fixes: 1c84f3c91640 ("mm, slub: fix memory and cpu hotplug related lock ordering issues")
>>
>> Which branch contains this commit? At least not linux.git or linux-next
> 
> It is Andrew's mmotm which is included in linux-next but gets rebased

Maybe I am blind or need more coffee:

https://www.ozlabs.org/~akpm/mmotm/series

> often, so, for example, that SHA1 is no longer valid in linux-next
> today (is is now fd917c6407fb).
> 
> This (unfortunately) make Fixes tags less useful for mmotm :-(

Right, and it somewhat makes sense, because Andrew will actually squash 
patches before sending them further upstream.

Ideally, such fixes should be discussed in the respective patch series, 
because before they go upstream, they are still under development.


-- 
Thanks,

David / dhildenb

