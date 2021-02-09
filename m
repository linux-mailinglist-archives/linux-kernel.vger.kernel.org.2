Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006333152D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhBIP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhBIP32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:29:28 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BE7C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:28:47 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id t63so18319470qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 07:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HeGD6+I/Cs2ZVAzM/f2bEdQ6Si5iou33votUBpUqwG4=;
        b=GKd274qOkvO6lCn2UyoRyYKnv9aEEhMYtqmPeNOq/DNeG2lnp9WqdPhwodVNSk+p3X
         2XYuYx95nWsRyymZYAbbb4SZLD4bNXRerQChOPAZv+UQ5xvnEzdQIjOi+TxsPq5lu+MQ
         UokLu+peT++x7Gtc+Dc2BkART/pN3P+hrYItv5Rh9vo3OwyzJC/M5i9qq9/dTWx6DUiM
         OytNr83a47lwk4jQOGzDvURBCSldZyKa5yc3A3u0CK86Ua6/c2kISHCYfEkT+WRpqouJ
         H3cX+dhCzdyYLOwDTR1zqGj+s0iZ9mM58Q9RSJFXtEAnv4shFWqmBZX4vpPJ+8sPEGXU
         wkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HeGD6+I/Cs2ZVAzM/f2bEdQ6Si5iou33votUBpUqwG4=;
        b=NKLzqyZL91CDzMF0nmN9Z3O15wZz9VyZZuv8MRt7iayCNOrZXapruNCDjb6uIL/yvT
         cvHB/CIT9AwmtT733OSNSNNbBnExCygLhPnYtp/+TvxYCwS+1aCjvhGkqWBocS8CcKT7
         C1dvJ+VPkawXOq1nH+oPfuhOEFeA5g/FuqaFuzN6lWK6x2Cb8q2ArrMMG+c1sYVgAi5D
         gTXrzr4YjGM6sda2gwyZm0NWMbN6f8254D2khn8nRl52WPBqnaEZaJHTqY+7NP5/nlD7
         +kbs4FhGZHdq815ylMqP+z5J/3l0MkxmvSOG1P4Mwcyivv/XxjUhCuAFi6yL328EoTPA
         NYbg==
X-Gm-Message-State: AOAM533VjgrM+Dr3TrFNY1k7iVzSTzrcBxVGpEHrqQM7jxCaGNgr56bB
        IAizzRNyh7dWqTA5F+D5dQY=
X-Google-Smtp-Source: ABdhPJz0w8tGzOVvvrut5oUvlwal8hSt5RasejdvAoKgUUpcYjhlNxIlI4N0eF1D1dTIVWAvpXqCaQ==
X-Received: by 2002:a37:6348:: with SMTP id x69mr1444621qkb.254.1612884526544;
        Tue, 09 Feb 2021 07:28:46 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id x74sm17911085qkb.55.2021.02.09.07.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 07:28:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 Feb 2021 05:28:43 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     changhuaixin@linux.alibaba.com, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, pauld@redhead.com,
        peterz@infradead.org, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v3 0/4] sched/fair: Burstable CFS bandwidth controller
Message-ID: <YCJj21ftgxS5MrVB@slm.duckdns.org>
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
 <20210209131719.1193428-1-odin@uged.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209131719.1193428-1-odin@uged.al>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Feb 09, 2021 at 02:17:19PM +0100, Odin Ugedal wrote:
> A am not that familiar how cross subsystem patches like these are handled, but
> I am still adding the Tejun Heo (cgroup maintainer) as a CC. Should maybe cc to
> cgroup@ as well?

Yeah, that'd be great. Given that it's mostly straight forward extension on
an existing interface, things looks fine from cgroup side; however, please
do add cgroup2 interface and documentation. One thing which has bene
bothersome about the bandwidth interface is that we're exposing
implementation details (window size and now burst size) instead of
usage-centric requirements but that boat has already sailed, so...

Thanks.

-- 
tejun
