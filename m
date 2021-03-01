Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC86329982
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbhCBAVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 19:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239675AbhCASYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:24:35 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4460C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 10:23:47 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i10so2910402pfk.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=elhVnNibLWRXOpYzcQWUom1XfAK+SnhKBYESEU9ckbg=;
        b=dhm8U9f32VMvL13XoBn/jRycDruJ1tbEfiCBwlmLC0J7q9pCugtCzaDkvEyjz30+zT
         u0dXXsf0v1iiw/TcBDHUr6qeE2Maa8HVWx4sezDa4OPmtrnThH9xTzhxV04KRryFDDDH
         awvXAKazHORtOuX7+ff4lIW+QV/vy8IkODhw6G4DX0Ol+PTgJoZmZzDup6bE8xsITPWa
         LVo5FNBezdnkQVgFAqmqtzBIqMKtdG237dm8kTihBkKD7uNAVUv+GLVxPMWDcn5VbPbU
         bsq9idzSQ6ncbhYEdpu8DqAyGFMWgzFNECUchuXoEYALuvmGdH0F6EgtGj3TkW9o8IhS
         VzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elhVnNibLWRXOpYzcQWUom1XfAK+SnhKBYESEU9ckbg=;
        b=uA49laaW69zoDzdcwRr1nn3G1QSL20HSawhj0fP3+mTeRsNFaMgBA3ioxQnKkDGJrv
         Ah1KzLvL/xCQLXb7TsZU+Rm2oDb8cvX1ZiJRLV1FWjm7DxB1bjRjPL214RZ1nY+JK8YG
         qUbadDsS1risDcA87tlRsKPuJsykPYb8EE54Jb2tG8q6UQQBb6dTv34VRAEI2SXmxJcP
         lMg8RCFRqzE2bjMKcAZFOmHRHHMcpP1ytUGIoWBZ2S6x9LQHnWXRp51aiHsYImF0tIGX
         4tkmxAHmX/c3tC+oQEWrThanP6GMd+RpsIerbiWt2uHrlyxpyXXnbzMqQ6s8udgJQofA
         L6AA==
X-Gm-Message-State: AOAM530jTvCoKQI+uFxZ3v2fJWBYWYloIAQ/3qqNLHxTzkfTIEOIPv8V
        fMl0zeYdGiV+8CfvQsIhjioitQ==
X-Google-Smtp-Source: ABdhPJyfYVi2x5un9uqI5jrKk0hKGwtPJZdYR5nFytZwwbl/qWkZ/qoQsTOsLuUNWum40B33u5cu7w==
X-Received: by 2002:a62:194f:0:b029:1ee:5078:23a8 with SMTP id 76-20020a62194f0000b02901ee507823a8mr12442534pfz.70.1614623027221;
        Mon, 01 Mar 2021 10:23:47 -0800 (PST)
Received: from google.com ([2620:15c:f:10:5d06:6d3c:7b9:20c9])
        by smtp.gmail.com with ESMTPSA id w200sm18791660pfc.200.2021.03.01.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 10:23:46 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:23:40 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     "Woodhouse, David" <dwmw@amazon.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v2] KVM: x86: allow compiling out the Xen hypercall
 interface
Message-ID: <YD0xLDj4pTK1Qzkz@google.com>
References: <20210226115744.170536-1-pbonzini@redhat.com>
 <49138fc5ae02d6009af3adcdb49f5cce05c3bfd9.camel@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49138fc5ae02d6009af3adcdb49f5cce05c3bfd9.camel@amazon.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021, Woodhouse, David wrote:
> On Fri, 2021-02-26 at 06:57 -0500, Paolo Bonzini wrote:
> > +       depends on KVM && IA32_FEAT_CTL
> 
> Hm, why IA32_FEAT_CTL?

Ya, unless Xen support is Intel-only, that's a bug.
