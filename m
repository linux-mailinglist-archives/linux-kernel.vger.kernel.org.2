Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7C355894
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbhDFPz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:55:29 -0400
Received: from foss.arm.com ([217.140.110.172]:45222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346083AbhDFPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9792C1063;
        Tue,  6 Apr 2021 08:55:19 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C03D3F792;
        Tue,  6 Apr 2021 08:55:17 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 1/3] sched/fair: Ignore percpu threads for imbalance pulls
In-Reply-To: <0bc97936-cb80-9c11-42b9-9cd2eb7340b9@arm.com>
References: <20210401193006.3392788-1-valentin.schneider@arm.com> <20210401193006.3392788-2-valentin.schneider@arm.com> <0bc97936-cb80-9c11-42b9-9cd2eb7340b9@arm.com>
Date:   Tue, 06 Apr 2021 16:55:12 +0100
Message-ID: <87k0pfo1b3.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/21 17:35, Dietmar Eggemann wrote:
> On 01/04/2021 21:30, Valentin Schneider wrote:
>> From: Lingutla Chandrasekhar <clingutla@codeaurora.org>
>> 
>> During load balance, LBF_SOME_PINNED will bet set if any candidate task
>
> nitpick; s/bet/be ?
>

Yes indeed...

> [...]
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
