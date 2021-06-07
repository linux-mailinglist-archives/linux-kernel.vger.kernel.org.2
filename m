Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C639E8AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFGUqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230385AbhFGUqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623098655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p14sNsrf29IyrlDe2puU05DlPkcSP+alqHwSenkYXkY=;
        b=aFq5EjMX8HTiAoV3Psdg0f81F+9kOhLVwJwbjxfdkzIaGfZZGQzGq1Khd4vOG8TNMa3Geg
        SH3mAkAsGIz2zmm5b+g6TxTHsoHmNxxARv129/KtP2cOqPNI//k4YUWV8mHtBgIcIABTuC
        F67u9KjQxLZvwYreezizdwOkzjwHJTg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-ObgzTngaMxiOWESpZs8Q7Q-1; Mon, 07 Jun 2021 16:44:11 -0400
X-MC-Unique: ObgzTngaMxiOWESpZs8Q7Q-1
Received: by mail-qk1-f198.google.com with SMTP id u9-20020a05620a4549b02902e956c2a3c8so13612187qkp.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 13:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p14sNsrf29IyrlDe2puU05DlPkcSP+alqHwSenkYXkY=;
        b=t1RdozWwaKNUjx39Ub3P2aw/zhA3NVdicby2fXBz1ATlyyyKyhlGglQgRr9HpiElB3
         a4RY9sb2YC8RTRsp4fCa/Mj7UXEq4/49e1w8RfPoWHvFmZkp++q8zpGeo8yKJjlv/teR
         SnIWEj6+tcRBRx6MCALn40+OvnGzMu8XQ6sjCh3TV4g2KSPUo1FyrufhCCOyDxmnEQAb
         Q2AA8DtBt0WzeyUqRMnoCM8kTU8yGNVh3LUzL3hpPsLPWjRClac2aCpqxwGJYU7kX8hK
         bUY8C79mPAz6V7FZF9TN8DlnMR8MfORrY6L1zq7KA/iEo9zfCO5pRcs0HVz7Wq8p6Cn3
         s8dw==
X-Gm-Message-State: AOAM531Ojjq6Lno+UcA72uL9ePhY2u0CdINopYX7nYagd0x8dirnGjRd
        xX6urqe6w4Wpii4BtMN7UDsbxy7CbYzGLldRmzkH9Tuf/YVto2qB3qcCcFmDovd2b3R23qL3sNS
        e52NB+ccsxMpuDXfg+6lHo+KcgmwAUwh2wVGOS/etC7vZiO9HdUIQPgicxIsOXB7nbLiD0JpV
X-Received: by 2002:a37:62d6:: with SMTP id w205mr11912921qkb.194.1623098650611;
        Mon, 07 Jun 2021 13:44:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzK1WDso3vmPdDtpFovWOfgu2bFxxCdtZ8LEgH4YYixyaYGsL3i1AJn3TUMi8viuAD/dKzRCw==
X-Received: by 2002:a37:62d6:: with SMTP id w205mr11912900qkb.194.1623098650386;
        Mon, 07 Jun 2021 13:44:10 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id m18sm4353002qtk.80.2021.06.07.13.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 13:44:09 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
To:     Michal Hocko <mhocko@suse.com>, Waiman Long <llong@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210607163103.632681-1-atomlin@redhat.com>
 <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz> <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
Message-ID: <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
Date:   Mon, 7 Jun 2021 16:44:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 4:03 PM, Michal Hocko wrote:
> On Mon 07-06-21 21:36:47, Michal Hocko wrote:
>> On Mon 07-06-21 15:18:38, Waiman Long wrote:
> [...]
>>> A partial OOM report below:
>> Do you happen to have the full report?
>>
>>> [ 8221.433608] memory: usage 21280kB, limit 204800kB, failcnt 49116
>>>    :
>>> [ 8227.239769] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents  oom_score_adj name
>>> [ 8227.242495] [1611298]     0 1611298    35869      635 167936        0         -1000 conmon
>>> [ 8227.242518] [1702509]     0 1702509    35869      701 176128        0         -1000 conmon
>>> [ 8227.242522] [1703345] 1001050000 1703294   183440        0 2125824        0           999 node
>>> [ 8227.242706] Out of memory and no killable processes...
>>> [ 8227.242731] node invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=999
> Btw it is surprising to not see _GFP_ACCOUNT here.

There are a number of OOM kills in the kernel log and none of the tasks 
that invoke oom-killer has _GFP_ACCOUNT flag set.

Regards,
Longman

