Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B39433948B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhCLRSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhCLRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:17:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA688C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FaILmyCBiYlIJSnG4vafUO35xMZZZZmitzPoNFi7v8s=; b=E9MtkAbVBsqCIeSCZW0LBea/2A
        TN0n3ady30bqdpBGHiZeUBWBm2A9L1hZWumpbQPlYp8MsOhcEtrymhMDBr0Vvs9aqJpReOPBjf0mL
        +cKHXxLnxlt5sJX4vZYZO6aqUWi7hZJaRw48lJ51XzVU5p8syibwfQaYdCC4tcgJOJ/5A3B/+FFgA
        1ixpvB0fH8JJj4x+87zGhBN1qOrutvzyIKFUzJZ1ROnOBzvlO7jY2kdXRe/jBTre//GF53VBhfdey
        Nta2zIM2W73rSQxEG2cdFiIlivHM2eGrbIPmESc7Ifnl15Tp4IbqDQo2X8EHDvRKXvC+022+pvMn5
        G5Hgz2hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKlQ9-00C535-VN; Fri, 12 Mar 2021 17:17:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 084C43010CF;
        Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F0AF823CC2281; Fri, 12 Mar 2021 18:17:52 +0100 (CET)
Message-ID: <20210312171613.533405394@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 18:16:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 0/9] x86,objtool: Optimize !RETPOLINE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that Juergen's paravirt rework, which included the negative alternative
stuff, landed in tip, here's a respin of my retpoline patches.

The main feature is replacing the compiler generated (tail) calls to
__x86_indirect_thunk_\reg with an ALTERNATIVE that replaces them with regular
indirect call instructions, eliding the double jump.

Patches rely on tip/objtool/core and tip/x86/alternatives

