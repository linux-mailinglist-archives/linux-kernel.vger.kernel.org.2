Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA5B45D32B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 03:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbhKYCdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 21:33:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231755AbhKYCbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 21:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637807289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u113tr+XHgf/tPsn5GKDgoAmZjL+yOW8H+2x+NeaHKE=;
        b=IgJzVhOTDBQOgQuWrnIsmpAwpIeh7ETXO4Oc2vitNjbk+Ix3Aw0hAff5DAT9CV/5MLPmBO
        9BO3nNiUSzo8T/pgv6+AaX3pE8fwvCLLmve4u80hMkw/tBsfYxf1FDfXFgshmuER7/gVzO
        giA433S1wXhmSxSHScnPlJ8E6OnCzdg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-5XqRbMahPCeTD12hK3B-Qg-1; Wed, 24 Nov 2021 21:28:07 -0500
X-MC-Unique: 5XqRbMahPCeTD12hK3B-Qg-1
Received: by mail-lf1-f71.google.com with SMTP id q26-20020ac2515a000000b0040adfeb8132so2373334lfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 18:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u113tr+XHgf/tPsn5GKDgoAmZjL+yOW8H+2x+NeaHKE=;
        b=u6xP+lFCzfCDra4dMDdlVqyplv1AxDpH7xTvc8Y+NBFDjo7CziPeB6LSpNxykUfLzM
         H6wf17ly9gXD7MvdCWyeKG+OZTnIOGA3EBr/MNQU4NaV8QF6S11ljX//zh5U10wPFoQH
         OT/0+cxKHtpK8AccrNLV6TffJVSX2PUr9/hkKUpfNtDm5uwPlbyeXhvzHmwBLo7CRRBe
         fPJYafKVMHpD2kHCBOo5jjOEZU9k6CHURqi6f6H9rbt3KDMTHwYCScz6FPO/o2bC7t85
         cRWhXf/nO1K0TwE2HkLW5D68+XK+JW+oShDjsdaR9Y/0csjc3G4lrsgZUmX4ie6cY/Ok
         9qqQ==
X-Gm-Message-State: AOAM533rBRkPBaMpBvWN1v2f6/PMIpq1rQI+L2c49P9GYSVi/bWrNvoT
        X7f5TeJAtdRhj39juZseRiipgNv4QKPj9O3EPu999d7TvzBVXeTllIk6O1Zs8sgR5GIa3/sfPZH
        ZAzd/0rgtbjA7X5LSJdJZ//k753ItA0uzhCB+d9yK
X-Received: by 2002:a05:6512:3b2b:: with SMTP id f43mr20862622lfv.629.1637807285909;
        Wed, 24 Nov 2021 18:28:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzK6BuAse/hOVXKz3JLz0KL4b+eODJeYiAN6J8Ec/Tf+RixyxmjYUlG288A643B1Puvy2YR2z6eJwsu+kIw4bA=
X-Received: by 2002:a05:6512:3b2b:: with SMTP id f43mr20862602lfv.629.1637807285742;
 Wed, 24 Nov 2021 18:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20211027022107.14357-1-jasowang@redhat.com> <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com> <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com> <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com> <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
 <20211123055906-mutt-send-email-mst@kernel.org> <87zgpupcga.fsf@mpe.ellerman.id.au>
 <CACGkMEteDZJVM8j5pir7_Hcn6Oq=tKbcg4DUiEQBGm5Kg9w30w@mail.gmail.com>
 <CACGkMEs086P=qfMieMQ3wPhcarsdO++iRTwVHtN-4cgKLm8opA@mail.gmail.com> <20211124123328.5ed9ce78.pasic@linux.ibm.com>
In-Reply-To: <20211124123328.5ed9ce78.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 25 Nov 2021 10:27:54 +0800
Message-ID: <CACGkMEu1ZsUFt4_-R74+6JtqCr+swBzYVnQU3E+XympEcTv_CA@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>, mcgrof@kernel.org,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 7:33 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Wed, 24 Nov 2021 10:33:28 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > > > > Let's see how far we can get. But yes, maybe we were too aggressive in
> > > > > breaking things by default, a warning might be a better choice for a
> > > > > couple of cycles.
> > >
> > > Ok, considering we saw the issues with balloons I think I can post a
> > > patch to use warn instead. I wonder if we need to taint the kernel in
> > > this case.
> >
> > Rethink this, consider we still have some time, I tend to convert the
> > drivers to validate the length by themselves. Does this make sense?
>
> I do find value in doing the validation in a single place for every
> driver. This is really a common concern. But I think, not breaking
> what used to work before is a good idea. So I would opt for producing
> a warning, but otherwise preserving old behavior unless there is an
> explicit opt-in for something more strict.

Yes, I totally agree with you after more thought and discussion.

>
> BTW AFAIU if we detect a problem here, there are basically two
> cases:
> (1) Either the device is over-reporting what it has written, or
> (2) we have a memory corruption in the guest because the device has
> written beyond the end of the provided buffer. This can be because
>   (2.1) the driver provided a smaller buffer than mandated by the spec,
>   or
>   (2.2) the device is broken.
>
> Case (1) is relatively harmless, and I believe a warning for it is more
> than appropriate. Whoever sees the warning should push for a fixed device
> if possible.

Yes.

>
> Case (2) is nasty. What would be the sanest course of action if we were
> reasonably sure we have have case (2.2)?

I think that's why a per driver validation is more preferable. The
driver can choose the comfortable action, e.g for networking it may
just drop the packets.

>
> Maybe we can detect case (2) with a canary. I.e. artificially extend
> the buffer with an extra descriptor that has a poisoned buffer, and
> check if the value of that poisoned buffer is different than poison. I'm
> not sure it is worth the effort though in production.

This might work but it might cause performance overhead. I still think
doing the validation per driver is better, the driver can choose to
fix the used length and taint the kernel anyway.

Thanks

>
> Regards,
> Halil
>

