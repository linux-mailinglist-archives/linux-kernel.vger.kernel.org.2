Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A064042215B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhJEI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:57:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEI5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:57:31 -0400
Date:   Tue, 5 Oct 2021 10:55:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633424140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mToF1A35rc8FkkqdsQ+ngAvlAmPoX09sNn76CPlVkyY=;
        b=A2DPMkGE6HLKyycsZ5X3hyf7Pfc/yliNtfqTHHnVJDn8kuaxJd8pPoskwVd72Ca0zuBlDn
        16Nx1POgFhbr8AB/EB9T9LtAlyE3tikf429StFGv+0JmKJbhQo6Co+D63bwTkAAmjj9pXT
        k/hPBzDKVVKeIN1IdECg4K1oCdxFHI+T1Ynu52CbXuh7g0SQfItKvFXYil4ztloTX2/mSQ
        AFpyl0f+SiGw80z8V7ziANk67eVDcOdMcBgCSE0O2H4Ss16z12MZRgA6c0IpPJV5zH5jAH
        Rn2fHhDgWzz4wKtB1WH6ASkl27tBdh48A/QTMXv62T/PInA4H6kbREVLwE2EbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633424140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mToF1A35rc8FkkqdsQ+ngAvlAmPoX09sNn76CPlVkyY=;
        b=OM91k6NfPbMyWwZwSfhT25SwF3ao/k4NC1C6AruwGdpvBQLnAoN9B2BWNI3qxoXZXvA32b
        /125J6amO720JfBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Stefani Seibold <stefani@seibold.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] samples/kfifo: Rename read_lock/write_lock
Message-ID: <20211005085539.kqi5542z6wgoxnlk@linutronix.de>
References: <20210923172918.o22iwgvn3w7ilh44@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923172918.o22iwgvn3w7ilh44@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-23 19:29:19 [+0200], To linux-kernel@vger.kernel.org wrote:
> The variables names read_lock and write_lock can clash with functions used for
> read/writer locks.
> 
> Rename read_lock to read_access and write_lock to write_access to avoid a name
> collision.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lkml.kernel.org/r/20210806152551.qio7c3ho6pexezup@linutronix.de
> ---
> 
> Repost.

ping.

Sebastian
