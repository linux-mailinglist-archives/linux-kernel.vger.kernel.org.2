Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B485038C98A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbhEUOxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhEUOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:53:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91584C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:52:07 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k16so20361027ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1WOzX1ssfOCVLT305+qup7nX3OjGyNBmw8hx6X3m4BM=;
        b=ChYjN/0vWSLzSRqTbW9FXhG/2dqTgYD+LrPGLs87AL6r4kA/4YjJcygIE5gTkoRxo5
         hZRvxBJ4LgwQL86g8t9iFZ0qZF6Ibev/VrOM+KhFpumNcgpPPyLoCpzjL1RMr3RAHUga
         VBjW0/iBdSVP3J+6QK34X+mj6kdUGA+vhHcfakSj0Gbd56+vcSgL3C4wzqRyklw5Uxj9
         1stWlZ8qwa2aPRwBhN8+cKTE33MS9Al2Y6Xa3i82y1O6oaNN9KrqZjVPWMEISPIXsMWQ
         awD9xjxv9o5UfNB8MABCeKjDnvHzMTkvSQSiTNAZA4Wza+u+4sqCkbrFLur8bVj9ZL+J
         +eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1WOzX1ssfOCVLT305+qup7nX3OjGyNBmw8hx6X3m4BM=;
        b=UZObCxBYCTIwKMl7uJJ4YeMvurKu5xdeFTl4/s73islZTqiOAr78CnVwVgHQ+T9Bfs
         sNPjKm7tWVS+qNEc9otbRlcqTXUU8AaZSbI4v6CD4WKMPzDGMI3gh2/W1WVcl3AHO3qs
         kPw+C8NsGfTgHCUoK9515/lqQPFgpvx40pHRvS3lHqmaJWWeIqdSHw2TxT4ui+K2AFji
         pOiuaXAZcdqPP7CHtQEHnvbctDwO3Qo93nTLhYvGtmCd8fzPZPf84qCgQbZVv4g/07RV
         eXLT1bg+dsSmsG25WvfEEYJLDMCzzFmuHNWpqx70Hsqw3WMVhEgSHYfB4kqntW6Jqq18
         OinA==
X-Gm-Message-State: AOAM532Z7ofrG2y0S5xv5kGRyScSZLQCVfXjrxtF2d5y06Gx8RetH4QJ
        gk/iLc/sBNpmLH0HWsEPbhREYexNJEr9JxnKcao=
X-Google-Smtp-Source: ABdhPJz5ZK5Cl893tSm7A+JLR46SRws+ZhtNWD+Dv2BnTIbbMNSB2DCo+09BHHDMCXq7PAI3s5mVc8DFnb9unTc+Bmw=
X-Received: by 2002:a02:3304:: with SMTP id c4mr4974079jae.68.1621608726828;
 Fri, 21 May 2021 07:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <cb099c69-0d59-7a12-b0bc-2ce71264363e@canonical.com>
 <20210518192820.181500-1-ztong0001@gmail.com> <YKerHVMuqnRQmhMz@kroah.com>
In-Reply-To: <YKerHVMuqnRQmhMz@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 21 May 2021 07:51:55 -0700
Message-ID: <CAA5qM4A+hvA2aHJcmnjKmDvpgQgMnq7EQYp+-hRoT4HGH1KpLQ@mail.gmail.com>
Subject: Re: [PATCH v4] misc: alcor_pci: fix null-ptr-deref when there is no
 PCI bridge
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 5:44 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Please just send a fix-up patch instead, I don't want to revert and then
> add this, that doesn't make any sense...
>
> thanks,
>
> greg k-h

OK,OK, got it. Thanks for letting me know how to fix this.
I will send out a fix-up patch as suggested ASAP.
Thanks,
- Tong
