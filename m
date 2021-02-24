Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C01324391
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhBXSJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhBXSJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:09:51 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE95C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:09:11 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z18so2522492ile.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=dKCWFwCtere4GZoadEUWnq7pobLJDcHFCquipMb1ruk=;
        b=hqke137REPFIk08X26O9Qf6S+JDQmGikbvjBbxcfEot4DctxH36v/1Z0sUISy5h2Nx
         3yUSceQyhSUXD1D7HmWMC4SbfTDFC98ZtgBdyo8N/CEM148DdmxO+n0yvPcEF9s4ky2E
         2KtG48ooopFe/gzIzAYS8EVjSdc3gnkI9piiA0iLkRGI+u+/fkxcFYxJ2uFsATFFoJ2k
         56R1JJnJGBTGNOyay/sPvXzGIDii9vZe3SXMIru02NOewoZc1kTF+VUg/Y9dLSuLe5wp
         RbRZH3n0RJGhAvAWTVooLr05i1lD6pZE02ZRyhqC6+AaghfThafHISJnaH7imAEHE4x3
         11nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=dKCWFwCtere4GZoadEUWnq7pobLJDcHFCquipMb1ruk=;
        b=WwunH+CwOmRI5Z1mXZkfdIpefOfkybIJrn+u64RPNdwRCKfvbxbHlswo/X3uNWghPz
         W0tsB5GDviNARhSet/g6cxkL5zYcJ5OBOAYXDl82oBskECAPN7GjJPK+x/Cw8G9PCaEd
         S4P6WurZgqec4XusvrM2oGFPWzhbWBBEhZMhrxvR4/DIhwD89r4vK61aU3COCHMr69Gq
         2m+3GRoHZkMvnZP4SZxCpPFKs/igO/RwgP0PRLF3tv70LvHcv3SdE9XFzzNR/NCEoxA/
         IXHnoo6l2OZzVF8pbun6ZW5lfeCRiNYmT/K+Ls21EP5BXtOTjD+P2xtr8qNSwgukx2zx
         9l8Q==
X-Gm-Message-State: AOAM531RwWXPTXhcL/ebdqaZ7W+MG2hPpw04AwkC4GDIhTNsDDHGAOeP
        Stc58UuL1g6bbkZce52g9JKlKs9mlvmi0EWNjzg=
X-Google-Smtp-Source: ABdhPJz3GIBdgA4zHbgVmxKw9YsFP/tLTYz2tkBhM/AiHwcN92PZFP+mitQPKNwLrlEkglorYH8lYc6zOj657BmjvVA=
X-Received: by 2002:a05:6e02:13a6:: with SMTP id h6mr14196474ilo.10.1614190150784;
 Wed, 24 Feb 2021 10:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20210211194258.4137998-1-nathan@kernel.org> <CABCJKueyXp5EQnmZ7a6HR87oKwDBDukprnJWT620McSYFd1SMg@mail.gmail.com>
In-Reply-To: <CABCJKueyXp5EQnmZ7a6HR87oKwDBDukprnJWT620McSYFd1SMg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 24 Feb 2021 19:08:59 +0100
Message-ID: <CA+icZUW=GTV0L884wdohaOdFmg4E4wdtSEOgF+KEGPcKzYOoow@mail.gmail.com>
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, qemu-devel@nongnu.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 9:41 PM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Hi Nathan,
>
> On Thu, Feb 11, 2021 at 11:43 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> > which violates clang's CFI checking because fw_cfg_showrev()'s second
> > parameter is 'struct attribute', whereas the ->show() member of 'struct
> > kobj_structure' expects the second parameter to be of type 'struct
> > kobj_attribute'.
> >
> > $ cat /sys/firmware/qemu_fw_cfg/rev
> > 3
> >
> > $ dmesg | grep "CFI failure"
> > [   26.016832] CFI failure (target: fw_cfg_showrev+0x0/0x8):
> >
> > Fix this by converting fw_cfg_rev_attr to 'struct kobj_attribute' where
> > this would have been caught automatically by the incompatible pointer
> > types compiler warning. Update fw_cfg_showrev() accordingly.
> >
> > Fixes: 75f3e8e47f38 ("firmware: introduce sysfs driver for QEMU's fw_cfg device")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1299
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>
> Looks good to me. Thank you for sending the patch!
>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
>

Environment: Linux v5.11-10201-gc03c21ba6f4e plus Clang-CFI as of
24-Feb-2021 on top built with LLVM v13-git.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -
