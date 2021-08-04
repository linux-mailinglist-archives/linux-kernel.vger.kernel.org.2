Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74F3E09FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhHDV25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhHDV24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:28:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A409C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:28:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j3so4523553plx.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwkwRJ9mLbXh7zqk7lDDyX/7/SuI/tJpL52Sp9LmiBc=;
        b=OE/AvtRMkBeyoJUtymm5FvWO/YBLRc0dy9KBzpwRW/ToEUPpaWRmMC/JvfVXySz4+b
         rywpJFZqj1Um7P1D3RLIp6VBJp6QKPoETT80bBQyKdCGtdWj2HwxF36cxC7GBBPzNvgP
         ehZHkhCKoiVj9o0YHWD3PK8sMo8Uh7Fqr8kmVz4FKdK3n6/pMk6qmdXWjdKuTb3iD39u
         RBTAgcWCfQpNPILQjyeMYAiaBZUDO0mnKg4sRctkx5hk68aL2guyJ0GTlMkmKu3yLYGi
         nvWxG11kdhoIWEwlz664vRRDWHXvX4S/ZJfPdivV589vP3whFMYgwH/JCwHwZ4ufyaPH
         /yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwkwRJ9mLbXh7zqk7lDDyX/7/SuI/tJpL52Sp9LmiBc=;
        b=Gu7BbzjjUta649LONMXJwU6vdQ747fXVNXRz/CyQ9kC798Hazy7Dsb0IBjUdZQ13B3
         8+Dxs1pET5rqvXo23TfNOmm/YeVZfBQgIHY2JU0g2h3SEwjfyL9eefY/XwQW8BYep/b8
         LPIDhaiwgIUzBtZki0slvgHFWnEYobGoadgyHA2URhzHYsIM3eqlnwDWDVfGFVQyadfF
         PDed35kAweQ1zdXyGwBZoY8moP6+ltviQqY+7QUqrePHdcmgCWG7iYGWPyOGSknA3GCv
         bb29QY5f0wsJzJiE5/ULM1+Mz12wLeuRfeUNjunHYmBBBOoRW3ILuKcuSkr4L57R5aKl
         UyRw==
X-Gm-Message-State: AOAM532gaK8iymvpad2XvQrKP+c4E8HCs3hzfPc0cRrwVahE3ygNEwBH
        kLBNVHZtixCS64DkFC5+CPZg0fpxqaIrje2hvPiDKg==
X-Google-Smtp-Source: ABdhPJzFVq7U9xJpmnszWMfMg7W/Q7UwjVYxw+m5FvMfbR7Rr8H+p1C6DFfux6NGIeUPdKskM9JDCoFFLzrXds0FDEs=
X-Received: by 2002:a17:90b:11cd:: with SMTP id gv13mr2974447pjb.149.1628112523029;
 Wed, 04 Aug 2021 14:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com> <CAPcyv4iEEDCz5719d0vNi=zi=6oN5vctcVfY5P=WQ9j_Zpz6eA@mail.gmail.com>
 <YQsBfAVPomaC97Rm@casper.infradead.org>
In-Reply-To: <YQsBfAVPomaC97Rm@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Aug 2021 14:28:32 -0700
Message-ID: <CAPcyv4gSsL5hk=CSk=9duqCN3VDS_T2LaYRL+_zK9VOkO8NB+A@mail.gmail.com>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 2:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Aug 04, 2021 at 01:11:27PM -0700, Dan Williams wrote:
> > On Wed, Aug 4, 2021 at 12:29 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > Why not just make distros that want to support this type of platform,
> > > also provide these tiny kernel images?  Why are you pushing this work on
> > > the kernel community instead?
> >
> > In fact, these questions are where I started when first encountering
> > this proposal. Andi has addressed the single kernel image constraint,
> > but I want to pick up on this "pushing work to the kernel community"
> > contention. The small list of vetted drivers that a TDX guest needs
> > will be built-in and maintained in the kernel by the protected guest
> > developer community, so no "pushing work" there. However, given that
> > any driver disable mechanism needs to touch the driver core I
> > advocated to go ahead and make this a general purpose capability to
> > pick up where this [1] conversation left off. I.e. a general facility
> > for the corner cases that modprobe and kernel config policy can not
> > reach. Corner cases like VMM attacking the VM, or broken hardware with
> > a built-in driver that can't be unbound after the fact.
>
> I don't understand how this defends against a hypervisor attacking a
> guest.  If the hardware exists, the hypervisor can access it, regardless
> of whether the driver is default-disabled by configuration.

The "hardware" in this case is virtual devices presented by the VMM to
the VM. So if a driver misbehaves in a useful way for an attacker to
exploit, they can stimulate that behavior with a custom crafted
virtual device, and that driver will autoload unaware of the threat
without this filter for vetted drivers.
