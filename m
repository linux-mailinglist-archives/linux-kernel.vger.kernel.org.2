Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208CD401944
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbhIFJvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:51:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbhIFJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:51:10 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630921805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0uFqclNYcUVYj+dZyKRYswnxSvqbQn7Y2J+XQiuzew=;
        b=HH2WSCxznwzEkeEOhE7rzEZ2pGtoYGARF9SULB6sR5WjDr4BqZdWBTJcAWVqXuEiBrvBpN
        ibQGOLfzVGszZkawEr7xFWgliAZsXNopTrlCUMJJ62GPLgzp9Xwc5JpSM2D6OIsYXAbY77
        Sz0ssc4WTxS3r5TAHvl9KHe5Vk47hW+Z1lqkRdA5lJUtuZY0OesZnpwz4/QxYPHEEzUUmf
        R2X+gVSD35rVaUVwmfUoxHxyutAFBxNH6XsFBHLnIQSv7otfnJx/+ApZd87Aa4uuy/yCxc
        ALmrX+rT+9L+8wv4kRs0rIZMMHJP6md+T1E9XjWWBy0uvHtPhXGlbnVkYvQq+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630921805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0uFqclNYcUVYj+dZyKRYswnxSvqbQn7Y2J+XQiuzew=;
        b=xMCNKp437XOsJ7iw/ape3yFXVVNaS+uRTg/It5heHqUS4ZrtcEX5/OCw6Rv1K32FXzeAII
        To/WR470XYoORrCw==
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/irq: Make irq_set_affinity_hint return the real
 return value
In-Reply-To: <CAPm50aL9trE88p59KFj-UfEKMji5Ouyjtk=eq55JnSzGZ12WsQ@mail.gmail.com>
References: <CAPm50aL9trE88p59KFj-UfEKMji5Ouyjtk=eq55JnSzGZ12WsQ@mail.gmail.com>
Date:   Mon, 06 Sep 2021 11:50:05 +0200
Message-ID: <87bl569goi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06 2021 at 16:20, Hao Peng wrote:
> irq_set_affinity_hint does not return the return value of
> __irq_set_affinity, which makes the state of functions dependent
> on the return value of irq_set_affinity_hint inconsistent.

No, it does not. The affinity hint has been installed even in the case
that __irq_set_affinity() fails.

Setting the affinity in that function is a best effort operation without
any guarantees and in hindsight this should have never been added to
this function.

Thanks,

        tglx


