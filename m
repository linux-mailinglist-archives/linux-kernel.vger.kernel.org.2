Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9203933DA67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbhCPRNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:13:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43284 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbhCPRNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:13:14 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615914793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVPJdIcbPKCh3bPSj76dGe/uoMXx2sKZ13pqyErvErk=;
        b=wA2mePQHnzHkbVIdM73JprRykasGPOdNEftBSB4COxHs3ogDDy5VkccbI+B123WpePVIPc
        TkLMWy6bGR4d8yt9WWnlbtMLGzIAaeD/EqqXahJNiVQHXmZU+ZN5R99Lmv7W5jxL1BqLuB
        /A3ulSxicDCCWnJPwbKxY/O1oJzsZd1G5H/lkUWisDS95V9qJ3ummUIdMwDc2tUsiZ2ozB
        PbCTNmQCjoY2MFS3AHBJz5QvChMIL9ljLQV90pK1xI6ctnEWM3Ih5Rwzm1VK6+bYpPV/4x
        BPup37PKS/2lbP+wDoJjMVbuW0llchqbWWpCtdna4GR7kGvKQbKNgG1oVDv5sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615914793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVPJdIcbPKCh3bPSj76dGe/uoMXx2sKZ13pqyErvErk=;
        b=ZzCHJ17PB+aLyaVJVeTw2kzvi8MSGCvBDE850vCqoEtjI592532oMoje+NaIKbzsLU9Y4c
        a8kukxlEBt0urEAA==
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiafei Pan <Jiafei.Pan@nxp.com>,
        Romain Perier <romain.perier@gmail.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] softirq: Be more verbose on t->state BUG()
In-Reply-To: <YFDKZ5Ukwy/j8Xk3@lxhi-065.adit-jv.com>
References: <20210315154421.11463-1-erosca@de.adit-jv.com> <87k0q7186h.fsf@nanos.tec.linutronix.de> <YFDKZ5Ukwy/j8Xk3@lxhi-065.adit-jv.com>
Date:   Tue, 16 Mar 2021 18:13:12 +0100
Message-ID: <87tupbyqc7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16 2021 at 16:10, Eugeniu Rosca wrote:
> If no other comments in the next days, I will resubmit your proposal as
> v2, marked with 'Suggested-by: Thomas Gleixner <tglx@linutronix.de>'.
>
> Alternatively, feel free to author the patch and submit it with us in Cc.

Just send a v2 please
