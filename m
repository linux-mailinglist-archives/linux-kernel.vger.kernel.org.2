Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB553B4D30
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 08:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFZGqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZGqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 02:46:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 23:44:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j1so13159233wrn.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xUzuk+g5+JYkMXXTgrkNLdDVSSyLreEfsj7n014KbL4=;
        b=WpuHkHjEENbMWHHxERePxuikek9bVaKGbtJTQqR1484T71CXhLPwkyuJKaZdiSJare
         Z2Xfd5u6L3yuOn1g07sGNbdVnDYCgXBKH02LhAnKiKa8rQhBvos3Zq1SQ1BLaP8rBS8u
         GNjIpPdz1RSEy3hcAzJTOr4tUAOfDecBa98Ib5JtyIfbNXAW3xKelLCSnm1biVEgt1Pq
         n4Nys3H4eWyjrMrcDUFlYJpj03szQ41/VkH+x2vkM4Arkv6SDyK9bTKmFxyAqYLwzipk
         rtMSEujjRwO2luaSSM+/f6LFznzo4M2UwetD75QKDBuVBI5jIGGNbsYN6r0A7t6VOkak
         Aknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xUzuk+g5+JYkMXXTgrkNLdDVSSyLreEfsj7n014KbL4=;
        b=HUIUmPw8xbEk2NFJa2T0CvQs7ZbuFKtSRELdjK4//PlV1hT/gfLRC0RUDdUFjC/d7/
         3Hw4OYXBpan7DRtKtdJItXapH311fZaBkIzN1pIyCiunpMf9j5qw52cqXK6gu2CEUk6L
         xLfk3iIArOjIuXphBDcreKq+HJfAHTj6GuUuZ298hmRbiUTEAjrZciblCt/dph3/it55
         dI+ob9jbGv/r87MZ+rfP5BI4XsbvKLHkMdlUrPATRqewkUlkwdMTLxey3bO5zAvveN3V
         3rvcUCkUOkYB1Sr8JnY1oKcgDBJXQHNzWrsgq1Wiw8FjEY8ZHAGOB1ZCwM4xdrrviYrg
         67Ww==
X-Gm-Message-State: AOAM531LWR13Lc7cAMEo5TBwXJYRYwHvARtfZnnfsXNVqjZXfBXz45MT
        lGVi0d4N0wpIwmcAsouwnw==
X-Google-Smtp-Source: ABdhPJxO9xW1HulRij+0e3g+5kn8dME9xrmOhEm3ZhsI4RvL0qFnh+vuT2LWKkXqMbMwtuJDn1HUaA==
X-Received: by 2002:a5d:548a:: with SMTP id h10mr15464725wrv.234.1624689867789;
        Fri, 25 Jun 2021 23:44:27 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.84])
        by smtp.gmail.com with ESMTPSA id c133sm12530270wmf.0.2021.06.25.23.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 23:44:27 -0700 (PDT)
Date:   Sat, 26 Jun 2021 09:44:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] ELF: add and use SUPRESS_WARN_UNUSED_RESULT\
Message-ID: <YNbMyXR476FvEPaA@localhost.localdomain>
References: <YNYz+hVeqsQmiEqN@localhost.localdomain>
 <CANiq72=qtAcsyReu85AVT-cSf3dcvbnTpQYEF1JhxCRP0WgHUw@mail.gmail.com>
 <YNZGNvGn/pkMhsx+@localhost.localdomain>
 <CANiq72=HCKAyuLD3anAuSug4s0MKMHwRXdMPt0pNs-mTxD1CXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72=HCKAyuLD3anAuSug4s0MKMHwRXdMPt0pNs-mTxD1CXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 11:57:21PM +0200, Miguel Ojeda wrote:
> On Fri, Jun 25, 2021 at 11:10 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > This is natural place. If you're supressing WUR, then the WUR macro
> > itself is defined implying that the header has been included.
> 
> I am not sure I understand -- I guess you are saying that your macro
> is only ever needed if `__must_check` is defined, which is what I
> meant by "related".
> 
> But this header was intentionally created to untangle others by
> keeping only attributes here.

Sure. But then developer needs to include another header to use SUPRESS_WUR.
As posted, attribute and its suppressor go hand to hand.
