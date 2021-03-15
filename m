Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC233C6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhCOTYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbhCOTXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:23:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCCFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yO0apWENpMRBblItjr/+oqvVMAF7kQ8kVJErQwoVT2Q=; b=Zuwh75VcSbl5/HLK4Id5YFgb6h
        fMO+QVnSAeq0Ddeg3IEDPMgFvJmCBZDJwYAGxKQLiu5gLs8xzInB4FTEnmiXSvhrgjD36uJq7ZVP+
        A1rzjPEVgUF8ntrR7YgZJk9gJbPojPLNcVM9ribMqJEgduEKr6m1fXQHEAdxYndcZIQAw0jwRPvzY
        ADweYDRbTG5sS7xJ1u2/YqVmyUkycI2ksRdrOvJ5CjRAnpTbeG0ji1x3zjIRV1EHaIyNffBm4nC3z
        ptG6A7Z59esVSSLRaM88StqKl1rv2OPp9gI+YEHR20A9+YwmDBoRkP/Q9k1VKbgzJwT/ansAUigBW
        yU1k/7zQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLsns-000eQv-AD; Mon, 15 Mar 2021 19:23:07 +0000
Date:   Mon, 15 Mar 2021 19:23:00 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Valdis Kl??tnieks <valdis.kletnieks@vt.edu>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: arm64: kernel/sys.c - silence initialization warnings.
Message-ID: <20210315192300.GA154861@infradead.org>
References: <162859.1615542946@turing-police>
 <20210315111433.GA22897@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315111433.GA22897@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:14:34AM +0000, Catalin Marinas wrote:
> We do similar initialisation in arch/arm64/kernel/sys32.c and
> arch/arm64/kernel/traps.c for example. It's a pretty common pattern
> throughout the kernel.
> 
> So we either treat W=1 output as diff against the vanilla kernel when
> checking new patches or we remove override-init altogether from W=1.
> Mark Rutland pointed me to an older thread:

Please just remove the override-init warning, it is not helpful at all.
