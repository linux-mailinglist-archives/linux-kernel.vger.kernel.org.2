Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA843BC00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbhJZVGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239390AbhJZVGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635282223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K81mj1S6a9jrOkqIwFK+AfGu2TivalPts2hUuqm/A1k=;
        b=Sqtd4T9ZJU7tdoV8x6XYMayLhmthFOnNKGLvu7htE+d52AuM1AdNdAmUoAcu3djlF/muF3
        rhigBZf8cb+inJXWNuBQiGD49zOkuuKzH7OzllvAo+ESqwtUet12QV6A0OiiFQJDmaSuiJ
        QDIQqfq4dk8D0cCNkAvCqxV3HVKgBns=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-4a_viMCNPymK3te7r3XZKw-1; Tue, 26 Oct 2021 17:03:42 -0400
X-MC-Unique: 4a_viMCNPymK3te7r3XZKw-1
Received: by mail-yb1-f197.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso590195ybj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K81mj1S6a9jrOkqIwFK+AfGu2TivalPts2hUuqm/A1k=;
        b=2CbcSsIo7cbiM0K774tbv0fFe6oRseukPi1p2fz/ZiU+Ut7Avg95aGxaMdhKKsGndj
         p9sL0arZCShgvzGOvzsWGxdaAGfosBFUDGohAU+7nnH0sQkG+El+3NS3XQwGgkIxR7Re
         oRYNFNIErJVxJa4DNe9oNovr1UCSaDzipJZ/hNbWEB0LCZRWD3vl6v9lUJou3zncYaQ5
         MyuuEyz29ZHNLGUjfz+XMYlQ7j8tUzPlxYqiwuonDkx7z2UGi5gUTdMVUOnPzjB4+orO
         ZiyyEwR1KlNxN5YwwYDbCwiMTYNIF/mQY+rvkkVVHtPOpkYusZ5YCx0O+Q48ClOa0B2M
         kcAQ==
X-Gm-Message-State: AOAM532L4kT/hS9caIAKm2hVc80sGXCvm5y0w8qCH7isXL7mqjEIGczw
        SFL7kB91WG1lHbFOqnhY8ue1KPn4rtUAehMooZQ7Du/JhehIdA5XPHcBz5DTqm7TA7sIUDNbPJ4
        ueAqg1kuxF4g8e/DZtxFIcbDh9pToWAHa2bpCy9y8
X-Received: by 2002:a25:d195:: with SMTP id i143mr4808908ybg.48.1635282221465;
        Tue, 26 Oct 2021 14:03:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWwMFjlHJq0k0Co0aHoZkkYIZNNOv5eISkpO+ADXOQe1cuAjV6x7G4ZOzIC7W8w39p9jC1gNevLxc+wu0qbFA=
X-Received: by 2002:a25:d195:: with SMTP id i143mr4808880ybg.48.1635282221265;
 Tue, 26 Oct 2021 14:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <2645866.lzt4QeR4KX@positron.chronox.de> <202109172238.fNcqoasE-lkp@intel.com>
 <33c77eb10e91f50c1d39065147b6e085d2fd753c.camel@chronox.de>
In-Reply-To: <33c77eb10e91f50c1d39065147b6e085d2fd753c.camel@chronox.de>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Tue, 26 Oct 2021 23:03:30 +0200
Message-ID: <CAE4VaGBDyAed0N9wayR1U_AL2PGnLhp9FYsP7CoCjqWV_pm+zg@mail.gmail.com>
Subject: Re: [PATCH v42 01/13] Linux Random Number Generator
To:     Stephan Mueller <smueller@chronox.de>
Cc:     kernel test robot <lkp@intel.com>, Tso Ted <tytso@mit.edu>,
        linux-crypto@vger.kernel.org, kbuild-all@lists.01.org,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 5:18 PM Stephan Mueller <smueller@chronox.de> wrote:
>
> Am Freitag, dem 17.09.2021 um 23:02 +0800 schrieb kernel test robot:
> > Hi "Stephan,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on herbert-crypto-2.6/master]
> > [cannot apply to char-misc/char-misc-testing herbert-cryptodev-2.6/master
> > v5.15-rc1 next-20210917]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:
> > https://github.com/0day-ci/linux/commits/Stephan-M-ller/dev-random-a-new-approach/20210917-174624
> > base:
> > https://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git maste
> > r
> > config: nds32-allyesconfig (attached as .config)
> > compiler: nds32le-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> > ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         #
> > https://github.com/0day-ci/linux/commit/335ce64ab466685e61b363a33a405c9c49c7a099
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Stephan-M-ller/dev-random-a-new-
> > approach/20210917-174624
> >         git checkout 335ce64ab466685e61b363a33a405c9c49c7a099
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross
> > ARCH=nds32
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > > > drivers/char/lrng/lrng_chacha20.c:35: warning: This comment starts with
> > > > '/**', but isn't a kernel-doc comment. Refer Documentation/doc-
> > > > guide/kernel-doc.rst
> >     * Update of the ChaCha20 state by either using an unused buffer part or
> > by
>
> ...
>
> All comments will start with '/*' instead of '/**' from now on.
>
> Thanks
> Stephan
>

Tested-by: Jirka Hladky <jhladky@redhat.com>
Reviewed-by: Jirka Hladky <jhladky@redhat.com>

-- 
-Jirka

