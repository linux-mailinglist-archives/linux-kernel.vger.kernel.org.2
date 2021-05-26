Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7788E39126A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhEZIex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhEZIes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:34:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D904AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ayi1aZxpImaUKGH6duzMtDP6l99UaS5sywY/3DasNpU=; b=qh9DODudqPXQIY8M6srRqx+hlI
        BVH0SAG11gAaZJpweQoBW8mHLczvQwdN5BmIhMEw0RqptBpYv9dQeW/BQcTgiUWJ4iHYiUirk3jfD
        DcMzKRTZJDE1fNyngOaSpT4pY97kT5tKp9I0/R3R/mCAairZXC2fFt27xeKwAFOWjx8MtNp3rwM0+
        SmLHX1wrjAibiX1VYsYpcPBkgvxA9tKQ4HlwFNQ5EYhT5a/d8RLRLtFbAEk08VRLS0V0hc0KoKDRo
        NYTrlqQu+xrUf3VIWg4vynNiSxX23Olp0DYfLA+h3i0HTFGKB7xPkRlZKFFyxCEZjgt8YkREcKUTv
        lww1wgUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lloxr-000Wkb-SA; Wed, 26 May 2021 08:32:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B214300242;
        Wed, 26 May 2021 10:32:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0522C201DB6C5; Wed, 26 May 2021 10:32:36 +0200 (CEST)
Date:   Wed, 26 May 2021 10:32:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        maddy@linux.vnet.ibm.com, santosh@fossix.org,
        aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        atrajeev@linux.vnet.ibm.com, tglx@linutronix.de,
        rnsastry@linux.ibm.com
Subject: Re: [RFC v2 4/4] powerpc/papr_scm: Add cpu hotplug support for
 nvdimm pmu device
Message-ID: <YK4Ho7e+LCqjYA2X@hirez.programming.kicks-ass.net>
References: <20210525132216.1239259-1-kjain@linux.ibm.com>
 <20210525132216.1239259-5-kjain@linux.ibm.com>
 <YK0G1nmvhOPimRay@hirez.programming.kicks-ass.net>
 <b89d1954-638b-34c0-2d79-5d1ce4e72a3a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b89d1954-638b-34c0-2d79-5d1ce4e72a3a@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 12:56:58PM +0530, kajoljain wrote:
> On 5/25/21 7:46 PM, Peter Zijlstra wrote:
> > On Tue, May 25, 2021 at 06:52:16PM +0530, Kajol Jain wrote:

> >> It adds cpumask to designate a cpu to make HCALL to
> >> collect the counter data for the nvdimm device and
> >> update ABI documentation accordingly.
> >>
> >> Result in power9 lpar system:
> >> command:# cat /sys/devices/nmem0/cpumask
> >> 0
> > 
> > Is this specific to the papr thing, or should this be in generic nvdimm
> > code?
> 
> This code is not specific to papr device and we can move it to
> generic nvdimm interface. But do we need to add some checks on whether
> any arch/platform specific driver want that support or we can assume 
> that this will be something needed by all platforms?

I'm a complete NVDIMM n00b, but to me it would appear they would have to
conform to the normal memory hierarchy and would thus always be
per-node.

Also, if/when deviation from this rule is observed, we can always
rework/extend this. For now I think it would make sense to have the
per-node ness of the thing expressed in the generic layer.
