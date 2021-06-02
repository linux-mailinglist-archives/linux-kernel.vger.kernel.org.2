Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A835B39964A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 01:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFBXYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 19:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFBXYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:24:34 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94346C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 16:22:50 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so952128ott.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWXfOWB2ZcUoziLC2rsM6+AWebQeH0STAUDFqx6ZI84=;
        b=qgSswxigcNOrr2ZMNR8Uj2NB8i7JEi7f/0mfyEP0UOlTnuEMuu1/d+SWh8AD0DeMNf
         LiU69e1Sl+HGQw8xd17EXIkXIG7dfZpwgtALqnrZtvHJwNL0O1wyGr3n9VMYKIGuFrlM
         +nP6B4MWh/aAnXi4vY5APg1X/MMJ4KA8gAOu1awWf+mcxoW5BgYQ5IYXv56gZMbPoy8w
         tHd1WxutfII6lbPvMkF+f6/JR2mwNJ9CSVyPAdS89UaPT3+r4yyp0/jXFNlQUldtZ31J
         eaMhfNCsV1mydY4WRWuSgM1w4OIdyVzy1t7tUf9Z2Tv+TJCXUYKuO1dsIcVfUPfxQUHE
         1jSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWXfOWB2ZcUoziLC2rsM6+AWebQeH0STAUDFqx6ZI84=;
        b=hpNkyH2I6xVjwzT7YkwFjRkQvInZ7CCfRpwVz+lBPnb4EXPsB8M9HKvFrnaVL6KINl
         ETu0wOGmq8j7EcxN+lHOgbRyRLN6APMErzOY2PBKTYIBKTcfwkpqieG+FFiwqBojaLhQ
         s8AQ8TzraohNfZZspp3oo2AEH2yWRyuH6K5ub+1JfH3sTGsWTDgdl/5lfW+gVHyo0DJc
         MiRAzpf+aO22iLhwHiIXaq/cDMjcegkPV/DL3WyC9lyX1H2kjoQLNcBAFrXOWRXIo8yN
         W/tlyHZ+5cr3oWwLjXLz0QQE6Kzd9n3k+LtHafWcsksyMkhGl/tQwx9RuunYiREfTJKu
         yChQ==
X-Gm-Message-State: AOAM5328j9WONywcsVr4ZQZm0OxyJ9qfYAVAqyOrRgw1PRah+NQQcdxa
        jRyX+ICXgWgxv//tj+850fyVogEc5Wz8IVUSU6dBDQ==
X-Google-Smtp-Source: ABdhPJx7wYc6+kS658MCpIv4PAwdEIqryfutuR0j19Xo+t9HH4OQ3OJZIwxSQlDk5/DV95gV0+8Tq42zmpoW/H8UvhI=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr27745872otl.18.1622676169637;
 Wed, 02 Jun 2021 16:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210602041539.123097-1-drosen@google.com> <20210602041539.123097-3-drosen@google.com>
 <YLfh9pv1fDT+Q3pe@sol.localdomain>
In-Reply-To: <YLfh9pv1fDT+Q3pe@sol.localdomain>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 2 Jun 2021 16:22:38 -0700
Message-ID: <CA+PiJmR1vWN7ij7ak4q=C0Wxa++t=SCnEFh_iDt7QVOAZy-VFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] f2fs: Advertise encrypted casefolding in sysfs
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 12:54 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jun 02, 2021 at 04:15:39AM +0000, Daniel Rosenberg wrote:
> > +#ifdef CONFIG_UNICODE
> > +F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
> > +#endif
>
> Shouldn't it be defined(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)?
>
> >  #endif
> >  #ifdef CONFIG_BLK_DEV_ZONED
> >  F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
> > @@ -815,6 +823,9 @@ static struct attribute *f2fs_feat_attrs[] = {
> >  #ifdef CONFIG_FS_ENCRYPTION
> >       ATTR_LIST(encryption),
> >       ATTR_LIST(test_dummy_encryption_v2),
> > +#ifdef CONFIG_UNICODE
> > +     ATTR_LIST(encrypted_casefold),
> > +#endif
>
> Likewise here.
>
> - Eric

Those are already within an #ifdef CONFIG_FS_ENCRYPTION, so it should
be covered already.
Should I send a v2 set with the

Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
Cc: stable@vger.kernel.org # v5.11+

appended?

-Daniel
