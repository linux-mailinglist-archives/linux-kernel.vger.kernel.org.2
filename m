Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8A534A08C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 05:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCZEb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 00:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhCZEa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 00:30:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A3C0613E1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 21:30:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r17so3810477pgi.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 21:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=35XopTC+7WOzIQnHzWXImRYQHw0CHWkdoXHcf/+9Onk=;
        b=FuXqSLOY5UJibY4x5cy44xNCqVYXhs/QB8SAK6Ph5plXJluUdlmzkl2vYUhpV/m3iz
         fBwsgAxyhUwk4l2OzfotcXS7ilTz5vz/4D0pRkceuJfu6MDHX6kEBtNhBX+0z1Q+x9Rq
         gJAq/6u1b6zvaFaFWLn9VBJN47ayz/H6CG+SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=35XopTC+7WOzIQnHzWXImRYQHw0CHWkdoXHcf/+9Onk=;
        b=YjwS7ZTUX5sbAhseZ4qUtfL1Ay4W44olyDwk3tJrMEjz2darzX31JZ9jl67q625frl
         aP2GJAp7p6Eg74n2xP7MQeCr7SHQTtejjY5PQ9Og51idMJSWe9KrmbhsZ7WIbBrPSTVI
         SDoBzD1OoxXfeFGbcZP4mh2ZmXF+o7KIYWttFHSH02Zj607B/UjOa56t9vCvEys3c8Bb
         FAUjAtscXgyFt+Db0yUJZ+3ESBeg2otK9UjrWLUA1539oqtcRUvDZRsGDMEvvEqFAwLq
         o8ul+2zpJbCdQrKTME15BBZy2iefStbY/+IiIkmT+Pdds5Xn6ilfThIImHew+KJHgnWe
         obnA==
X-Gm-Message-State: AOAM532z79p65rCrnoujUW9ho5GUvDhqR5U1hWYdRVuDCr30Vpit/JJl
        fM0LZtNabqfSM3jyg91h2PfvbQ==
X-Google-Smtp-Source: ABdhPJxJ4Uh8qq7VGivmsaxoe1yrWQkMSLzdjT7KyXHUDkthLjeUOIqUGrr9oa/zfMmenb3JnsesWA==
X-Received: by 2002:a62:7f86:0:b029:20a:a195:bb36 with SMTP id a128-20020a627f860000b029020aa195bb36mr11204021pfd.4.1616733055463;
        Thu, 25 Mar 2021 21:30:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1sm7098940pjc.24.2021.03.25.21.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 21:30:54 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:30:53 -0700
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
Subject: Re: [PATCH v31 10/12] selftests/landlock: Add user space tests
Message-ID: <202103252130.54C78E4@keescook>
References: <20210324191520.125779-1-mic@digikod.net>
 <20210324191520.125779-11-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210324191520.125779-11-mic@digikod.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:15:18PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Test all Landlock system calls, ptrace hooks semantic and filesystem
> access-control with multiple layouts.
> 
> Test coverage for security/landlock/ is 93.6% of lines.  The code not
> covered only deals with internal kernel errors (e.g. memory allocation)
> and race conditions.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
