Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753AC3B2990
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFXHo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231589AbhFXHoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624520521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Yl8Nuvty4QYUf2fBRyceLQvl1ee5BlE4z8/YgvidaI=;
        b=Yfpx5IVAUjFIAy8BiBUkhmlZ0qnrQbM4JQ6OkoCO0qPlH1wrnW9IQHP2W3REGbEMYPywzJ
        BsV+jnOZyK7kmg43XG3cBbluBgYcQxufTcftIp8qaN4o38PJsFzA7X02st4eIRc7UYnZs4
        3cFfgnrq19zQZk9DxfZoaDX76Vl9qz0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-OkEsuWq9NsWa0NoC14zwsQ-1; Thu, 24 Jun 2021 03:42:00 -0400
X-MC-Unique: OkEsuWq9NsWa0NoC14zwsQ-1
Received: by mail-ed1-f72.google.com with SMTP id p23-20020aa7cc970000b02903948bc39fd5so2867807edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8Yl8Nuvty4QYUf2fBRyceLQvl1ee5BlE4z8/YgvidaI=;
        b=C0ZqeDC+YiIPdn01YLVTbRJeE9zIOKiLgl/CMFbM6ngIw7FfmN0dSrpcpKLKCqvjpQ
         xevs+T0/CgShC51JeBV90AY+s6TgVRJzHF5H9PmPHXIkgQdjjb+GR/aZGQ7P39/+OaWo
         aW9KgyXwm0gKufj0tn43WaFUdNgX7st1cJMgOoDgZMwWoPQ8FJeTKJ6rTgFb+mg7bMjY
         OPzanaA58oFHczFb0CNGZDD1Xpm6HUlbgJrT9ylcbxJoANMKTLZCGLjE7JVDdiYqVc5A
         Zvlzw9FlZ4uR8an6gJRT2Mjc1KDtaD4SvkJCvEq6h2AQCwzOx42wUy9cErjQIGlT5vHC
         LN9Q==
X-Gm-Message-State: AOAM531f6B17Vl1m/NZ4JfyTXvw3L8kCwCGBxWvAqGfmJhR+cxhsItWy
        y6mdygT6qHf93OO9D4qOsTmghW6MIjJyuHHVZGZwhLwrHZigMISiCsWTZPPUySYL8VpH6S0O4UF
        MHrqZbyWbi92ZrBHu3LtPgET5
X-Received: by 2002:a50:935a:: with SMTP id n26mr5463249eda.8.1624520519149;
        Thu, 24 Jun 2021 00:41:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytEipzHx0rgPSfpScBppsp8KZXBCqJU+3iRhbfOUJ5XWLX0iJONRxlf5yHljf8nfHnkXZgKg==
X-Received: by 2002:a50:935a:: with SMTP id n26mr5463229eda.8.1624520519007;
        Thu, 24 Jun 2021 00:41:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c23sm1364482eds.57.2021.06.24.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 00:41:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Cathy Avery <cavery@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH RFC] KVM: nSVM: Fix L1 state corruption upon return from
 SMM
In-Reply-To: <82327cd1-92ca-9f6b-3af0-8215e9d21eae@redhat.com>
References: <20210623074427.152266-1-vkuznets@redhat.com>
 <a3918bfa-7b4f-c31a-448a-aa22a44d4dfd@redhat.com>
 <53a9f893cb895f4b52e16c374cbe988607925cdf.camel@redhat.com>
 <ac98150acd77f4c09167bc1bb1c552db68925cf2.camel@redhat.com>
 <87pmwc4sh4.fsf@vitty.brq.redhat.com>
 <5fc502b70a89e18034716166abc65caec192c19b.camel@redhat.com>
 <YNNc9lKIzM6wlDNf@google.com> <YNNfnLsc+3qMsdlN@google.com>
 <82327cd1-92ca-9f6b-3af0-8215e9d21eae@redhat.com>
Date:   Thu, 24 Jun 2021 09:41:57 +0200
Message-ID: <87lf6z4sl6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/06/21 18:21, Sean Christopherson wrote:
>> On Wed, Jun 23, 2021, Sean Christopherson wrote:
>>> And I believe this hackery is necessary only because nested_svm_vmexit(=
) isn't
>>> following the architcture in the first place.  I.e. using vmcb01 to res=
tore
>>> host state is flat out wrong.
>>=20
>> Ah, that's not true, using vmcb01 is allowed by "may store some or all h=
ost state
>> in hidden on-chip memory".
>
> And also, "Different implementations may choose to save the hidden parts=
=20
> of the host=E2=80=99s segment registers as well as the selectors".
>
>>  From a performance perspective, I do like the SMI/RSM shenanigans.  I'm=
 not
>> totally opposed to the trickery since I think it will break a guest if a=
nd only
>> if the L1 guest is also violating the APM.  And we're not fudging the sp=
ec thaat
>> much :-)
>
> Yeah, that was my reasoning as well.  Any reference to "hidden on-chip=20
> memory", plus the forbidding modifications of the host save area, sort=20
> of implies that the processor can actually flush that hidden on-chip=20
> memory for whatever reason (such as on some sleep states?!?).

Ok, so it seems nobody feel strongly against the idea I've implemented
in the RFC. We could've avoided saving L1 host state upon L2 enter in
vmcb01 altogether, true, but we would still need some sort of a cache
emulating "hidden on-chip memory" for performance reasons. Resurrecting
'hsave'/ allocating 'special' vmcb01_smm/... and modifying nested state
seems to be unneeded, the L2->SMM case should be rare indeed.

I'll add a testcase to smm selftest and submit v1 then, thanks!

--=20
Vitaly

