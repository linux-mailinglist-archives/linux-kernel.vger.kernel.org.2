Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF640B012
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhINOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233309AbhINOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631627972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaya3EDVq+i2kEee2RcyRm9vp7G1d6PEMiE8V6O0cGg=;
        b=OoZkV1uoe7bBEP32yxu+BlkeeR9otGOqfoAKEkf/x0V8c3zncIOvd6xIdsaOKNXXHuhHkH
        Az2UOrSHlGjpsRjB78cooBtlL7K0MMuVbMhzwycrS5V3VbpbSG0XOsp16NCxG6xwn95B+l
        kR6wmbDU8wF2mVljXRBuh+FpQEzovQs=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-1wcb5AK_PHq5D8N8YbqxQA-1; Tue, 14 Sep 2021 09:59:31 -0400
X-MC-Unique: 1wcb5AK_PHq5D8N8YbqxQA-1
Received: by mail-il1-f198.google.com with SMTP id f16-20020a92cb50000000b002376905517dso3132260ilq.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 06:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaya3EDVq+i2kEee2RcyRm9vp7G1d6PEMiE8V6O0cGg=;
        b=shUW8524CUJPY+SHz69gKEX/ciqydXfekMLfJQDgmgPFfViE90GK2FcYLiSWYNZZEQ
         ehbg/87aEOWDBKXnUJzSVbev5IdAvJOOOQ4VvjkHw4Roaf7xsncUPBsMUrdEgGpXhXz2
         v1gqDIh38UwH31Yx48SyUkCvdbINwEoW2egIxbYsleWY7qDj+pq71gs0MVxOQYyvIAn8
         Pp1X7pe50W8Ki/Ugkz4fd1gxbHaquslAqGgEmFogUv9KFqzQ3nb6od7l6UIcJbFdFmaV
         orS01vC2oYMGNutfhWPjVonH/phundcxH4Abt66iikYpVPl3yTyMdRaYH+wyVm+skh/F
         4GFw==
X-Gm-Message-State: AOAM531MP61jU+Sn+h2/f9FNQGdY8Qwc9YrNccZS7GRUWWuDDe3xbnTo
        +64a2pK5OwsNgwwne+bvVxHBRMpCVQlY/q9uZRuKDzokz7In9aTByapwG6zE3pFt3r+TzRf4105
        oXEwL0V+RHlcp8Gpuc72FJmKwIP3AGJ3Dqq/ym/OV
X-Received: by 2002:a05:6638:1606:: with SMTP id x6mr14896507jas.25.1631627970921;
        Tue, 14 Sep 2021 06:59:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyykZ0VYVJ0bOaRFeN+fD5tTcAMHGgErQub0XJv3DCUagog8L0n472IWYdPHqWMZTwm1ZepJvhHcI2h2Lqcvw4=
X-Received: by 2002:a05:6638:1606:: with SMTP id x6mr14896484jas.25.1631627970753;
 Tue, 14 Sep 2021 06:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com> <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com> <YTYr4MgWnOgf/SWY@work-vm>
 <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com> <YUCa6pWpr5cjCNrU@redhat.com>
In-Reply-To: <YUCa6pWpr5cjCNrU@redhat.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Tue, 14 Sep 2021 09:59:19 -0400
Message-ID: <CAPL3RVHB=E_s1AW1sQMEgrLYJ8ADCdr=qaKsDrpYjVzW-Apq8w@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:52 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> Same is the requirement for regular containers and that's why
> podman (and possibly other container managers), make top level
> storage directory only readable and searchable by root, so that
> unpriveleged entities on host can not access container root filesystem
> data.

Note--if that directory is on NFS, making it readable and searchable
by root is very weak protection, since it's often possible for an
attacker to guess filehandles and access objects without the need for
directory lookups.

--b.

