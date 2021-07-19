Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56CB3CD139
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhGSJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhGSJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:12:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBC0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 01:56:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x16so9304098plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E2tZE1Ed0aZpkrCfB99XZNU8SFfnSKYacY6RqWfb6v0=;
        b=WH2Ykao0CL8ffEEwvky53xOjUsbsh37gLm2+9Pd7OtE5goUtTklLM51bZXpzgkuglw
         hPZjP70D8RR/PKC9cvktg8Aoyvs0VvKOO/Wz8hIbtTzILSHgKhGZ22LPzl7IxkoJMqQd
         jsQk6Fs84EJs369DPBiQy/dFMNwZdSwaCsLdsc0kKaQ34Yufukf4SxiqJFUxFH4JivZQ
         +u99HXf8QYRYF/8ddNtDTSVEhWr3/X0+sLLIRWOfLAqInXwODZOfFGX7d9/RzxBU2qrI
         CeUPJWM3uDmbEegsZhDGe0rpDr3KRnC0LHNnVd7P4H6rvOM1wr7yWyLZwcqxkGq5n4s8
         ITZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=E2tZE1Ed0aZpkrCfB99XZNU8SFfnSKYacY6RqWfb6v0=;
        b=tg2qlFyVzZaIFJuhVz2n0LuaX4YxC3UhWlzLJQPhtYUIo9t75uzLVIPW4p9aiDPFYx
         RPQE9iItO0H+iBM1GcTA+jIo3KpZ2zm8WjVwG7QmIe58TZze6L1772ARVPpLIK3Q5TQg
         DMk+KP/yOrE7u8IwvkPzi9GjueLnPmfoCnUXVzAEm5jZLR1vIMRxrz+YD/1/R5WEQdjM
         +Yu0DSvGA+MgFERrawnkXMLojIXSki3VZFTu9BA56R/N/57HqOOg9N4pLEcAkBGiIiV/
         D1rr6gDlZOxh319afh74snolpXfePipF6hMB5w7PpZEDDd28VZKbX3rR1zbDITyVyUEE
         xpSQ==
X-Gm-Message-State: AOAM532xBte+72uH/Q9TX7X9DM1Nt30tNMDcI67ebcfvyE5doO8IODAd
        TkE3uQ3lgeuLFK9hTEJE+rXMkA==
X-Google-Smtp-Source: ABdhPJzE4kEpR1F76PMihUwTBGQTjf87c9UpFZlcNlaP9p/GUb1Ez01h+tYgDZRGl7H1xCbSbOJBiQ==
X-Received: by 2002:a17:902:e14c:b029:129:d117:fa3d with SMTP id d12-20020a170902e14cb0290129d117fa3dmr19054634pla.53.1626688397949;
        Mon, 19 Jul 2021 02:53:17 -0700 (PDT)
Received: from [10.200.196.235] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id c14sm21099059pgv.86.2021.07.19.02.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 02:53:17 -0700 (PDT)
Subject: Re: [PATCH 1/7] mm: fix the deadlock in finish_fault()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <20210718043034.76431-2-zhengqi.arch@bytedance.com>
 <20210718212814.suvziikndiyezi6m@box.shutemov.name>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <9e97cedc-9fd7-4290-9f44-04b96acea15d@bytedance.com>
Date:   Mon, 19 Jul 2021 17:53:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210718212814.suvziikndiyezi6m@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 5:28 AM, Kirill A. Shutemov wrote:
> On Sun, Jul 18, 2021 at 12:30:27PM +0800, Qi Zheng wrote:
>> The commit 63f3655f9501(mm, memcg: fix reclaim deadlock with writeback)
>> fix a deadlock bug by pre-allocating the pte page table outside of the
>> page lock, the commit f9ce0be71d1f(mm: Cleanup faultaround and
>> finish_fault() codepaths) rework the relevant code but ignore this race,
>> fix it.
>>
>> Fixes: f9ce0be71d1f(mm: Cleanup faultaround and finish_fault() codepaths)
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> and add stable@, please.
> 

OK, I will add these in the patch v2, thanks.
