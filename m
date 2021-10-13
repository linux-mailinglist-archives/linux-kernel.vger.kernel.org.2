Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E35642C33C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhJMOdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234081AbhJMOct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634135446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AO/zChsVkIYLZ96daeF/ZiQLlqScJHcanz8k6BY2Rvc=;
        b=ifze4MqUD9Nuy3FO3GYGglKM0U7BAn75k60aK5SoG8XGqa2SVwc7U2CaXq0XOVW5aZaT3E
        Hm15yahlLwW4q9pSmI2A5kl6w9slJHPoPTebutevfVfSBjxBee52PKUfwv3mqLY3mpBbLN
        M3/LqYmedfGRS13Y7m4TjZCJnPj84uc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-176uYVdCNKicCZDT4V10_w-1; Wed, 13 Oct 2021 10:30:45 -0400
X-MC-Unique: 176uYVdCNKicCZDT4V10_w-1
Received: by mail-wr1-f72.google.com with SMTP id y12-20020a056000168c00b00160da4de2c7so2147284wrd.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AO/zChsVkIYLZ96daeF/ZiQLlqScJHcanz8k6BY2Rvc=;
        b=GY9tRyGLZJzXcxUPrw92qYWMvQphANNkoEnPRFsSm2joVHFFlzTlttoZfXWkjH/+0W
         wZHIQ4G4PGplXySV00+ySwz/YBh75X8STNgV6GFTTDhH7ngp8EEJxBIxL7ETjJj0f/CI
         qk8yRm8ZAnsIHIehwToppXkfDXdb3pijBHCDill0SN89Br8F/2hqJZ1tbNV6o1w8U4sy
         bFH7nLnDv95Ar/lRE5wAfpldgYUwfnUkAHaeK/hIe5aa0fqhsBFBPD0GFs6qhra5WN7d
         nJplMK1Ks61UZ3EOIY4PQPDkBZTBdccLH6hsN3uYeNTfRMhYrTeod2aXXThIwU/1gfB4
         rDcA==
X-Gm-Message-State: AOAM533XlfdlbfpjpL19KODC1djN87t0acA8WiJ4f61WTLaGUbbQe7oa
        uJb1GRLqzOeXIOD8IuGTEKTiu9qNmZ1h6M3HJO4RIXo11ySwveQ/ZipdbQaSTDZCbMZdLJqYvdf
        Lq7G7adVYI3gVxJI1ApFUAIZf0xNnKy3pHBqmTkmi
X-Received: by 2002:a1c:191:: with SMTP id 139mr13353247wmb.186.1634135443847;
        Wed, 13 Oct 2021 07:30:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqH/rCG9AXDVUiqC1etKy/JfEXaqVkIX9zKnVTbSSiI66uhKSHLO7m4Z2QSTOV7VhlCJ56O4JUFybYJ00jvzA=
X-Received: by 2002:a1c:191:: with SMTP id 139mr13353226wmb.186.1634135443644;
 Wed, 13 Oct 2021 07:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210920190518.23056-1-tim.gardner@canonical.com>
In-Reply-To: <20210920190518.23056-1-tim.gardner@canonical.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 13 Oct 2021 16:30:32 +0200
Message-ID: <CAHc6FU6Zn7L1p0yeQHepk5+T_YQz3dpPa26dxXiAtr=nOoXeFA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix unused value warning in do_gfs2_set_flags()
To:     Tim Gardner <tim.gardner@canonical.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Mon, Sep 20, 2021 at 9:12 PM Tim Gardner <tim.gardner@canonical.com> wrote:
> Coverity complains of an unused value:
>
> CID 119623 (#1 of 1): Unused value (UNUSED_VALUE)
> assigned_value: Assigning value -1 to error here, but that stored value is
> overwritten before it can be used.
> 237        error = -EPERM;
>
> Fix it by removing the assignment.

pushed to for-next.

Thanks,
Andreas

