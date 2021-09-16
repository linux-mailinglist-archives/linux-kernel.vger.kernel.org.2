Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EEB40E58F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbhIPRMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:12:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349124AbhIPRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:03:47 -0400
Date:   Thu, 16 Sep 2021 19:02:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631811745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bpGfOVRfihbzCZQPktrWeUBsiNFJC+Xvb1XqdriBFyU=;
        b=kI5qiXp9d1kenYU3Rkpr6fVd96+xsMSyySYLtlG3R0GfTOUo8Bsynaa9tbDp9TL21vnCf4
        7ucGMklAJrg7gO019/gf8ZjFGl+o0D3yWlXYjGpxlhWEpUBubD3cTOHAEcLTpayMNlwuc+
        ZE0uCMu2apMnH6Ab4dArfz+PBDhrWcV/kPhmfFb71UOC/PII0MfVA/BskHLrBw1lzJ4o6j
        qHLG9go8UylyF7KN24pkttZSuC11cUwRukRuEGK6WfQYquMoymMygT48rZd5kvJo1i7DOz
        SNgqTrnHJizW7HYfEnHL3AaA1/IIsbACG0eWvIe0oH5AZkaHDFFOX3/8iX0diA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631811745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bpGfOVRfihbzCZQPktrWeUBsiNFJC+Xvb1XqdriBFyU=;
        b=bcVWjH+85hg36PRJFLTFLkBPN2dB0PMjH4pYHsL/C7UKrB/sigccyuJnnlan43HY5S9gJa
        uo1PP3jOkXzVe+Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, peterz@infradead.org,
        mingo@kernel.org, rostedt@goodmis.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] locking/rwbase_rt: Lockless reader waking up a writer
Message-ID: <20210916170223.ocefifs33ul6lx6h@linutronix.de>
References: <20210901222825.6313-1-dave@stgolabs.net>
 <20210901222825.6313-3-dave@stgolabs.net>
 <87ilz4fyzi.ffs@tglx>
 <87wnnjcuam.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnnjcuam.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-14 12:42:41 [+0200], Thomas Gleixner wrote:
> Something like the untested below should work.

works.

> Thanks,
> 
>         tglx

Sebastian
