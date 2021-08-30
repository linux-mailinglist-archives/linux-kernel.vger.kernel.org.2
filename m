Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB173FBA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhH3QuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhH3QuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:50:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3ACC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:49:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso14279187pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MusWhgua/ijN+CulqnkeztmJziWKh/0oyOtw230/yQ4=;
        b=DsXDAqQJBP+5wLke8EeTpPMfjRpczMaWTRNlrSyU2c5HEvC24INHIYonE5P7GwHIa/
         gu5pNMnu/UUvSuhdslbtVTIsLrurarhyemwGhzH7qRzW9uzT84H34dgXwH/prsKGT3EY
         KhxtvisWR8ZY5DAob8uYYRdSmB74PWDiF6fwlu61fg5OUEJI5gzleqZT7r1PWyZ0d8fl
         yHNaVMNX2mjgUbGQ/WBFjkL7iAGIsFHnyC/yOhE9LmD0TQOzNGRGzeQ+ySL4z5fbEsij
         4gg/fjaoM3NQ9vybsCOjtaHwo1HVNKRA03Athfwn1eQrkv/QdICtkIDNx20KZXomFBbW
         UTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MusWhgua/ijN+CulqnkeztmJziWKh/0oyOtw230/yQ4=;
        b=P4ctO29E0RA4xHIOISIi5C9cB+VYRywNXildnV4iTJwUzUbjSlKnrWcM0PPLPo/0qa
         EBeIPs4N1abDnc4dfVcIJasbDB9FNGXVidDBSEjVHak+CWrzX7emWJf9n5OhLb1k8pXg
         9sP6HGxlQv/biZXfRZwg3/NYzCLomZccbhIoRrEFYfezzHxofDccPPMYNjSSDIJbqyf5
         yZYVH4OYPAm98wftZpRa99hT7W9s64XovCtFqfvjo2zRdyzg6MaYMFSdIGTJe36swLeE
         yVSjXV4p+ZNekfcXTLhJPBW9K8/I1JNq1E1wWRYai8O59HX/NedgmKgE3Mfj9f9QxKgn
         0cwg==
X-Gm-Message-State: AOAM533v8Q/Knae41PLx5Z33BN9gf8zPY1mxfJCUBXZg0nRTGdylLpoH
        q2k1XEn4c1Or8+Oooh3lEP8=
X-Google-Smtp-Source: ABdhPJxZxEUFf4T6v366H42UdxJDvc04Vq4mk0IKNhGmmRvnkNbBrLx4N98nnubx0SqxLLrQ9C0+tQ==
X-Received: by 2002:a17:90a:c290:: with SMTP id f16mr23605pjt.0.1630342156312;
        Mon, 30 Aug 2021 09:49:16 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-44e6-6a58-44be-40a6.res6.spectrum.com. [2603:800c:1a02:1bae:44e6:6a58:44be:40a6])
        by smtp.gmail.com with ESMTPSA id r8sm17530808pgp.30.2021.08.30.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 09:49:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 Aug 2021 06:49:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        anderson@cs.unc.edu, baruah@wustl.edu, bsegall@google.com,
        dietmar.eggemann@arm.com, dtcccc@linux.alibaba.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        luca.abeni@santannapisa.it, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com, daniel.m.jordan@oracle.com
Subject: Re: [PATCH 0/2 v2] Add statistics and document for cfs_b burst
Message-ID: <YS0MC4H4EnvyaxfN@mtj.duckdns.org>
References: <20210830032215.16302-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830032215.16302-1-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:22:13AM +0800, Huaixin Chang wrote:
> Changelog:
> v2:
> - Use burst_time in nanoseconds for cgroup1 interface, and burst_usec
>   in microseconds for cgroup2 interface.
> - Minor document adjustment.
> 
> v1 Link:
> https://lore.kernel.org/lkml/20210816070849.3153-1-changhuaixin@linux.alibaba.com/

From cgroup interface pov, looks good to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
