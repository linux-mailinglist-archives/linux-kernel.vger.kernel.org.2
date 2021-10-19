Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95D5433E26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhJSSMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232130AbhJSSMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:12:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B9361057;
        Tue, 19 Oct 2021 18:10:04 +0000 (UTC)
Date:   Tue, 19 Oct 2021 14:10:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] Performance deterioration caused by commit
 85f726a35e504418
Message-ID: <20211019141002.386e7b6a@gandalf.local.home>
In-Reply-To: <a138a0db-94a0-f77e-9b2d-bcffcba6862b@linux.intel.com>
References: <992d3b1c-70db-5cc7-8400-39caa5d502d5@huawei.com>
        <20211018093731.2dd5917f@gandalf.local.home>
        <19e4222c-c9ac-5c1a-0c3a-b8bfd3524ab7@huawei.com>
        <20211018225112.3f6bda99@gandalf.local.home>
        <a138a0db-94a0-f77e-9b2d-bcffcba6862b@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 12:30:28 -0500
"Zanussi, Tom" <tom.zanussi@linux.intel.com> wrote:

> So anyway, as far as the histograms go, I think optimizing the two
> changes in 85f726a35e504418 while ignoring trailing garbage can be done
> without affecting the histogram correctness.

So, none of that is exported to user space?

-- Steve
