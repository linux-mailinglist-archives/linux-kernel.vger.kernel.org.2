Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA740C3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 12:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhIOKiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 06:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhIOKiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:38:12 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97ACC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 03:36:53 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y144so2851335qkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/mGcCmjESDIAm3+tF207IbSt9cMpy/yGpDLXhbXJilw=;
        b=jZC6J42lFWe5NjJGxcOV7d5AVFnElkEpr8x+JCTMRSstrsGQB7n1PDUNmHQE+EjSNI
         8a8PFwQYT3/eO9AmTYKozh2AB+ToXko00hIRCPFSCtNyWdCeNudFFHu2G5RnjgevgSPT
         5iY/6u6XgvLeUuGI0IjNvnNWQqUNtyMWw8DqXz6SgkP+6ejr2dKXCtdrKoyA84l0aEmK
         mr41TRJlBSEcavNsm/QFGj7kBko3Odrd/5rvAZ01j/6mxcqdILwtJ0oQ+7p+jt6xRkNB
         sKJfnShOM2tR7QOCzqiT0xb4f9MvVKCkRdu8vV6BQr5a5DZqc7vH6Y3jZLJ2OVxALGNc
         /q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/mGcCmjESDIAm3+tF207IbSt9cMpy/yGpDLXhbXJilw=;
        b=nh29S6pFa9wDRtzHDMxVAlP6ndYCjiX/yCjYHtsr9e2fuD+DYmo6NURbSPivRnmpTd
         iQ2rjq+P8iWBpYql7oLj1VHW5jHTsPGBS7Kj6UsISPZgzVIe6cUXpIKEWwJlI6hZoVc+
         8hQ/RFDsPBxB7gUEC4nHuOeyBRGUjQEn7M3y4eX00+Y907e20aebnr1EghzdRESSk6UN
         a/l9WNj3zHpNq9R97nvFKc4Q3eDen1JoS9OoGq1auHEmZgm8m+n/98DPSWsCh5qZ1NFE
         jHIwF8vPJyHfuFqjduB/EVRxa6Bi9P20XIY8EpqKU5Hwem+NMwXDvPKDmr0dJQQBaSAf
         8MyQ==
X-Gm-Message-State: AOAM532xc7vWn2x1ZOD+SBMV1MQd2XsvlfdzeyN94OfcHKwbcL3lA7Ty
        wklLxikW6TRKI3h6Xi6QVndY2jM/fueIq9oRW+w=
X-Google-Smtp-Source: ABdhPJyyeGXQ3+sRzznoBgOxXz9YNLXSOUaweAHcQrmowpOjqhjo5dtOoCXxwX8tTWUygcmhyv3Bpmdep+B6k4C28TY=
X-Received: by 2002:a05:620a:1388:: with SMTP id k8mr9066031qki.152.1631702213021;
 Wed, 15 Sep 2021 03:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com> <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com> <CABXGCsOPLH2DkZ09PDXSxStin6JJb_m5bJuQWmXooBLaSJ2Ezg@mail.gmail.com>
 <dcbb87cc-c95d-ae58-d601-413a6277a7f8@amd.com>
In-Reply-To: <dcbb87cc-c95d-ae58-d601-413a6277a7f8@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 15 Sep 2021 15:36:42 +0500
Message-ID: <CABXGCsOQ8uXY85zrCOOd611gDj3AhtqH4=LcYHD=T9jVEzkuig@mail.gmail.com>
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sept 2021 at 14:55, Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Yes, absolutely. You should see GPU resets and recovery in the system log=
 after that.

Unfortunately, not one DE will survive a GPU reset. All applications
will terminate abnormally in fact this would be equivalent to reboot
(and denial of service). :(

--=20
Best Regards,
Mike Gavrilov.
