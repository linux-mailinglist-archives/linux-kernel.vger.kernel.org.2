Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F9D43BF86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbhJ0CWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230243AbhJ0CWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635301215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mqXh93ZFW8hFzfkQUD4WZhM1OFNU+n4S2OHIXxEnQVk=;
        b=S30pQc7PzUFvk6UC9Pif/gPk9CJZwobqUhAusNLW2b8An4VDv+8svZ6hRDClZjKGuR6bjk
        c/utWo6BOnN7OCpiX8ueOEpnX/P96wGpjVhqnxIMBNYBqIpjqNL8PfxlURKHWnI9fCM+vc
        64WNPqsfa5AJB3R7zzgOJJ7u+mXJ0h8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-nQsuecufNi6twmHeodhKrw-1; Tue, 26 Oct 2021 22:20:14 -0400
X-MC-Unique: nQsuecufNi6twmHeodhKrw-1
Received: by mail-lf1-f69.google.com with SMTP id k15-20020a0565123d8f00b003ffb31e2ea9so627176lfv.17
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqXh93ZFW8hFzfkQUD4WZhM1OFNU+n4S2OHIXxEnQVk=;
        b=iCpKLxc/R8uNsAR1P4rgBpu/fKh87Ot8RzliMv+LxXEciuRLEE7HNtI5Tis+udwwmx
         M7J9pquOJ6NnXB5/PeJYyYoGBErVkjXTedtBDRcrECSlWolWO4C6A1Ehi+Ha/awaqjK7
         J135Ef0bmmxS1FuZmZcF3TaKXV0a4rN7To8cpuvKK6xV6MezCESEsO4iOopcCyzA0N0B
         MhTOMzNGQV4Y5wt3MNMU7Lqz5/T80SoarEIiAPrmjywbWNulFjMRUp1K4gIQE03rkCiu
         x7T1Q2cmQ7jeHLfzGGjyPJewWZXlDT70k0tm75uf44WWvgF/+FjdijLHHbdQQNvr53Yt
         CPbQ==
X-Gm-Message-State: AOAM530wkCTEQdJOEUFOrG8w3pXBnqU4XOhSjDUwg0OlN6HSK2SPBzyu
        JCBuiVtdDWioz6+CMFBLsWdaAVP38sZOrHxzTbwCaa/a0YLZNLH8YP4Pl5E8FG+nWMJbEWoT2t5
        1Du5PK9+5uuwPOQKTTJYL72c3pCrbmhKNu8deg+RI
X-Received: by 2002:ac2:5e7b:: with SMTP id a27mr18585235lfr.103.1635301212943;
        Tue, 26 Oct 2021 19:20:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjJ9eMzhF9j7b0a5ruulTUMfrDQJSlIkrZ30hzGkZMx2g6pfvQe49LM5HOZ0EI4jaW4nP6IDlutoGaAHGMav4=
X-Received: by 2002:ac2:5e7b:: with SMTP id a27mr18585208lfr.103.1635301212668;
 Tue, 26 Oct 2021 19:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210806142914.70556-1-pkalever@redhat.com> <20210806142914.70556-2-pkalever@redhat.com>
 <YUL+1PE1z5aM0eTM@T590> <CANwsLLEgHhrh7uh+awJp-qs8xxxpwQBc6fMkEys3VMU4anvWZg@mail.gmail.com>
In-Reply-To: <CANwsLLEgHhrh7uh+awJp-qs8xxxpwQBc6fMkEys3VMU4anvWZg@mail.gmail.com>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Wed, 27 Oct 2021 07:50:01 +0530
Message-ID: <CANwsLLH03KazGmog6pj6zjTTmAwr8nz1i=ZxLoyWFOUaop8xjA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] block: cleanup: define default command timeout and
 use it
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     Ilya Dryomov <idryomov@redhat.com>, Xiubo Li <xiubli@redhat.com>,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 7:48 AM Prasanna Kalever <pkalever@redhat.com> wrote:
>
> On Thu, Sep 16, 2021 at 1:52 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Aug 06, 2021 at 07:59:13PM +0530, pkalever@redhat.com wrote:
> > > From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> > >
> > > defined BLK_DEFAULT_CMD_TIMEOUT and reuse it everywhere else.
> > >
> > > Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> > > ---
> >
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
> Thanks for the review Ming.
>
> Attempting to bring this to the top again for more reviews/acks.

oops! please ignore, this is the wrong thread.

>
>
> BRs,
> --
> Prasanna
>
> >
> > --
> > Ming
> >

