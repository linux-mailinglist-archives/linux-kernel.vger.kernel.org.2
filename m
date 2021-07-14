Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6113C8BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhGNT3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGNT3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:29:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5916C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:26:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k27so4645986edk.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5WdCmdzAAZvn5CRq9XtWBn39mC8lrQD6RcbEsNxMOI=;
        b=Gjva4LKSPLcViL3TOIl2Mc/A0lDJQTjRM9xq2B9qx1sHfcDAKjhG/577r60coBuTmt
         lveR39Z2Q22b8Ni995AAZHyuELVSC7x+xq5/hqoobsl3HnqHTmkTaO88zRHyoOqxQw6p
         5BpWpvzXkNYL5X9+YFlv0d1TzcK58hNXXJhKlDhNiNNOnz+PIY2oNF4RqGGeN3QYzdQd
         WrdYryvX9GQXtiklsSUto/WFgaJeZXejGy8fdSLv/yGGJGF4jnb8hK6JrvMh/OZZ9S/B
         3rdO8J2PSygyHP3tia+Bf0SDINS6usxgdT4pzs0sC3PMjph7DlHGKt0qlXvCBErx66LV
         1teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5WdCmdzAAZvn5CRq9XtWBn39mC8lrQD6RcbEsNxMOI=;
        b=XEbbZ3OHA3v1snuAVeUQ3Eepw3xtW95ZvH5M7T9Lc2pCGaqCINAZ83Q87qlWoxMPcC
         GMk2qDqZWXHiTfN5xMcWKuH6LF98WihUuHlGPeW6ViGJ+GoK7wusd0O9jlyx8i9CRorn
         hi3+AuuBGZw8mW1ANaj9LhXuLajemjf17lNpbpPwzkha/DJF61vSM6nXDxze38dUAz76
         ij1v/t19I92bNn8CPoNQawG++dQzs3rTvqnHIpQHyPUnPsI5QyJKLw1vVME6GDRQ4X6v
         zKfSxBMV77dK0bf1TYynA6pSPinLcjwq1MgZHiZ+6KxW/7ZtWJxqPdvIJYZ2CruBsqys
         wgSg==
X-Gm-Message-State: AOAM5333SqP6PJmQf6LcYg+8ssBGJlVFo4xKzWg/soQMkJqP9rEhX2oE
        kH6pODtI+hd66M9HIqDl680d8cN90kvuNMGeACaH
X-Google-Smtp-Source: ABdhPJzuuppjxI2Pl8GpOQeqwJtE2szTRGxA2kpnlfr01dqUNwoTamqdiAGN0UoKSryZ9QEcoFhJ/10ppMl4ArRo+Xw=
X-Received: by 2002:a05:6402:b79:: with SMTP id cb25mr15716215edb.164.1626290808373;
 Wed, 14 Jul 2021 12:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210714001127.GA994@raspberrypi>
In-Reply-To: <20210714001127.GA994@raspberrypi>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Jul 2021 15:26:37 -0400
Message-ID: <CAHC9VhSd7hTXUyeYB1=icx+W40f4E=1fzp4AC3B2gHFeubArRg@mail.gmail.com>
Subject: Re: [PATCH v2] lsm_audit,selinux: return early for possible NULL
 audit buffers
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 8:11 PM Austin Kim <austindh.kim@gmail.com> wrote:
>
> From: Austin Kim <austin.kim@lge.com>
>
> audit_log_start() may return NULL in below cases:
>
>   - when audit is not initialized.
>   - when audit backlog limit exceeds.
>
> After the call to audit_log_start() is made and then possible NULL audit
> buffer argument is passed to audit_log_*() functions,
> audit_log_*() functions return immediately in case of a NULL audit buffer
> argument.
>
> But it is optimal to return early when audit_log_start() returns NULL,
> because it is not necessary for audit_log_*() functions to be called with
> NULL audit buffer argument.
>
> So add exception handling for possible NULL audit buffers where
> return value can be handled from callers.
>
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/selinux/hooks.c       | 4 ++++
>  security/selinux/ss/services.c | 2 ++
>  2 files changed, 6 insertions(+)

Merged into selinux/next, thank you!

-- 
paul moore
www.paul-moore.com
