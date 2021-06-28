Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEE73B5D38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhF1Lj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhF1Ljv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:39:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527DEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 04:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gIqo8lRwVVH69oc8YU7He7pv/Fq+9Goq0bsCOExsGOo=; b=bqza/5QnNvxaPg+U+c3+ARLaYM
        GkifKwQhU80Hu9SpEYGFbaaUrXFWNLOlCNYC5PpY0G0ZWAs9wx0G5Uhv4s+TPrbjbspsQoOstuwEr
        7SjJlSwNlZoPrkhbB8Sd7KZxjuuQ3LLO4UWZWyGHEWQ29S5sIJlUz1jTab822ZkM44pVWgMiWkT5v
        ypjSxyw8gtOOsQYzIhKP3uwqyYYaHbixccoWwGU1cVNmLNPPWUFXyLgM8xbQF/0rAbY2tUuvTZp0J
        MYIviUw6XRO/Xv7KrcgAAa4wP4xyG8Uk3I60R+o8HHg1zn3ydaR7hYS2PNzywZ96u9YHngn8eM4no
        /D3iXvAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxpYe-002ulU-Kd; Mon, 28 Jun 2021 11:36:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 14E2430022B;
        Mon, 28 Jun 2021 13:36:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0493A2BF0CB33; Mon, 28 Jun 2021 13:36:08 +0200 (CEST)
Date:   Mon, 28 Jun 2021 13:36:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liu, Yujie" <yujie.liu@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [LKP] Re: [jump_label, x86]  e7bf1ba97a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <YNm0J6etioinNhJH@hirez.programming.kicks-ass.net>
References: <20210623022826.GA20282@xsang-OptiPlex-9020>
 <YNLtSKUtqxqPxmGP@hirez.programming.kicks-ass.net>
 <SJ0PR11MB5598608507B7EB38983113BCFB079@SJ0PR11MB5598.namprd11.prod.outlook.com>
 <YNmUzDjX6sECp37P@hirez.programming.kicks-ass.net>
 <YNmflj/WpFG5Ivmb@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNmflj/WpFG5Ivmb@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:08:22PM +0200, Peter Zijlstra wrote:
> Let me go write up a proper patch and do the same for static_call.

https://lkml.kernel.org/r/20210628112409.233121975@infradead.org
