Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45F0340BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhCRRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhCRRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:23:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D13AC061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VpI2pWm+iaVmNktCA4RVhj4ljrVU+LH0ADIL0UfacLg=; b=LAyBs7p/nbiUywe+wygeLGhSjs
        n7ZCq/yqUPxUDXj93H7psnWKaeNNrRUtmRCZOlCbaLtjtG56pgiNF9KokdZCxXuIpieBpiZFghqxM
        ILvUCCsqZd5Y16YCYkBPH+gGWn1GK2LNzAEuNWe3r3/uoUPOmws8d8nde4RvZw1edj7jt+r6ePiWu
        gdf3zfuXgMCK9wzH4gIVsBaq8w3S4k9eYgLwuHwUMDKdQO8/86pA8p1APqQgN6kUMStG9HBlMbW4Q
        Z4mFinvdyKomELwX2af0eNaMEREwx2bd31fA1aQ5EVo8b73EGTv52X63SW/VdrZqEUIqubofGOO3y
        vSJyit6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMp-005kEY-HX; Thu, 18 Mar 2021 17:23:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CDAC3050F0;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0D4C5213C0F58; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171103.577093939@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 00/14] x86,objtool: Optimize !RETPOLINE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Respin of the !RETPOLINE optimization patches.

Boris, the first 3 should probably go into tip/x86/core, it's an ungodly tangle
since it relies on the insn decoder patches in tip/x86/core, the NOP patches in
tip/x86/cpu and the alternative patches in tip/x86/alternatives.

Just to make life easy I'd suggest merging everything in x86/core and
forgetting about the other topic branches (that's what I ended up doing locally).

The remaining 11 patches depend on the first 3 as well as on the work in
tip/objtool/core, just to make life more interesting still ;-)

All except the last 4 patches should be fairly uncontroversial (I hope...)


