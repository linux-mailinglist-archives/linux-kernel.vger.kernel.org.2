Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A40340DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCRTGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbhCRTG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:06:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB09C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:06:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id bf3so8038036edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U15tb4g3nXjGjLDNPkVSVXyuRsDcgd2AwJjskj7Z5Ec=;
        b=n/RerCQHRWgQkiEovha3KzwKaNtZvM1td5YX8JoEDq+f+XQYWv//r9Xtpwv6AfRRTL
         SHiaTpHO9fAo73UzhelG6kc+uXS7FIRpx51sz3FoFIPL/VtMztdbkHZY+Cb1Czce+hQh
         sotI8cogdbYTKHBnvvhcap3QYkHyBjaSADWXz4Y/rvHJ9xN2dWdGRMxpDSYmlMeyrTxU
         WOe/MmmTfV9UQs7LyzgFNMfkFwNkTp7Spv/oV7oTZjgLl3UDSSzy0OZzlSYDlJtTHmZZ
         Od+CWI+meI8JXVQHhDxFI7Gxgw/ftEd0WITgPQReQvYRKpHWdVgr6+6MeoA+nJsnZd4r
         lo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U15tb4g3nXjGjLDNPkVSVXyuRsDcgd2AwJjskj7Z5Ec=;
        b=ZCWToNZvJAROtBDhQ32KKm+xiZSb1c9iwHS7UL426dDFpWAozC9eM17NuS+Fe5qAWN
         BEstLJ+KuG1QevgH4QCurB2q1Q85P0CRFicMjFRwuznShHf09RU3iIhUkzt8UEKhAmkS
         zgnMJQCGuZSxRW19wp/feua07vgyDDiO/MNDzg+K7uiQ3UZF/glKdUyIPDCsoEdMGt11
         3eiK9zjK9pIRlLJrh1gdPuEHIgpix0J6rDbnkpBlZpBOo/bdsdTZobAJUY2wqra/wk8O
         u/U0u2gmAnksP5il9QmJY02gCS84aX6hilOqz00Vv7OKA+FQw1PuoHGxyRqBHXjx/ugn
         cLjQ==
X-Gm-Message-State: AOAM533S5V1dI/PTdvCSy/VzuC4HBMrafnxQt1VQk64S7Jq3/1KTy6p3
        dkaceGsEDnNgviRMFA2P1nirUwGn46MXgU9bK4rT
X-Google-Smtp-Source: ABdhPJzk6BrSrIOsFMVG4w2aM5J+DjbTTiGzJ+fGRB4nHTkATd+3xFXgV048yNudqUCP67Cbv7Ja8rjuMWFp3ddCjBU=
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr5475637edt.12.1616094386871;
 Thu, 18 Mar 2021 12:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616008065.git.rgb@redhat.com> <0e77d290bb50232d9ec9317645106f1330bd2d54.1616008065.git.rgb@redhat.com>
In-Reply-To: <0e77d290bb50232d9ec9317645106f1330bd2d54.1616008065.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 15:06:16 -0400
Message-ID: <CAHC9VhTawo7jrRPeCV6mcPe9r3CZ5D+O+ukWz5Ji_mZu=PFo4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] audit: document /proc/PID/sessionid
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 9:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
> was added 2008-03-13 in commit 1e0bd7550ea9 ("[PATCH] export sessionid
> alongside the loginuid in procfs")
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  Documentation/ABI/stable/procfs-audit_loginuid | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

The same comments from patch 1/2 apply here.

> diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
> index 013bc1d74854..5d09637a4ae2 100644
> --- a/Documentation/ABI/stable/procfs-audit_loginuid
> +++ b/Documentation/ABI/stable/procfs-audit_loginuid
> @@ -13,3 +13,15 @@ Description:
>                 AUDIT_FEATURE_LOGINUID_IMMUTABLE is enabled.  It cannot be
>                 unset if AUDIT_FEATURE_ONLY_UNSET_LOGINUID is enabled.
>
> +
> +What:          Audit Login Session ID
> +Date:          2008-03-13
> +KernelVersion: 2.6.25-rc7 1e0bd7550ea9 ("[PATCH] export sessionid alongside the loginuid in procfs")
> +Contact:       linux-audit@redhat.com
> +Format:                %u (u32)
> +Users:         auditd, libaudit, audit-testsuite, login
> +Description:
> +               The /proc/$pid/sessionid pseudofile is read to get the
> +               audit login session ID of process $pid.  It is set
> +               automatically, serially assigned with each new login.
> +

-- 
paul moore
www.paul-moore.com
