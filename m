Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0730671B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhA0WQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbhA0WQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:16:40 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:16:00 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id v190so2667968qkc.15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nMvW9sCogvCQk3Z+FvTaolhNqJWAlRopE1dL8mD/EfM=;
        b=XabaZr51cxeVUNojdcIqjRe6bUepIDvJQtPM0wT7pGFP6YgPydkBjs45hRKKl6wAx2
         f+R5m/9IWnpxCMiLjlprYlhVQFrC+5CKHwcjdip7Vkt/KLjJKkrkGbxg61UieoIiUILx
         gmM3zOCAsPd+PQT5AzJHRnwSu4+GByKO4ea1z7p+wb0qhgrhCkIVp+0b0YjKYhyEsb6c
         rFt6j2h6OqzGbC1f5rCGLaZOUom6GerytFMyK7S8VH2Arad07pUUgx8vWq2M+gOQdQt9
         EJdwH76rsjIvforkattkvFzUHWRNXC15PDQDmrNzW8KVDodG6IGo5LGXLIFyvoKTijgS
         JBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nMvW9sCogvCQk3Z+FvTaolhNqJWAlRopE1dL8mD/EfM=;
        b=JiY5Ki8KciWlq/UuSnlYVjVau18a6XnTHdQs3LufJynVhr957F4xCW92h5MPyj/Sd4
         FFOC0qZl9oDr5K7/nnMxXqOzwYBBED5unyiofOXzfxsPVF3CieG77DLs4POgE2tSoPoR
         3EVYyx76NJmAjRwPNyHOI7icLCyAZLWhuE+2SCw+Eh4fFzedNc4mW67ttTEcTfJ0OEDV
         Ft+N2FcpeojwwrAOpnb0gHX6nEjyoZWjGO0yS/SMfhOUOXm+HvOARO6it7cOEG7xoPhH
         MhhquNdA8n5HGRQOvmKeQj+mg03UT3oOAMtnPNGPBa49zn6ZmFDSOw/AQyFSk6b+GXwv
         f+SQ==
X-Gm-Message-State: AOAM5328sWhomg6cH/S8qJLj4D2Sypwcr6qF34OSlTzijAK3eYKCJkHl
        yPSlAz2UQwmAee9YugETv2wMS0wLAf0xpsN65cw=
X-Google-Smtp-Source: ABdhPJz7J2G6u1AIImLhrSDhwzedx39UPabhVKQcdZxwaHSdva5MN+PnhrmVByfJP0/dWGSG5HSuKEXBRBBQU2+tB84=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:fe0b:: with SMTP id
 x11mr12660475qvr.18.1611785759532; Wed, 27 Jan 2021 14:15:59 -0800 (PST)
Date:   Wed, 27 Jan 2021 14:15:57 -0800
In-Reply-To: <20210120173800.1660730-13-jthierry@redhat.com>
Message-Id: <20210127221557.1119744-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210120173800.1660730-13-jthierry@redhat.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     jthierry@redhat.com
Cc:     ardb@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
        jpoimboe@redhat.com, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, peterz@infradead.org,
        raphael.gault@arm.com, will@kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Raphael Gault <raphael.gault@arm.com>
> 
> This plugins comes into play before the final 2 RTL passes of GCC and
> detects switch-tables that are to be outputed in the ELF and writes
> information in an ".discard.switch_table_info" section which will be
> used by objtool.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> [J.T.: Change section name to store switch table information,
>        Make plugin Kconfig be selected rather than opt-in by user,
>        Add a relocation in the switch_table_info that points to
>        the jump operation itself]
> Signed-off-by: Julien Thierry <jthierry@redhat.com>

Rather than tightly couple this feature to a particular toolchain via
plugin, it might be nice to consider what features could be spec'ed out
for toolchains to implement (perhaps via a -f flag).

Distributions (like Android, CrOS) wont be able to use such a feature as
is.
