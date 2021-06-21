Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0E3AE89E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFUMFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhFUMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:05:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A334AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=iv+5qwuRixrBfPUr5p/l8qj9Y/ZxEqaikPrdjEKt3U8=; b=Ycoz2Fyo5omaHLpgzfsyWS6t1/
        B6SbOQcTtfEzhtMQYB7HymbHCqH/Zw6sQOaNB45HYO37qTpcvqy5uqGhmnzGa5XUUFW/v7VZD54H7
        kpiDjQiRHmv0riuoT3rEATmBt3wQ8LnxIPcTUKrdGB7gCRWpMcMztOkO08m7452S82TNQa+Qa2hB8
        8Wnh7ghf3nhR/CJK2VNxQA1qymCtPI4rCx5ekMThT1/MEVKL3AYJ3YKxpegiAUFoR2ACK6o8U/Dw4
        0HFJIH6/gQ2s+vpNvwQtq3J3db0PhoxmbtXDmZB8ychx64tAOzT49/7yEuZghMp7wDAaMjuVdAAke
        4LMZ9dUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdO-00AEJY-2M; Mon, 21 Jun 2021 12:02:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32B93300258;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E3390235EE360; Mon, 21 Jun 2021 14:02:38 +0200 (CEST)
Message-ID: <20210621111233.344964031@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [RFC][PATCH 00/18] objtool/x86: noinstr vs PARAVIRT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Per long standing request from Thomas, this here mostly sorts the whole noinstr
validation vs PARAVIRT.

It isn't exactly pretty or robust, but it does work.

So far only tested on x86_64-defconfig+kvm_guest.config+xen.config. I did a
quick allyesconfig build, but still saw some funnies with that, will poke at them.

