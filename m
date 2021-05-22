Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAC438D58C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 13:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhEVLIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 07:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhEVLIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 07:08:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4165EC061574;
        Sat, 22 May 2021 04:06:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v14so13566276pgi.6;
        Sat, 22 May 2021 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tY2f8e1mWuxZ4T+nMsDuCLX1gO7v94N8XlXOmhLqJj4=;
        b=sLCRevkkUsLwX741XRfzSu2RUZfe73tFe4Tyb+lM63mW/px+TUWevRY8tlnDeLK1vd
         oolbJiKTcbefSLJGUqw2+hB2vR6vN5LqvboCzaKn2EYcP5I+sWgUW+QXPv9spI5sJiWF
         cG8Oh4x3ypFiPGhr4yvhwlArOVXUZJeIWoJ1dZIUdrMekUmsL/SidkH5V/dhtY8TyutU
         sCInTnt8BdyF3D85za5JglGEitRJu2TaeXOgm0Ebx6FbGodWqdqqcbXhci7cOiamTYDF
         xWs+ipcs+NH0mUVLOA8ur5A/3uHSgDUJlb5mp+gkjLkLdcsuRnxHu1qjsWNOZAQ64DpG
         0hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tY2f8e1mWuxZ4T+nMsDuCLX1gO7v94N8XlXOmhLqJj4=;
        b=IeC3tehdKr6B5HTiLpbTcQC3dGCVG81clG3xbEQPDpBOJ54FtXYvLBg+Ix4jKGzYli
         0xqoptfgOZ1U6bKk5p/YvkklAp4C7yInXHbXljm8feRKlKexiXeTYnQAvjQnDiOmHpMg
         i4j459KsC1lzX2hfJvmZYctW6s6X0xmHD2l1suxhHjAvJnVCvgS/TFzf6cooReW30t+y
         Nboh0ekaa2JFI0kR/+eJP5dnUmWubomlDt+rcnqLSpI4X8/XxKVHUsQXpoAg0Ha48OFU
         lypfopwiRwAiXx4VGSTSqRpggumUj7CJM6ndvVl6HjFOc/75QthCyFlEqfdBzXglekX2
         skpA==
X-Gm-Message-State: AOAM533H/RZ6lannAlhXp04/1Hpq5gSV4fxSbMsz4NB1wpF2xG3PjmgX
        BVpFhoHnHEOJT0gaL8/dBflkylGmSo8KqmTWo71j2KsINwoXtA==
X-Google-Smtp-Source: ABdhPJwiJ3LTKU1Oq/1OVQhh5Lg/mfdMj7r3XdRdWGYrQpJiEoSnm7lYhGiK8uSAFHC0Se6wxq5iJEP7s9q0DNDISQc=
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr13067530pfh.73.1621681598619; Sat, 22
 May 2021 04:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
 <9212cdc8c1e5c187a2f1129a6190085c2a10d28a.1621665058.git.christophe.jaillet@wanadoo.fr>
 <CAHp75VdhgEEeOoJZNXu9RMR0QppDv7HZ-_Lmy4PC=ptXHaz_Lw@mail.gmail.com>
 <CAHp75Vct5cHgSDU4oQ8ScEoKviiZZgYCKN62AEy0MS=V4oGTiQ@mail.gmail.com> <1217b537-57ea-dcf2-06d8-5b5bd7bcbd5f@wanadoo.fr>
In-Reply-To: <1217b537-57ea-dcf2-06d8-5b5bd7bcbd5f@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 May 2021 14:06:22 +0300
Message-ID: <CAHp75VfQHEU9C41Jrv-a4Vw9OHBtmOStrBMNtPCh-74mj1k9dA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] misc/pvpanic: Make 'pvpanic_probe()' resource managed
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        pizhenwei@bytedance.com, Paolo Bonzini <pbonzini@redhat.com>,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 1:57 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 22/05/2021 =C3=A0 12:09, Andy Shevchenko a =C3=A9crit :

...

> I'll send a v3, but my turn to nitpick now:
>
>     Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>     Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Which one, should I use?
> I guess the later.

Both. They have different meanings.

--=20
With Best Regards,
Andy Shevchenko
