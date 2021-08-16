Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ADE3ED884
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhHPOD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:03:27 -0400
Received: from mail.efficios.com ([167.114.26.124]:51008 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhHPODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:03:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 637BF382651;
        Mon, 16 Aug 2021 10:02:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bNylGs34V7ob; Mon, 16 Aug 2021 10:02:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F3877382650;
        Mon, 16 Aug 2021 10:02:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F3877382650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1629122571;
        bh=ejQJikqjD1O5aRG34kThZj9GE5/6cz818qSzrHRyM8I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=e5yp/2y2flWtjQ5dfEkrTAJYlp3Y7olGMYSPnJdpvRnpX1w27hG+9c1XsT980HBcS
         dhffavbQe+b0LCVTkIyyAkBiE1B+oBvzZUd/BpEeNt+4iwxrSdFfwjtBCrdmmxAPgj
         S6QHQTNjQO2Rx2UFKr/c9pSlWJYZPzJAzaM1GdHRAWGuvkwgVl9rffy8GT/UmVaixV
         TZrTjQvh9kfGzkru/7Qu0SBKC2kQ/6Vk/cCWqnX9sL8DnFCDpnyMU/dVl11y1tVZwi
         GUz0pnqKW4SnQk0wzL5aUH9xCYLUMSuiViTMX8SYtmwL17UVt2ijV8H+NRoUrPVi3u
         X8OiFWv2cgMvQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JlLKERSo0MOA; Mon, 16 Aug 2021 10:02:50 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E3E3738264F;
        Mon, 16 Aug 2021 10:02:50 -0400 (EDT)
Date:   Mon, 16 Aug 2021 10:02:50 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     zhaoxiao <zhaoxiao@uniontech.com>, rostedt <rostedt@goodmis.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2005434147.15227.1629122570891.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210816052430.16539-1-zhaoxiao@uniontech.com>
References: <20210816052430.16539-1-zhaoxiao@uniontech.com>
Subject: Re: [PATCH] tracepoint: Fix the comment style
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4101 (ZimbraWebClient - FF90 (Linux)/8.8.15_GA_4059)
Thread-Topic: tracepoint: Fix the comment style
Thread-Index: nOonbYm9y07I5uROTWjvFI3b10hu6Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2021, at 1:24 AM, zhaoxiao zhaoxiao@uniontech.com wrote:

> Fix function name in tracepoint.c kernel-doc comment
> to remove a warning found by clang_w1.
> 
> kernel/tracepoint.c:589: warning: expecting prototype for
> register_tracepoint_notifier(). Prototype was for
> register_tracepoint_module_notifier() instead
> kernel/tracepoint.c:613: warning: expecting prototype for
> unregister_tracepoint_notifier(). Prototype was for
> unregister_tracepoint_module_notifier() instead

Thanks!

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
> kernel/tracepoint.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index efd14c79fab4..64ea283f2f86 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -577,7 +577,7 @@ bool trace_module_has_bad_taint(struct module *mod)
> static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
> 
> /**
> - * register_tracepoint_notifier - register tracepoint coming/going notifier
> + * register_tracepoint_module_notifier - register tracepoint coming/going
> notifier
>  * @nb: notifier block
>  *
>  * Notifiers registered with this function are called on module
> @@ -603,7 +603,7 @@ int register_tracepoint_module_notifier(struct
> notifier_block *nb)
> EXPORT_SYMBOL_GPL(register_tracepoint_module_notifier);
> 
> /**
> - * unregister_tracepoint_notifier - unregister tracepoint coming/going notifier
> + * unregister_tracepoint_module_notifier - unregister tracepoint coming/going
> notifier
>  * @nb: notifier block
>  *
>  * The notifier block callback should expect a "struct tp_module" data
> --
> 2.20.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
