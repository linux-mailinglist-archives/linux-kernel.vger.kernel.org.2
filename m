Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601323B9DDE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhGBJFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhGBJFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:05:24 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA4AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 02:02:52 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id fi7so3787479qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 02:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wouMDCEmOnlrtZpz+FmGiW0VfGP4ffRcioS0po6bc8s=;
        b=X7JOsLAafvEHvG56iOX5jXaqRQmCKP3BB2bW+XKDjEg+RQ+8oV57Gzw6ir7AG4RoSM
         F7asgFx8TsxTOAladJDiv3UL6fsv8GF4Z1xJzHmLjC5++YjcaSGULk5M6t7oK2OOvbGG
         kA9QnuddYZwTTZ7E6+CinnViHSQFgQYk+TyO5wNK4rZqeM606x1gUIVhs7BcsFriITaK
         lV8K9zXgQN3x9idUOFymeaf9+aKxEsRGerh2nAg9EYsoTcleTX9NXV1Fwp+AYAv2xhs+
         Gf2DiaNKGTc6/U6E49Pz5sUW1l7uHLP3XagblzdcgBxps6N2KvsrQcLV9B5Sk5dJVvbh
         WYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wouMDCEmOnlrtZpz+FmGiW0VfGP4ffRcioS0po6bc8s=;
        b=tKniFoRFsN5R2Q6Zit5klTDx/LA1SuA6Fes23apmAWxIRs+X465ljgdnteQfE4ZtMW
         rVXh6shTFCMhvWKh3T4jaUGuBRm605cUiASFB4ONco96RrQpztaMb40Y749HPCwC/pNX
         Ti80G7Rkry2s+ktvYXG/TSC4C8FWAf60e1z3IvnJfT+5CniphyiIF4eKDDFr4j9hbbZy
         Bc0Q+fIVxf6w423vs3kRlTTyS1wqoQZhXt9XSFkpBAwZk1hgmpU52x1ckggu61lkgYlq
         DvYSiaN+ra7ASB/I4y5PKDa+HQiEjgwP/wxR9cLFqItQ2OAX0l+Vet6NenYTQxcYlrCu
         F4jQ==
X-Gm-Message-State: AOAM531SsAFZoL35MZMw1ZEdmMIn6ZOAuye+jCQDC1c45E8DNiXFTKnS
        W8jgGxh/np3UF6UYqP9nuPbKcMEriDtRQiF/wpVfFw==
X-Google-Smtp-Source: ABdhPJz++9pQjQJNHMuS8p75EJ/pDmspUEOo68yPT9csG9HF/y+MvDCpmi0DF7+I3HHZy50g1zLQkTLue9Cm7YSwKbg=
X-Received: by 2002:a0c:b752:: with SMTP id q18mr4134963qve.6.1625216571739;
 Fri, 02 Jul 2021 02:02:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:1715:0:0:0:0 with HTTP; Fri, 2 Jul 2021 02:02:51
 -0700 (PDT)
In-Reply-To: <CAKfTPtCuV6iCRfb53Avu7=+rV6G=AYYRyutqm0_LJU6mVV1kKg@mail.gmail.com>
References: <20210701171837.32156-1-vincent.guittot@linaro.org>
 <DAABF914-F5D0-4C92-BFE0-341D83B9F3D0@linux.vnet.ibm.com> <CAKfTPtCuV6iCRfb53Avu7=+rV6G=AYYRyutqm0_LJU6mVV1kKg@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Fri, 2 Jul 2021 11:02:51 +0200
Message-ID: <CAFpoUr1fA-1NFQ2YvZuT21qjvM89QKyi-Q2agX7bpUqz6COOXw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Sync load_sum with load_avg after dequeue
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Odin Ugedal <odin@uged.al>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

Reviewed-by: Odin Ugedal <odin@uged.al>

Odin
