Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA28740321A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 03:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242547AbhIHBS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231577AbhIHBSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:18:25 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D8C461131;
        Wed,  8 Sep 2021 01:17:17 +0000 (UTC)
Date:   Tue, 7 Sep 2021 21:17:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     qiang.zhang@windriver.com
Cc:     bristot@redhat.com, bristot@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] trace/osnoise: Fix missed cpus_read_unlock() in
 start_per_cpu_kthreads()
Message-ID: <20210907211714.696cca61@rorschach.local.home>
In-Reply-To: <20210831022919.27630-1-qiang.zhang@windriver.com>
References: <20210831022919.27630-1-qiang.zhang@windriver.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 10:29:19 +0800
qiang.zhang@windriver.com wrote:

> From: "Qiang.Zhang" <qiang.zhang@windriver.com>
> 
> When start_kthread() return error, the cpus_read_unlock() need
> to be called.
> 
> Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
> Cc: <stable@vger.kernel.org> # v5.14+

FYI, no need to add the "# v5.14+", as it also breaks my scripts. The
"Fixes:" tag is now used to know what stable releases it needs to be
applied to (if any).

Daniel, that goes for you too, as you suggested it ;-)

-- Steve
