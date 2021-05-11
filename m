Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35DD37A11D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhEKHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:48:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42348 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhEKHr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:47:58 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620719211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dtVEhCLda8HUeKzIqG51m4PkcfarQ4Ebl7TLDitKBI=;
        b=3LourMSF7DsaPAHqr0aaZ6BlkdlbV6LqKjrjyfvqoMLqY1XJGOJUPBcuusaM1rMe9Sut1y
        zOT9Eue0HmJZpL5QrOZ35cMHp0WfFlkVJ8jLp52OnY8B7OYTbbOBmT+ZQ7BoFvBgVUTE2L
        Ke+arWRAAVz+z+Lv+9VQFisOOBs3IOuEx3WK9Cx+FvbhqFUJfGoHUqQjkqlfg98JzEOqlU
        P6EMrY6Yfvw9ldiXeWfvLdKjlrhbKlhcqKtdlCATUvSpUFZ/Qi+tgb1bK2bEhx7w9jgmIT
        Tu+IBEssamCP/1Xz0Y25r9wMyi2i3kra4FPKERzDVn5Ho0IgwqwkkICi58hyrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620719211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dtVEhCLda8HUeKzIqG51m4PkcfarQ4Ebl7TLDitKBI=;
        b=x+fuvGCbSAp/hR3iIE9JNfwIzdafP9EW9cZnnVgnaAxVLdmLmtEdUT0DxHqi1z9/3XijY8
        fBCXmu4ZweIM55AA==
To:     Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sassmann@redhat.com
Subject: Re: [RT] Question about i40e threaded irq
In-Reply-To: <YJofplWBz8dT7xiw@localhost.localdomain>
References: <YJofplWBz8dT7xiw@localhost.localdomain>
Date:   Tue, 11 May 2021 09:46:51 +0200
Message-ID: <875yzphfv8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11 2021 at 08:09, Juri Lelli wrote:
> My understanding is that rps_trigger_softirq() sneaked in while
> i40e_msix_clean_rings() threaded irq was running and, since the latter is
> using napi_schedule_irqoff(), the softnet_data poll_list got eventually
> corrupted.
>
> Now, doing s/napi_schedule_irqoff/napi_schedule/ in the i40e driver seem
> to cure the problem. I'm not sure that there isn't a more general
> solution, though. Is it expected that napi_schedule_irqoff users in RT
> know what they are doing or do we want/need to fix this in a more
> general way?

The straight forward fix it to map napi_schedule_irqoff() to
napi_schedule() on RT. Fixing this at the driver level is a whack-a-mole
game.

Thanks,

        tglx
