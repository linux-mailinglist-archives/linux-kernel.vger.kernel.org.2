Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F9409F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 00:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbhIMWC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 18:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234740AbhIMWC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631570471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBIFmwovN0AX7FNl3CrTwWZ3rAWB/MKhfO4Mt83/g5Q=;
        b=UcmAU5Jq23wNdB3PN1gc+UiO+at/hpPc7m3GTYaIfCLKi801enSi08IYod0Xix71fxwbyw
        +aFpI9HohZqofxqVSPFvT3V93LvwNjk878NYd7xh/7NtuM9WLuM4KWlgEinYvqkk7Oftn7
        y4P6ILfZdTEkNyiUXcLJjlL26In8Y4k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-zeM0TKU4NsW7mY1ZR_xpAA-1; Mon, 13 Sep 2021 18:01:10 -0400
X-MC-Unique: zeM0TKU4NsW7mY1ZR_xpAA-1
Received: by mail-wr1-f69.google.com with SMTP id a27-20020a5d457b000000b0015b11fccc5eso3169326wrc.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hBIFmwovN0AX7FNl3CrTwWZ3rAWB/MKhfO4Mt83/g5Q=;
        b=52SgLcHNtmcfb5qVxOhpXrir6ErYkHEHN23KOpsaQz/JVj07HfhCxDcTPkJiz6rCYA
         ZMhZ1hCQFZrHPEQtQ7DxAoIpko4ts8wRqRXL2rKdmgn8/j/pR22me/tNXMyB6TqNaPLd
         bWcxp3++7/fSYrfjDRqq0mEs3s5uZE+Tya94GIMGZ/rxX6aa4E7vyC/OH7cDQtLkgxet
         NxOj/+uICMnycJRDTOfROOLhJYH3g8HVIsQigM08nRsCcyBpqgmcMqub4SBVBTodge0M
         D2iqymFS3aWaJqnxjRXTepmVhfmRgtN6UGs7DXJcQm28rWMbTMIlbO8LefSiSq1Dmm9Y
         D8GQ==
X-Gm-Message-State: AOAM530ojpyCOR2ROWpVrFkzGo4pUFnYB2vgeeDdxMhnmNyvuldB98eK
        ux/RF52ms9VDlpn74WY6DmHL0icMJKYLlkoTaaiHj288ROP1LmOJsb7ICujkj3yz1n3cphKRJz5
        t2rmLm9BlhV4TQcxz7WTTVEbz
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr13251210wmq.21.1631570468927;
        Mon, 13 Sep 2021 15:01:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgHCJVlTo5Q7ufuv4RmgQflxRDkka0ghsQSd8ubKToVxE5UDhUvgwSIExgPSoK0Pk5nJxZyA==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr13251198wmq.21.1631570468793;
        Mon, 13 Sep 2021 15:01:08 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
        by smtp.gmail.com with ESMTPSA id m1sm7570288wmq.10.2021.09.13.15.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 15:01:08 -0700 (PDT)
Date:   Mon, 13 Sep 2021 18:01:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
Message-ID: <20210913175428-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
 <875yv4f99j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yv4f99j.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:36:24PM +0200, Thomas Gleixner wrote:
> >From the interrupt perspective the sequence:
> 
>         disable_irq();
>         vp_dev->intx_soft_enabled = true;
>         enable_irq();
> 
> is perfectly fine as well. Any interrupt arriving during the disabled
> section will be reraised on enable_irq() in hardware because it's a
> level interrupt. Any resulting failure is either a hardware or a
> hypervisor bug.

yes but it's a shared interrupt. what happens if multiple callers do
this in parallel?

