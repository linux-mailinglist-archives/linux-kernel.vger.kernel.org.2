Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1554032C5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 04:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347440AbhIHC4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 22:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347323AbhIHC4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:56:43 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1D061164;
        Wed,  8 Sep 2021 02:55:35 +0000 (UTC)
Date:   Tue, 7 Sep 2021 22:55:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "bristot@redhat.com" <bristot@redhat.com>,
        "bristot@kernel.org" <bristot@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace/osnoise: Fix missed cpus_read_unlock() in
 start_per_cpu_kthreads()
Message-ID: <20210907225534.7d9d48c0@rorschach.local.home>
In-Reply-To: <BL1PR11MB5478CF84562E63476BB1472AFFD49@BL1PR11MB5478.namprd11.prod.outlook.com>
References: <20210831022919.27630-1-qiang.zhang@windriver.com>
        <20210907211714.696cca61@rorschach.local.home>
        <BL1PR11MB5478CF84562E63476BB1472AFFD49@BL1PR11MB5478.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021 02:34:46 +0000
"Zhang, Qiang" <Qiang.Zhang@windriver.com> wrote:

> >FYI, no need to add the "# v5.14+", as it also breaks my scripts. The
> >"Fixes:" tag is now used to know what stable releases it needs to be
> >applied to (if any).
> >  
> Thanks Steve
> I will resend v3.
>  

No need. I fixed it. I'll add Daniel's reviewed by if he gives one.

I'm currently running it through my test suite (with several other patches).

-- Steve
