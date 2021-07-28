Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC83D8EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhG1NOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1NOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:14:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BEEC061757;
        Wed, 28 Jul 2021 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GLs20Pvs0SB3MahpgVmKF84+QdadWR1ytigyGFlYBm4=; b=Oqi+E/OHJ/M7SZ1NXx7hOvIAKC
        fBc+CT2dhNdTp0JULuvYQGXu0PlcQvQ/yntxBqAGROLw6QSIhY0mmaxrGbHtZgN6gec8naGVVAc1e
        tWeBguo1awqdFJnurXA4BNRruysyO+GMgHUX9ZeHsVxpyG8rx6t81jgGebB4KMeo9maIHPyb3v5s1
        AGXjCRmOL8unO1cGTibHbmYgdqEu+yQNtb2I4pOddd7x2xxUAjZTFgynkVP/TustmZsQ/ncIp5E2W
        GZOw450Vrl4eXatAUwrCtrYul43sk+3+zvA++jDL4M9mOG4NTyeV+ORcgZ4HfPlJ08fWoW2cUEfan
        Jz9fOEcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8jNL-00G4lq-2R; Wed, 28 Jul 2021 13:13:50 +0000
Date:   Wed, 28 Jul 2021 14:13:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shivank Garg <shivankgarg98@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, util-linux@vger.kernel.org
Subject: Re: /proc/pid/sched units
Message-ID: <YQFX+8+y9CUjgwB4@casper.infradead.org>
References: <CAOVCmzEJqg6=FW3Vu1MScyj8GS-KXb2s_ztxBxwDmcbN5sbQuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOVCmzEJqg6=FW3Vu1MScyj8GS-KXb2s_ztxBxwDmcbN5sbQuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 06:26:44PM +0530, Shivank Garg wrote:
> Hi Everyone,
> 
> I'm analyzing the cpu time taken ("se.sum_exec_runtime" in
> /proc/$pid/sched) by process in different configurations for my
> project work. But I was not able to get the time units for the values
> displayed in the file. I tried searching it in source code -
> kernel/sched/cputime.c,include/linux/sched.h etc. but it left me more
> confused.

include/linux/sched/types.h: * @sum_exec_runtime:       total time spent on the CPU, in nanoseconds

why did that leave you more confused?
