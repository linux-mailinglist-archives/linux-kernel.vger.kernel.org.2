Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F443E5BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbhHJNe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:34:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43424 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241515AbhHJNeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:34:25 -0400
Date:   Tue, 10 Aug 2021 15:34:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628602442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fShiZYCaMk2gHnoeA6tos56B08l/ETcR3/wV6YsybFI=;
        b=GL1ATN8jU7vjmXrcRDFbZ2ATVsnjRRpcRiSRj6ryy74Dv9pai+q70hDVhRgCPEK3XoCaR+
        bu5S7+c3EKxiX7qv/kim5X4KByevMBm7vF6OkSApXADzTL1xY0aCOpUEsVNKTTTzrrJwGq
        8Z4mauE0Q+kUveEJ1ppqlJ3YiASJG6qp9CBwny3kmfLNKnNXTb0OgZ2Ig7hYhbdaAFZkT3
        I1emjU6+U84UMePSSzk4snmIvBW804uRjFUNyLws3PMA6fAVuZp4jgwIZEHWP7/+366jN1
        /NVqE5FrbPrrYt+ZhE+BUc1GxHIuQLME/t/XBWBqKF7Ags0KnbEnRuxFpVypYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628602442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fShiZYCaMk2gHnoeA6tos56B08l/ETcR3/wV6YsybFI=;
        b=DwHd1UYyQEAKV3InHxid+eshzz6bOh/L3lcUx+eYPu19s2q6rNHXaPd6AT6u67cV3kIyOu
        jBlOhTqDj30NwkAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 36/38] tracing: Replace deprecated CPU-hotplug functions.
Message-ID: <20210810133401.6xhxtr2uwd36uase@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-37-bigeasy@linutronix.de>
 <20210803222637.0612b6aa@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210803222637.0612b6aa@rorschach.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-03 22:26:37 [-0400], Steven Rostedt wrote:
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Steven, could you please route this via your tracing tree?

> -- Steve

Sebastian
