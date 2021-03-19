Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4480934252C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhCSSqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhCSSpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:45:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE41C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:45:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso7113894pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sb8mG2TwoLcJMKUkEkVhAmXUHbnUNYxK1v1iC8KimUA=;
        b=CmUS9RcCmK5o96Fk6zyoSVLADipDZJ38jBX+VRx8vf9lsD2CgWWYfDsPUIj3QczMWR
         AaiQadC5iuMOJEZRtQ6ZIcrfB1K5dnxHEEaSckKGDMsCD0J7OswnuO4wDM0nDIwrNKLj
         2OqV6blXxkO3bm9u9mMktQ68Ql9zMUKo57h4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sb8mG2TwoLcJMKUkEkVhAmXUHbnUNYxK1v1iC8KimUA=;
        b=CebRC1FkRPMRElbayS8RjDAh0A5w8mxLQR7eNzlMR+2Sm7h/63WGjGbyTuqCLRfgwT
         Hbt4RQYoaF8zdCnvb5gaJUuwq9vX+vLO5F7EzBxq+rz+igUOtluURunKC+OIYl5waB1Q
         VGoYzEIuGJFOCJGuX0fT2+P4M4qWUQtxB3zOZMB8oMVXiOknHPuhG3Y2Bhyy6nt08Ny2
         xlJHHS4Z21lw5UOHgjz8ahEpM0/W3b/GKQUd22xOoZdK2+qCME5X2N73BfxtbkQZByL7
         ST6Cx0CRYNpXs+0pw7/K78UqTAB6EQpgX3aya3l+zyR/3RKdeKVw1JB6Q6sLpeyeKUEI
         g0iA==
X-Gm-Message-State: AOAM533EEGbPSOcZQQTURD8MfUuiD8Hzcu+YqcIzsPBmc6hepShARLcw
        fYfs2HxBhY8q7E3680nb095XYg==
X-Google-Smtp-Source: ABdhPJwxrFCu/tr6zG57P/oXPpC7+dmNq8+B1nfLURKK038KTmr5VVbtL8LNWxfd7fIU6Fty2w8R/g==
X-Received: by 2002:a17:902:d481:b029:e4:8afa:8524 with SMTP id c1-20020a170902d481b02900e48afa8524mr15809510plg.52.1616179515805;
        Fri, 19 Mar 2021 11:45:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 132sm6172474pfu.158.2021.03.19.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:45:15 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:45:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v30 03/12] landlock: Set up the security framework and
 manage credentials
Message-ID: <202103191140.7D1F10CBFD@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-4-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316204252.427806-4-mic@digikod.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:42:43PM +0100, Mickaël Salaün wrote:
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> -	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> -	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> -	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> -	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be ignored. This can be

There was some discussion long ago about landlock needing to be last
in the list because it was unprivileged. Is that no longer true? (And
what is the justification for its position in the list?)

> diff --git a/security/landlock/common.h b/security/landlock/common.h
> new file mode 100644
> index 000000000000..5dc0fe15707d
> --- /dev/null
> +++ b/security/landlock/common.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Landlock LSM - Common constants and helpers
> + *
> + * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
> + * Copyright © 2018-2020 ANSSI
> + */
> +
> +#ifndef _SECURITY_LANDLOCK_COMMON_H
> +#define _SECURITY_LANDLOCK_COMMON_H
> +
> +#define LANDLOCK_NAME "landlock"
> +
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif

When I see "#undef pr_fmt" I think there is a header ordering problem.

> [...]

Everything else looks like regular boilerplate for an LSM. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
