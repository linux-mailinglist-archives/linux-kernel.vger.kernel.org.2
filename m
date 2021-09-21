Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEBE41378E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhIUQ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhIUQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:29:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51CFC061574;
        Tue, 21 Sep 2021 09:28:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t18so40936945wrb.0;
        Tue, 21 Sep 2021 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pdxgn+Iv0FLPW3wja2N4FsSArulcu3EkDWvQdgKFDZo=;
        b=BYxgfBvslUhEoeAB7TeIlVHFcPFcta5skdaAS21F4jCnqBjzsrs8ki2/SDpp/j0lVt
         7bOPh3kkakRqAJTsZoRnbMwhK5NKmRKmVvZt4+caBVihdg85JvgnWFkqCu/49wtXylu1
         XQ2FcWtJ0L46BEXS3W+eFcg6u8XPvjgdM5ThH+ALdPtc9g2a8rcI7q5xdA/unNYIm29R
         pVG47SmL4cWvvq3azttH2l0K81NnBnQZyw0NG+bQEreX8XS/CuNyQ4y4CBohAVTeHnar
         cXSMBV3y1Qrw17MiC3Qkzti1tyXvZQyRk5z9IP2but/Ev1JH9yzZe9RZx15AVClxDmXY
         3KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pdxgn+Iv0FLPW3wja2N4FsSArulcu3EkDWvQdgKFDZo=;
        b=o6/63zGZ4HhRbDZPxv3Sph0La/sSEDNaJqidOkOVv2m2nTvVar5SIfB4bZ+slFF0v9
         cUUBWyu2bHq7QdGlSsncQZAyvh86ueV4kXa43nbV0H/bAvcFYLHqvcpULbbeztqR8EBX
         d2cxIlLS0F7fYlTqQo+9aLSoKz2mbVVAjWCxzfnaeU8bpxMcmWYMn04G0yaFY9HpxPka
         LdhruW+6lClKd9pAq2AOu8WdoYftiB3F9hZOfxFI4P1orJZZ4RDu0PyORexZrs1f/u78
         B/7p2CJuXPi8wZlQuYqMplPiAnFqtJ5hQSOp5f5boNcU84hgBbXpNbQzperYeWSUxaem
         o65w==
X-Gm-Message-State: AOAM532NXMYf2CjvU+saKiQqBa74oEpIZsD1TWnPicO/TIqegEO2NnQl
        6aea04k3lwaqGMWGB5cN8TM=
X-Google-Smtp-Source: ABdhPJx138MdhtzPk2yEybsriOKRNt6q/Xv94voA+2Fj7mUIP638wzyhZga1/3nzHorRurL/YkHI2g==
X-Received: by 2002:a7b:cbc4:: with SMTP id n4mr5744783wmi.93.1632241705142;
        Tue, 21 Sep 2021 09:28:25 -0700 (PDT)
Received: from elementary ([94.73.35.139])
        by smtp.gmail.com with ESMTPSA id s10sm19766253wrg.42.2021.09.21.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:28:24 -0700 (PDT)
Date:   Tue, 21 Sep 2021 18:28:20 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        alex.hung@canonical.com, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Gurtzick <magic@wizardtales.com>
Subject: Re: [PATCH] platform/x86/intel: hid: Add DMI switches allow list
Message-ID: <20210921162820.GA5154@elementary>
References: <20210920160312.9787-1-jose.exposito89@gmail.com>
 <NgI8poho2fFBrbj2ivUSWphaZbwgMIxHVovWWqI2UWdJA8FNhlDtkFk-Y7cp4mYxiiOtkFQHoCQj-kkGh71lQfsvzJ1sg0IgixkJqdEdcnM=@protonmail.com>
 <ca5834c0-3456-bda8-36d8-becd8e1a2590@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca5834c0-3456-bda8-36d8-becd8e1a2590@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 03:13:31PM +0200, Hans de Goede wrote:
> These events don't happen all that often. But this still is a good suggestion.
> 
> Since this is a regression fix of sorts I've gone ahead and made the suggested
> changes myself (keeping José as author) and I've applied this to my tree,
> see the version in the review-hans branch to see what the merged version
> looks like.

I was going to work on the patch tonight, but you were faster :)
Thanks for your review Barnabás and for applying the changes Hans.

Jose
