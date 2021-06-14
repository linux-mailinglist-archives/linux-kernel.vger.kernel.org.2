Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8394F3A7239
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 00:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFNWxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 18:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhFNWxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:53:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D29C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 15:50:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso1001870pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 15:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aciRkOzayHTWrTzSJKmVf13JrZoWxtea1Rx5Gqhhjmg=;
        b=nIwp+FZxbhehtXuzhGjb6YSm7hYtx2sK8E76UiJ5RWfCYIPYLLGpUB7odZ3pY6zsSv
         MgZhR/qK5xP1/GaERZvUSbyzt9nXy1Z26iJ6XYs/rswA09QvHCRH1Zm3w8c7Iiwk1CQV
         qLnd5kMTVtgJ7vCLk1aVpVW8+o/q0Sae0xiY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aciRkOzayHTWrTzSJKmVf13JrZoWxtea1Rx5Gqhhjmg=;
        b=m0gF+5gN34EW/8QMX8DP+2oxgqk+zF+BZDnGJzBYMn+8ayMKN+yS1R4vgGSnD9TCl5
         yuWB8L+FETdxgOa6i9RwP79hqp9lrrJ205o0KoEoNJJ6E8pXq2SWto3f7V3Ve3Fwna1Q
         40n5tgwqFjaKMnZRJxHD+6E0bYrxnJ6LQeRqDTb1XtIenoH/fkYM347TSFKR2KAR5TBU
         SHPSVntVsVn/HiYeKxv0npF47FJ7RoawooHD/7UMOx3NG9+SOT3LlPUyyv6QrY1iKScM
         xeYIwfmRyylI/3l8DcEsQWvPKnEv8zVu9mVDnMXWQsZfXNaHN5Z4noVmN2aheUt6MilL
         yYMA==
X-Gm-Message-State: AOAM53270j8O5uHeaqtuti8+zi1qQ8/RP5sb3+4OU3F9DhYXhu6K5AiL
        zQ3AGia8KR4o2ou5IQglNdT+4w==
X-Google-Smtp-Source: ABdhPJwpQvuLgIPeiP/70rxgicnMCOhXHbg3vIOZOxpkA7GVBdOBxrKghch1YeGH+GEgoNG2dpP50Q==
X-Received: by 2002:a17:902:c651:b029:118:896f:cead with SMTP id s17-20020a170902c651b0290118896fceadmr1287574pls.29.1623711052271;
        Mon, 14 Jun 2021 15:50:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8sm13816594pfq.198.2021.06.14.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 15:50:51 -0700 (PDT)
Date:   Mon, 14 Jun 2021 15:50:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     youling 257 <youling257@gmail.com>
Cc:     torvalds@linux-foundation.org, christian.brauner@ubuntu.com,
        andrea.righi@canonical.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] proc: Track /proc/$pid/attr/ opener mm_struct
Message-ID: <202106141503.B3144DFE@keescook>
References: <20210608171221.276899-1-keescook@chromium.org>
 <20210614100234.12077-1-youling257@gmail.com>
 <202106140826.7912F27CD@keescook>
 <202106140941.7CE5AE64@keescook>
 <CAOzgRdZJeN6sQWP=Ou0H3bTrp+7ijKuJikG-f4eer5f1oVjrCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzgRdZJeN6sQWP=Ou0H3bTrp+7ijKuJikG-f4eer5f1oVjrCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 02:46:19AM +0800, youling 257 wrote:
> I test this patch cause "init: cannot setexeccon(u:r:ueventd:s0)
> operation not permitted.
> init ctrl_write_limited.

Thanks for testing!

This appears to come from here:
https://github.com/aosp-mirror/platform_system_core/blob/master/init/service.cpp#L242


In setexeccon(), I see (pid=0, attr="exec"):

        fd = openattr(pid, attr, O_RDWR | O_CLOEXEC);
...
                        ret = write(fd, context2, strlen(context2) + 1);
...
        close(fd);


and openattr() is doing:
...
                rc = asprintf(&path, "/proc/thread-self/attr/%s", attr);
                if (rc < 0)
                        return -1;
                fd = open(path, flags | O_CLOEXEC);
...

I'm not sure how the above could fail. (mm_access() always allows
introspection...)

The only way I can understand the check failing is if a process did:

open, exec, write

But setexeccon() is not doing anything between the open and the write...

I will keep looking...

-Kees

-- 
Kees Cook
