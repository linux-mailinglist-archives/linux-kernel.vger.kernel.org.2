Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9FC33F9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhCQUJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhCQUJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:09:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52404C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:09:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 12so2202913wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B1X6ipcuUsdf82cZtHT305TsFbY9DYduqDXWEcArvjs=;
        b=I/SAZZEPuUymklCLKMXfsZdV5shnTpG2UWuFRn7J27do+1FBlLNLSg65pzDpoxo6In
         3b9a9ikKnXilSDrrLZ1++it5B405eKC7+YYI932QuvNUSV0kDtAyblQAFAJScQCc40pE
         90arlEZ28O2nljrlVFzoQ2QsfGwIGeWRk0CyOIstNTNAjLR2TEsi21Ytf7rYdvGw4tmN
         PdPks3LugmKWGN8NuyJss76/W1wpOdQRnFfZRs78n0Ihlj0c9YIkeLwfaEcDD7SVMny/
         PthHwceCdnD4dvte9lzO54ylRKbDnZ8iK8Eu11s51YYHyyWgDnn0jFfV5hmW2wDYQ+K1
         6UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=B1X6ipcuUsdf82cZtHT305TsFbY9DYduqDXWEcArvjs=;
        b=iO+GNFZPIh8W/r/2BnA/x/JGzaVcU8TL4ebSkV2ykZ3B24dV4pUKVOhtqGNdAUD8ID
         kn2B3hUSJOGmFFBi12jVjIhevBQFlVQTnZee4W0i141TmLJXoWZJU6rRC9yAgW5FFu+M
         qQolGC3IbhcfgwmRc8V7yYcedgYCABGhgYj0MYNVEZu3eMexIaoidVBtXsJtB3lUOz2s
         7Q81guPPOJc94RGGaiQRrGXyyISDuaILgYwx39KHtO9aKa3txg4S0Bq/fWXujyK3CDdV
         HPqjZWi54vmDYTwcC4pIu5Ha8rBWBWsMK+ZiHGi16praquFAuzhEWa33T8v3RtwzNB10
         O5WQ==
X-Gm-Message-State: AOAM533UwxPjSGJaQqXbRcHS8j/5IPvP1RBFWlk5BXotANiqZWq1PP3m
        hEwtP4jsvKWQduanUbJSBvw=
X-Google-Smtp-Source: ABdhPJzzKjZlsHcZFVHlcOjW+/RSBZx7qSrnqG0TTk4kohjxzbVsB9ubi+G+q8DQpxGptyHRVUoj8A==
X-Received: by 2002:a05:600c:2053:: with SMTP id p19mr436599wmg.87.1616011765037;
        Wed, 17 Mar 2021 13:09:25 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p6sm55567wru.2.2021.03.17.13.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:09:24 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 21:09:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        He Ying <heying24@huawei.com>, frederic@kernel.org,
        paulmck@kernel.org, clg@kaod.org, qais.yousef@arm.com,
        johnny.chenyi@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] smp: kernel/panic.c - silence warnings
Message-ID: <20210317200922.GC3830960@gmail.com>
References: <20210316084150.75201-1-heying24@huawei.com>
 <20210317094908.GB1724119@gmail.com>
 <9691919b-d014-7433-3345-812c9b19a677@csgroup.eu>
 <YFH0sDpUIUmdpNkQ@hirez.programming.kicks-ass.net>
 <fa3f9880-eb05-f18e-ae7f-4735209f4c94@csgroup.eu>
 <YFI+YMo7zml+spKc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFI+YMo7zml+spKc@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Now, the C people figured that distinction was useless and allowed 
> sloppiness. But I still think there's merrit to that. And as 
> mentioned earlier, it is consistent with variable declarations.

Fully agreed, and my other point was that it's also consistent with 
the other existing externs were used *in the same header file* 
already.

I.e. there's nothing more sloppy than mixing different styles within 
the same header. Checkpatch needs to be fixed or ignored here.

Thanks,

	Ingo
