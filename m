Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1532C562
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349181AbhCDAUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450426AbhCDAQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:16:21 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E93EC0613D7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 16:15:22 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id a4so17589191pgc.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 16:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=G2LSh/1BV8WYnMHZ9xLSStG/V6rbX5+AmYhW+PAYzUA=;
        b=k9Bj8mwHoqseZVGIS8xDFEnjNtACosQKWkznua+IsB42lU5Khyb59e50H/IHe4Uw/k
         NBC293ps8Oq7WWNkA6Pa5diWlCLifH/u+Vz6njtc+aDzLWxauA4oBAMMKNUiRgsvALci
         xu+NU+kHKB+x3mcaLKHj9FaO3DK9bv/DFT2YBvG3AJPN6OHvU8vGnaq0j0hTbN7M8HzK
         DYtV5Z0fwM2ddBG3gaKUFaBW9rwRMnvFk6yvSe4uNWr6ocwpZtW/+mqoB6XKIDzBROzx
         0pCe0rTuSEqlmwTAQiFTyVFSNTmZC33alP5xHzuTobKPdIvcBA5ehEMNtw8uljs8U/oi
         edDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=G2LSh/1BV8WYnMHZ9xLSStG/V6rbX5+AmYhW+PAYzUA=;
        b=PzrFkMvoxkEgV7PYfPT9nwWMdjDpO9RMGCEn2YuSn5PztTlp/qM39P8FG5RvYxwubW
         MB3yDeqm0dhjCEFaJfMeg7FSM6+lwcVnjCFz3rrRlZZMG6PGqeq+2krTmNf/A2rRrnZI
         neAZlRpa5ZNZQY5/800XTt6NIZBaDq5JMdQjzsH3QL/8PiP530qE3K8yujwLrxeFVOqr
         fJfe2wuSlrQ8O79DWHYctxHOT2sd5/RTPByxYP9hLbYaYsIKVDH2tTureyKIa7d07K0g
         4Dhtdd+L01DKsCHFHVEH3y/O8/a8YCe6KFXVLwuaVz5gHQVelMH7bMg6GS4K85wNfPVD
         RtLA==
X-Gm-Message-State: AOAM533Tn/UgQpzqHze9fsEwjeDhhmZo1Cuw7hshrDdHsBfWoiepPtm5
        4SUkPqnqHSZy1mWmRmXS2jhRRg==
X-Google-Smtp-Source: ABdhPJy38raSv/wGO/vBP8EZNO8pRu5nlexP6jAder16KUote7C7AFOcLG/q+X97UW+Q+Gt08oD2Gg==
X-Received: by 2002:a65:6a4b:: with SMTP id o11mr1347665pgu.138.1614816922197;
        Wed, 03 Mar 2021 16:15:22 -0800 (PST)
Received: from [10.255.117.57] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id s12sm7598209pgj.70.2021.03.03.16.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 16:15:21 -0800 (PST)
Subject: Re: [External] Re: [PATCH v2 0/4] psi: Add PSI_CPU_FULL state and
 some code optimization
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
 <YD+kP0z0yWm9UeDK@cmpxchg.org>
 <YD+sAnZ+Ep0il5lp@hirez.programming.kicks-ass.net>
 <YD+zu0UVKEG1ZK/H@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <dd652bc6-43d3-0948-5354-d6272cddd2ed@bytedance.com>
Date:   Thu, 4 Mar 2021 08:14:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YD+zu0UVKEG1ZK/H@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/3/4 上午12:05, Peter Zijlstra 写道:

> On Wed, Mar 03, 2021 at 04:32:18PM +0100, Peter Zijlstra wrote:
>
>> Yes, I can do that. Thanks!
> Please double check the patches as found here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/core
>
> I've manually edited the tags.
Looks good to me, thanks!
