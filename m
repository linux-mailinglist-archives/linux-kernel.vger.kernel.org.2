Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B042843CFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbhJ0RrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243368AbhJ0Rq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:46:59 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42842C061348
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:44:34 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id m184so4750031iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=reqXnAkyYZJHyySejk8iQHJg4nb4uVEfEk866WL40JU=;
        b=QSNMT8nysz2zJ8AWcvDBEDN9piJ6091u6zSSvGadCME4aJkkwxe6/nPWfimZ2Hdhmq
         7Z1w6i2kW/T/cWUOnUqipo76jWPkT+oKWWGgNBeTX+2TQa2Yva9hw8i9cLciVdEQHQJS
         4lBDPpkdZVApoOaHB0f23O86esuXYN6b5oqc0xuih7k8QhW8JaHQbWBIiTu3KSEYLRbm
         ICwosqi9Xg/JZXadpjhHsOLmyy+1VQErRThtyfnYTPJJLP9uaJB8DyQnJKbNTCkXG4I0
         dOqm7PN0SFxwwhbAwwADYosm+3SP5f8qk3/eOgm10eZJnPuRsy15k5xLGd4gIXeY8dka
         mbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=reqXnAkyYZJHyySejk8iQHJg4nb4uVEfEk866WL40JU=;
        b=GNoZjGQvLfu5smnN+A7FAOqHVac8cde9w32QuxVcfQ3sYpFhx+5M+AlTI34OzaXnk0
         AMBbvJEzGIYF1DB6VdY47iZdCFah2DP/wlxc/u0TLWjmTArZ2wupp6zlvvXjFEnBDrPJ
         yilLDYQT3fbOeqTrsjuTdgBqRLNKA3b1SmixEYRI7YLdTjafedcQQl31oLeT8boi3epi
         Pny9iR8Jgb2csZP4s70DYHMqXGEaoyn9lnKZBQHnJuFdYdUbaBXP1+kte3BpENQzA/1u
         IOwhIH4tCXiq6IfKqmi29hX3JtpgpTj5oc9kA0qNmpNYzOiI7nVPUDv8Gte8gW6Ugh+y
         kI3g==
X-Gm-Message-State: AOAM530xM8eD3RgHGw11oRgb1kC4nX/jxdWUdZLlGehX4PdjM4p44bXq
        Kysk+XDrJKP7t/MH7ZibRw5quQjMqRxNi5DkP7Q=
X-Google-Smtp-Source: ABdhPJx+VpEoAGXmZu9PfY2G+y5/z2rX72uWoSoI30y8fqkmaGlxVp7jf/6lbORqHOa+8VSQJzRIqD3wLLwanGJTZKU=
X-Received: by 2002:a02:8565:: with SMTP id g92mr16207057jai.29.1635356673646;
 Wed, 27 Oct 2021 10:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2CkAWjS8=kKwEEN4cgVNjyFORUibzEiCUA-X+SMtbo0JoMmA@mail.gmail.com>
 <d8434a1a-b813-958f-69d7-34007faa49b7@deltatee.com> <CAD2CkAV8fWVPdtoxzf5w-q_411Zw_Rwm1QGuz3-Li7eFXehktw@mail.gmail.com>
 <3747d7c3-0cb1-c9b7-8eb8-4d0b167e03fb@deltatee.com>
In-Reply-To: <3747d7c3-0cb1-c9b7-8eb8-4d0b167e03fb@deltatee.com>
From:   Marshall Midden <marshallmidden@gmail.com>
Date:   Wed, 27 Oct 2021 12:44:22 -0500
Message-ID: <CAD2CkAVvgZU_nFYyjhg6ArNjgxfRvzGbVo0WPHf5+NyaVASJzg@mail.gmail.com>
Subject: Re: v5.15-rc7 AMD no kernel dump, spews "scsi_dma_map failed: request
 for 36 bytes!"
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try number 2 with plain text definitely selected.

Forgot to cut and paste -- interruption occurred. The
"vmcore-dmesg-incomplete.txt" (this file is created before the vmcore
is taken, and then later in the process, the vmcore-dmesg.txt file is
created).

AMD machine after taking dump and rebooting:
    /media/parsecdata/crash/127.0.0.1-2021-10-27-12:06:53:
    -rw------- 1 root root 5410206160 Oct 27 12:06 vmcore
    -rw-r--r-- 1 root root          0 Oct 27 12:06 vmcore-dmesg-incomplete.txt

Intel machine:
    /media/parsecdata/crash/127.0.0.1-2021-10-27-12:12:33:
    -rw------- 1 root root 5482529464 Oct 27 12:12 vmcore
    -rw-r--r-- 1 root root     236525 Oct 27 12:12 vmcore-dmesg.txt


On Wed, Oct 27, 2021 at 12:24 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
>
> On 2021-10-27 11:21 a.m., Marshall Midden wrote:
> > Yes, the spewing of messages stopped. Kernel crash dump taking is now
> > occurring.  Patch applied to v5.15-rc7.
> > Reworded: THANKS!  Patch works!
> >
> > Dunno why the dmesg isn't right, but at least there is a core image!
> > [I updated makedumpfs for v5.15-rc4 -- applying a bunch of cifs/smb,
> > qlogic, etc. patches and was getting ready for new kernel release in a
> > few weeks -- couldn't debug a cifs crash. :) Down the rabbit hole...
> > ;) ]
> > Intel machine booted, etc. and it has a dmesg correct. *sigh*  I don't
> > think "I" need to worry about that. Someone else can report it.
>
> What do you mean the dmesg isn't "right"? What are you seeing and what
> are you expecting? What is it that someone else will be reporting with
> Intel machine having a "correct" dmesg?
>
> Logan
