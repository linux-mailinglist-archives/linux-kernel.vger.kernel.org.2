Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F703194AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBKUmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhBKUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:42:06 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA87C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:41:26 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id g5so2182778uak.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqZZZvFE5VxL++dFfoZprDhk9+CSenhmKTyUPdyCU/U=;
        b=JwpYmrz5Pq9isvSseBiUCn4eQXQyfBr2OxOXWrBy7tw8o+XYqRFK+R2ucZp0cFdhaK
         A4sSR+eNIBHOfYKj7ZwwWoMNYH1qP8OtXTYlKygnib3yOBIkWMO2BAsEd4R0rZWVDrU4
         UQB2CNI9KgTkaZW/msOwTE9FUsXlVrt18/mRJUzfFqEXYlrgLt0Vxwx1wDYe7v4b0wKV
         rJ9yO9NLkvzKJHpcirJ1nQVtIIu9dUAgZPIFkDx86PTwZf6zFB8pXXDqiVLhBjiSGy1W
         3Txd7anedzyRr7l070exCjtnnQVhSA6MSHFx8e3l2nPByd1zdHNBPvjCE2cIpGXPRd8K
         kGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqZZZvFE5VxL++dFfoZprDhk9+CSenhmKTyUPdyCU/U=;
        b=tSiTCP9WkCSvf14Gc9wFf/zNHs+If3542uQe+k0G1I/h0lKnYtcSP1BWBLLqE/LjQU
         WoYAv9LBBYwB8poEUL/kDYW3pPKTl37vnqgOBmtPSEnqLynYRS1ZHz2BgK3JZO2rZEOi
         3MtiOjApoWEpwymYOv+FE9Mmz/l2rToJCnu8yjmnk9CWVXUGv03Q/7Yxoz+TvZm9YtW/
         or50aP3Pl62zjnVKvvCABjbQ5JBhALCzDf2VL1POCrR7c+hzctQPJY5/bFEa8W0e1jXd
         7NafS5INuKAVFpTPq0jnZnjB50AQXy1RARb1WjB8Jmwo0TJhf8QPBspp/Et7LboKU5RX
         K3GA==
X-Gm-Message-State: AOAM531/uIVrsUpScZ1fCtdeoQUvd5BQVhKIdQ9vxsavh2eGJN/Y87G8
        voH1eKeUeQoSRaPWTJeF8w6U/O6+MWrLJh37+kp0aA==
X-Google-Smtp-Source: ABdhPJzIm5VtW1C8leqxolWHrGOE0VBLS/CwbuSyepxQoy46V+/+2C4/k7slInILzPb1rPE6aCMUoTA1e2xrIj9H8d8=
X-Received: by 2002:ab0:2448:: with SMTP id g8mr6669684uan.89.1613076085437;
 Thu, 11 Feb 2021 12:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20210211194258.4137998-1-nathan@kernel.org>
In-Reply-To: <20210211194258.4137998-1-nathan@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 11 Feb 2021 12:41:14 -0800
Message-ID: <CABCJKueyXp5EQnmZ7a6HR87oKwDBDukprnJWT620McSYFd1SMg@mail.gmail.com>
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, qemu-devel@nongnu.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Thu, Feb 11, 2021 at 11:43 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> which violates clang's CFI checking because fw_cfg_showrev()'s second
> parameter is 'struct attribute', whereas the ->show() member of 'struct
> kobj_structure' expects the second parameter to be of type 'struct
> kobj_attribute'.
>
> $ cat /sys/firmware/qemu_fw_cfg/rev
> 3
>
> $ dmesg | grep "CFI failure"
> [   26.016832] CFI failure (target: fw_cfg_showrev+0x0/0x8):
>
> Fix this by converting fw_cfg_rev_attr to 'struct kobj_attribute' where
> this would have been caught automatically by the incompatible pointer
> types compiler warning. Update fw_cfg_showrev() accordingly.
>
> Fixes: 75f3e8e47f38 ("firmware: introduce sysfs driver for QEMU's fw_cfg device")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1299
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Looks good to me. Thank you for sending the patch!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
