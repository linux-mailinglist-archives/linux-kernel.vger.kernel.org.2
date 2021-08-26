Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436733F8519
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbhHZKLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhHZKLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:11:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2146CC061757;
        Thu, 26 Aug 2021 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P3fBlJbN4Wwlgb2DErBDbg3h8KlOq0J2kHfaCvG4BKg=; b=Q3PVQyfU3McP68Q5nf6qKSOj3t
        aVpL1YMtIr/9ywlDCEkOiiL+9ZuqLIqkHjLAXM83SYk25HPDaeQ1I0QFFbWgQv5sYz3m7do7Imomc
        vlWahbutQZ0eThYMuM1i98DplU4BGqK+ekOopzYJT8Se0/vMx9noN+Mxo4JcmVcURivFhr53X/1P6
        5x/S4EPCEdzzbsNvKhSBobjYtjfjYNO9PN5fcFmrvw+6sryjNay3GFU39qODUKLFFvjINaZM4DgRV
        z6s8EUFk1mIDkF9HcXTrzEqzo1Q23pPFSsvyyrqRB4qxMNkpYXLSAcjVSSdWYztyIkeA3METPe11G
        6aqwdHHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJCJd-00DBDt-Tj; Thu, 26 Aug 2021 10:09:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A31498629D; Thu, 26 Aug 2021 12:08:56 +0200 (CEST)
Date:   Thu, 26 Aug 2021 12:08:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com
Subject: Re: crash on s390 with SCHED_CORE=y
Message-ID: <20210826100856.GA4353@worktop.programming.kicks-ass.net>
References: <yt9d35qwa82w.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9d35qwa82w.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:06:31AM +0200, Sven Schnelle wrote:
> [   25.044234]  [<00000001655b7534>] raw_spin_rq_lock_nested+0x5c/0xb8
> [   25.044241]  [<00000001655d2cfc>] online_fair_sched_group+0x9c/0x1c0
> [   25.044248]  [<00000001655e481c>] sched_autogroup_create_attach+0xdc/0x210

Does:

  https://lkml.kernel.org/r/162970967846.25758.333277155824309635.tip-bot2@tip-bot2

help?
