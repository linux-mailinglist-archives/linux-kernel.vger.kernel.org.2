Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7F4504E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhKONGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:06:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231587AbhKONF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636981380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNHR/4EKA1J8JSmTNFejCsQ+Ytekp9kmZceJTflwDKc=;
        b=KtqHoZynzWSwaSje8rE8cOgJxTdVy24hHtcLSiocpFqyUp76lAcpwvRZCvetUqXo4HeN1j
        70OrYp1dZAXU2OdoaQBCS2SMOrnev2R30flN57sV+1JCVgk/wnr4IfqMlzsE+ifdBDafKf
        sewHp4P0WRG9GWu4TCwmDNQVNwzHS3I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Kx4Y2SjcMhm2rQ9clQsRvw-1; Mon, 15 Nov 2021 08:00:51 -0500
X-MC-Unique: Kx4Y2SjcMhm2rQ9clQsRvw-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso9619950wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fNHR/4EKA1J8JSmTNFejCsQ+Ytekp9kmZceJTflwDKc=;
        b=5DdlMvlfeRr0+Xx6bsD5/5oneyoAqpwucY9JR0c0LHCJzCvppT02J7ewUquHXOpNtF
         7xvEWW4Y+84nPl1hzMLMCvVptiukplTn/xFncm/PR6JQlAAVc9G3hnqhuYpQR08uKGxc
         bfk5oFjBIpa6pKp7sm8dfYM9U2oCFL8uOGxIXcNHBPCXlPNMJgRcVaz46LAtDs9G75tH
         dr/f4jZoKOwJQDQ8hWTpdXKrazIC+q6g85iW1aebTYxnsIPoY0tNSUy/wngEui5/TavC
         SYesGmC9RO0CHHz3+2Vc6hjr1I9m7B5bDFn+uswKGSOseuz/O11PM7FbnXW877aR8RFv
         6/Pw==
X-Gm-Message-State: AOAM533YaXWoG563vmsqhHfzXM20MlpV2bnMZKxTVsM+2IXC4wCw3XiH
        uPcpX5nXMNFCR9A3F7VEp4/FSS9RsV00b99JKdpP5w2YU5WyremE+h25Z/S7fcRClc+UNl385Ck
        yBRlFAYVy9GvzJmvCWQNWKAebTnBubOPfj4Rht+8lMNBUJlnLPkCtpibs7vyiIsohDfNI6ba0wU
        Jj
X-Received: by 2002:a5d:6902:: with SMTP id t2mr48286159wru.317.1636981250429;
        Mon, 15 Nov 2021 05:00:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyksSkAyNqlPH0unAflPwLe/0xyM9aEOqPn8ztJiP3iIOBdvhurRV64rjvGcWEiuYSq5VU+dQ==
X-Received: by 2002:a5d:6902:: with SMTP id t2mr48286129wru.317.1636981250253;
        Mon, 15 Nov 2021 05:00:50 -0800 (PST)
Received: from fedora (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o25sm15107809wms.17.2021.11.15.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 05:00:49 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     =?utf-8?B?6buE5LmQ?= <huangle1@jd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] KVM: x86: Fix uninitialized eoi_exit_bitmap usage
 in vcpu_load_eoi_exitmap()
In-Reply-To: <567b276444f841519e42c91f43f5acd7@jd.com>
References: <567b276444f841519e42c91f43f5acd7@jd.com>
Date:   Mon, 15 Nov 2021 14:00:48 +0100
Message-ID: <877dd9efpb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E9=BB=84=E4=B9=90 <huangle1@jd.com> writes:

>> =E9=BB=84=E4=B9=90 <huangle1@jd.com> writes:
>>=20
>> > In vcpu_load_eoi_exitmap(), currently the eoi_exit_bitmap[4] array is
>> > initialized only when Hyper-V context is available, in other path it is
>> > just passed to kvm_x86_ops.load_eoi_exitmap() directly from on the sta=
ck,
>> > which would cause unexpected interrupt delivery/handling issues, e.g. =
an
>> > *old* linux kernel that relies on PIT to do clock calibration on KVM m=
ight
>> > randomly fail to boot.
>> >
>> > Fix it by passing ioapic_handled_vectors to load_eoi_exitmap() when Hy=
per-V
>> > context is not available.
>> >
>> > Signed-off-by: Huang Le <huangle1@jd.com>
>>=20
>> Fixes: f2bc14b69c38 ("KVM: x86: hyper-v: Prepare to meet unallocated Hyp=
er-V context")
>> Cc: stable@vger.kernel.org
>
> Commit f2bc14b69c38 is not in stable tree I guess, it was merged in from =
5.12,
> do we still need Cc this patch to stable maintainers?
>

There are multiple stable trees, one for each major release. Not all of
them are still supported but you don't need to care about it, 'Cc:
stable@vger.kernel.org' is just an indication for everyone who has
f2bc14b69c38 in his tree (5.12+) that there's a fix available.

--=20
Vitaly

