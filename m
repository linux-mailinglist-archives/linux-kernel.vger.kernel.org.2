Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909F63B4473
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhFYNaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231690AbhFYN34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:29:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BBC61976;
        Fri, 25 Jun 2021 13:27:35 +0000 (UTC)
Date:   Fri, 25 Jun 2021 09:27:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        ying.xue@windriver.com, "Li, Zhiquan" <Zhiquan.Li@windriver.com>
Subject: Re: [PATCH] seq_buf: let seq_buf_putmem_hex support len larger than
 8
Message-ID: <20210625092733.63bde998@oasis.local.home>
In-Reply-To: <06010fbf-1d46-3313-1545-b75c42f19935@windriver.com>
References: <20210624131646.17878-1-yun.zhou@windriver.com>
        <20210624105422.5c8aaf4d@oasis.local.home>
        <32276a16-b893-bdbb-e552-7f5ecaaec5f1@windriver.com>
        <20210625000854.36ed6f2d@gandalf.local.home>
        <06010fbf-1d46-3313-1545-b75c42f19935@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 15:28:25 +0800
Yun Zhou <yun.zhou@windriver.com> wrote:

> Hi Mr Steven,
> 
> I found that you had ever wanted to enhance trace_seq_putmem_hex() to
> 
> allow any size input(6d2289f3faa71dcc). Great minds think alike. Your
> 
> enhancement will let the function more robust, I think it is very advisable.
> 
> Now we only need modify two lines to solve a little flaw, and to let it
> 
> more more robust.

You are still solving two bugs with one patch, which is considered a no-no.

One bug fix needs to go back to the beginning. If you want to add the
other update, then it could be labeled a fix to that commit. Either
way, it requires two patches.

-- Steve
