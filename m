Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954CB351C64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhDASRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbhDAR7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:59:36 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B79C02FE99
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 09:04:18 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g38so2273589ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sUBBxIsh5MoadReGP/VqLbxohML6QjbcEagpy6zr2XU=;
        b=kgGoI1mi73jJD6vU65ZjfSW989i3YggKxTExgsujUPG2obK52+EqLs3uOVTYfZIwvS
         zIpdGcgqASulxt+rZ5WjRLODKT93fo5mJAsIYXfg7bKukY4PJNYKVVCG7WgoFiU+mwtj
         hcoIxKw8pdNBbIvX7rerUuJEa5a0V20aWrMKo/IMqB5QW2n1+TRXL/6ClTWQabbYsytE
         2s0MGIGrkq5F9P8qW40p/EKzwRoXNCh1+nYnSvM6YgvmJnM7s536PwfhYAPXmX+BEtiR
         beJ66gKeaeuXmHOwilFjAUIN26vIU106ceWCK1wWhmUY0bdzn42lqhUkxnOZ1QJO//1R
         mSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sUBBxIsh5MoadReGP/VqLbxohML6QjbcEagpy6zr2XU=;
        b=A9VfslQqXVSV3f9wqXJaKH0Sj1ixacSI8uuyKh8fnVHti6/gYH+tdzwiBDAPRmtxhv
         Kii1KO43ZIGoZmdWiRBQyOtj+1slGwvpfng9uUbr0JLoC4KB7Ga84XdQWoATIzw2P5Lj
         J7XEnNDVaQvD9wzamYKaf8fG9BuEC6VAgclApQzz1XZAr7S72jK0Cm85XIJw6EtvtExV
         B0iYKuAQxSEc5ovglK2d2pf0X40H7O5OcJS653fL/qHsDV5ROmYq/8ddAJ6Ayzp0WF2D
         z5o8nX5ktEiVTbZ+849ZWFSX3wkS8E9/WxLBIK1EVjFGcPBlGqMqgdau2f2+jVR/VKuB
         i1lA==
X-Gm-Message-State: AOAM531L9z3B39Ja5oBnkHvLzoSPAoReII3Ch7MbRs6+8dslbLuwlNBy
        oymBG2uG0RA0iDilVDHCp5LoqHdZWpMWB4hjGAkpzA==
X-Google-Smtp-Source: ABdhPJy9LhPezyvzgsg7ZroTaiT8wXFSCxJWKBWR93Vq5xwa7AbGV2rFFaql2dzdLKzB4TEZ2VQm4+2+1V7LIj71wDE=
X-Received: by 2002:a25:3614:: with SMTP id d20mr12775432yba.452.1617293057194;
 Thu, 01 Apr 2021 09:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210401155704.35341-1-otto.hollmann@suse.com>
In-Reply-To: <20210401155704.35341-1-otto.hollmann@suse.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 1 Apr 2021 18:04:05 +0200
Message-ID: <CANn89iJvtuT4q-djaCzoGJTY68vE8wT+LVDkYGm=8_XzC9gchg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: document a side effect of ip_local_reserved_ports
To:     Otto Hollmann <otto.hollmann@suse.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Ahern <dsahern@kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 5:58 PM Otto Hollmann <otto.hollmann@suse.com> wrote=
:
>
>     If there is overlapp between ip_local_port_range and ip_local_reserve=
d_ports with a huge reserved block, it will affect probability of selecting=
 ephemeral ports, see file net/ipv4/inet_hashtables.c:723
>
>     int __inet_hash_connect(
>     ...
>             for (i =3D 0; i < remaining; i +=3D 2, port +=3D 2) {
>                     if (unlikely(port >=3D high))
>                             port -=3D remaining;
>                     if (inet_is_local_reserved_port(net, port))
>                             continue;
>
>     E.g. if there is reserved block of 10000 ports, two ports right after=
 this block will be 5000 more likely selected than others.
>     If this was intended, we can/should add note into documentation as pr=
oposed in this commit, otherwise we should think about different solution. =
One option could be mapping table of continuous port ranges. Second option =
could be letting user to modify step (port+=3D2) in above loop, e.g. using =
new sysctl parameter.
>
> Signed-off-by: Otto Hollmann <otto.hollmann@suse.com>

I think we can view this as a security bug that needs a fix.
