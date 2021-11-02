Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2B4435E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhKBSoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbhKBSoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:44:09 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA761C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 11:41:33 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id q33-20020a056830442100b0055abeab1e9aso162698otv.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 11:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXZVlbIcIr6QeS8szUfuWZxESqbyLh03FTBfRvGINUo=;
        b=NS2N8Bit28Oj6P/ShfB3eh0SAcXy2ug1SzqIGzDFmiLCYg/VSJgWPGSYr1dfS4C+SF
         MAp0V/IlneDi35qoi8599nW/pLrxHVAHsJn4nclDaDHK8Y2baKzyoc6CPPSpIGjbntxy
         cvmf3xR162U//nNNNGwreppOnx4FOh2ba5J162b44AYTnlLELH4ks3TCl9BVP1v4KN+b
         6jYXu8Y/xfTIqWUxDzhJewr4rwvy4HdV/gBqVgscZF9oC85eJHeNYr5UBEVtLtyxYLzB
         D+Awj+s+y0KgPgbx5OylxLn4TLqr1IE7Pp47H4pd6+BmX7yOS/O2s66ych459qTgEoDb
         GC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXZVlbIcIr6QeS8szUfuWZxESqbyLh03FTBfRvGINUo=;
        b=bYFeWbO4rdS5Xo69cudrXKiiocLR4j/ojTIcTI6zJwYW50bEWvVVF3DyAWjJVcNNHy
         eL1T/x8/0toaQyWtKWZ37PWmcS84SlV/vZjWXcr4fiKLI2kRqEtfDTo/uZ+hrjESGaZp
         mXe1i8JEkb2MgLcM251ZqPUcysxNX4q6ABha1w4YzPs2+x+Og2PX+bCu86XGnWxSTntn
         GH3DhUPq1BP8HRxT/Ns0unzgL8XsO2CymSjoy4d8/6S1PXhlWQhBZ262r45JdBSIIRXD
         g/9T2lxHSkYSMZhj6UblpXft/7coi8UwS26h9DAH72kRG06E5Ot4fuZ6IyU6Vhh1YurD
         XXhw==
X-Gm-Message-State: AOAM531Iwgod1TAqkPwyPgVHikyaFtMkjSRYztc/ORzkRFHOmFf/jEbm
        Cb0OsB5tOxWfNzWV76OR4B+ac8wcibViscbWSqNgC+5hkD8=
X-Google-Smtp-Source: ABdhPJziAcADPbVIsQAAtyWVG5CS8dajyXuOXQsN73GniPhhbrAC8irZdGm4pSJuIAs5rwLIRDefz+nCYb9tbvL7mhY=
X-Received: by 2002:a05:6830:2aa5:: with SMTP id s37mr17368028otu.299.1635878493358;
 Tue, 02 Nov 2021 11:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211102070125.4445-1-ye.guojin@zte.com.cn> <lvX4AA55dPGJGyFf1ncXCnqomRKljUmW8TXAJV88VrSpYt2gSTrcK3JnCbGl5zsRJ4Gqs7-MAXIuCGr01axsnxkzDO5STy3cMMAo5SL7wOE=@emersion.fr>
In-Reply-To: <lvX4AA55dPGJGyFf1ncXCnqomRKljUmW8TXAJV88VrSpYt2gSTrcK3JnCbGl5zsRJ4Gqs7-MAXIuCGr01axsnxkzDO5STy3cMMAo5SL7wOE=@emersion.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 2 Nov 2021 14:41:22 -0400
Message-ID: <CADnq5_MnWvefEbYYEJ2NrS6-uFG9pGxrsmTp5c-mVf5t8KgkaA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unnecessary conditional operators
To:     Simon Ser <contact@emersion.fr>
Cc:     CGEL <cgel.zte@gmail.com>, Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Zeal Robot <zealci@zte.com.cn>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        syed.hassan@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        George Shen <george.shen@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>, ye.guojin@zte.com.cn,
        Jude Shih <shenshih@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>, Roman Li <Roman.Li@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Nov 2, 2021 at 4:58 AM Simon Ser <contact@emersion.fr> wrote:
>
> Reviewed-by: Simon Ser <contact@emersion.fr>
