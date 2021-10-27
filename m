Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FC143CF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbhJ0RT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:19:57 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.93]:23131 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233702AbhJ0RTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:19:52 -0400
X-Greylist: delayed 1309 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 13:19:52 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 4AB57AA64
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:55:37 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id fmDBmkYjHIWzGfmDBmtjl7; Wed, 27 Oct 2021 11:55:37 -0500
X-Authority-Reason: nr=8
Received: from host-79-18-63-114.retail.telecomitalia.it ([79.18.63.114]:46384 helo=[10.0.0.43])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mfmDA-001rC0-0h; Wed, 27 Oct 2021 11:55:36 -0500
Message-ID: <c6eee2dc-5019-14ca-762a-3f2a8d26ebf8@kernel.org>
Date:   Wed, 27 Oct 2021 18:55:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V6 08/20] rtla: Helper functions for rtla
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1635284863.git.bristot@kernel.org>
 <183637700a31169e5d6d1c8a827c5365599ec806.1635284863.git.bristot@kernel.org>
 <YXlcBhnqiKVxV4UX@geo.homenetwork>
 <575a2d6b-9e37-5566-9343-e77e4f4e8c1f@kernel.org>
 <20211027123702.09564df2@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20211027123702.09564df2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.18.63.114
X-Source-L: No
X-Exim-ID: 1mfmDA-001rC0-0h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-18-63-114.retail.telecomitalia.it ([10.0.0.43]) [79.18.63.114]:46384
X-Source-Auth: kernel@bristot.me
X-Email-Count: 15
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 18:37, Steven Rostedt wrote:
> On Wed, 27 Oct 2021 18:24:01 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> Steven, I am tempted to start placing fixes patches on top of this series. What
>> do you think?
> 
> Please don't. But you can also wait a few days before you post another
> version. You don't need to post a new version for every comment. Especially
> when the reviewers are not done reviewing the patches.

yeah, I was being overly optimistic... It is what was left from the youth Daniel
ahah.

-- Daniel

> The default is to wait a week, although I would say at least wait 3 days
> after the last comment was made.
> 
> -- Steve
> 

