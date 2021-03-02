Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597B932ADEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360159AbhCBWRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:17:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232227AbhCBUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614717104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LoXsMIh8kxioX7DB8CWUSz1tO5CDutkuFkB3ayoWzcQ=;
        b=F5zdcuhqn5Vj+h+B3vNQdtWH/JAhLPKjPhfBUm9qwutYZQRIjIvMU/ojPdwmsJ6Yv3uwpm
        A0pesZMtnXOjEXv5zALVQrLCWuVfyWtNGXkWfdZX0WeyZEKDukAExBZTkYKfx5sm99y0LZ
        t+eeY41psqBMX4IZt8R6KWmADPy+rFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-OE0YojrQPy2CBngDxBhEcA-1; Tue, 02 Mar 2021 15:31:39 -0500
X-MC-Unique: OE0YojrQPy2CBngDxBhEcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA72518B9ECA;
        Tue,  2 Mar 2021 20:31:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with SMTP id C973A60BFA;
        Tue,  2 Mar 2021 20:31:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  2 Mar 2021 21:31:37 +0100 (CET)
Date:   Tue, 2 Mar 2021 21:31:34 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Why do kprobes and uprobes singlestep?
Message-ID: <20210302203134.GC21871@redhat.com>
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
 <20210301165130.GA5351@redhat.com>
 <20210302112224.6b3568434be490fbfbdec790@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302112224.6b3568434be490fbfbdec790@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02, Masami Hiramatsu wrote:
>
> > Not sure I understand you correctly, I know almost nothing about low-level
> > x86  magic.
>
> x86 has normal interrupt and NMI. When an NMI occurs the CPU masks NMI
> (the mask itself is hidden status) and IRET releases the mask. The problem
> is that if an INT3 is hit in the NMI handler and does a single-stepping,
> it has to use IRET for atomically setting TF and return.

Ah, thanks a lot,

Oleg.

