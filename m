Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19E942D6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNKLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNKLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:11:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C90C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kiU6A1Sq5BHvN+gODfXf5q4DwZRjSOu//da1cgbvW80=; b=BcdqQDO9osE3rRKFH63zFvG/9a
        eTrSpBGZR8aMCqP3wUhSZVdJ+enxPXKGJJwmv+67iadyvsdhFXALWtjg9/2W5gVP3ADCNPnZpjaXT
        u9B7fHv0EI0QDE7nQM/IEkjkkyQdACje0+Vx2NNhtRVn97plqy1+tGjohT/am57wRn7Bk58HcLKPe
        CljrFUQEdUS0z+Ff+dHZo5cg/EIelpcxGIueEtD06p3pHXua9+ebB04NtUJ/dgsmlRl6MeP7GiGJ/
        w16hCwNSE+vsmqNH05beKFudsgtq6+BGXsfw+MBaMCOgUVr04VK4PkASpnUANCBA7V8sMq6Fm0Pok
        GaFgJxnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maxfp-009oWH-0y; Thu, 14 Oct 2021 10:09:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33F9830031A;
        Thu, 14 Oct 2021 12:09:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 176EB20A958D5; Thu, 14 Oct 2021 12:09:16 +0200 (CEST)
Date:   Thu, 14 Oct 2021 12:09:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kan.liang@intel.com,
        ak@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel: fix ICL/SPR INST_RETIRED.PREC_DIST
 encodings
Message-ID: <YWgBzFf31lR6oGVA@hirez.programming.kicks-ass.net>
References: <20211014001214.2680534-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014001214.2680534-1-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:12:14PM -0700, Stephane Eranian wrote:
> This patch fixes the encoding for INST_RETIRED.PREC_DIST as published by Intel
> (download.01.org/perfmon/) for Icelake. The official encoding
> is event code 0x00 umask 0x1, a change from Skylake where it was code 0xc0
> umask 0x1.
> 
> With this patch applied it is possible to run:
> $ perf record -a -e cpu/event=0x00,umask=0x1/pp .....
> 
> Whereas before this would fail.
> 
> To avoid problems with tools which may use the old code, we maintain the old
> encoding for Icelake.

Uuuuhhhhh.. but we 'stole' event=0x00 for the fake events. There must
not be actual hardware events there or we're in trouble. I thought Intel
knew that, I'm sure I told them that.
