Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79683A121B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbhFILPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236236AbhFILPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:15:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61F6360D07;
        Wed,  9 Jun 2021 11:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623237216;
        bh=uhs8d95HceYB1QUJSgYhSkNSFEsBhgKq9pUw8SHgTuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iP7nNY7C5Azf4Q9bRTEpxUMFaBpBMDMZU/z7RzX8ozKfqlvI/y1LMmkEANZA5oeUJ
         ganG39il0m7+rjZ1T5JXc3WzrfTOX1BXsCX6h0bhtwHJXF4xImkNpyIr1CyCbu5Ao4
         w0dS0V9C+d/efMMGQ6LAqL5gzLyMhDEPPIM7ymgCvk6pempFBU6TNuaBbMnf9JCGBk
         7fXDck/SqJjz/qGfPH67e9jvz2aHQmxBxGAcJMqwi+bees5PsRWT5XriazmO10ByHs
         4vCANERq7akWI1OYC3SLMduRqLwx1sLD8WFnLqOXzd0h9aaTKEIs/zAVgviNcH4Lz7
         cvoH8caGNnLBw==
Date:   Wed, 9 Jun 2021 13:13:34 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched: Add default dynamic preempt mode Kconfig
Message-ID: <20210609111334.GA104634@lothringen>
References: <20210608120442.93587-1-frederic@kernel.org>
 <20210608120442.93587-2-frederic@kernel.org>
 <YL92vbcw3ozRLycU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL92vbcw3ozRLycU@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:55:09PM +0200, Peter Zijlstra wrote:
> Urgh, would something like this work?

Oh yes much better thanks! lemme try again.
