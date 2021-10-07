Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921E3424C25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 05:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbhJGDSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 23:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbhJGDSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 23:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633576606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OI26e346o7wA+cB8PKVQ/OS+qo43Vn/vft+r1uTg9ik=;
        b=ie0PCLetBfiwhR3j5xF+/tVh3fGy7zmAZfeqz5X/io5UPKeObnjTJ2vW/vr7NxCXGgLgL4
        j+qIQU5VutuMznK9b1wepxdWiEbNLwK/HZuZpJaQU8dTW93+RicdXlbFC1Eh9A0S6UrMD6
        tRlVbGJE7DcRc+qYZKSTsSkrgRmF3IQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-ATp1eocJNYWoQdcmPR40-w-1; Wed, 06 Oct 2021 23:16:45 -0400
X-MC-Unique: ATp1eocJNYWoQdcmPR40-w-1
Received: by mail-qv1-f71.google.com with SMTP id e6-20020a0cb446000000b0037eeb9851dfso4496279qvf.17
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 20:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OI26e346o7wA+cB8PKVQ/OS+qo43Vn/vft+r1uTg9ik=;
        b=ArpBaQU2L9J3p4oeVfcy+gSeYK1Qe7bBfOtT0XPSsbldgk0UFgW4NR+URDOMYWqD6M
         yraqlbWnQ7WmFBaq7vjUstSgKb357XAUQH2P4/aJLbTX5bAqKVLZnkZsrLYHrAXJP6vh
         Eq0nkfhRsJcCMN2mEqDulRmZdl+128C5zUjbDkWVHc6jVzAJyWF1Pv22l3nz9rbIiWOH
         nci9KmZJIHnKwafD1Jha6ubWUH2dsWLFLNTccKPpotX/2DLYOzbg1qcjcJqWK7WAgnYO
         dWoui+dIUyF2QGvPAbphr/JvA0CCyIHXojt306BuDcpui6Rma5vTcCXEjhHOCtqZ4Thb
         pZ8Q==
X-Gm-Message-State: AOAM532tnmyle7zEzMWPzH+2dtT5/p/cAe1S2IK0kCpFNqAwsalbK68M
        1QSBpXuWKLOU+WBlG05xhybC8KTtuU+DDSwh6+vvK5QemM2ISFLo5w9GwJpweV1IfrsK2r07P6y
        rGhT1uoIBMFTv7W6hPm4qmdyL
X-Received: by 2002:a37:a13:: with SMTP id 19mr1434458qkk.497.1633576605113;
        Wed, 06 Oct 2021 20:16:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw633O+CNquyw98iWbLmMKLtdUwTQpcrGkcehVm3s7c93gwRcIUYcuMFlkWP6kvKPI5OWyJ8Q==
X-Received: by 2002:a37:a13:: with SMTP id 19mr1434446qkk.497.1633576604827;
        Wed, 06 Oct 2021 20:16:44 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id x9sm3101983qtw.84.2021.10.06.20.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:16:44 -0700 (PDT)
Date:   Wed, 6 Oct 2021 20:16:41 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] objtool: Check for gelf_update_rel[a] failures
Message-ID: <20211007031641.7byi3w6qjj7dooa4@treble>
References: <20210509000103.11008-1-mforney@mforney.org>
 <CAGw6cBv2NBCDrZb7ZnmAhZOJ_EwgW6tR-8AfY2v=T9OkD=6O8g@mail.gmail.com>
 <YNmHRi+00RAAUmEt@hirez.programming.kicks-ass.net>
 <20210629171224.jhlqyyb3lus323o3@treble>
 <CAGw6cBs8qf-GWYS-LtrCm+ye-=K_vu1WxDPOROnya_PVod=TGg@mail.gmail.com>
 <CAGw6cBtjGUzM+gDxGBgVuP1kwB=1qD7FOa7AMAUN3dp+yGZRhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGw6cBtjGUzM+gDxGBgVuP1kwB=1qD7FOa7AMAUN3dp+yGZRhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 09:58:13AM -0700, Michael Forney wrote:
> On 2021-08-28, Michael Forney <mforney@mforney.org> wrote:
> > On 2021-06-29, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >> Looks ok to me.  Let me run them through some testing.
> >
> > Just wanted to check: did the testing go well? I'd really like to see
> > these patches in 5.15 if possible.
> 
> Ping again. Anything I can do to help this make 5.16?

Hi Michael,

Sorry this got dropped.  I'll try to get it in.

-- 
Josh

