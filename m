Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB5A35564A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344997AbhDFOQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344993AbhDFOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:16:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E4BC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 07:16:15 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c6so11261663qtc.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7QNqnHfmfB+qZd6+/+JDJ7LdbsfNDRF6gz/dsivHuOw=;
        b=syvpuZy1TSPELHcW35heDbPZa/1Jcb7gZQj2RYxy1FYI6j7LiXj06FDijFGMsf9BJN
         lsCJ25o73ABAhqpN7B1N2/P9FAYixuiFbGGXsGANMnuojdqgoQI4lxhXCkrevnbdSQwY
         pQkRHEQkDaRHtX7WsYqczlfY9LPPmJo0FyD4szgrKZ11LaB90m2+eJ+H91NCSAV0wU3b
         ia++C8Hn6+HGzRuRa4hv39TyvtGCEwOjg0X2CJ3aLKn9TT9VcCRQ+GD/p7i9DaxY/L3u
         OPDONWBLyliBXI34BaSZwvZ3v91MaBapfULx/+HgfcLl4q3KBZsjf/lgQ6luacZYcl6d
         2ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7QNqnHfmfB+qZd6+/+JDJ7LdbsfNDRF6gz/dsivHuOw=;
        b=BtlrJvcoGXf5biPQpDovvQy7M7UIMrpcfWQEvjE0fAI2Qx9kzkkqvP9YVmdRgz6rit
         jZUPKnxmB7y4oBsFUiAec9E5pJO8eTCn1v9yEZzNc3SzmlxfkwkU9r2HN99MTj/BX6tk
         0ijjHT5FMucfNZ0XRWSTfYZLNzrf6p5oq2HVoV0s/lX+8K4ggRU3DK9kUutmW9MKcSv2
         T0XxHGNISZXl40gFjlz2EziiL0m6tzh2LjlP3uL3Ng33knhmjRRsjRfg3bQb8s9LdxFC
         3ICxA5NN3JLp3VQdf0qbrbR2kEIJM7gH196EzHxX8AN6gBmj8DinMSfIpAGCaBETZfYm
         iM9g==
X-Gm-Message-State: AOAM5325hec2rU47eW8n4LL+blGvJ5ujY27engbfsU7+cvn7PwqY/v1u
        f4FnURxfgDXbdVUnm5oodvA=
X-Google-Smtp-Source: ABdhPJw19HPW7yN9Lsz6oCbcQm5hK83V1Sm59QcQJAqWlmEyNp5+UUaMuRZtHw7O3yJrMwnP3Hk1Sg==
X-Received: by 2002:ac8:424b:: with SMTP id r11mr27930494qtm.311.1617718574197;
        Tue, 06 Apr 2021 07:16:14 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id d18sm14065309qtd.85.2021.04.06.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:16:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Apr 2021 10:16:12 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YGxtLOxCb4LO8kN0@slm.duckdns.org>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <CAEXW_YSS0ex8xK7t2R7c1jiE4eNbwxdwP2uyGPDK78YAaYQr5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSS0ex8xK7t2R7c1jiE4eNbwxdwP2uyGPDK78YAaYQr5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Apr 05, 2021 at 02:46:09PM -0400, Joel Fernandes wrote:
> Yeah, its at http://lore.kernel.org/r/20200822030155.GA414063@google.com
> as mentioned above, let me know if you need any more details about
> usecase.

Except for the unspecified reason in usecase 4, I don't see why cgroup is in
the picture at all. This doesn't really have much to do with hierarchical
resource distribution. Besides, yes, you can use cgroup for logical
structuring and identificaiton purposes but in those cases the interactions
and interface should be with the original subsystem while using cgroup IDs
or paths as parameters - see tracing and bpf for examples.

Thanks.

-- 
tejun
