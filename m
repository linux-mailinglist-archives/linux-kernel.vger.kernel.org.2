Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA4C339742
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhCLTQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhCLTPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:15:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AEFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:15:41 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k16so1872015ejx.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJfM+I5HqJFFYJ65C4XP9E9lkasVMia7svQJuRMmO9U=;
        b=N5N5eVLGku4zyQQF0pypZhXjcTD78uOnSIXvAk1ZwCEOMJRObNrh6B5N6Jk0IiY/FO
         KDEn6ZT5oGHh75BmEelkREgigLyXkyzmDsS9e5YCGsgoIMxZQm+vVmr9Nn0rM+/C5e2N
         u0QjYO83Mg2fmvA1mGR249GHMS3AA4HmeF9milDkPDl7agn+xb867CWIn8bLaKg1LuEX
         aDErq28lD6sAs6vzbr30h0BC/qd+kAZk8v3slKuqwRpUx0h8ZFe6wDvo+yURq8BoZa9r
         vSav2QCSxrpoHkzEVXiWEfyWTwdCKihIQqol7702P9Ai11d/FYogxhIWD4Fi9VBNIv2d
         elOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJfM+I5HqJFFYJ65C4XP9E9lkasVMia7svQJuRMmO9U=;
        b=opPO5u+AILXv/0OdCNYlkBJDPz0mBjiMxM23khKU/6WTflY3qhiS+wGbIcTiSIz+6q
         iCNU6u+GlilWZQRrTgCaW/mJ5y7tamolHBWA+z+CmWf0hq4y61oJkRY8zDWDPZMnSrBK
         ry/CS7kjH/ql7cffQ3+FhQUeYGlVlceOvSYOjWYAyyV8q5a6CLUjMHXa0Yl2esZHe9mj
         YpbbGL408mfrALiXALlWc49tLM8wL1Qx3FYoo7SWT8idmHpS/Q/TzlY4PYy23VWzSCgq
         1oAD8eXV8TRBTFrQpVLXzvHQbT114lzmtV/xOQN56hF5UKWP/HLtghAa3Q5hj9L2pYqn
         SgqA==
X-Gm-Message-State: AOAM5317P9S7cDbs7XEH5dwr71Kz4UE4ai8ZotSq0ofKmVRAnEnSQaGe
        /glKK0zs/BqJ9J4AdfD0o2+xPef1Yby3nvln5sXU
X-Google-Smtp-Source: ABdhPJyW1i4bRVgK1CIQV5uJdUKrirYYDE6X9ulg01wuX+VWr+puT2u8BurlKxyMpi9dwpgdM3hqlqPDJsMsaOXvnaA=
X-Received: by 2002:a17:906:e116:: with SMTP id gj22mr10028144ejb.398.1615576539704;
 Fri, 12 Mar 2021 11:15:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615414262.git.rgb@redhat.com> <df2ca2e9817140dd5c4ff97297b60700b96cb898.1615414262.git.rgb@redhat.com>
In-Reply-To: <df2ca2e9817140dd5c4ff97297b60700b96cb898.1615414262.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Mar 2021 14:15:28 -0500
Message-ID: <CAHC9VhQHsYJnEh_J8ovFGQ9JyNew6C-HCSuFcQamOK3MuAHgQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: document /proc/PID/loginuid
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:41 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
> was added 2005-02-01 by commit 1e2d1492e178 ("[PATCH] audit: handle
> loginuid through proc")
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  Documentation/ABI/stable/procfs-audit_loginuid | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/ABI/stable/procfs-audit_loginuid

After ~15 years, it might be time ;)

> diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
> new file mode 100664
> index 000000000000..fae63bef2970
> --- /dev/null
> +++ b/Documentation/ABI/stable/procfs-audit_loginuid
> @@ -0,0 +1,15 @@
> +What:          Audit Login UID
> +Date:          2005-02-01
> +KernelVersion: 2.6.11-rc2 1e2d1492e178 ("[PATCH] audit: handle loginuid through proc")
> +Contact:       linux-audit@redhat.com
> +Format:                u32

I haven't applied the patch, but I'm going to assume that the "u32"
lines up correctly with the rest of the entries, right?

> +Users:         auditd, libaudit, audit-testsuite, login

I think these entries are a bit too specific as I expect the kernel to
outlive most userspace libraries and applications.  I would suggest
"audit and login applications" or something similar.

> +Description:
> +               The /proc/$pid/loginuid pseudofile is written to set and

I'm really in no position to critique someone's English grammar, but
if we're talking about changes I might add a comma after "set", "...
is written to set, and read to get ...".

> +               read to get the audit login UID of process $pid.  If it is
> +               unset, permissions are not needed to set it.  The accessor must
> +               have CAP_AUDIT_CONTROL in the initial user namespace to write
> +               it if it has been set.  It cannot be written again if
> +               AUDIT_FEATURE_LOGINUID_IMMUTABLE is enabled.  It cannot be
> +               unset if AUDIT_FEATURE_ONLY_UNSET_LOGINUID is enabled.

-- 
paul moore
www.paul-moore.com
