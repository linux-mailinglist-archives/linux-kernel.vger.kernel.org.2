Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C97379BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEKBLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEKBLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:11:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13486C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:10:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y32so14562012pga.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u/mlB5IeUtFeQjqdJci0HvxGkJDHf+1eWBq5dmgx6vk=;
        b=b10MJUdYL0MFoYDbbAr8Y7fGpVsJI4yoSc9DFZLMRU4vt1ZtWmNCFfU1tsPLUtAKY1
         nBXTaK7Gzo+5KE3gDVJREFx2BGnFtzpNHT6H7o0jdRjCSz+UnBkTJrLO8P+LJyQGgi29
         ouaZU76LyVmfHo0+Y/tHfHe6J87CHutK2MHjhkXsIf2WMv2CJG29jn9H6BaDb/AmqfxK
         U1dN2FVlA3gvTQhx7ZI0KsetkWRnGLiAAmm9rsAPSSl9s4vUBrl6t7nErESk8+ll17JT
         tOMsHWubpctlC23ZJh+ksMXVICKJCpRNomYNQC3X9jJeX2yF1QlhPtr5CvLDmb4ZgN5W
         rfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/mlB5IeUtFeQjqdJci0HvxGkJDHf+1eWBq5dmgx6vk=;
        b=rYYjwy4RsTkYaYXWr0hhfjBm4+4YmYdFRNo6FBmPoSGq+119bDRzllB/hj5sFJcizG
         HmcU65v5h9gsxW29TapiCFGDHTvWENY98gjiPkNhHnzZNxrmDcpMaDXjR9IBFwc7yagr
         qUv1xiLGna5vlSLHJE1cN5oe7+hqHQDC8p6PuAlpWyyuODhY/LuWvjL0E03Xr4j1D/kx
         d6aFWGPntSSH7oY9s+gX9wdj6v2aCvyq031VsfKbd73MePvEpsPx0vvBEAzspTtej2Q3
         koqnYoOutYcPeBJHItp5uAQgxQb3+gkq1s0BrWlYghVHw/RmUD6a+888I0GYep4qrXpG
         Px+g==
X-Gm-Message-State: AOAM532l0AuUoSP24M/zjdFX6GC6AKKY8N1qb+UpYCNuPL2YpPGWjxva
        hFbtTWPcu0iMuYkArEIyFxQZYPdMYKw=
X-Google-Smtp-Source: ABdhPJyfYcWR83NcAMJUrm17BqbBn7FgGb4bey9R5ncXR1g4hOZBS1BN+OUVjTozRkM6gIK99KlW+g==
X-Received: by 2002:aa7:80d3:0:b029:28e:f117:4961 with SMTP id a19-20020aa780d30000b029028ef1174961mr27738088pfn.37.1620695423784;
        Mon, 10 May 2021 18:10:23 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id y66sm12235534pgb.14.2021.05.10.18.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 18:10:23 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] delayacct: add a proc file to dump the delay info
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     adobriyan@gmail.com, bsingharora@gmail.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
References: <8ac9f35074326cb36e3cdbf0ad70b36dc3412e86.1618841970.git.brookxu@tencent.com>
 <3da76d1d565c423c6cbf92b02cbae9f86cd5accd.1618841970.git.brookxu@tencent.com>
 <20210509205853.42a3a06f9c5b70b52bdf8509@linux-foundation.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <b83bd36b-2e19-50f1-323b-2961a35bfe5e@gmail.com>
Date:   Tue, 11 May 2021 09:10:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210509205853.42a3a06f9c5b70b52bdf8509@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for you reply :)

Andrew Morton wrote on 2021/5/10 11:58:
> On Mon, 19 Apr 2021 22:37:07 +0800 brookxu <brookxu.cn@gmail.com> wrote:
> 
>> Many distributions do not install the getdelay tool by
>> default, similar to task_io_accounting, adding a proc
>> file to make access easier.
> 
> Well, we developed and maintain getdelays.c for a reason.  Why should
> we add (and maintain) kernel code because some people are too
> lame to install the tool we provided?
> 
In some production environments, all modifications are restricted, and
the addition of business-unrelated tools is generally not allowed.
Adding new tools to Linux distributions may require a very complicated
process, as some of them are directly using centos. But kernel upgrade 
is sometimes necessary, so I think a proc file can circumvent many
problems in the production environment.
