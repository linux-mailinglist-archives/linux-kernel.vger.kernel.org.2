Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C84084B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhIMG3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:29:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52526 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbhIMG3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:29:45 -0400
Date:   Mon, 13 Sep 2021 08:28:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631514509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YHVS4ggR2N4fiwQY6f6vC3zFQGRcxYhcQoljW7DEmRA=;
        b=MEGqEw6B0U3q9No2Q2J5xmF7fnpn+DMobBiwqc/MvWU8fAcuxv80tIMyO3IobsxkBtuUoh
        qaecd35BHtRUaO0xV0fQzIhM1QNmwyI0jBIY/B3wHhXVuCEl1GcfSIXe5gygTBERyDkEOZ
        hjm2V5bTd5ZkduJ2ojnEFeOcGcC359NedsYH59n7qFFvTvcB0kLSzcPMAH+bvLgSw6w9ff
        nuFupgkGbphSAF24RdbnkIqowGT7SLbj5pRSOr8F5CGMFqtKLLHTwfF69tpkfhvB9suNna
        acQCW3WaTAG9N/3wXceocG/eP/tTQYrNhSfAjIMdiG7S8fKiy4zwiAIyS+MY6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631514509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YHVS4ggR2N4fiwQY6f6vC3zFQGRcxYhcQoljW7DEmRA=;
        b=EhXBodGLG3ChkuGTmgFn+R6qtYByxEGraUbesWb9h9Omo4Soy8TGvHaEo8Z1HrEl6Xg9Z8
        1f+UZ7qibScUiTBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V5 34/72] locking/rwlock: Provide RT variant
Message-ID: <20210913062828.fu7f5n6wc3nw4lyt@linutronix.de>
References: <20210815203225.710392609@linutronix.de>
 <20210815211303.882793524@linutronix.de>
 <d456062c-d5d4-be8a-d960-1a1d43f63456@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d456062c-d5d4-be8a-d960-1a1d43f63456@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-11 10:59:11 [+0800], Xiaoming Ni wrote:
> rt_rwlock_is_conted() exported but not declared in the header file?
> Is this a special design or a mistake?

under discussion, see
   https://lkml.kernel.org/r/20210906143004.2259141-1-bigeasy@linutronix.de
   https://lkml.kernel.org/r/20210910163704.ykotcrvbt6yaqron@linutronix.de

> Thanks
> Xiaoming Ni

Sebastian
