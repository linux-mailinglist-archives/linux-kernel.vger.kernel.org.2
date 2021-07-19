Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B653CD1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhGSJjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhGSJjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:39:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB02C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:26:02 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o4so13886154pgs.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8+plMzy1GpXf0vMW4A7COLA30NEdDVp1gfiCAEBYGEg=;
        b=ypqOgi5AFe9zex8bFiyIfAQA1juQ/lpgmpNaKCGT6um56q7CuxpGbFYc0hwwnznKpR
         EPtQ3YK/c4y5Sp4XX0fxx7BhrgyLZEaQzRyPo3uxAkwoLCefWPS0lq8QAC3viEJR9Cca
         ZOtaaisRiRp+Aa42k8ml1on/j0tSccOV/eiskpDf2SZSRIw1DcKNjdKMXNx4Yw4Ig6q4
         hmnfLwLG8GNVdzodKph+xvp1hTqAB4sFdnnSRcB00m3jrHxkhggLoqraXbJtXt6iUKNZ
         cMftqKQdDpYAZSrVJdGZOde8sCfY7U8nZevXTgjpu9s4XcnkMcWzGBVUS5qzvXN2Zdzc
         NAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8+plMzy1GpXf0vMW4A7COLA30NEdDVp1gfiCAEBYGEg=;
        b=Nne4j6S2QPuYctrC2GeYQs8m18bLQlgBtaYcj2UMUq0A3+j9PLWitfeOnyUykgl+sn
         Qz/GpFitJZmRo0H3Qf6Tr3Wn+i8lZt1bniz2M6QyhiXNfX4vaIzf4zJNyAGu1+TxQrca
         Ijh4N5CgFhfGDUy776g+x8GJZpB7/14DOCHNQnVzHVRoGgof70ycsTMQjPG8OpsBUzWG
         4bEw01HSeiJjRdVkw/tpukbd+0BDE0i36ivLeR+F/9wfPC5gUtFN7M4otqCpslqOg51t
         wxEGTU2swzfQ/HiiuGvI36TTXpB/ly6xakCv8bE/TYcEVb4vrRmSUT6GSPyZOTFcK3/1
         79fQ==
X-Gm-Message-State: AOAM531SoooO0NtzUkcygFc/qv3MM76pi8yqSKkd7iYfGP5mT084u7Vx
        88pPFZT3s8/GAc/uYMfOEm1I+A==
X-Google-Smtp-Source: ABdhPJxaUsGR2nKzjCWMm2PK5pJ16pPtRD/baJ0YBDUQ3Edk8qAUndLkGV4YG8gt/xYcyyczu12iKQ==
X-Received: by 2002:a63:514c:: with SMTP id r12mr25117618pgl.70.1626690024128;
        Mon, 19 Jul 2021 03:20:24 -0700 (PDT)
Received: from [10.200.196.235] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id q125sm12669828pga.87.2021.07.19.03.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 03:20:23 -0700 (PDT)
Subject: Re: [PATCH 2/7] mm: introduce pte_install() helper
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <20210718043034.76431-3-zhengqi.arch@bytedance.com>
 <20210718213120.rtqbgseb6drcwxj4@box.shutemov.name>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <46573169-3c97-7024-bc04-ba1fb7a548f6@bytedance.com>
Date:   Mon, 19 Jul 2021 18:20:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210718213120.rtqbgseb6drcwxj4@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/21 5:31 AM, Kirill A. Shutemov wrote:
> On Sun, Jul 18, 2021 at 12:30:28PM +0800, Qi Zheng wrote:
>> Currently we have three times the same few lines repeated in the
>> code. Deduplicate them by newly introduced pte_install() helper.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> I don't like the name of the helper: we have confusion of PTE being
> PTE-entry or PTE page table. And pte_install() doing pmd_populate()
> doesn't help the situation.
> 
> Maybe pmd_install()? Or pte_table_install()? I donno.
> 

Look good to me, I will use pmd_install().
