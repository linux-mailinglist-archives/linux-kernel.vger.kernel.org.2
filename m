Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A03AE96F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhFUM5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhFUM5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:57:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D92AF61026;
        Mon, 21 Jun 2021 12:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624280094;
        bh=ZAjvql/WozVxJBMClscRiTlo3MN4OgvT5SVv+auyNe4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qneNoNXPAz0jZ1yeBFTZWDeRZqVahSNNMbgA+FIk4yEvEUC7UwdgZ13QC5ekuBLFT
         LwalqS4v6eymMGyLRlhH0JbD1QVUiihbR5Xd9X/86SmF0UhtevQ1g7gcZdoFVMn7bb
         DtGIroST6RHBLJL5fgQJGbxUWk1PckxCdge1EtH9DDusgZey1E1ssD/ygIOahaTABV
         v0LvPgqlDsH3KHuD+FVf9PZqy/CjRaGPAwMJrEsSY/zMmk3BvBBgypVClGtPNPW0XX
         HrlOttalNx196MgqCEpwsd7lP3Yj4+ZnFzSJLv5cFmXHb2ZhjMtyF9Q4FmbjS5U78B
         Vhwb5Mpg8jehw==
Date:   Mon, 21 Jun 2021 21:54:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, acme@kernel.org
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
Message-Id: <20210621215452.0eea52e14dbe5969b66ae149@kernel.org>
In-Reply-To: <1624266910.z97eue1i84.naveen@linux.ibm.com>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
        <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
        <20210611154021.008537b0@gandalf.local.home>
        <1623684632.0k2j6ky7k3.naveen@linux.ibm.com>
        <20210619011516.dadbd24e27996bae62fd288f@kernel.org>
        <1624266910.z97eue1i84.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 15:06:24 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Hi Masami,
> 
> Masami Hiramatsu wrote:
> > Hi Naveen,
> > 
> > On Mon, 14 Jun 2021 21:00:52 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> Steven Rostedt wrote:
> >> > On Fri, 11 Jun 2021 19:25:38 +0530
> >> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >> > 
> >> >> We also have perf_event_open() as an interface to add probes, and I 
> >> >> don't think it would be helpful to require all tools to utilize the 
> >> >> error log from tracefs for this purpose.
> >> > 
> >> > The there should be a perf interface to read the errors. I agree with
> >> > Masami. Let's not have console logs for probe errors.
> >> 
> >> Ok, understood.
> > 
> > Will you update this?
> 
> Not sure if you are asking about error logging with perf_event_open(), 
> or about reading error_log from tracefs.
> 
> For perf_event_open(), I think we will just need to return the error 
> code, and interpret the return value in userspace. I don't think there 
> is any other way to pass error log or strings back from the kernel.

Yeah, I think that's good idea.

> 
> I will update this series to return the correct return value as 
> suggested.

OK, then I will update tracefs to interpret the code and put appropriate
error message on error_log.

Thank you!

> 
> 
> Thanks,
> Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
