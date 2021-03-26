Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551C634AB45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhCZPP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCZPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:15:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD1C0613B6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=S1o7BNz71kluLlLC+DlLNUBjpEieVXra/hOpGWdwz4c=; b=g2XSvhl1H/Vxu3C748PB8eFK+x
        xsfcBIQLpKrW4YjigdG9FqDW/TCIbLh9oQZItqqIFuO1msynhGIfir26+9AvIRJcZBuRGektK9ul9
        cJfh8om+o018NBpa99DKwy67CwZ2XgZj/+vhcdMTTE16D85Z0dcpwQiHoUedvyXqhgEX23WbWZPCQ
        iGQ/kF4pOD305I9SPgOExOmQyZljgiXW/D0sUP4uLxCCdxmxQx2or8DdDP4AHyYgUfmS7YzfZmYPf
        ELylGoGgx9v3+8HuS39Xb8sp3WvHpFW0xNem00GZ3bAcEmW1E/nwsn0wf5EJhBwSipnC0BkzAEkN5
        L5m5AzMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9X-00F0oO-RA; Fri, 26 Mar 2021 15:14:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85454306BCA;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2BDF12BAC2E5D; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151159.128534163@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:11:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 00/16] x86,objtool: Optimize !RETPOLINE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, another week, another update :-)

Respin of the !RETPOLINE optimization patches.

Boris, the first 3 should probably go into tip/x86/core, it's an ungodly tangle
since it relies on the insn decoder patches in tip/x86/core, the NOP patches in
tip/x86/cpu and the alternative patches in tip/x86/alternatives.

Just to make life easy I'd suggest merging everything in x86/core and
forgetting about the other topic branches (that's what I ended up doing locally).

The remaining 13 patches depend on the first 3 as well as on the work in
tip/objtool/core, just to make life more interesting still ;-)

All except the last 4 patches should be fairly uncontroversial (I hope...).

There's a fair number of new patches and another few have been completely
rewritten, but it all seems to work nicely.

