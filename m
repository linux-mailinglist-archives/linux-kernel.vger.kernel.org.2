Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97014456F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhKSN3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:29:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhKSN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637328367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDrQgx53U8HesTcis3pQIJTyz9AOSXX3EzbKVHyF6d0=;
        b=KLIP5HiLUPjyWPU3ObQ+i83/2+J1HAVZmNjTv1Pqiz2Zj8XZ8+8wNDCt5oSgKgVEX0YcOM
        8ISZmk0NMiN5mK2nHN7w2IXn3ttV/Dw/3b5pShotoOyNggMXuDfakdIUX9/W7ou5CsAElP
        v7Xr0JhGsSKz+2kzhU6VdnwSIxHg6GE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-z_-7XQHRNxaINAzTPKPqsg-1; Fri, 19 Nov 2021 08:26:06 -0500
X-MC-Unique: z_-7XQHRNxaINAzTPKPqsg-1
Received: by mail-wr1-f69.google.com with SMTP id p17-20020adff211000000b0017b902a7701so1773540wro.19
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tDrQgx53U8HesTcis3pQIJTyz9AOSXX3EzbKVHyF6d0=;
        b=7pyL12WFg9F5zNTue3lKDkU/RqxH2wIH68Xqox/qZ++c5iMyNuF5U0TBq1pv0j5wvs
         DGYX/2dLFes8UDzftE+HuUMVItSIeAq0tEw3t+sSjpc6B9ejtH4iAxHYJrmxBf4Bd3aL
         LVKn7xH4eNXjho1D6zO2CMf5qlko6cR6xnuPoSFZ2ypjBVq2cfAE+6kOT3l+3rUOK0T0
         GDMJGATHY5pYVnlNBebijXH08V92gfcsvmb3udRCbnBNOaxutNWnUqMXXfoa+4XEz2NQ
         SKGRZb7Sw4itKxmBjEgi+xLE/te1Tj+XTMvUsM595Wj45ZCLYfmi3uPiMls5xUU9HLmf
         lBJA==
X-Gm-Message-State: AOAM531iYy7xL8yVgO9hp3eBYG4Xsi/0DHZeV6cDi0yeCskKx5/6uQNU
        E2HwEtA0tUbB3MxJ4ndOe4KmDHS+56r8LEbJqDzXWAaiNsTCzCSI956+hwMHzbOoAqJPPnMCqjx
        sd8VI2aAMJXIs77PG6cMyGCcl
X-Received: by 2002:a05:600c:4303:: with SMTP id p3mr6982015wme.128.1637328365428;
        Fri, 19 Nov 2021 05:26:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweP7wgXb5BaGXphhgtU6lkM9ldywaVRytkeY4pifGSaoOTuJNb3qZ1CNxeHzPL9hlFgq7JTQ==
X-Received: by 2002:a05:600c:4303:: with SMTP id p3mr6981971wme.128.1637328365233;
        Fri, 19 Nov 2021 05:26:05 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id s8sm3034920wro.19.2021.11.19.05.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:26:04 -0800 (PST)
Message-ID: <f83be3c5b582d1d25a4d3337e1d2971b48e9a83d.camel@redhat.com>
Subject: Re: [RFC PATCH 1/2] arm64/tracing: add cntvct based trace clock
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Marc Zyngier <maz@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        mingo@redhat.com, nilal@redhat.com
Date:   Fri, 19 Nov 2021 14:26:03 +0100
In-Reply-To: <87h7c873u0.wl-maz@kernel.org>
References: <20211119102117.22304-1-nsaenzju@redhat.com>
         <20211119102117.22304-2-nsaenzju@redhat.com>
         <20211119112624.GA51423@fuller.cnet> <87h7c873u0.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-19 at 12:00 +0000, Marc Zyngier wrote:
> On Fri, 19 Nov 2021 11:26:24 +0000,
> Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > 
> > On Fri, Nov 19, 2021 at 11:21:17AM +0100, Nicolas Saenz Julienne wrote:
> > > Add a new arm64-specific trace clock using the cntvct register, similar
> > > to x64-tsc. This gives us:
> > >  - A clock that is relatively fast (1GHz on armv8.6, 1-50MHz otherwise),
> > >    monotonic, and resilient to low power modes.
> > >  - It can be used to correlate events across cpus as well as across
> > >    hypervisor and guests.
> > > 
> > > By using arch_timer_read_counter() we make sure that armv8.6 cpus use
> > > the less expensive CNTVCTSS_EL0, which cannot be accessed speculatively.
> > 
> > Can this register be read by userspace ? (otherwise it won't be possible
> > to correlate userspace events).
> 
> Yes. That's part of the userspace ABI. Although this particular
> accessor is only available from ARMv8.6 and is advertised via a hwcap
> to userspace.
> 
> For currently existing implementations, userspace will use the
> CNTVCT_EL0 accessor, which requires extra synchronisation as it can be
> speculated.

To complete Marc's reply, here's an example of how CNTVCT_EL0 is being used in
rt-tests' oslat:

https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/oslat/oslat.c#n87

-- 
Nicolás Sáenz

