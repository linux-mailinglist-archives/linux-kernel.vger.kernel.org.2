Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2013DEF11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhHCN3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236260AbhHCN3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627997372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcuyzBZVCsQzdOpIzaT9GhZQ70W+KOCymEeOniqVHmM=;
        b=aouWyB+RagCDDyRN4wpI+vJd53SR6haxt1kJhvVIin8EoXjw6V2rlTB7cgk6kYjmYiyl+g
        5WwUtTmx6g3i6WRcA20kOgVlVpfOieRWgWNMaRYYNfr4kdK5EkSUdEQ+4R9dqFKpw+3wrE
        DmiQ1gpr9DDoG9wBe3LqbXUIy/gAAqk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-8LEDKJV0OI2E0-rPHAK-sg-1; Tue, 03 Aug 2021 09:29:29 -0400
X-MC-Unique: 8LEDKJV0OI2E0-rPHAK-sg-1
Received: by mail-pj1-f70.google.com with SMTP id v9-20020a17090a7c09b02901778a2a8fd6so3042594pjf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 06:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcuyzBZVCsQzdOpIzaT9GhZQ70W+KOCymEeOniqVHmM=;
        b=rVUJ799mT6UFenV2BmPEbhm7eamFIlGrGsQlwg1WpWd8v6doUpDqubJxtJlOes6nWp
         /glWTDsWS7edF5j4V17kEtWpVxBU4GtKRbkqc1Fsrq71riT0xRvc58++RLcOc0O5VaoJ
         j/il2OrAD49iTpi41Esd5UM2rsP+yUCZ8Hmnzf6ZQAbL/ZHYxYeldbZaQDLDoJ7FT7pN
         oQKEoWFaXENXNeQnTcTGov5sgJWNMRV8JUIz4SVza4En1qK5/hCHWBozbbv1MxrGrqMh
         hyyukNkQ+lQOd04kdsBtxfApO5efSONUY7205elekGG8msVpbMSLp3ywv9XOkBqprOor
         d11A==
X-Gm-Message-State: AOAM533gcvj791eerBi3Vn5HC5ad0RVr+vK3FpoE+I3wXxRnC6WQsUPe
        BcutxbpPyhLemnUwCUzKK7oCccCE6Lnsr6Kv7D5Vw3ujht2vrDzaV1cWHP/7cporKja3dta9eez
        iVYC+CPqWLlpjrjHoua/uXqo0+36BiVkMTNDrth89
X-Received: by 2002:a17:90b:e10:: with SMTP id ge16mr19921911pjb.150.1627997368681;
        Tue, 03 Aug 2021 06:29:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzxa98h40WXZjb7MbKGaow2kMLBjuSDMzy/SK9GtPRKrme9h8m7Mim/oH4cNzNd2U3c+ZjB2RXr7Hl4V6qgAU=
X-Received: by 2002:a17:90b:e10:: with SMTP id ge16mr19921886pjb.150.1627997368395;
 Tue, 03 Aug 2021 06:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210730043217.953384-1-aik@ozlabs.ru> <YQklgq4NkL4UToVY@kroah.com>
 <CABgObfb+M9Qeow1EZy+eQwM1jwoZY3zdPJfZW+Q+MoWmkaqcFw@mail.gmail.com> <YQlAl7/GSHWwkzEj@kroah.com>
In-Reply-To: <YQlAl7/GSHWwkzEj@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 3 Aug 2021 15:29:16 +0200
Message-ID: <CABgObfamvoMai1b9hrPkt1uwgw0kozhU5V_Vvk1__k_sGnx4LA@mail.gmail.com>
Subject: Re: [RFC PATCH kernel] KVM: Stop leaking memory in debugfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So userspace can create kvm resources with duplicate names?  That feels
> wrong to me.

Yes, the name is just the (pid, file descriptor). It's used only for
debugfs, and it's not really likely going to happen unless a program
does it on purpose, but the ugliness/wrongness is one of the reasons
why we now have a non-debugfs mechanism to retrieve the stats.

> But if all that is "duplicate" is the debugfs kvm directory, why not ask
> debugfs if it is already present before trying to create it again?  That
> way you will not have debugfs complain about duplicate
> files/directories.

That would also be racy; it would need a simple mutex around
debugfs_lookup and debugfs_create_dir. But it would indeed avoid the
complaints altogether, so I'll prepare a patch.  Thanks,

Paolo

