Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545EE31F224
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhBRWPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:15:16 -0500
Received: from mail.efficios.com ([167.114.26.124]:40732 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBRWPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:15:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8D98829EC9E;
        Thu, 18 Feb 2021 17:14:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ouFG5lUhns2P; Thu, 18 Feb 2021 17:14:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3778729EC9C;
        Thu, 18 Feb 2021 17:14:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3778729EC9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613686464;
        bh=Tee7rWuqCoOit0acxEiklVLLKfdEi65Akx9WfZEn67U=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tunEDOZADLoQBI0E5yPYqJ1I8/0Mvnt0RmBX/hIKkDHfNZXKzmEeTmMfqiYS1pY2/
         2huxKpYkVher2PRU0wWjdW2bfJTBmBQXqHpDxwcDCxvrUCeSedMNqtBPPJekz/H+gs
         TYDWr384S4uRDh/R4seUWtNDhlL5YPvU7uNFpZFT3JR9OGNgoGvpfrjkp24SSgBqtv
         QEAnx+PoV4tfExQb4ousFCE9dO7R2PwdXxiWosg/KYjggo3NqTfMcbivp97CRNubjG
         eHYgcegIQWiFtiIibPQUHnqZ9ZX+De+PDzfrDazyXSjn41UIWgXkadnGDshqkPex2W
         +7PIzyntTQ0Iw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kR94IUP1C6jg; Thu, 18 Feb 2021 17:14:24 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2B9FC29EC9A;
        Thu, 18 Feb 2021 17:14:24 -0500 (EST)
Date:   Thu, 18 Feb 2021 17:14:24 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev <lttng-dev@lists.lttng.org>
Cc:     linux-trace-users <linux-trace-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2137653784.27421.1613686464160.JavaMail.zimbra@efficios.com>
Subject: lttng-trace: a new strace-alike LTTng command
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Index: Lfx1OD8Hxjqn+78W97ARTlbDOIKMug==
Thread-Topic: lttng-trace: a new strace-alike LTTng command
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I just pushed a new command line tool named `lttng-trace`, which allows tracing a
specific command and its sub-processes using the LTTng system call tracer. It focuses
on simplicity. It can be found here:

  Git website: http://git.lttng.org/?p=lttng-trace.git

Clone with:

  git clone https://git.lttng.org/lttng-trace.git

For instance, tracing the command "date" is as simple as:

  lttng-trace date

The tracing session can be optionally configured by using the usual lttng control
interfaces after this message appears:

[lttng-trace] Tracing session `date-20210218-170545` created. It can be customized using the `lttng` command.
[lttng-trace] Press <ENTER> key when ready to run the child process.

After execution of the command, the following message details how to view the trace:

[lttng-trace] Sub-process hierarchy traced successfully. View trace with `babeltrace2 /tmp/lttng-trace/date-20210218-170906`

See `lttng-trace --help` for more options.

This new command is in early alpha stage. Feedback is welcome! For instance, we are wondering whether
the default behavior should just be tracing system calls, or if some level of user-space tracing should
be enabled by default as well. Or if some new options should enable "typical" usage scenarios.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
