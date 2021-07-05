Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8723BC1B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 18:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGEQgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 12:36:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55814 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGEQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:36:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BEF7D203A4;
        Mon,  5 Jul 2021 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625502840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkPXIuH/RB2D0QQyUgwo3tt0LzV1ZF0yIHcY5Q7RSRA=;
        b=dhQONS9SP70K9gmKDN1/3brZ6Ws7J1+ecCqYz1p2GG0YG03FI4IH6fHwbmokt1r7ya3LId
        AUAuMzuTQ1/kI9JaHFTNlp8unvQ08SuWzPI4I6hDly31837s4vo/g+/oW2PHbrvdh9MEHq
        ZmGICP3Tky5YTT10yU+K0fySIxa8VhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625502840;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkPXIuH/RB2D0QQyUgwo3tt0LzV1ZF0yIHcY5Q7RSRA=;
        b=GGH+zTrRWKqliCGxDTsieZ7pw98QA3b+Ipk/dEoTlWDBiCIN9d3s6+/5TX9pX0HKT9m8iL
        Gp8GOJBB2wgUfdCw==
Received: from localhost (unknown [10.163.25.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 98709A3BA8;
        Mon,  5 Jul 2021 16:34:00 +0000 (UTC)
Date:   Mon, 5 Jul 2021 18:34:00 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <20210705162519.qqlklisxcsiopflw@beryllium.lan>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
 <YNp50pmlzN6M0kNX@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNp50pmlzN6M0kNX@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 09:39:30AM +0800, Ming Lei wrote:
> Can you investigate a bit on why there is the hang? FC shouldn't use
> managed IRQ, so the interrupt won't be shutdown.

So far, I was not able to figure out why this hangs. In my test setup I
don't have to do any I/O, I just toggle the remote port.

  grep busy /sys/kernel/debug/block/*/hctx*/tags | grep -v busy=0

and this seems to confirm, no I/O in flight.

So I started to look at the q_usage_counter. The obvious observational
is that counter is not 0. The least bit is set, thus we are in atomic
mode. 

(gdb) p/x *((struct request_queue*)0xffff8ac992fbef20)->q_usage_counter->data
$10 = {
  count = {
    counter = 0x8000000000000001
  }, 
  release = 0xffffffffa02e78b0, 
  confirm_switch = 0x0, 
  force_atomic = 0x0, 
  allow_reinit = 0x1, 
  rcu = {
    next = 0x0, 
    func = 0x0
  }, 
  ref = 0xffff8ac992fbef30
}

I am a bit confused about the percpu-refcount API. My naive
interpretation is that when we are in atomic mode percpu_ref_is_zero()
can't be used. But this seems rather strange. I must miss something.

