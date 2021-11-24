Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592DC45C863
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhKXPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233512AbhKXPT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:19:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BCB660F45;
        Wed, 24 Nov 2021 15:16:18 +0000 (UTC)
Date:   Wed, 24 Nov 2021 10:16:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <rui.xiang@huawei.com>
Subject: Re: [PATCH] trace: Fix a kmemleak noise
Message-ID: <20211124101616.618ee8f2@gandalf.local.home>
In-Reply-To: <20211124140801.87121-1-chenjun102@huawei.com>
References: <20211124140801.87121-1-chenjun102@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 14:08:01 +0000
Chen Jun <chenjun102@huawei.com> wrote:

> The reason is elts->pages[i] is alloced by get_zeroed_page.
> and kmemleak will not scan the area alloced by get_zeroed_page.
> The address stored in elts->pages will be regarded as leaked.

Why doesn't kmemleak scan get_zeroed_page? And if that's the case, how does
all the other locations in the kernel that call get_zeroed_page handle this?

-- Steve
