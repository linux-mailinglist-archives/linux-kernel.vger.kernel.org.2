Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDB33974B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhCLTRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbhCLTRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:17:43 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4182C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:17:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ci14so55272865ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6ZgASB+qgCwfbF/JMCzQzVtFFhgcIqRIrGbjW1M1j4=;
        b=Moc6kgAHSB1CU8OG/jwV9nCCtwe3lyBOZIK1TnqgEID9v3ACLDDKi9BpQ1pbaNLbos
         wtaEixp8x+QC+2A9fXVzF1IV0dXGbc1aVh3Vws8Tr+Cgr6A1jJHVFT/pqn/ndEGlHZJ3
         EUckEKUsVBQurJB0K4YKE2VVdTbLmMN/Z8VU8rr9AIUfqW+Kna/R9fYUzoi0crqpBOWG
         KHr9CrkIMGrjS9v4vLLSDTBALZ0arYd4SsFFXi24TI5umD1iSeJo5a0QSh7Q4Zr/xc3R
         2Gr7Ou8c898SCK7omn4h9alexlecZg1A+DwtDIqWiJzmlTzHjHIlbJ4p/EUcheQaVi6X
         ICzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6ZgASB+qgCwfbF/JMCzQzVtFFhgcIqRIrGbjW1M1j4=;
        b=i0YHB6I1k+8RQmAg0KCPHLbQpRcCIAeJnO+4084lTXBiBOhS/55PPUK8GzdaOMLdou
         qVUCndnQv8Jju1lOVSUlkVHy+w+KaHg9oFO9X5jcwN2cqqJYWqEoMIKtbd4M8ePtE7N3
         obuAiyjyoo00ZXttjJR9bW+kfifgVjvCRjoG3Wr6Z+wlxCha+NWR5N7YFNjErf0QYRYr
         bSSEk9DWBiOoPfMXNHnX7I/2C7QBQxpqqHWXTzp4NPOqaMe0/nVwjWHbwb5JvJipBOMe
         AOTDN9NBYq7rE0lA8wEhhh2gGA67knxrA2KBtKbnCQhPIhfMZ60Flvh20punfOAf9L9x
         uY2w==
X-Gm-Message-State: AOAM533RasqSuHeIMo2NGLGhI1VepY3jux8+dr0hdPYXmBwu90ywZgds
        A/cTi0/OvMrH3Pqhu0RaHlhr9PZ13zBAzgzGWKT32Tt89xNG
X-Google-Smtp-Source: ABdhPJzHH2v5+ctQq8g6wnqNmWb/FxTzWTC0x5DcPJViB8M2A+CHifCaQwRHgAG3gTocUdthsUA32byzNZZA+oxAlpo=
X-Received: by 2002:a17:906:e116:: with SMTP id gj22mr10037529ejb.398.1615576661321;
 Fri, 12 Mar 2021 11:17:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615414262.git.rgb@redhat.com> <b8a16198e196bf8acc07f8c6701d9870d72f967c.1615414262.git.rgb@redhat.com>
In-Reply-To: <b8a16198e196bf8acc07f8c6701d9870d72f967c.1615414262.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Mar 2021 14:17:30 -0500
Message-ID: <CAHC9VhSB-ECG-3MJNmMFu41ZqhRb4EL-d+6t0pYd5P0e823MNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] audit: document /proc/PID/sessionid
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:41 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
> was added 2008-03-13 in commit 1e0bd7550ea9 ("[PATCH] export sessionid
> alongside the loginuid in procfs")
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  Documentation/ABI/stable/procfs-audit_loginuid | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
> index fae63bef2970..175ee6ec3695 100644
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
> +Format:                u32
> +Users:         auditd, libaudit, audit-testsuite, login

This should be obvious, but just to be safe - my comment from patch
1/2 also applies here.

> +Description:
> +               The /proc/$pid/sessionid pseudofile is read to get the
> +               audit login session ID of process $pid.  It is set
> +               automatically, serially assigned with each new login.

-- 
paul moore
www.paul-moore.com
