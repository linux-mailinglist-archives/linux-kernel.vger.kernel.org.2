Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AFA40B265
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhINPCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232079AbhINPCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631631673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f4doVZdRhwwzGkMFAoRi2PUNaC9z4kzqnDQ6De1+mEk=;
        b=T1GYAYZBhwPfQ5/nR+ml/hTWlNetCXc3uBGr2ISr2FtplmX31s2TR3iYiWQMuLyf9degnK
        2t74KNadb/P2toTx3P2YwAeFsZOeuMoIDO3UDezSbyhNKBN11H2XO7L+7drNBi9ZFjigLg
        uTeuUSMU/06zTmcGI7ZdUVDb0NbGprs=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-SiKwvEdNOnOWkXz8LHaILA-1; Tue, 14 Sep 2021 11:01:12 -0400
X-MC-Unique: SiKwvEdNOnOWkXz8LHaILA-1
Received: by mail-io1-f71.google.com with SMTP id i78-20020a6b3b51000000b005b8dd0f9e76so16451340ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4doVZdRhwwzGkMFAoRi2PUNaC9z4kzqnDQ6De1+mEk=;
        b=Ejex6ivmb6wn5g4ajjJL++ceAT0jZ/Ay3ykME8mUMiLs0GAPGPDzW+rOP4XXQZ0c22
         Ai22Rn2C9qOyuMq6vMaJfBKU3mIFQPIORNzVM9m+hVs232rj6AYYbZMqheaUVVGiLv7J
         vfVcL4N2QzCuFy//tIfMKtCT1b3IrfgMsMLMHwygrVoFg4XJq0qVaKr/469hDYeP1v1D
         7gd9PNRKbg7ZKsWYvcBE1VpGLsAACA5VVC2Bacq/eRVdZc/EOaWQwdZZAe0RS2IiVEPR
         VdccAGTVD3BoerZK0XcmWMhMkxG2Bat5+v6rO/3ZvM/qhEXPfcS+5iUvHmUd1UOkRA7i
         sR2g==
X-Gm-Message-State: AOAM533R3zuP7Bq1xv2U9d5WvIxTrUohMF4JICwAEv52ojrPa6HIcE6O
        he/57RXiKXlmZsXEFSTqWQc5lo74jjkhoxOMl0tyxmBxX19rO90OR+mN2+dNMMDjBqvpYRlTh+A
        kFXqEk6ewnaxnDa64+OQSXz9vkuYVv5I/vWGR9Rs0
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr12302580ili.29.1631631671753;
        Tue, 14 Sep 2021 08:01:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaAeiekMMKeZruAEeYbCxZpJjpmCzKAy5WCzmfRtD8PhxXBHVBLZZb+MFaozIMIyxqQwE9MVbD21EwvnT+xp8=
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr12302560ili.29.1631631671531;
 Tue, 14 Sep 2021 08:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com> <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com> <YTYr4MgWnOgf/SWY@work-vm>
 <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com> <YUCa6pWpr5cjCNrU@redhat.com>
 <CAPL3RVHB=E_s1AW1sQMEgrLYJ8ADCdr=qaKsDrpYjVzW-Apq8w@mail.gmail.com> <YUCybaYK/0RLvY9J@redhat.com>
In-Reply-To: <YUCybaYK/0RLvY9J@redhat.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Tue, 14 Sep 2021 11:01:00 -0400
Message-ID: <CAPL3RVGXWtakCS9bvE60gWp0tcsduJFKfoU4aoqANRgp7HvFow@mail.gmail.com>
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

On Tue, Sep 14, 2021 at 10:32 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> open_by_handle_at() requires CAP_DAC_READ_SEARCH.

Or some sort of access to the network.  If you can send rpc requests
to the nfs server that appear to be from someone with access to the
export, you can guess filehandles that allow access to objects under
that directory.  You'll need access to particular objects, but you
won't need read or lookup access to the directory.

You can prevent that if you set things up right, but these
filehandle-issues are poorly understood, and people often forget to
take them into account.

--b.

> And if you have
> CAP_DAC_READ_SEARCH, you don't need to even guess file handles. You
> should be able to read/search through all directories, IIUC.
>
> So how does one make sure that shared directory on host is not
> accessible to unprivileged entities. If making directory accessible
> to root only is weaker security, what are the options for stronger
> security.

