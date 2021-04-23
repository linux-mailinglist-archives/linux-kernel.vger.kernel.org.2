Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F855368D16
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbhDWGX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhDWGX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619159000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i04pIjxo3caTqanxSGddCRT34Sd+t2sowO3Lx1kBprA=;
        b=JrI1SrV3LdELlX6qX9YjCcckAuNn8AmPrZbN8JyZ9tWEa+IB/O77mjsEuODd0hkJBazlIG
        PrJmm2J+MlOKEoBzezHkNDaYr9dMNmJhHHbG/k6f/0G7YSDiGdf3VbydFvTTwaYOqi1DOs
        0fpUbEXaeebUSezDWPDX4Wyq+lUmAvk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-7vpFuOHLOVujdCskhA3XpQ-1; Fri, 23 Apr 2021 02:23:18 -0400
X-MC-Unique: 7vpFuOHLOVujdCskhA3XpQ-1
Received: by mail-ej1-f71.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso7976685ejn.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=i04pIjxo3caTqanxSGddCRT34Sd+t2sowO3Lx1kBprA=;
        b=kwsnBbY2yc/s0pdv8Kayimew20FrztMza0zwJg4kKLnD0iwxSabc6S4A/axKHthWPx
         vhZYi6leP5SWLblQMIUt7MtyeF6Y/S6HepFBJhZzBzpb+4wXIlUsz6XLJP/eKDHycYvj
         ianLCkQu3pbLx5vIwKXwm5nzSptHHbZwVYFtL+jLERXpXa5cbBZoMcG99Lf/lgfn85mu
         CvVtLHizKAby6ipRaSEFvFZluu36K2L+nm4fJ6akQuGROJktnSuvBkaPQQPaGoVMk7CT
         v+HR7MNopkcieWpr4j9nlhhmKMjQpMJWNlQTkqMufOXvT36vJE92ya698VHst7MavBKh
         D05g==
X-Gm-Message-State: AOAM5318xdTwroxVYdEoexf32K0KEx/sW/p0Jz5NqMqCYbwJuSrt3G4K
        cL9Yz9fcI5IL+huStCJ/SAWffBdNzsz/+4MhCak05DL8BuCbeS6hsyYckvVWrsKiq4Fj9qmHdAe
        oRPNIKsEQLPcJjojIlaBH/ttD
X-Received: by 2002:a17:906:49c1:: with SMTP id w1mr2577069ejv.178.1619158997529;
        Thu, 22 Apr 2021 23:23:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrErPQXlsGRXqqTFc3nZhFmRd6UymB8vfJtXB5oSSJcCHPAEAZ38BB4GOh6RFAlctlcaLtnQ==
X-Received: by 2002:a17:906:49c1:: with SMTP id w1mr2577058ejv.178.1619158997393;
        Thu, 22 Apr 2021 23:23:17 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id gt33sm3194927ejc.89.2021.04.22.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 23:23:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, xudong.hao@intel.com
Subject: Re: [KVM]  4fc096a99e:
 kernel-selftests.kvm.set_memory_region_test.fail
In-Reply-To: <20210423032514.GB13944@xsang-OptiPlex-9020>
References: <20210423032514.GB13944@xsang-OptiPlex-9020>
Date:   Fri, 23 Apr 2021 08:23:16 +0200
Message-ID: <871rb1h63v.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <oliver.sang@intel.com> writes:

> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 4fc096a99e01dd06dc55bef76ade7f8d76653245 ("KVM: Raise the
> maximum number of user memslots")

...

> # selftests: kvm: set_memory_region_test
> # Testing KVM_RUN with zero added memory regions
> # Allowed number of memory slots: 32764
> # Adding slots 0..32763, each memory region with 2048K size
> #
> not ok 32 selftests: kvm: set_memory_region_test # TIMEOUT 120 seconds

This is a timeout, it can be raised in
'tools/testing/selftests/kvm/settings'. I assume the test is running in
a VM?

-- 
Vitaly

