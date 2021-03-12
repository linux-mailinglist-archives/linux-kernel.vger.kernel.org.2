Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B113396BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhCLSjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:39:19 -0500
Received: from mx1.riseup.net ([198.252.153.129]:60448 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233517AbhCLSjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:39:14 -0500
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DxvjY6hMPzDv4G;
        Fri, 12 Mar 2021 10:39:13 -0800 (PST)
X-Riseup-User-ID: 9761080F93156BC9C7A6806C2C7650E20C7CBBA6EC4AF15504943B3896730E07
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4DxvjY1LbKz1y6h;
        Fri, 12 Mar 2021 10:39:13 -0800 (PST)
Subject: Re: [PATCH v5] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210312173855.24843-1-jnewsome@torproject.org>
 <20210312102207.a347e38db375226a78cc37bf@linux-foundation.org>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project
Message-ID: <ccfef0d5-c419-0a8d-cf75-9642e9d11f94@torproject.org>
Date:   Fri, 12 Mar 2021 12:39:12 -0600
MIME-Version: 1.0
In-Reply-To: <20210312102207.a347e38db375226a78cc37bf@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 12:22, Andrew Morton wrote:
> 
> Could we please see some performance testing results to permit us to
> evaluate the value of this change?

Sure. I've been doing some ad-hoc measurements with the code below. It
forks 8k children and then waits for them in reverse order (forcing a
full list traversal each time). I'll need to reboot a couple times to
get apples-to-apples measurements on bare metal, though. I'll plan to
run with NUMCHILDREN = 0 -> 8000, by 100.

Does this look like it'd be sufficient, or is there more you'd like to
see? The current form doesn't use ptrace, but I expect the results to be
similar; (maybe more pronounced when tracing threaded children, since
every thread is in the tracee list instead of just the group leaders).

#define NUMCHILDREN 8000

void fork_and_wait() {
    pid_t children[NUMCHILDREN];
    for (int i = 0; i < NUMCHILDREN; ++i) {
        pid_t forkrv = fork();
        if (forkrv < 0) {
            perror("fork");
            exit(1);
        }
        if (forkrv == 0) {
            // child
            exit(0);
        }
        // parent
        children[i] = forkrv;
    }
    for (int i = 0; i < NUMCHILDREN; ++i) {
        int wstatus;
        if (waitpid(children[NUMCHILDREN - i - 1], &wstatus, 0) < 0) {
            perror("waitpid");
            exit(1);
        }
    }
}
