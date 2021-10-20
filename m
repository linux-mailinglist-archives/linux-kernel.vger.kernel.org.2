Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89819435465
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJTUOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJTUOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:14:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CEFC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:12:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id i1so321215plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZiXG6npJQ40qHjEvArb6k7d15fp/E+O+F6q9OgsTVB0=;
        b=Bs6oDxIB9/BvVAMg2OuQLkevbXtWhuULIQBz+tqDxlUSrd8RseBFIS63sD5AFUyNFA
         y6rjUICcdFnVdlmsyhEg/SAVUrRIBjTHT1EPHCFeljsfY9tI0FlqVdePnDs6rspmVybg
         JprEhH85z/yToGsmQwvLF1iCTVZAsvwJlEk6EXQ0y2k6N6MAHn3qDk2ZgNgQWXr51LTX
         d9cXEFt49jshq0HZu8G67Bhu+aAKS3raIBigvZVnN1h4i8tMvjNF/rjs6KbJo+PvaCjg
         yvtpQo6kI09UQQ9P5CuPPjpmXLbxwjO8vGXgr0FkQKwf34SZSsuvldUqskUsGfKS5LfE
         Y6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZiXG6npJQ40qHjEvArb6k7d15fp/E+O+F6q9OgsTVB0=;
        b=abOClz+afEAmB6D4xuEoyYpvegQLfAyCEd38uJ1SwyVm8vxX0cl5JsOVGp1bh2Alcx
         NkiYUXSJpv5CWWL2sfQVneCD76BF+HHClTozFcOnZmtgNVpTsIZIjueNPG2Cmc1590Ze
         u3aY/ZVRp4aLKf8fGLeL9n9fngbfj0dzeDoTxf1FzLNevFZw6zVJfDdoJMLNBPPKgGQs
         8ZjemrN3+8HnySDyZgMb0K3xR7UKJtO3VfWY9zSXeePF0GQiM890gPoOUrrmnTfZv0GW
         ttJIS3ZqmaaGI92EwWblBqy0d+7e4VPTOpP7hJbRb6EsF9eQt9/fsB5ICWe/WV17Jhii
         gtxg==
X-Gm-Message-State: AOAM531WPhMXD6iHCNEdhpiYt0/r5p4XXBiKzrV7q1Wz+A9jfs39hU7I
        HpoOHqk7d6ggUAGaaTAvE9fmIA==
X-Google-Smtp-Source: ABdhPJxyDHHysLeYQux6u2PjLueuQPGehtUGpIgOL8UuONJAF8k+vkIJxYxeVmC9UGFYJ5fS4AQuYA==
X-Received: by 2002:a17:902:a9c3:b0:13f:c765:148d with SMTP id b3-20020a170902a9c300b0013fc765148dmr1191357plr.28.1634760728940;
        Wed, 20 Oct 2021 13:12:08 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x6sm3827540pfh.77.2021.10.20.13.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:12:08 -0700 (PDT)
Date:   Wed, 20 Oct 2021 20:12:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: Introduce boot parameter no-kvm-pvipi
Message-ID: <YXB4FHfzh99707EH@google.com>
References: <20211020120726.4022086-1-pizhenwei@bytedance.com>
 <CANRm+CxAVA-L0wjm72eohXXWvh9fS7wVFzfKHuEjrsiRFuk9fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CxAVA-L0wjm72eohXXWvh9fS7wVFzfKHuEjrsiRFuk9fg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021, Wanpeng Li wrote:
> On Wed, 20 Oct 2021 at 20:08, zhenwei pi <pizhenwei@bytedance.com> wrote:
> >
> > Although host side exposes KVM PV SEND IPI feature to guest side,
> > guest should still have a chance to disable it.
> >
> > A typicall case of this parameter:
> > If the host AMD server enables AVIC feature, the flat mode of APIC
> > get better performance in the guest.
> 
> Hmm, I didn't find enough valuable information in your posting. We
> observe AMD a lot before.
> https://lore.kernel.org/all/CANRm+Cx597FNRUCyVz1D=B6Vs2GX3Sw57X7Muk+yMpi_hb+v1w@mail.gmail.com/T/#u

I too would like to see numbers.  I suspect the answer is going to be that
AVIC performs poorly in CPU overcommit scenarios because of the cost of managing
the tables and handling "failed delivery" exits, but that AVIC does quite well
when vCPUs are pinned 1:1 and IPIs rarely require an exit to the host.
