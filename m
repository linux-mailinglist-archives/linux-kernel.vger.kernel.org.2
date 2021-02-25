Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D0325A31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 00:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhBYX20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 18:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhBYX2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 18:28:21 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:27:40 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lr13so11663934ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLcmTEjAiF5yFpxf27atOmC91/iDittSsNlvHgP+FGw=;
        b=WAV1PV1KABzooKU+nDNO9oCfpMmd7hnjojZfiA9jbcjxpJ5euqn3q1lz1J+VxZGzvs
         TOWw/xoVDYENrYzytLq03NBIbhDH57Jm9hAL/UFdbc/fYldOcIaMgkZOe9xhjoset08E
         KPFE5YyrjUcy6dFzxw5a1oPyprnC6RPg8cFd2bumvS+D39E3rrrMfyed598M4dsvw1YI
         0a7Jx66J1XZaiuR2n+n28/7/EjbwBQ92ir4SXmRFyHOegjQ7NNJfK9sCFpm+mg/rg2JF
         Og6zjWvOrK8ICMQLekXr9xk7mbkW3fjljVVxq8ZhPbr/gMziu1Ohp84sTiPzt0XDsxpl
         P3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLcmTEjAiF5yFpxf27atOmC91/iDittSsNlvHgP+FGw=;
        b=WlIy9JHhqh4B0GAEIpfjGUExAfvh/8kS9ZIBKU+REcMMmTlnW6zVDf/R8BSkZyt6P2
         HIzIjeOwJfKg9BDuN8Ju/pmsUoQX/Gum/A1lB0jzggwMMuL2DdWqbVQI80DHFJrfBe9T
         C/iRDoT6qPHZOXzMlzvcSg5uWD8BSRuw9dXkcc6FXKL8rM7xiYlsBSl27Ndka15SRtie
         PnOd4/uMb4cq43Zwkjy2PpPWz9Rp7fVy1TxRV7BdG/tsxDiIoiiHUJhWnlRH+67xcZtI
         3S4vWDmUo67bGJhKEUSjpETCTFVonCSIvMhmTcaz7EAAzLR8CGk5kMhTf7G8HY/XpIdY
         +pyg==
X-Gm-Message-State: AOAM533LKrNjIFfGr14qU6Y8cjpjGyOYT0yf8744BNg0T6+3F2IXOxtX
        pFCP3RGZgdFk00IJNiFDcSuQ8FJNQlgoxcKTtbgs
X-Google-Smtp-Source: ABdhPJyWVS/hrD+V4AvttM+SSjvEy52dNqah1ffuwMS87KYsNyJ8cUUVc1mTEFfK+8tWKRBoVMuAEFf/vCbdv+CpJ2Y=
X-Received: by 2002:a17:906:2e91:: with SMTP id o17mr43073eji.488.1614295659553;
 Thu, 25 Feb 2021 15:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
 <20210224143651.GE6000@sequoia> <CAFqZXNsNtAD56H0K-oOMkm=M_M6g=zuSvprDAWVk_phwQGk_TQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsNtAD56H0K-oOMkm=M_M6g=zuSvprDAWVk_phwQGk_TQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Feb 2021 18:27:28 -0500
Message-ID: <CAHC9VhRTBrBU+PgWWyymeS+wvLKX5LRw8BZFZpS56eo2uMJedg@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 11:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Unless someone objects, I'll start working on a patch to switch back
> to read-write lock for now. If all goes well, I'll send it sometime
> next week.

Sorry, I was looking at other things and just got to this ... I'm not
overly excited about switching back to the read-write lock so quickly,
I'd rather we spend some additional time looking into resolving issues
with the current RCU code.

-- 
paul moore
www.paul-moore.com
