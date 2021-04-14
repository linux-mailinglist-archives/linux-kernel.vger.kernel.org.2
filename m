Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B935F37F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350833AbhDNMWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350789AbhDNMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:22:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59393C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sGP5G3sgoSJvze5sW0WvZVHOi1F2TIB+/wBGMjRNfq8=; b=LJehGaxke4GiKv+GQb/KRtxqI4
        PM55SUDjuhQdFa5oLExb98caNTwwPSWCZ+IL0DbY/H0XRAhQg4sFL3YJ7Hh/lWdSrK82vd1tDQ/Vi
        vdGi/tuLk7vCCXg/FUtd7qOazLdPohSFqxuh/7LHYsKegHFJzfA25KwSySEva7AL3kVwlV+qPqu13
        jBT/+ppj+VduZgPkN8kQiBSOq3tgNyRLAaAZqXBQjRDNI1yWcCb8V5xxNfHtCn8Ec4N5duhupIau0
        AtdcPOFbVDoaMYYgymZKyeTqpST2j4nHcTtBfZ9K3QoxE+WI7OCud63rgQyJcgTbxfFEkgZETm5gv
        MUci3iIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWeXA-00CZAg-PI; Wed, 14 Apr 2021 12:22:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B574230021C;
        Wed, 14 Apr 2021 14:22:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A58432021BFB8; Wed, 14 Apr 2021 14:22:15 +0200 (CEST)
Date:   Wed, 14 Apr 2021 14:22:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        ak@linux.intel.com, mark.rutland@arm.com, luto@amacapital.net,
        eranian@google.com, namhyung@kernel.org
Subject: Re: [PATCH V3 1/2] perf/x86: Move cpuc->running into P4 specific code
Message-ID: <YHbed9/VDTiDg+vt@hirez.programming.kicks-ass.net>
References: <1618340250-29027-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618340250-29027-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks for these Kan!
