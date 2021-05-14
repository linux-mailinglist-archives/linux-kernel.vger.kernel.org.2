Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBA3808DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhENLsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhENLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:48:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4148EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9+rh5toy6w7tSZKTYyXb9xGpei7fnwqJwkaQ76SHrhM=; b=RhZRKiZs8yRPgN+DkBxlK/W39E
        EDrXRZzdDv4sK9rr+ahPrxlAV+O+mOfCQmwpX30btZfKLkkMtmEb66RPvTy2aFcP/bzCXYi5nsIsE
        w4jZwGTiMbqPww8VUZ24dl81dUO2Ij8JPHS4SWrftGxqE6DHHzvWk6vQZcvpj7lA8MajQPM3rp8ct
        meAaSN+khRlZ4XBBwGOSKFYwL8nnffi+vJtZFR3r8tF7ae39CFt2qOhWF9LAz9hGsV4K+Ll5ru3oi
        yIJ+MIrrmIJXIj6RBIWTUxMkLwWq713CONMFpeLKEDzildtr4YQxa6vuoE/0WUDdC+bR8Gi8+WNAw
        DMHgGQzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhWHl-007xqp-1z; Fri, 14 May 2021 11:47:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2F7A30001C;
        Fri, 14 May 2021 13:47:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B67B20829F97; Fri, 14 May 2021 13:47:15 +0200 (CEST)
Date:   Fri, 14 May 2021 13:47:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        maddy@linux.vnet.ibm.com, santosh@fossix.org,
        aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        atrajeev@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [RFC 1/4] drivers/nvdimm: Add perf interface to expose nvdimm
 performance stats
Message-ID: <YJ5jQ1ixz7D0Ij2R@hirez.programming.kicks-ass.net>
References: <20210512163824.255370-1-kjain@linux.ibm.com>
 <20210512163824.255370-2-kjain@linux.ibm.com>
 <YJwP9ByvAcDPixVN@hirez.programming.kicks-ass.net>
 <37015d53-050a-acef-2958-b1ff5d02800b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37015d53-050a-acef-2958-b1ff5d02800b@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 05:56:14PM +0530, kajoljain wrote:

> But yes the current read/add/del functions are not adding value. We
> could  add an arch/platform specific function which could handle the
> capturing of the counter data and do the rest of the operation here,
> is this approach better?

Right; have your register_nvdimm_pmu() set pmu->{add,del,read} to
nd_pmu->{add,del,read} directly, don't bother with these intermediates.
Also you can WARN_ON_ONCE() if any of them are NULL and fail
registration at that point.
