Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15D1336F00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhCKJgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhCKJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:36:41 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827AEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:36:41 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 75so900392otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/yJc2SsfEWziBZ1LArgu9WV9K8NEngQzg7n/JFp0cM=;
        b=RnMEZOtkbouSIgAcWgcLjYn+e8sSOQsk+gwKETZkeyO6CxfoGJomwqfueCC/TMkell
         2ZF/GXXxdfoZlarfmCfCXhmWTv5EjeLw1PsCv1WLdMxi5V66om9ILEZmohPTVutCAadr
         3U26F0jjA2mtiraU35ghuye85+lEj7OTtoKsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/yJc2SsfEWziBZ1LArgu9WV9K8NEngQzg7n/JFp0cM=;
        b=H8ui4bDF2Xqd/sNzA4DxElut4XE/Bnc6Z79AaY6UqVPWQ+ECUbhUDolwT1CEU66KUS
         R2TFjCDICfsAmUp3gykmScxMQiXbl36dRBX16jZwCerYvpjL+VRZUVXHBdot06e/SlX+
         Agd+7TgQbQumOODg9ZeYHPW/O1ZcbSK0eZiYQCuMaXYuzUXNOh+6dPmC1AjkRNznc8l4
         iEqBP+E8xKW+UFDcRjflzDJvVlGElqgW+PH2rNkj7YdIGhH2rbEg+Ixj2X1KfWfn29SS
         TViF20YaXmfqKNVKwR4kOMN/Y6CIBkNPEPSiXLSv78ZaoTpkWBFL+4xPO0IQHJdps4Ue
         qpHw==
X-Gm-Message-State: AOAM530Y5+Y650Ab8fM5kZVrFfXqsmp8WVplFIN529DEMTOgdWl8+2YQ
        cByx80sGRVXfeCWO+p2Kb3ew5Oqfr2pn/RIK
X-Google-Smtp-Source: ABdhPJyeIkm2ynkIdN+DXN1iBDnDWO4waZuWnP4ekX0FQd3iS9VF+veYcwV1CArHptMy2M3gfxTGUA==
X-Received: by 2002:a9d:7ac1:: with SMTP id m1mr6395423otn.186.1615455400009;
        Thu, 11 Mar 2021 01:36:40 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id t3sm543909otb.36.2021.03.11.01.36.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 01:36:39 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id j22so909557otp.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:36:38 -0800 (PST)
X-Received: by 2002:a05:6830:144e:: with SMTP id w14mr6263501otp.0.1615455398529;
 Thu, 11 Mar 2021 01:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20210310225251.2577580-1-dualli@chromium.org> <20210310225251.2577580-2-dualli@chromium.org>
 <YEnH1qd527g/neY4@kroah.com>
In-Reply-To: <YEnH1qd527g/neY4@kroah.com>
From:   Li Li <dualli@chromium.org>
Date:   Thu, 11 Mar 2021 01:36:26 -0800
X-Gmail-Original-Message-ID: <CA+xfxX4tD30BJLgwLAoiMzF7xTC-4q1i0A5Znp3tJzyi3ATLzQ@mail.gmail.com>
Message-ID: <CA+xfxX4tD30BJLgwLAoiMzF7xTC-4q1i0A5Znp3tJzyi3ATLzQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] binder: BINDER_FREEZE ioctl
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@google.com>, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@google.com>,
        hridya@google.com, surenb@google.com, joel@joelfernandes.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 10, 2021 at 02:52:49PM -0800, Li Li wrote:
> >       if (target_proc) {
> >               binder_inner_proc_lock(target_proc);
> > +             target_proc->outstanding_txns--;
> > +             WARN_ON(target_proc->outstanding_txns < 0);
>
> WARN_* is a huge crutch, please just handle stuff like this properly and
> if you really need to, warn userspace (but what can they do about it?)
>
> You also just rebooted all systems that have panic-on-warn set, so if
> this can be triggered by userspace, you caused a DoS of things :(
>
> So please remove all of the WARN_ON() you add in this patch series to
> properly handle the error conditions and deal with them correctly.
>
> And if these were here just for debugging, hopefully the code works
> properly now and you do not need debugging anymore so they can all just
> be dropped.

When the target_proc is freed, there's no outstanding transactions already.
The FREEZE ioctl from userspace won't trigger this. It's for debugging.
And I'll remove it in v2. Thanks for the suggestion!
