Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEAA381193
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhENUR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:17:56 -0400
Received: from mail.efficios.com ([167.114.26.124]:47584 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhENUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:17:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 243152B8753;
        Fri, 14 May 2021 16:16:44 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EH_EZa7z_b1E; Fri, 14 May 2021 16:16:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2A0EF2B86DC;
        Fri, 14 May 2021 16:16:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2A0EF2B86DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1621023403;
        bh=9TPfKsrWNTWjMuRzOgMfqO7nFVmgGuNpVQNMyB0qLd8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tT2AGbWjaeqjRPFJsnvrbz0Vt0KaUwJt6NTu4LXRnEqqFkUUwn6TZu4xg7BVvQfty
         I2FoNWu2oceuS0lQR8/V53+6FOJE5w1VPWXHOw8f+JkR142Z1ipvaAJAtJuPJDoW2D
         s30Fx7/lXQvb8gVY7yMx2aROmXV48F5T7UBWpkcVnuaGzqY6L1pFdi6Hnee8KU2FbF
         MIeLQSkSnP5OcSVIfqn8LElBpxiMVlnHouPQx8utIrjt73lRd8hdMmj/1WRB3PZE6M
         42pY5FO6A76NGpLw/CR1y+UhUaNr7BLOwoGHtVSPvDlRDDYPD+5Ekvu/bWJdlcl6vG
         1Pl1134h0j3oA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fz-5Jf-HqOng; Fri, 14 May 2021 16:16:43 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1CDE52B8835;
        Fri, 14 May 2021 16:16:43 -0400 (EDT)
Date:   Fri, 14 May 2021 16:16:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev <lttng-dev@lists.lttng.org>,
        Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Genevieve Bastien <gbastien+lttng@versatic.net>
Message-ID: <1811223777.46126.1621023403092.JavaMail.zimbra@efficios.com>
In-Reply-To: <1336422991.46023.1621021967687.JavaMail.zimbra@efficios.com>
References: <1336422991.46023.1621021967687.JavaMail.zimbra@efficios.com>
Subject: Re: [RELEASE] LTTng-modules 2.11.9 and 2.12.6 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: LTTng-modules 2.11.9 and 2.12.6 (Linux kernel tracer)
Thread-Index: 7GWFwXFXkLY7KtGgWu1JPUyXPl1BvkX71erz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 14, 2021, at 3:52 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi,
> 
> The 2.11.9 and 2.12.6 releases of the LTTng kernel tracer are the latest bug fix
> releases
> of the 2.11 and 2.12 stable branches of the LTTng modules project.
> 
> There are a few minor bug fixes, but those are the noteworthy changes:
> 
> - Support for 5.12 Linux kernels,
> - Support recent stable kernel branches 4.14, 4.19, 5.4,
> - Support for newer Ubuntu 4.15, 5.4 and RHEL 8.2/8.3 kernels,
> - Fix: increment buffer offset when failing to copy from user-space:
> 
>    Upon failure to copy from user-space due to failing access ok check, the
>    ring buffer offset is not incremented, which could generate unreadable
>    traces because we don't account for the padding we write into the ring
>    buffer.
>    
>    Note that this typically won't affect a common use-case of copying
>    strings from user-space, because unless mprotect is invoked within a
>    narrow race window (between user strlen and user strcpy), the strlen
>    will fail on access ok when calculating the space to reserve, which will
>    match what happens on strcpy.

There is one additional noteworthy set of changes in lttng-modules 2.12.6:

        * Disable block rwbs bitwise enum in default build
        * Disable sched_switch bitwise enum in default build
        * Add experimental bitwise enum config option

The block rwbs bitwise enum and sched switch bitwise enum were introduced late
in the 2.12 rc cycle, and ended up producing traces which were not strictly
conformant with the CTF 1.8 specifications: they were producing enumerations
with values associated with no known labels.

This causes Babeltrace 1 and 2, with default options, to generate warnings when
viewing kernel traces.

So those commits introduce a new build-time option which can optionally enable
those bitwise enumerations, e.g.:

 make CONFIG_LTTNG_EXPERIMENTAL_BITWISE_ENUM=y

So until we finalize the CTF2 specification and its implementation in the tracers
and trace viewers, this provides a way for experimental users of LTTng-modules to
keep generating those bitwise enumerations without producing warnings in the
default use-case.

Without this option, a simple integer field is emitted in the trace rather than a
bitwise enumeration.

Thanks,

Mathieu


> 
> Thanks,
> 
> Mathieu
> 
> Project website: https://lttng.org
> Documentation: https://lttng.org/docs
> Download link: https://lttng.org/download
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
