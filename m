Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC23AD031
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhFRQRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235866AbhFRQR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:17:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F4E561164;
        Fri, 18 Jun 2021 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624032919;
        bh=8qEH77Y0Qf30/JIPXOCXqB6LDvWgELe4XZuXXAGh9wE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ae15oKi+Z8TrdXO23sUZFDCesgwuN+90p290VWV4DFd3RgEKqrHJ4Me1LDyo+7NHv
         IIaPhx3CCFWNWmrjEehfCXCcIvwIFNgOH+C4KmYckEgWhwFcmABImVTU13Auba+UxX
         NT0Cxh/K62pK54ctkCMyLEO2sD0IaGo+D0+Wa+NKhpUFNN2Rtvr2E+D3DzCB1/Xc3R
         9wfR/dXdtfZqEEJ6qIWzHJ4YLG63+Wj8IAt1bjPoCOHaxqEzwpUc++aZ+hZjhh5U/r
         OSf0wYiCTP1qk0l6jxzi/r0z/7vUGA6rUNAaN36rJntTMtHahJX1qwJONaPJSeYJJs
         VclI7DLoci0zA==
Date:   Sat, 19 Jun 2021 01:15:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
Message-Id: <20210619011516.dadbd24e27996bae62fd288f@kernel.org>
In-Reply-To: <1623684632.0k2j6ky7k3.naveen@linux.ibm.com>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
        <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
        <20210611154021.008537b0@gandalf.local.home>
        <1623684632.0k2j6ky7k3.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Mon, 14 Jun 2021 21:00:52 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Steven Rostedt wrote:
> > On Fri, 11 Jun 2021 19:25:38 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> We also have perf_event_open() as an interface to add probes, and I 
> >> don't think it would be helpful to require all tools to utilize the 
> >> error log from tracefs for this purpose.
> > 
> > The there should be a perf interface to read the errors. I agree with
> > Masami. Let's not have console logs for probe errors.
> 
> Ok, understood.

Will you update this?

Thank you,

> 
> 
> Thanks,
> Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
