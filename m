Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E9351814
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhDARnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbhDARhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:37:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB42DC08EC98
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:58:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x21so2079606eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGU7ZT7+8QwMgBJMRItGXfNyZM26bXJF2/PUv7FUxvY=;
        b=kFf5WxXSV8o5rrKUe9NTEmUHHVbwMmBKUNPdC8hm2AibPzleJMNa6EfFTqYFT3jLJo
         Ij+/GP6hz25LttAZB0xQcVu9eUrwOZwAQsim0kHA+IutdyK6H8c1TNXH1FlZLd6z2Swl
         HFtoJ5CXsz/ttyzp0NpD1iGKmEJdd9g0hbtGWL69PQCg+MMSB/vTpnM7ZHLjnpoGnoFz
         /JJ1/N+OEwNTsffJ6aHYpGUioIW/YaYuuqTbu/YagPj8uAs4SZABuPzTOuX+zRR7L73J
         IPgu/uQrfDsRNNbTqW2VMPGnWJQswtm8KrfQh+9kXQRkYi8TD9J1+lg0ncpnxYBnBGm+
         UsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGU7ZT7+8QwMgBJMRItGXfNyZM26bXJF2/PUv7FUxvY=;
        b=d1xjz4rzPalzuchaUf7F5Tu7gpPUCj8BtBuCFKsRCbYACDoHDaFiSKwDVnHa7eqIYd
         rtnNHd0a6Pln/kt6jjnM3HGdrc7yE2Y4KRptJlHiT33TCpe3Eepp5690bPxfhfscTMyS
         4u/pTrAJi8OBpqvjWRQlfHl44ZnpiG4s3Upl5VCrW1Ub4L719adDmYq5dvHXFh3z0WUA
         pBkLM8UhoQgiFYkbn+YTSwwbxm81QpkMdk4AgYv8NpoBkwgWPZtgRGpemEZmjK96GXDX
         xa5q6yu1gc9STdpxass6DKpL6Pz3dH107USxRm7vjLnkoqLPiZ3JFtbMvYJKp/M0I1hh
         WI+Q==
X-Gm-Message-State: AOAM531bdMx+a+QnkNV+wjM+No4mVrMqPygRL3cjKA2Y9RH+xd9kpZat
        rnIOzhBqwY6bbdgv/g/iB8Iu2dddNrxqIUQ6WzGT
X-Google-Smtp-Source: ABdhPJxw4nDiadCckjeSPqlBGtvIBsGhzqc6ScATkGiOfkdigUx5G+2vuz33V5RwX3qH4QaIJiehDxQTSjCW14KNGZg=
X-Received: by 2002:a05:6402:105a:: with SMTP id e26mr10077031edu.164.1617285486539;
 Thu, 01 Apr 2021 06:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616095045.git.rgb@redhat.com> <14139c54992a4b50448fbbf07ebbfed743e09f3a.1616095045.git.rgb@redhat.com>
 <20210401154827.2f801300@coco.lan>
In-Reply-To: <20210401154827.2f801300@coco.lan>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Apr 2021 09:57:55 -0400
Message-ID: <CAHC9VhQ6d7_gX2dWSK9Wnk1p+w+1yOPb=Yf8fTCeMbhGru0iUg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] audit: document /proc/PID/loginuid
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 9:48 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
> Em Thu, 18 Mar 2021 15:19:10 -0400
> Richard Guy Briggs <rgb@redhat.com> escreveu:
> > Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
> > was added 2005-02-01 by commit 1e2d1492e178 ("[PATCH] audit: handle
> > loginuid through proc")
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  Documentation/ABI/stable/procfs-audit_loginuid | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 Documentation/ABI/stable/procfs-audit_loginuid
> >
> > diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
> > new file mode 100644
> > index 000000000000..e7c100b9ab18
> > --- /dev/null
> > +++ b/Documentation/ABI/stable/procfs-audit_loginuid
> > @@ -0,0 +1,15 @@
> > +What:                Audit Login UID
> > +Date:                2005-02-01
> > +KernelVersion:       2.6.11-rc2 1e2d1492e178 ("[PATCH] audit: handle loginuid through proc")
> > +Contact:     linux-audit@redhat.com
> > +Format:              %u
>
> The ABI definition doesn't include a "Format:" symbol. See:
>
>         Documentation/ABI/README
>
> For the valid ones.
>
> This change causes a warning at the ABI parser:
>
>
>         $ ./scripts/get_abi.pl validate
>         Warning: file Documentation/ABI/stable/procfs-audit_loginuid#5:
>                 tag 'contact' is invalid. Line
>                         Format:         %u
>         Warning: file Documentation/ABI/stable/procfs-audit_loginuid#21:
>                 tag 'contact' is invalid. Line
>                         Format:         %u
>
> You should either drop it or add it to the parser and to the README
> file, if the ABI maintainers are ok with such new field.

Thanks Mauro, I didn't realize there were tools that parsed these files.

Richard, please post a patch that drops the 'Format:' line from the
newly added audit files as soon as possible so I can merge it into
audit/next.

-- 
paul moore
www.paul-moore.com
