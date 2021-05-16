Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1E381EA5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 14:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhEPMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 08:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhEPMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 08:17:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2AC061573;
        Sun, 16 May 2021 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dHP6r2DtDtGoZZly7AA5EZIa9h/com+KPWget/NtC9c=; b=nK6c1qsjUtKQ6MPUYDQu4o/VEG
        Z3TnfGwyhlqFQTOsSq13h80W8pfDiFGf1SkYDxw7j4SuPqRcPzUeSnZWni1s+QxbmqjTy+lZIwcLo
        JlIyaGVS7Qyz/BG8+Z003fVMfaqtT1Txg/uraPK27sKJeL3J/7BV3IGTr706xObaxqjGhF7zwdCib
        SLVn75KZsEzRhwKTXWTAkzRngNi7yYHlkhmuKSgjMcG3GvXCQ1C9GxcXW3ubje96C6tmS0PjrySkN
        s9l6TxIZu7kZdJMICpCyBmlFqP5x0PCRuKeZMFxxIgbgfv2vh3GPZT3camgGgzxPGmIfIPdg0vOMF
        63a1ydRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1liFg2-00C04c-47; Sun, 16 May 2021 12:15:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C158F30021B;
        Sun, 16 May 2021 14:15:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68FD6312D6791; Sun, 16 May 2021 14:15:18 +0200 (CEST)
Date:   Sun, 16 May 2021 14:15:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Haowen Hu <src.res.211@gmail.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86: Improve code format
Message-ID: <YKEM1qrJ5nhdWXHj@hirez.programming.kicks-ass.net>
References: <523745bf-c399-dc2e-ac57-1d580254802a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523745bf-c399-dc2e-ac57-1d580254802a@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 04:08:54PM +0800, Haowen Hu wrote:
> Reformatted several lines of code, in order to satisfy the kernel code
> format.
> 
> Signed-off-by: Haowen Hu <src.res.211@gmail.com>

Your patch is whitespace damaged, also please take your efforts
elsewhere, I don't much care for random nothing changes like this.
