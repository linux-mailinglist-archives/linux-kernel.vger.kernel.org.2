Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD543BF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhJ0CVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237456AbhJ0CVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635301122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UBzGUnOUEFcF6KLWEluzYL4mLQjg1E6PUhcyyR60VNU=;
        b=LgbfryfvZOqSCkQMBo51PXs6RWcvXcb8i1+EAFiH2iZW3Kz/UqVuo89cGL8I/EfF5WZZm1
        C3K2bJigySx5TX7uRFyDNojXtff7lnuecB4eSaIWUnqHnEOrC1wvu8cO/xg96FFy6b2TsI
        NhKOTrP6VXyHy9woK6Ymqvuy0Gifyl8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Y6bxgZrSPfqtKAnsCel3SQ-1; Tue, 26 Oct 2021 22:18:40 -0400
X-MC-Unique: Y6bxgZrSPfqtKAnsCel3SQ-1
Received: by mail-lf1-f72.google.com with SMTP id i1-20020a056512318100b003ffd4e89eb9so15829lfe.19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBzGUnOUEFcF6KLWEluzYL4mLQjg1E6PUhcyyR60VNU=;
        b=nhMuz9cpg4nS3Ocwkvq1+X7ABcu/IXF6btYrv2kQjXpM1t+axlm05ak8aGxEhrRRzL
         Add4nftmhY34tal581XAhtQTK+EUoqZHP2jZhilU/kesFKGSMNSLR8GxS1CgtP8BA9Kb
         IXpUglOQa6iSNwswmyQvcuZ9+LtCeVezzXJYA5YK3v2l5dO4oCem6d9ATKT3WI/XaD56
         vCT8fN5PxN074k3Q9WnySiR89c16aAsh2euWNultwHC6Fvi1c6dr8gVrH+5K6mbPTE/6
         f1lBzb5AuMCjJkjv24mnCjoGYJb7Gu6NgXKrXDfTJ1Bmp6NHhdMu2DlCCHHE/eOKySlu
         34sg==
X-Gm-Message-State: AOAM533tnaCsrNpt7CYtwOTJcL9rloaWQ6uaERCWApubL+YPf0vdki9G
        TpoflZIhoWa3FbXDEEiHDN0T8Jwek17kNtfZfaiNH8Od7ZTZMeU/5o5Z1ZHq9C1Eo3teCr67Rt8
        38pH57cmmgX8R4ZyLMPzmtE50FB70YS1mApbqTJql
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr29943454ljg.448.1635301118962;
        Tue, 26 Oct 2021 19:18:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+WkJqJ7pHPSdrcPy5Ze4mNvUI2dJhewRaerkMzgGNgWAOUKSx17NXREubDi/lXrB/ymdEoifp1TYQO2vnjlk=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr29943446ljg.448.1635301118723;
 Tue, 26 Oct 2021 19:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210806142914.70556-1-pkalever@redhat.com> <20210806142914.70556-2-pkalever@redhat.com>
 <YUL+1PE1z5aM0eTM@T590>
In-Reply-To: <YUL+1PE1z5aM0eTM@T590>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Wed, 27 Oct 2021 07:48:27 +0530
Message-ID: <CANwsLLEgHhrh7uh+awJp-qs8xxxpwQBc6fMkEys3VMU4anvWZg@mail.gmail.com>
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

On Thu, Sep 16, 2021 at 1:52 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Aug 06, 2021 at 07:59:13PM +0530, pkalever@redhat.com wrote:
> > From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> >
> > defined BLK_DEFAULT_CMD_TIMEOUT and reuse it everywhere else.
> >
> > Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> > ---
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks for the review Ming.

Attempting to bring this to the top again for more reviews/acks.


BRs,
--
Prasanna

>
> --
> Ming
>

