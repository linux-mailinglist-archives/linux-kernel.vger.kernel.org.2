Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEEC340DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhCRTGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhCRTFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:05:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9C0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:05:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jy13so5650430ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpeAY+IlhK2l7Stnip3mBHYcu4i8LuRlI2TMsBQ+z28=;
        b=osyoo1e/fFBBhxzr5GbwB5KNn2SQkjGo2E8ZhF1UFtkpg3hCjlOetntqgie+vy7lwd
         OBAlItyS8ryUBbQu6++0puXQ3yHTsHZA/svFx7x3hckLc379plW/oHyEf+G6F77EQ/Cw
         OsKEjYH6qgwdFIna57rTY0whQaKulmG2y5S5uWJ/PghmTECc7fOODxKfwIJS3HKLsmAp
         kb8j5td8Ln6nI9meDr67lIeD8mc1cBJ9V06+HE9SzqdIq9I4+VKAUYqf0LTfs67cMXa1
         ZpzFiDLPVFl/vq0R4Phx+GTZws0StOahHgtRM73XFTHTsJ7B6v4WLOpma07WANAL+eWR
         Oivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpeAY+IlhK2l7Stnip3mBHYcu4i8LuRlI2TMsBQ+z28=;
        b=G7L/vbn1nEFzIshFPbJPx0M5PFLxY2vNwzczqtqEVqlHmb92yW4JAjkav0PYUXQ1G1
         WiCPxoqQ8/pACSGPMQODpdCEFQTMbuRfTXeqOphXe8mBF6k0F3L4XmGap0XJb9KMm+pL
         SkB6WNHGh/R9b/4qhwt8y0j7NJTBduJEpj/zKDTgg7TjLsl3wKqvOMLzQh11ZXqntA95
         EuTsgd32eLeNbAuE3AOlt/YprAOQrBjypHSklAfoHhX4g6P0lAJpSdNHWsRZH+BNVkDw
         hgUOX5c8pwmN3WOECnAswS38+41hezdqseK49hym6PkwHP6Y6Y/y7i2wzNM3PKaTuoeD
         esdA==
X-Gm-Message-State: AOAM533by5XNG2MkkjlX42ytUYFC/KTkqD/z/udjUvwRhWGbm+bq4HZU
        y4wx5i5FaLglaYcVrYqdnus5TWX4NeqSBoM/Ixhi
X-Google-Smtp-Source: ABdhPJzAb3AhZ51EbHigihuot6RpwrS37kkfH4TXc6eKDv18ZCtWiKfjgTtz9SV9KLOWuHk+RKyPDph8xdSLN46OCxA=
X-Received: by 2002:a17:906:a443:: with SMTP id cb3mr66435ejb.542.1616094350794;
 Thu, 18 Mar 2021 12:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616008065.git.rgb@redhat.com> <fa3967b0c74e5497932f0f08c2e67bb5fdd9844b.1616008065.git.rgb@redhat.com>
In-Reply-To: <fa3967b0c74e5497932f0f08c2e67bb5fdd9844b.1616008065.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 15:05:39 -0400
Message-ID: <CAHC9VhQ-cUe9OyEAeMZA3EC4Qa0k2jQuixW-K3UkU01QgG_VXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] audit: document /proc/PID/loginuid
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
> was added 2005-02-01 by commit 1e2d1492e178 ("[PATCH] audit: handle
> loginuid through proc")
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  Documentation/ABI/stable/procfs-audit_loginuid | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/ABI/stable/procfs-audit_loginuid
>
> diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
> new file mode 100644
> index 000000000000..013bc1d74854
> --- /dev/null
> +++ b/Documentation/ABI/stable/procfs-audit_loginuid
> @@ -0,0 +1,15 @@
> +What:          Audit Login UID
> +Date:          2005-02-01
> +KernelVersion: 2.6.11-rc2 1e2d1492e178 ("[PATCH] audit: handle loginuid through proc")
> +Contact:       linux-audit@redhat.com
> +Format:                %u (u32)

Existing examples seem to just use the printf format specifier, e.g.
"%u", without the explicit type, e.g. "u32", which seems cleanest to
me.  I would suggest changing this to just "Format: %u" to better fit
existing convention.

> +Users:         auditd, libaudit, audit-testsuite, login

I didn't get an opportunity to reply to the previous thread before you
sent this, but I really don't like listing specific userspace
tools/libraries here.  I recognize that you like the specificity, but
I do not, and I fear that it will become invalid over time either due
to deprecation of old packages or omission of new ones; the fact that
we are just now adding an entry from 2005 shows how this area of
Documentation can often be neglected.

Please replace this with something like "audit and login applications"
or something similar.

--
paul moore
www.paul-moore.com
