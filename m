Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8DD3D44A2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 05:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhGXDGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 23:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhGXDG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 23:06:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B0CC061575;
        Fri, 23 Jul 2021 20:47:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so6440225pjd.0;
        Fri, 23 Jul 2021 20:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bK4wXWV2w6jl9gOjwEaUE/3gjceKzZWBlAbYkJoZ0dc=;
        b=i0B4FodZBwFxzUJJoBvd69lApHhWjTVltIQElPfXSDEr6XRvTDQVLSX/4aRjHjv4wS
         tID9dv+f1ln9sUMjXR5RgRR69O0xT/ToWnKaX9DhLL2bczdFM87oFIdb6kLwFR6rwB/y
         O9Z0E+h7BpMMEjen231ysCaWiUqOXyY8LTG0pXOH0tHdZZMY52TfqB3PlzrVBCxqw9fK
         zgATthlgoqLy8a+Lvebz/HtIkgLymUlfDNI9OsLzJEk+arD7dcULkOcgJfpCMTYt+gib
         Vgp6sH2ro/Pm822LJlO/RTLWJqej8umrFjSzeXVp1XvkcQWXjkN941l2M83y/uAaLFHP
         mYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bK4wXWV2w6jl9gOjwEaUE/3gjceKzZWBlAbYkJoZ0dc=;
        b=cG7wYMB952N+GIqU0+UMj/EEL6FumzSXMBxN/diM+QoPuxTsh25IoIYy3X5rVnXS+m
         h6rFf28wGYPdzjTDqQlKNPNne0qfgXG50/10d7JKlOYDuMD8IkCx339YQ6tMKX2JKa/0
         +uVKP8SmBErHYqQAvl2IpFpG1yeIqWNoFOwTLHnaFlLG/BQVkdcZi/CdacB3T1rGfBpo
         BEMEge8pouKKce7KRIa+xQ406FJw/a+op+F5BFSBsGBBu6eUtZn8SyCSv0v95icjbIVo
         Ccu1ldcJRgPEFH+ys1w3qlQKwSIi1ooo+4fgIwh28keVxKWO1GA9Sf3XibY6ISpNssc0
         fjAw==
X-Gm-Message-State: AOAM533VfnCeYvUggs5nLZQCqsUAVw4fBBg+3t7+pnxuCV8LXnYfpPAc
        zVPwazq0tgNvtmgC8KM7GJXrttqtXykXAkiVHe0=
X-Google-Smtp-Source: ABdhPJwjeDocAzcQqLtC0l94cdkAreCmg5PMVO5RVpV3aRpx6xPMXTAxIq8Ho7pJa9tRXBP5xvgVunhM51G/ojx99fY=
X-Received: by 2002:a17:90a:8b86:: with SMTP id z6mr4852886pjn.179.1627098420403;
 Fri, 23 Jul 2021 20:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011430.404813-1-yang.yang29@zte.com.cn>
In-Reply-To: <20210723011430.404813-1-yang.yang29@zte.com.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Sat, 24 Jul 2021 11:46:50 +0800
Message-ID: <CAMU9jJrQjFdWJQJYL3E5GBCqpNfrbOLsCY=W7O6V-TnO=bMDpw@mail.gmail.com>
Subject: Re: [PATCHv2] docs/zh_CN: Add zh_CN/accounting/psi.rst
To:     cgel.zte@gmail.com
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        yang.yang29@zte.com.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<cgel.zte@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8823=E6=97=A5=E5=91=A8=
=E4=BA=94 =E4=B8=8A=E5=8D=889:13=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Add translation zh_CN/accounting/psi.rst and zh_CN/accounting/index.rst.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  .../translations/zh_CN/accounting/index.rst   |  23 +++
>  .../translations/zh_CN/accounting/psi.rst     | 154 ++++++++++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/accounting/index.rst
>  create mode 100644 Documentation/translations/zh_CN/accounting/psi.rst
>
> diff --git a/Documentation/translations/zh_CN/accounting/index.rst b/Docu=
mentation/translations/zh_CN/accounting/index.rst
> new file mode 100644
> index 000000000000..f50e81bc5e61
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/accounting/index.rst
> @@ -0,0 +1,23 @@
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :doc:`../../../accounting/index`
Now, we use the new format:

:Original: Documentation/accounting/index.rst

with this,

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Thanks,

Yanteng
