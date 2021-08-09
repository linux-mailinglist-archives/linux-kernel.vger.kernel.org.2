Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57713E4A3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhHIQtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32339 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233175AbhHIQtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628527723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ENPrgo5w35+KlcK+SuK2nefYio5S7IHYrfuMgY1BhrU=;
        b=fHG/UgYPBR9iOyPUaU4iyo4lC+nRqGsrKdjzE4dxKrMHfnRNw7Chn9914HzHyApHm8enuU
        H4qsz72paln2E2/oAm7n0oEAWHpyfT7YXfM16f33TweyGjyg6lbN6Nsz8b5co5mp49eFKf
        RDvS9dbOGtORbd05RhwZ8i3nEo47/04=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-QBh6WgkBN-6UMEdWAsGqyQ-1; Mon, 09 Aug 2021 12:48:42 -0400
X-MC-Unique: QBh6WgkBN-6UMEdWAsGqyQ-1
Received: by mail-ed1-f69.google.com with SMTP id e3-20020a50ec830000b02903be5be2fc73so3167498edr.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ENPrgo5w35+KlcK+SuK2nefYio5S7IHYrfuMgY1BhrU=;
        b=qoVFZsJlDO0tyuqQKA0FRajPhmNrcxdbHrXqej5HoqZ30InXuyp1GGsfOOu1IyWt4D
         lTQ6yHbVevRikzUobU1q0eqCtC4ahmYjjCMbXeqljeyin0+4NyULm3M/afrHgmSK4YKB
         WDpr2cRYrdHThM+WGWwBhjlh2wazBBkuaJZohHUVyuQKH2xu2zFeUexJGGvB39XSgpll
         DSzZ38gceegWbE7q7n/Whr/gICuUWWRoMfRf2wae6vK6P1e+x5EdNChqT1tCTgkZr4Yy
         5dnnzzKnLwBnw2y3VYSww3dXzlVyeq7oxckkJMipAyx2LVCfczPbjvZr7XGah0+UYLzV
         Z/ZQ==
X-Gm-Message-State: AOAM533fOuEo8LHuewkdhQ7DA7QL9xzTQyQPSQ3xwJKzUSafo6PMuh25
        y4JiJ1yLl35xfzde29TszAiCzNADy6B6wO9RNydN6xTtGFBftMp3G3bw6Eku0cBmfjA+EiRBsf/
        gl/ui+muyX8Qk0OK9GZo0cREX
X-Received: by 2002:a17:907:105d:: with SMTP id oy29mr8790343ejb.531.1628527721227;
        Mon, 09 Aug 2021 09:48:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWhL/TutsCnX+TvG9NXtv2hLoc0vQwzt47UrweXrSao686agiImAhFYd5A36TNMkJg9tnVLg==
X-Received: by 2002:a17:907:105d:: with SMTP id oy29mr8790301ejb.531.1628527720963;
        Mon, 09 Aug 2021 09:48:40 -0700 (PDT)
Received: from x1.bristot.me (host-79-27-15-231.retail.telecomitalia.it. [79.27.15.231])
        by smtp.gmail.com with ESMTPSA id r27sm8344695edb.66.2021.08.09.09.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 09:48:40 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Phil Auld <pauld@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ben Segall <bsegall@google.com>, Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        patrick.bellasi@matbug.net,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rik van Riel <riel@surriel.com>,
        Hillf Danton <hdanton@sina.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Paul Turner <pjt@google.com>,
        Dario Faggioli <raistlin@linux.it>,
        Andi Kleen <ak@linux.intel.com>, Scott Wood <swood@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>, Mark Brown <broonie@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [ANNOUNCE] CFP: Scheduler Microconference - Linux Plumbers Conference
 2021
Message-ID: <b325be52-7dec-4682-c0e4-43c978250dca@redhat.com>
Date:   Mon, 9 Aug 2021 18:48:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler is an important functionality of the Linux kernel, deciding what 
process gets to run when, where, and for how long. With different topologies and 
workloads, it is no easy task to give the user the best experience possible.  
Schedulers are one of the most discussed topics on the Linux Kernel Mailing 
List, but many of these topics need further discussion in a conference format.  
Indeed, the scheduler microconference is responsible for many topics to make 
progress.

At last year's meet up, the Scheduler microconference achieved the following 
results:

 - Core scheduling was merged! [1]
 - Scheduling fairness patches have been merged [2]
 - Fixes to NUMA topology limitations[3]

Not only were enhancements made, but the meet-up also helped prove that some 
topics were not feasible and we do not need to spend more time on them [4].

Some possible topics for this year are:

 - Cgroup interface and other updates for core-scheduling [1]
 - Cgroup and SCHED_DEADLINE [5]
 - Capacity Awareness – For busy systems
 - Interrupt Awareness
 - Load Balancing:
     -  Wakeup [6] [7] [8]
     -  Periodic [6] [7]
     -  NUMA load balancing

If you are interested in participating in this microconference and have topics 
to propose, please use the LPC CfP process, and select "Scheduler MC" for the  
"Track". More topics will be added based on CfP for LPC microconference.

The submission deadline is August 31st.

Come and join us in the discussion of controlling what tasks get to run on your
machine and when. We hope to see you there!

In case of doubts, feel contact the MC Leads:

Daniel Bristot de Oliveira <bristot@redhat.com>
Dhaval Giani <dhaval.giani@oracle.com>
Chris Hyser <chris.hyser@oracle.com>
Juri Lelli <juri.lelli@redhat.com>
Vincent Guittot <vincent.guittot@linaro.org>

[1] https://lore.kernel.org/lkml/20210422120459.447350175@infradead.org/T/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edaa5ddf3833669a25654d42c0fb653dfdd906df
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=620a6dc40754dc218f5b6389b5d335e9a107fd29
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=585b6d2723dc927ebc4ad884c4e879e4da8bc21f
[4] https://linuxplumbersconf.org/event/7/contributions/762/
[5] https://lore.kernel.org/lkml/cover.1610463999.git.bristot@redhat.com/
[6] https://lore.kernel.org/linux-arm-kernel/20210420001844.9116-5-song.bao.hua@hisilicon.com/T/
[7] https://www.spinics.net/lists/kernel/msg3894298.html
[8] https://www.spinics.net/lists/kernel/msg3914884.html

