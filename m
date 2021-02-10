Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19139316941
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhBJOi0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Feb 2021 09:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhBJOiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:38:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5C7614A5;
        Wed, 10 Feb 2021 14:37:38 +0000 (UTC)
Date:   Wed, 10 Feb 2021 09:37:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210210093736.0b26f917@gandalf.local.home>
In-Reply-To: <20210210144409.36ecdaed@xhacker.debian>
References: <20210210144409.36ecdaed@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 14:44:09 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Add tracepoints to retrieve information about the invoke_fn. This would
> help to measure how many invoke_fn are triggered and how long it takes
> to complete one invoke_fn call.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> 
> Since v1:
>  - add BUILD_BUG_ON() macro usage to make sure that the size of what is being
>    copied, is not smaller than the amount being copied. Thank Steve.
>  - move optee_trace.h to keep include headers sorted

From a tracing point of view:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
