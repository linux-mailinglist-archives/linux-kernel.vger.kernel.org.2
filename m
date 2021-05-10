Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96AF377D87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhEJH4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:56:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35336 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhEJH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:56:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620633299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+e2LVoGoQWMuVCOL9fWn+mEuUhKFaylXgBU3Qerka4M=;
        b=1gK5IxLzLGYPoOPMh9825jjnrg8KLdfXeonBs3lL7BwLxLwETHVlO+nn/MNyJ+EDUgK34Y
        XUvVbZVtrR+g+agHKQ5ljsuE6kB0vRz53Z2f2NEIoIrpqTNvKE6FS67ciS/YjbOAIdAaGj
        yo3Uh1XmoLUcsgnoIFdPfFEl/mwJKrIxRJNm8qPe9/AgZSnNHzvI9a5WsLQndKXEZOzSkj
        +2fH7n8liH+LMLCbpaERJznIEnYYvc5huzhQOeqnEWA0ycgaw8yaFcnEoRL/uuKZatcTNl
        lM/Nn5QODV4vNltC6Np+/23xwQwt4kmjxsQRCWMPdR15wlqKnivAlljmfrpZ2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620633299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+e2LVoGoQWMuVCOL9fWn+mEuUhKFaylXgBU3Qerka4M=;
        b=oI5VvMSVEoXgNhFOc+ZlmM28YFGA2Jv1SC0NxM2K/GfrshdzvozqPRgH3m8htj7MFb33Vh
        3elT4z4qaOd/pKCA==
To:     "liaochang \(A\)" <liaochang1@huawei.com>,
        xuyihang <xuyihang@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, minlei@redhat.com
Subject: Re: Virtio-scsi multiqueue irq affinity
In-Reply-To: <9903df53-8a84-fe89-7ae0-aac8e6d3f42f@huawei.com>
References: <20190318062150.GC6654@xz-x1> <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de> <20190325050213.GH9149@xz-x1> <20190325070616.GA9642@ming.t460p> <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de> <20190325095011.GA23225@ming.t460p> <0f6c8a5f-ad33-1199-f313-53fe9187a672@huawei.com> <87zgx5l8ck.ffs@nanos.tec.linutronix.de> <9903df53-8a84-fe89-7ae0-aac8e6d3f42f@huawei.com>
Date:   Mon, 10 May 2021 09:54:58 +0200
Message-ID: <87r1ifkoq5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liao,

On Mon, May 10 2021 at 11:19, liaochang wrote:
> 1.We have a machine with 36 CPUs,and assign several RT threads to last
> two CPUs(CPU-34, CPU-35).

Which kind of machine? x86?

> 2.I/O device driver create single managed irq, the affinity of which
> includes CPU-34 and CPU-35.

If that driver creates only a single managed interrupt, then the
possible affinity of that interrupt spawns CPUs 0 - 35.

That's expected, but what is the effective affinity of that interrupt?

# cat /proc/irq/$N/effective_affinity

Also please provide the full output of

# cat /proc/interrupts

and point out which device we are talking about.

Thanks,

        tglx
