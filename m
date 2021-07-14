Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CFB3C9350
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhGNVsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhGNVsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:48:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D3EC06175F;
        Wed, 14 Jul 2021 14:45:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b12so3225323pfv.6;
        Wed, 14 Jul 2021 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EDJeHP+Cbj06l1JuifY/WPhYURdEEHaTycc8ZayHpA8=;
        b=WZiXZEXBKnzhS35KThjFYPiHo61MrjTSYO6cnoEHj6lG/aGyGtKmDL11E7ubxQMxki
         7xy3TSE4GQeqC/xzzOrApVbtwklTTRbxW59AODcpnnk/XdL8Cplyqi+ZySgiN9DKsphD
         h2mCbIZoWcDdlbSkx16sjIfrTvnyD6UixJu/nvDTYPSs6cRcilQ2eIEye/Yw3lujowFW
         ChI/hsK+CzcaJe2cIR4aAhYigF2VTzLSd7vXxkNFRIgaBLL9AiJ4iptpsS4vOd5RN2S9
         glG16eKCQu9G3E66b8jpu6F+eOqCtcShkXGBKC3PTQ9SGWLF9LE7YmDtpQutZ07w4EIc
         2MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EDJeHP+Cbj06l1JuifY/WPhYURdEEHaTycc8ZayHpA8=;
        b=KkJID8h0Sx6lYMoKhVnPLtB3sLCzezXYY56VNTdfRl9t3WqBSb9kYb0pcTMZeFVOE8
         SAEnCnXvGRRRNpRE0MKWFy78+TxrHP8v5UgpUL5FhJuit7jVI8XFrQHselhmwqOOZmDg
         4bSuAyqOfVfnC4kw0XUUL1B4qVB6aibzwhuKT9ziRpEGq4wI5+D91M4NkTtWyZNR58UK
         9+wGioonr2Fcy6ons0tZB688w4XLmGXKmlFuL3RyOPhrwnpZuKx2TqzOYHOoWUviyVpr
         FB+O+JJTbxXQNiR6JqPNF24Q+LdXu+SGir0zEo4oVE4AJSGjd7e6oVxqUhsB4GJUw7Oh
         dOfw==
X-Gm-Message-State: AOAM5335Z2rAGiXBuYAY3kLxrW04euRb4QLzcRJ122UMLNmwxC7bXK88
        W/7s+OXajz+o/AuWk7fEM3VgXBo3uzJeE9Q8/o0=
X-Google-Smtp-Source: ABdhPJwBuWsmhLdoBODfd6Y7T5rfHShgFXe5lmmjFpOv6Ue1yzAKyKiVz5KAk3n67uGPzAy2T98Z0KaIKjlWhZfEwGY=
X-Received: by 2002:aa7:9a4e:0:b029:32b:34a7:2e4e with SMTP id
 x14-20020aa79a4e0000b029032b34a72e4emr183163pfj.20.1626299147861; Wed, 14 Jul
 2021 14:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210714001127.GA994@raspberrypi> <CAHC9VhSd7hTXUyeYB1=icx+W40f4E=1fzp4AC3B2gHFeubArRg@mail.gmail.com>
In-Reply-To: <CAHC9VhSd7hTXUyeYB1=icx+W40f4E=1fzp4AC3B2gHFeubArRg@mail.gmail.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Thu, 15 Jul 2021 06:45:37 +0900
Message-ID: <CADLLry7E+THeMSPLR7kxu-hzA21NHh=tLms0UJ1Wru4NFJ5jRA@mail.gmail.com>
Subject: Re: [PATCH v2] lsm_audit,selinux: return early for possible NULL
 audit buffers
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=EB=85=84 7=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 4:26, P=
aul Moore <paul@paul-moore.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Jul 13, 2021 at 8:11 PM Austin Kim <austindh.kim@gmail.com> wrote=
:
> >
> > From: Austin Kim <austin.kim@lge.com>
> >
> > audit_log_start() may return NULL in below cases:
> >
> >   - when audit is not initialized.
> >   - when audit backlog limit exceeds.
> >
> > After the call to audit_log_start() is made and then possible NULL audi=
t
> > buffer argument is passed to audit_log_*() functions,
> > audit_log_*() functions return immediately in case of a NULL audit buff=
er
> > argument.
> >
> > But it is optimal to return early when audit_log_start() returns NULL,
> > because it is not necessary for audit_log_*() functions to be called wi=
th
> > NULL audit buffer argument.
> >
> > So add exception handling for possible NULL audit buffers where
> > return value can be handled from callers.
> >
> > Signed-off-by: Austin Kim <austin.kim@lge.com>
> > ---
> >  security/selinux/hooks.c       | 4 ++++
> >  security/selinux/ss/services.c | 2 ++
> >  2 files changed, 6 insertions(+)
>
> Merged into selinux/next, thank you!

Great, thanks for review and feedback.

Thanks,
Austin Kim

>
> --
> paul moore
> www.paul-moore.com
