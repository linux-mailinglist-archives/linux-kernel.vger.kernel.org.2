Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06F5393AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhE1BB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 21:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhE1BB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 21:01:28 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BD73613AF;
        Fri, 28 May 2021 00:59:53 +0000 (UTC)
Date:   Thu, 27 May 2021 20:59:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Yejune Deng <yejune.deng@gmail.com>, 0day robot <lkp@intel.com>,
        Yejune Deng <yejunedeng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        rafael.j.wysocki@intel.com, npiggin@gmail.com,
        mark.rutland@arm.com, elver@google.com
Subject: Re: [irqflags]  21db66c4ff:  will-it-scale.per_process_ops -4.5%
 regression
Message-ID: <20210527205951.2490d75b@oasis.local.home>
In-Reply-To: <20210525070354.GD7744@xsang-OptiPlex-9020>
References: <1621824679-29258-1-git-send-email-yejunedeng@gmail.com>
        <20210525070354.GD7744@xsang-OptiPlex-9020>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 15:03:54 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> FYI, we noticed a -4.5% regression of will-it-scale.per_process_ops due to commit:

As Mark explained, your patch was not a nop. And the 0day bot just
showed you why we didn't do it the way you suggested.

-- Steve
