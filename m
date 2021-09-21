Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFFA4135D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhIUPHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhIUPHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:07:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:05:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t10so76239108lfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRK25cZbHHtlQKavhU/T9/6jGV0iBTcTONyhOsAYBmY=;
        b=am7IEocc9YZgVOfwglWFP7qU3HRHIDFdEY7/6iVrw3nBX4AN0QxJcPORozT0JcXZd3
         X3DouWAu6xRb4Y/CKD62V/RwVGwqBvqbWnUz7FEcko+fyqpZSbwHvD4vLPuFdIpv3ONm
         wjRohBQR48FUAQorBiB4gTtYNZz19Qamw+lcNrw9us4NBvU4zi8MbkIAFDY1nQDeZBDT
         NJpv7eGl1T1p5HLTfawuBfmif8afkEsGEiMwtb+8VHEbLV4JR4IPzajP2UYBaLPScr2m
         JQ59dIG7nOprPeCxyQ8xuizIleLUbGiDwEovP/jvKQBgFPjO1HC2YQ4XCwVnNDN3wklf
         +kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRK25cZbHHtlQKavhU/T9/6jGV0iBTcTONyhOsAYBmY=;
        b=vr/4QKFDi+37bjYaqb/sVSuUZ2nwPcH8ojeqLsrukF7JMw4qGF3c8/FxJRyGFhP6Nb
         /tWOawUF2VqU+dy16fNgKU3ZI3dEwfhLEveZynsLTtMx76igZKedRrN7jpscomovVaPK
         W0iCeAsWaOt4DSJ0roLjaMc5gBYm0TYAMkPHVwv9OMm9xnz26QlUmbjQw1AoJMCNrWB6
         SdKefNYMplJmTbLyAcXH93+LEGuiAO0p4n5AXYFADzE9+tqUsnSxHRskDV6/ldkDUbWP
         JoKmCC+FCakxaLrsLuRMPNzAS85AeIWAdKR4v9wACxjTI+0wVMVgs0uKJpSmks0l4oEG
         pcbA==
X-Gm-Message-State: AOAM533Ls9EdRSSa9VD9GilQLCIsANBO+nhqV960ZrDzR5ecl0OYIkw0
        HOxvberW1kYr7YgaUerKIJNrzaa3XPp16iqpDcW2Yw==
X-Google-Smtp-Source: ABdhPJy03MZ6PsLXxCBphy/9l6XP4QH8/9qvAfZ204QqRfRejxpeFjCFsK/aSNT6EEPDl+bwgfy3kxdmW9PyHfEy9uI=
X-Received: by 2002:ac2:43b1:: with SMTP id t17mr22629712lfl.373.1632236672432;
 Tue, 21 Sep 2021 08:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210914171551.3223715-1-pgonda@google.com> <YUDcvRB3/QOXSi8H@google.com>
 <CAMkAt6opZoFfW_DiyJUREBAtd8503C6j+ZbjS9YL3z+bhqHR8Q@mail.gmail.com>
 <YUDsy4W0/FeIEJDr@google.com> <CAMkAt6r9W=bTzLkojjAuc5VpwJnSzg7+JUp=rnK-jO88hSKmxw@mail.gmail.com>
 <YUDuv1aTauPz9aqo@google.com> <8d58d4cb-bc0b-30a9-6218-323c9ffd1037@redhat.com>
 <CAMkAt6oPijfkPjT4ARpVmXfdczChf2k3ACBwK0YZeuGOxMAE8Q@mail.gmail.com>
 <9feed4e4-937e-2f11-bb56-0da5959c7dbd@redhat.com> <CAKiEG5oirC30Ga=mrzKq24mkwSYvbzMw9AVfL6epVG4O0EZE7A@mail.gmail.com>
 <CAKiEG5qJZ0kk-dZLLp853K634+hTFUEGDtzpQiGxqgoYqP+QAw@mail.gmail.com>
In-Reply-To: <CAKiEG5qJZ0kk-dZLLp853K634+hTFUEGDtzpQiGxqgoYqP+QAw@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 21 Sep 2021 09:04:20 -0600
Message-ID: <CAMkAt6oFWtt8OTkLRHmQE7gxmGcQhBw=zhzLB7j-qziLSU8eAw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: Disable KVM_CAP_VM_COPY_ENC_CONTEXT_FROM for SEV-ES
To:     Nathan Tempelman <natet@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        kvm list <kvm@vger.kernel.org>, Marc Orr <marcorr@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 1:00 PM Nathan Tempelman <natet@google.com> wrote:
>
> On Thu, Sep 16, 2021 at 11:08 AM Nathan Tempelman <natet@google.com> wrote:
> >
> > On Wed, Sep 15, 2021 at 3:33 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > On 15/09/21 18:10, Peter Gonda wrote:
> > > > svm_vm_copy_asid_from() {
> > > >
> > > >     asid = to_kvm_svm(source_kvm)->sev_info.asid;
> > > > + handle = to_kvm_svm(source_kvm)->sev_info.handle;
> > > > + fd = to_kvm_svm(source_kvm)->sev_info.fd;
> > > > + es_active = to_kvm_svm(source_kvm)->sev_info.es_active;
> > > >
> > > > ...
> > > >
> > > >      /* Set enc_context_owner and copy its encryption context over */
> > > >      mirror_sev = &to_kvm_svm(kvm)->sev_info;
> > > >      mirror_sev->enc_context_owner = source_kvm;
> > > >      mirror_sev->asid = asid;
> > > >      mirror_sev->active = true;
> > > > +  mirror_sev->handle = handle;
> > > > +  mirror_sev->fd = fd;
> > > > + mirror_sev->es_active = es_active;
> > > >
> > > > Paolo would you prefer a patch to enable ES mirroring or continue with
> > > > this patch to disable it for now?
> > >
> > > If it's possible to enable it, it would be better.  The above would be a
> > > reasonable patch for 5.15-rc.
> > >
> > > Paolo

Sounds good, sent a 2 patch series this morning.

> > >
> >
> > +1. We don't have any immediate plans for sev-es, but it would be nice
> > to have while we're here. But if you want to make the trivial fix I
> > can come along and do it later.
>
> +Steve Rutherford
