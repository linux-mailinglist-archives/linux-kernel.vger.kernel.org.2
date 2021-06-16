Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBA03AA337
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhFPSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231858AbhFPSdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:33:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3470660233;
        Wed, 16 Jun 2021 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623868293;
        bh=K/zv0RYYHjMIXPCNC8kFGwHg1xvoxIhY4ZE4W5uBEQc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DFrmhp/yHde/NgfCrqZ86WuY8OOvlqVg2JX46GqI1Sbnaiyg8TdK7LrYn3NI9/RYV
         4+z1NVCifahnIynH2tQmUZIndcW0roEDHkb5qEQElcu2KLPYet1b6tB8dZr+DzAqcw
         yhXxvgUDArA9hMFHBrVAyLbxJqMJzoRVjPKK5ZFr0JPmIf6QlJfVLK96PF303Hnhan
         Fc/TZdmG6OkDAxBdnrA55ZNbqcvhx7vsmMLtusEfOOoqOzl2FrHT4mm1x/rPAHr8JD
         nJTNtGBM/wrNBCxoEhbTko7GIgY2QPCfNelQS3/pZvVnf0DktTzhjUrQVRlf+HASr3
         Ot09X4X6UTumQ==
Subject: Re: [PATCH 2/8] x86/mm: Handle unlazying membarrier core sync in the
 arch code
To:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1623813516.git.luto@kernel.org>
 <571b7e6b6a907e8a1ffc541c3f0005d347406fd0.1623813516.git.luto@kernel.org>
 <1623817261.p1mg6dm2ud.astroid@bobo.none>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <097dee91-dae5-f58d-d0c8-87522079a658@kernel.org>
Date:   Wed, 16 Jun 2021 11:31:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623817261.p1mg6dm2ud.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 9:25 PM, Nicholas Piggin wrote:
> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:

> I'm fine with the patch though, except I would leave the comment in the
> core sched code saying any arch specific sequence to deal with
> SYNC_CORE is required for that case.

Done.
