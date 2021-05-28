Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66364393F21
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhE1JFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234769AbhE1JFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622192607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTwN2k4peqAjfmPctN2SUYzqE0Tq2QwueUFdp3Geoso=;
        b=Y0iLH166xmAfXYErt0hrbljgKF58z99KwfsHETK6su39mkAmgcp6wJddgV/UJGtjG27SjQ
        wC3Qr0SXZhV+o/gnQ5Ueo31IO8AvGj2w3eNNzxrFpuQ9pqe7pvaAoSlT5Ln/BgLifaxzOv
        HsTd4km4y+RL8u07E3kwse0oa+cEC/U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-60t_xiM5Pa2ftepA82uQIQ-1; Fri, 28 May 2021 05:03:25 -0400
X-MC-Unique: 60t_xiM5Pa2ftepA82uQIQ-1
Received: by mail-wr1-f71.google.com with SMTP id f19-20020adfb6130000b02901121afc9a31so777186wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YTwN2k4peqAjfmPctN2SUYzqE0Tq2QwueUFdp3Geoso=;
        b=pT5pKBDIEBwIT2l0ZO0F34M3JtYUIGwA3TXAhcbCzu3SnTP030Ajnrxvt0p8kwI05l
         HUPkIKWAamLuuy9TVLKNCHT2wP6C7VUjaE8CL0MUHrvUcRHi6CpXQues/XjoxfT2JSKf
         b1ECnE2Bfly4ZOYWddakubhcpbZ/q6QXToUwP5HyWDct6qJ7tdNpYmzRuUbshhhlZvvf
         GA6P5ZtRdy1P+kD286Vw81EbpH4k0m/qkZBWjG1DnLG6Nz6uNwsZFmh5GhFlG4S7qlVR
         Z9fa878CoUa+oDEoylMJjyBI7gvfz6IAnJ/KoW3AGYM2s+wyo2nV4CIb0P/uN/8oLqud
         ecjQ==
X-Gm-Message-State: AOAM5320iyPOCCQ3N0uQwE0DmR6QtlKDt0fi8A8cnWBO0TmIl6gU74Xp
        p5qz/n5imFC/O31IrvWMjvYx7Eim+6SZJa5mipyi5toF+SiCEseGS2OpjG7PsuFcSDQ8nhqIl3M
        4yWf3moulxN9YhyWXhXu3d+Ah
X-Received: by 2002:a1c:638b:: with SMTP id x133mr12508775wmb.182.1622192604043;
        Fri, 28 May 2021 02:03:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVphzGOvvslzQI9FRLu7cqG/JfG/HUagBHGUD5s2C43hUW67T7V1Nb8oh4p2o9NSQtKYnYAw==
X-Received: by 2002:a1c:638b:: with SMTP id x133mr12508750wmb.182.1622192603802;
        Fri, 28 May 2021 02:03:23 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6870.dip0.t-ipconnect.de. [91.12.104.112])
        by smtp.gmail.com with ESMTPSA id q27sm6297872wrz.79.2021.05.28.02.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 02:03:23 -0700 (PDT)
Subject: Re: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and active
 CPUs
To:     Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, "Tang, Feng" <feng.tang@intel.com>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
 <20210528085545.GJ30378@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <54ff0363-2f39-71d1-e26c-962c3fddedae@redhat.com>
Date:   Fri, 28 May 2021 11:03:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210528085545.GJ30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.21 10:55, Mel Gorman wrote:
> On Thu, May 27, 2021 at 12:36:21PM -0700, Dave Hansen wrote:
>> Hi Mel,
>>
>> Feng Tang tossed these on a "Cascade Lake" system with 96 threads and
>> ~512G of persistent memory and 128G of DRAM.  The PMEM is in "volatile
>> use" mode and being managed via the buddy just like the normal RAM.
>>
>> The PMEM zones are big ones:
>>
>>          present  65011712 = 248 G
>>          high       134595 = 525 M
>>
>> The PMEM nodes, of course, don't have any CPUs in them.
>>
>> With your series, the pcp->high value per-cpu is 69584 pages or about
>> 270MB per CPU.  Scaled up by the 96 CPU threads, that's ~26GB of
>> worst-case memory in the pcps per zone, or roughly 10% of the size of
>> the zone.

When I read about having such big amounts of free memory theoretically 
stuck in PCP lists, I guess we really want to start draining the PCP in 
alloc_contig_range(), just as we do with memory hotunplug when offlining.

-- 
Thanks,

David / dhildenb

