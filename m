Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F631F0A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhBRT7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:59:39 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:60692 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbhBRTnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vz9cGALEpUjlZMbPF4dKWkZ7j9oxemuoQgOU6IaGSyY=; b=KCgTfPaBHLmISVroGNOkvDyNA8
        +dPONVhYW00N+cK2i1P2h9XpJYq5diP3E7I/oeHGW0eadCuWlnPer0RJBSlh7xYJ86OV0zjVGl/s3
        sSMkbR10DJu6x5GJbgvI1eO0XACotyHEYPyGlE/34cgnA5GcVZiYBDDtf3KdHqsXQALM=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lCpC4-0003x5-1Q; Thu, 18 Feb 2021 13:42:32 -0600
Subject: Re: [PATCH 1/2] perf report: Remove redundant libbfd checks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
References: <d1c87379-8837-a5e7-eb44-f063ca0f4766@codeweavers.com>
 <94758ca1-0031-d7c6-6c6a-900fd77ef695@codeweavers.com>
 <YC7CetsRKrZXf8WE@kernel.org>
From:   Nicholas Fraser <nfraser@codeweavers.com>
Message-ID: <59cd6ab8-52d8-f19f-669c-afef5c9ac8e9@codeweavers.com>
Date:   Thu, 18 Feb 2021 14:42:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YC7CetsRKrZXf8WE@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-02-18 2:39 p.m., Arnaldo Carvalho de Melo wrote:
> you forgot the:
> 
> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> 
> I'm adding it, ok?

Ah yes sorry about that, to be explicit here it is:

Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>

> 
> I'm also addressing Jiri's remark about spaces surrounding |
> 

Thanks. I included this fix in my follow-up patch though so
you might get a conflict.

Nick
