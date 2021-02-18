Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787BB31EF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhBRTDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhBRR1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:27:01 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F06C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hWg0XP7fO2g0yLNO7yCKhtPhNCNNXSECX/6x8OQx93Q=; b=XxXRwoeKbHjo9ZJYoZ5jW7mSpH
        iFx724UzmFTNlmTp6Akh7lRCrYBBs2cfEj6hzBHCVOdtPgEFkwSEO8B8uOfy+rVFupEtMUjhMbHzo
        Z44Lky7nSzOAlOOcPdNGFZJ37JMBHIHoEMQWjbNiXqHVm3BbA4tyG+cihXOZvzbvJnYlxR/ePm3Py
        K1dnbzx3ZrDPoI4LOXWWm9q+53YtSFAPu17oRfDueA9pu1iK7A038r4YYH5GVPn/PRX+OQPNTvT9M
        4+Q+493tJ6WcR3OjzBJQhIt5fNhl7RpS6TEXx3D/kxywouoR1uYWTGbQbxqG1NSk7MIOC6x6iidg6
        mOJ+BLJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lCn3V-0007qr-6K; Thu, 18 Feb 2021 17:25:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B937A305C10;
        Thu, 18 Feb 2021 18:25:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 915CB20268332; Thu, 18 Feb 2021 18:25:29 +0100 (CET)
Message-ID: <20210218165938.213678824@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Feb 2021 17:59:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, tony.luck@intel.com, pjt@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        r.marek@assembler.cz, jpoimboe@redhat.com, jikos@kernel.org
Subject: [RFC][PATCH 0/2] x86/retpoline: Retpoline on a diet
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The first patch rearranges the implementation and consolidates unused bytes.
The second patch uses INT3 over LFENCE to shrink the retpoline to 15 bytes, by
which 4 can live in a cacheline.

Patches have been boot tested on my IVB.

