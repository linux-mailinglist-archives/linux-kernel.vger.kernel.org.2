Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6868845334E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhKPN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:57:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236906AbhKPN5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637070865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0l8U98gykrEb+6mbIddDuP0F41+6lCqLlmJs6JdFso=;
        b=Pp8LDO4NClydwzyHNH6XaE92wVnVHs+wJ//i3B5ApZnKMpX8i4gAVHSTshUlBRQn/wDINA
        KdpB4pKUsXdcY9wkc9I6j5+4BDg+SJlDP9kAePa54nXB9KDl6rVfrVtk93SiOoB3/o7B8u
        mR33QfX+AIfEQZpUyhUZ0z0bw3A+Fjo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-JwUGbuitPK283VZtfEsr_A-1; Tue, 16 Nov 2021 08:54:23 -0500
X-MC-Unique: JwUGbuitPK283VZtfEsr_A-1
Received: by mail-wm1-f71.google.com with SMTP id n41-20020a05600c502900b003335ab97f41so1514222wmr.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0l8U98gykrEb+6mbIddDuP0F41+6lCqLlmJs6JdFso=;
        b=7v+Rh4pfF4/C9VWainWmh8QmVvApx98j13+swibkJVw+/9wckoC30oVEe/s9FvPUdl
         WEzypPQUAKtXDrO/1lsj0MflBljR2TbdI7yX8mpvuGrJiXjV2yKgab32UkpaH6I6iLSj
         UBVj/Vb5jrp/Qo9BA/AB6oZ5GROuDPHzqsQlyfUnsQlhyeyO8rZn1XUvi4MbXO4fQuQY
         C868uBnpp2IImqog3B6T62a7dCly3tMeLQQwLONXzvfBica0o672rKd15PNfkYcgGaTK
         tDTrE1NDKCmhgBq3egAuh4x+RMA0q4C/q38622sTnsP5rmSYEsbrHwkbyIRmFmrnnUly
         wXnQ==
X-Gm-Message-State: AOAM530lmixjlsvrZwKEwEVbrCcLYnimPobNYEjc6p1bgmfi6mW8X2QX
        F117ZWUfmV9bM4WfRJKFs7hrXvOrqMmNZ4cReav484Csv5GEMI4QhWzbI3mkn9EGz1Pq1aQUKUw
        7ORcF+VdpkyY8TZCdDSvmDsvpkdryHkAxIhLy5bRN
X-Received: by 2002:a05:600c:1ca0:: with SMTP id k32mr8157165wms.74.1637070861988;
        Tue, 16 Nov 2021 05:54:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkE0ZUdhTupcolHEn3mZwOjI5RxolJG8TsOzucbh8Kv+FGnxDoIbqJ9yNpgl/Dl6oTuf5XlMzsyqFNl9LN+Zk=
X-Received: by 2002:a05:600c:1ca0:: with SMTP id k32mr8157134wms.74.1637070861810;
 Tue, 16 Nov 2021 05:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20211115165313.549179499@linuxfoundation.org> <20211115165315.847107930@linuxfoundation.org>
 <CAHc6FU7a+gTDCZMCE6gOH1EDUW5SghPbQbsbeVtdg4tV1VdGxg@mail.gmail.com> <YZMBVdDZzjE6Pziq@sashalap>
In-Reply-To: <YZMBVdDZzjE6Pziq@sashalap>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 16 Nov 2021 14:54:10 +0100
Message-ID: <CAHc6FU4cgAXc2GxYw+N=RACPG0xc=urrrqw8Gc3X1Rpr4255pg@mail.gmail.com>
Subject: Re: [PATCH 5.4 063/355] powerpc/kvm: Fix kvm_use_magic_page
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 1:54 AM Sasha Levin <sashal@kernel.org> wrote:
> On Mon, Nov 15, 2021 at 06:47:41PM +0100, Andreas Gruenbacher wrote:
> >Greg,
> >
> >On Mon, Nov 15, 2021 at 6:10 PM Greg Kroah-Hartman
> ><gregkh@linuxfoundation.org> wrote:
> >> From: Andreas Gruenbacher <agruenba@redhat.com>
> >>
> >> commit 0c8eb2884a42d992c7726539328b7d3568f22143 upstream.
> >>
> >> When switching from __get_user to fault_in_pages_readable, commit
> >> 9f9eae5ce717 broke kvm_use_magic_page: like __get_user,
> >> fault_in_pages_readable returns 0 on success.
> >
> >I've not heard back from the maintainers about this patch so far, so
> >it would probably be safer to leave it out of stable for now.
>
> What do you mean exactly? It's upstream.

Mathieu Malaterre broke this test in 2018 (commit 9f9eae5ce717) but
that wasn't noticed until now (commit 0c8eb2884a42). This means that
this fix probably isn't critical, so I shouldn't be backported.

Thanks,
Andreas

