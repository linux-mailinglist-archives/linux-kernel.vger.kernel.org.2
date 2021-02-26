Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B423261B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhBZLCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhBZLBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:01:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F852C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 03:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RN6FFy8WfmvuIii5kevqHdHdZynSOLgMW44gUoFNBcg=; b=EYTq8EqO4J+clbepADeA9rFcI/
        h1VNpc4Po0p6jbTLDN740wdWsaIefqyn6ssjkmHtS6oh5Mx27PXjJTIKM2NvAyOa8MITmJD4JtPkc
        DklhDELpa0dql22Kss2AvvD2gqkBAsBzv+mP+0QA4xMw/XB8sVNP6mIvdJZ9R9tBMBeTzMBb0jHhR
        aaUAB8u2bkqKTFehkAaRsGhcS5fLAWCRyVXCQ8KKfw5DhQ3qfHUas2XKsF1APwABMnIIm+e71LVbl
        ASzSIcU9xN64zPHh3MXZRnFmOP45Sh8w4py4ZFd35x3RO9VyEBpuK6aGLH77bRViHz5vJzPPporfq
        VsSK+tXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFarV-0006GS-OZ; Fri, 26 Feb 2021 11:00:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67FC530504E;
        Fri, 26 Feb 2021 12:00:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 58D0120BC9288; Fri, 26 Feb 2021 12:00:43 +0100 (CET)
Message-ID: <20210226105742.844988140@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Feb 2021 11:57:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     bp@alien8.de, jpoimboe@redhat.com, mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org
Subject: [PATCH 0/3] objtool: OBJTOOL_ARGS and --backup
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris asked for an environment variable to have objtool preserve the original
object file so that it becomes trivial to inspect what actually changed.


