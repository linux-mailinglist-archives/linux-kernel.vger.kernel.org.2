Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21C5330C76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCHLdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhCHLcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:32:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730ECC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 03:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KHNXOetkcaaBxCVQe9PQn01joXoDWKgalZTCVlfPktM=; b=ql4is37fB+HRl+S/3uCrXWOqw+
        40P0S7KYPXsukXoARcaVdZRzSD/SnsR3qc7WSo7XzHlxzG0/fejLRSOXv5RcrEfQRNqe6WlqC9NGz
        xEeN8e+FpGFAYNPPHKx43c9RfWYhhptBviLg1zzYxw+65otZZjemO9EcLvoxt9eKO4BligepGtPSv
        J1yBTyCfLswSlTocEW182p4ROWdng1ncbvv1OLFS5zqiE6Tj4J78mWIpCS6onSylVupMlfSpf1f+m
        eqPCK5IniIru47vP+K2oSfw9U+Kr2pMM6Hj3WYq/LsdtYDhssLhfWiZRGsmBFxy5t+7fE+pu2DMpF
        D3HzVd9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJE7d-00FPCQ-Va; Mon, 08 Mar 2021 11:32:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 820013010CF;
        Mon,  8 Mar 2021 12:32:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 228F4207A761E; Mon,  8 Mar 2021 12:32:25 +0100 (CET)
Date:   Mon, 8 Mar 2021 12:32:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH] sched/topology: Fix a typo in pr_err()
Message-ID: <YEYLSdUdNmIE/quo@hirez.programming.kicks-ass.net>
References: <1615195496-13980-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615195496-13980-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 05:24:56PM +0800, Yicong Yang wrote:
> Fix a typo 'borken' to 'broken' in pr_err().

It was not a typo..
