Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D736B3D1907
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhGUUrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhGUUrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:47:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE759C061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:28:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b12so2103617plh.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m52PtSGS5i2ngVfsBQ5ZUPxnRYkxsgX69pi1tPp/x28=;
        b=EkRmTC23UJLa27xiqrDPH9e0nL/5dbsaIMYECtzNpfQdqxU0y++VvIo9t3iZOZasl4
         jYpw45BVN3QaRitxTs3cwM8dzEJ2XqP31EZxKQ7iA3MxjV5p229J+WehsDebrvcj7VG9
         IFHImvsX9TSaZrJekSbBMbLHBqoIUFhU5393LxtR0GoWKzmQz2HQdZq6/oQCP1/8P/Ui
         wvRREhKgvtgIRbz96NCsgk/6a24bn9bmZrob2IZzZY31nKdoscikPvIXNGvT2TOY3X5R
         jZkyiU86yysTbPsDId8Uw/VFPTacnJshMELqVIB/27u9v+L/DZgQAv6fZn0RfgfbXARd
         6M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m52PtSGS5i2ngVfsBQ5ZUPxnRYkxsgX69pi1tPp/x28=;
        b=L0/oxpqzrEz9zARROF5y4meNzzieuvWQr/6BAFITKjjXlqMNBTymm7SaQ4LtVoBTJN
         lcgRL4hlQIQIvf0KBuVxzJhJ24bsQ81/4Zhb07NCzBR2atLH0e7EeLRRBnuYposXrLeC
         +WFT5hVtec2ZEySHjAoabf9NdZ0xPXw0Hf1Hp833lXhYSYMFdBcN9UsmSu5LHV1BXo+p
         JHCdvkNowJ6YZBCsWZD5wB1XMA2Q1cdM87ptx8wR312Bzcam7tHEIiTH+aR0qeiIquE8
         AiZdKzSzapohOQ6p9cixg9lpB6AjJvbsY22EtRFQoZ9QN9cq4ucDqPvzltOi37UTKfOg
         XuVQ==
X-Gm-Message-State: AOAM533ewyuiqZuKM9HUdjP+SZzSGQwZ6EXx0abrKmhgPk1VUThSRK+3
        SRGg2gkQxHYI7LJ/PTZBUU7alA==
X-Google-Smtp-Source: ABdhPJzsoonsfnNjS3Ej+And/W99sgjoE8mLSxLOu98GqGpd3UXFs6LJBzdPMDQ7TgaGj3mTUb7RMA==
X-Received: by 2002:a65:6a0d:: with SMTP id m13mr38552756pgu.356.1626902907296;
        Wed, 21 Jul 2021 14:28:27 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w18sm25716948pjg.50.2021.07.21.14.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:28:26 -0700 (PDT)
Date:   Wed, 21 Jul 2021 21:28:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "KVM: x86: WARN and reject loading KVM if NX is
 supported but not enabled"
Message-ID: <YPiRdiG0uFFNGtmN@google.com>
References: <20210625001853.318148-1-seanjc@google.com>
 <28ec9d07-756b-f546-dad1-0af751167838@redhat.com>
 <YOiFsB9vZgMcpJZu@google.com>
 <20210712075223.hqqoi4yp4fkkhrt5@linux.intel.com>
 <YOxThZrKeyONVe4i@google.com>
 <20210713035944.l7qa7q4qsmqywg6u@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713035944.l7qa7q4qsmqywg6u@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021, Yu Zhang wrote:
> On Mon, Jul 12, 2021 at 02:36:53PM +0000, Sean Christopherson wrote:
> > On Mon, Jul 12, 2021, Yu Zhang wrote:
> > > Why do we need EFER in that case? Thanks! :)
> > 
> > Because as you rightly remembered above, KVM always uses PAE paging for the guest,
> > even when the host is !PAE.  And KVM also requires EFER.NX=1 for the guest when
> > using shadow paging to handle a potential SMEP and !WP case.  
> 
> Just saw this in update_transition_efer(), which now enables efer.nx in shadow
> unconditionally. But I guess the host kernel still needs to set efer.nx for
> !PAE(e.g. in head_32.S),

Yep, and that's what I messed up.

> because the guest may not touch efer at all. Is this correct?

KVM doesn't require EFER.NX "because the guest may not touch efer at all", it
requires EFER.NX to handle scenarios where KVM needs to make a guest page
!EXECUTABLE even if EFER is not exposed to the guest (thanks to SMEP && !WP).
