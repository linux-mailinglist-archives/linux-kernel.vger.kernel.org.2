Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16B41AFB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbhI1NRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbhI1NRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:17:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7979C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:15:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so1717266pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aolHsLxiI3WCUZmb1av0qGsyGus5Ej0uRV0XSkfqb7A=;
        b=Ysr/3EQufajPzxdLCpIovF/FtHxpHpBi7gxq+8UjyKy3t3/iusmG1dCun4JapnPja6
         3cv65wSt37oPBM5RX/f8drZDAAprZw23PQaOaXmVhXH9ykDA7k1UU6WD7ahExMBx9u3T
         jxxda3D7YDx21nKGJbvtOgfApKEtDR9E/LnNcZ0o0l39M+O2atOp5kfsxtm9z+WIGNHA
         RnarK292CXfO+9azckWgLxIpstTIftBcvj6Mg3tvQ1VZxCFcEG5yz39k5xZrgbadjLq+
         epxAbwaxQbIvkvngrlpM3nTjuv6fsCmD7wLNP2IcSpGmxIbH5g986/dsZWlslBXCK3Mv
         IW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aolHsLxiI3WCUZmb1av0qGsyGus5Ej0uRV0XSkfqb7A=;
        b=vzj3VnymXZZFxi9R9eZsOFbTCvl7QXUI6ZQLboQfa1S6uKo6N8Z/GbleQgeOiaccm3
         8fZOtlGwN765PheID9zKhO91BZXMWgwku7/Fn1DshulicPKT5tkRkWTuRUMw6V1AfTNn
         JTPiYM98/Py2bz3l7pXF1NQfbE8jDI2hMhVLbcGx89SRX+8XZw0yIZy2FNo1rjIU8Ccf
         HT05v6O/ddXMRwJYt2roQxlZ3c9LaDjTmSwK1GdPI7sQCtKr9od4V1R/cePQVxYOp6Ba
         X03GFTi/f6ld5iBBkHesy9+4oV/rpGgG6bnXGkNVrKQEBvuRJ4l3BZqZ07hPIIPYg41/
         CHcw==
X-Gm-Message-State: AOAM532DCa8ITN+i/WfneeRqIDdl/r/MK+WvgjanFktziQLds8ZtnbeW
        huX5LbsMa4zfYhvrpIy+y0xkxYWw5ldhi/hZk50=
X-Google-Smtp-Source: ABdhPJzkSgNPblo0TDMbe+/cWcYqKjFUhRzj+hVARJEkJ4DR3QtSJIsJnCq1rTvo+Cjzd9rq6swp6nd9VuyiGar6T6Y=
X-Received: by 2002:a17:902:e54f:b0:13c:a004:bc86 with SMTP id
 n15-20020a170902e54f00b0013ca004bc86mr5021929plf.78.1632834938271; Tue, 28
 Sep 2021 06:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <a0e1c245-8209-a173-18c4-d21433bf46bf@forissier.org>
In-Reply-To: <a0e1c245-8209-a173-18c4-d21433bf46bf@forissier.org>
From:   Volodymyr Babchuk <vlad.babchuk@gmail.com>
Date:   Tue, 28 Sep 2021 16:15:27 +0300
Message-ID: <CAOcqxo339CS63i5sMdweqx3MO7ME9TxFPJe-p-ESWME=vSzLwg@mail.gmail.com>
Subject: Re: optee: regression with kernel v5.14 (virtualization)
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, 28 Sept 2021 at 16:08, Jerome Forissier <jerome@forissier.org> wrote:
>
> Hi,
>
> I met an issue when testing OP-TEE with the latest released kernel
> (v5.14). The kernel won't boot when virtualization is enabled. More
> precisely, the boot hangs as the optee driver is probed. The last line
> on the console is:
>
> [xxx] optee: probing for conduit method.
>
> The issue can easily be reproduced in the QEMU OP-TEE environment as
> documented in [1]:
>
> $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
> $ repo sync -j10
> $ cd linux
> $ git fetch github --unshallow
> $ git checkout v5.14
> $ cd ../build
> $ make -j2 toolchains
> $ make -j10 XEN_BOOT=y run
>
> [Note, if you switch between XEN_BOOT=y and the default build, you need
> to "make arm-tf-clean"]
>
> git bisect points at commit b5c10dd04b74 ("optee: Clear stale cache
> entries during initialization") and reverting this commit on top of
> v5.14 does resolve the issue.
>
> Any idea what's wrong?

Yes, there was a small mistake in the mediator. My colleague already
pushed the patch. It is at staging now:

http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=1c3ed9c908732d19660fbe83580674d585464d4c

And will be backported to Xen 4.13+


-- 
WBR Volodymyr Babchuk aka lorc [+380976646013]
mailto: vlad.babchuk@gmail.com
