Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CB44104DE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243393AbhIRHn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243443AbhIRHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:43:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F820C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:42:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so9025582pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1w7Q+TlbIJEDf050IMqqi4cI13qRxqpQFb6QhY6iVGE=;
        b=i04if8NfZTO3k1BrW7F/zgWb8x94oUdoIIHjvbHWlPUdYsJNQW7FL2ANRQ0BsBFw7w
         wbiudpDZgWPdTEs/kVJIE6qF4ePRFW2TyArUaQezkGph99ZbXjpMoM3dxG7DQOXST8mZ
         c1+eKdVcvJvnkJkIZ+RLeSEwzGni10yYKWgsbcXzi13MxuIv7sOIdVDDLI7HiPItq4zS
         TAA55ETYxapXT870Io7ZOvAMKNOgZYl2gm04ks2Eo+5hDlSyG4ANAqm3XADSgyT0GKxV
         R0oJ4swklTVnfgCLsOjQm8yGUnOR+u5uger8LPHgzPCVYeAtrLXwJkqAbv6tt1l5OvoJ
         kAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1w7Q+TlbIJEDf050IMqqi4cI13qRxqpQFb6QhY6iVGE=;
        b=gcxo74C4+HlQb5Zif1yLmtLdQKWungeioh07+nY7yQCBWRmLPP3jxXcd7Cmj77DPoO
         ZsYzlnBDmF/kSAYTQeHWjmyAwBHk9THx1N/W5NG1Qvrq+wNc1fRODrDIOgSoAH7p8RIu
         +CjQXb82FYIEXBYBB+JhQiFiBpdcXRVIpxzpoyXx04AS6dfRIGOtJGuYKKAwAZOwqpJs
         7N32tIfEnJtvxQqid7w0J0QfvohhtiO94iY/Q8JV0i/FLmGN9DJXGOoRfTc1mpetc8IP
         OXspoBa7zyNEPhfWqiEFyNRYwsuofOu2eezWZPuGvyvn44yC39c+hhyYSkPL3MSPd1fS
         gy0Q==
X-Gm-Message-State: AOAM532zkzV0yxvwmfSh0vqOS72qpwOFK2BaxXm3OulUWQ4AV7AqeBBe
        y50tJSKXJrZdr+ZK3vjOwXA=
X-Google-Smtp-Source: ABdhPJziyTQakmlQBaNSFkvjppamnRchFXlgLPonnDHc26LrwGve1C+vTvVaMQK9sIX0aOsnDjPWXw==
X-Received: by 2002:a17:90a:fc8e:: with SMTP id ci14mr17052054pjb.12.1631950920077;
        Sat, 18 Sep 2021 00:42:00 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id l142sm1276569pfd.87.2021.09.18.00.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:41:59 -0700 (PDT)
Date:   Sat, 18 Sep 2021 07:41:55 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: Sorry for annoyance. it's buggy.
Message-ID: <20210918074155.GA53700@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210918071552.53171-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918071552.53171-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it was actually misunderstanding.

I misunderstood counters - it is union, not just unsigned long :(
So changing inuse and frozen affects count and it's not meaningless. 

Sorry for annoyance.
