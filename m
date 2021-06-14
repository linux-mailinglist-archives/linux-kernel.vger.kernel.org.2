Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9163A6B74
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhFNQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234511AbhFNQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623687367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WhxhHHcEI/rhxTOPrzoemrU6XJoPEGDeoQZJS0c7PU=;
        b=KILG1it8IzfNhXsjUZ2sgm5VMaB7lBOPR9p+6FN+yEj+vAThJF7uL6NCbb3iLdkNaXKv4w
        E4/yH0SQb0Qkjg7uqGiUDztSJ6Kg72XfdZPI/X9j7BUbT5M8jdgmcR3JGYi1VYITcPPknC
        Tty8IBnzyspryRlfe6P7+T7hYIct1zM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-wo-gEvsjNEafmChUjo35qw-1; Mon, 14 Jun 2021 12:16:04 -0400
X-MC-Unique: wo-gEvsjNEafmChUjo35qw-1
Received: by mail-wm1-f72.google.com with SMTP id k8-20020a05600c1c88b02901b7134fb829so2477653wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6WhxhHHcEI/rhxTOPrzoemrU6XJoPEGDeoQZJS0c7PU=;
        b=kmE1TOJQGQP5JqzZh4XDcD719VTNbpnfReNSatAhjZWCtSgWsjeyRRQOZsQZI0EO49
         DdndtZgxCaxGVrnb/sJfh+JzO+iTvVHRZL1yw5i6AZd3DNN5FvAcS/rMTn3S7I84V7NG
         KbueYEcFbH+Y20MP6xs+SxeItEVnVrFn432N8JhnTFrO8DET76EOaXBO4XsesMNNTNNx
         Miiva15R3A7YJ6KQnXTu4dDihoc57+hwZ45gYoMRUxlN8RUoQs3vnUJqdjFbAEUPFTlq
         79g6/gLEyAKKxw+RzzQoseh84E0o9Yb/4RswxLYuRhsFMUMjgtynmZFTrtdLO49fgawl
         aRxQ==
X-Gm-Message-State: AOAM533/c0QCOxuvDXKC0EnUpUZD6vEdDvlsHd90G4CLKFnZyPmwn8cv
        /WnqtVpQg0wIYHVCAb/P5PBVnO2qkLULz8FdBSvxERhR3/Bg8LkZxHc0+novhxtN+JDSNbtWu0n
        ExDvPxfhkqynl77lOteVOkm+k
X-Received: by 2002:a1c:2cc3:: with SMTP id s186mr34549355wms.150.1623687362866;
        Mon, 14 Jun 2021 09:16:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd+DbuaL/JiPNasgGJA38HY32C75yjxcc9cCMZxRZ0zALvCuFELujSB+bLgneKSZ5dtyadfw==
X-Received: by 2002:a1c:2cc3:: with SMTP id s186mr34549324wms.150.1623687362608;
        Mon, 14 Jun 2021 09:16:02 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66ca.dip0.t-ipconnect.de. [91.12.102.202])
        by smtp.gmail.com with ESMTPSA id r1sm2854570wmh.32.2021.06.14.09.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 09:16:02 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20210609075752.4596-1-david@redhat.com>
 <87y2bd9wse.fsf@meer.lwn.net>
 <d517106f-64ba-5d3a-59f5-c87d5e032bdc@redhat.com>
 <87fsxka5zh.fsf@meer.lwn.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 0/2] memory-hotplug.rst: complete admin-guide overhaul
Message-ID: <300305e3-b225-623b-f02f-0973f4909705@redhat.com>
Date:   Mon, 14 Jun 2021 18:16:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87fsxka5zh.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.21 16:14, Jonathan Corbet wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> Essentially against Andrew's mmotm, which already contains v1. Note
>> mmotm was chosen due to a conflict in:
>>
>> https://lkml.kernel.org/r/20210510030027.56044-1-songmuchun@bytedance.com
>>
>> I'd suggest we take this via Andrew's tree, unless you have other
>> preference on how to handle the conflict. Thanks!
> 
> That's fine with me - one less thing for me to deal with :)
> 

Thanks!


FWIW, the patches are fine. My setup simply seems to compress the file
paths in the diff stats more aggressively:

$ git format-patch -2 -v3  > /dev/null; cat v3-0000-cover-letter.patch | tail -6
  .../admin-guide/mm/memory-hotplug.rst         | 800 ++++++++++--------
  1 file changed, 455 insertions(+), 345 deletions(-)


When I force to a bigger terminal size, I get longer paths:


$ git format-patch -2 -v3 --stat=80 > /dev/null; cat v3-0000-cover-letter.patch | tail -6
  Documentation/admin-guide/mm/memory-hotplug.rst | 800 ++++++++++++++----------
  1 file changed, 455 insertions(+), 345 deletions(-)

(maybe my awesome-wm + xterm setup confuses git, or there is a
BUG somewhere in my software stack)

-- 
Thanks,

David / dhildenb

