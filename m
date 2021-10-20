Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD743510C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhJTRQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 13:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJTRQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:16:38 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:14:24 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s9so8098061oiw.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bH8bzWordrBPaRkjYl4H2o6uElofK80vQkMqzZLeV8k=;
        b=Dd5sDh9GAh1DnLARXlVR24rfGMecPEynsV8E1Xb1ZPcCgUDkTCSGtfKuNknTzBcTXJ
         4sSQF/82dDDzAUony3UsNvdilaWDMgQgw4/6VXfHyEzA7USmRPa/OZ8nMkJscsfqMpk+
         YeZtWvvCok9ewpLXFfah1Mt0O0BvBgTzLaM8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bH8bzWordrBPaRkjYl4H2o6uElofK80vQkMqzZLeV8k=;
        b=WCKzgjRCFZgclMdE2TVIAGA4MEoI259KDkUhDI677Uts4t+B5jCLIzUXaHzcSysfDI
         riKuN9dmXbmvFYsQExlTUT2wWB+Go9fB8klzjuaaEI5ny2VBwI21VfH171wwrBLbG3DC
         ZnfVDb9Rb5ZST1hyFWegPyEyJdnQKjyWNGyghZOTM68/3W78GJj8malulOeyWQuyqFYX
         FP4B/0L9Brg3QXjmyMCeL9fbS3ONg7PqZUVOgL9CdtkCTP58OU9mdAwkUOLyiDhT3/Wq
         zXXBqZ+cni7qMxDP1wtvnVm8p+gq75cS+YeeOCcY9A2dcaGXQIsQnETvK522kLTAZDlb
         37PA==
X-Gm-Message-State: AOAM532+IDapxJweWIVoIkjpuhYWaeS8OQLxAlrkaM8Ztw3gJqfhEtqD
        M4BHrkHxpw0pDyitv9TjAMIMVF2K5phjTg==
X-Google-Smtp-Source: ABdhPJz2TMoFOKPnhhB906PQW5Lb1LhbAQExFlRZYYAtAieumISsTWXI6a+ixjmH+9aL15+7DmSnVA==
X-Received: by 2002:a05:6808:1508:: with SMTP id u8mr578223oiw.4.1634750063246;
        Wed, 20 Oct 2021 10:14:23 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id l7sm486731oog.22.2021.10.20.10.14.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 10:14:22 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id s80-20020a4a3b53000000b002b7ad17e169so1556126oos.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:14:21 -0700 (PDT)
X-Received: by 2002:a4a:be0a:: with SMTP id l10mr381504oop.64.1634750061332;
 Wed, 20 Oct 2021 10:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211019175932.1.I96669f75475cbb0ae1749940217876aa8991b703@changeid>
In-Reply-To: <20211019175932.1.I96669f75475cbb0ae1749940217876aa8991b703@changeid>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 20 Oct 2021 10:14:10 -0700
X-Gmail-Original-Message-ID: <CA+ASDXN5_NrXfaoE-SVphyQG4Qqqktrk85QQX0W16=dOiaro7A@mail.gmail.com>
Message-ID: <CA+ASDXN5_NrXfaoE-SVphyQG4Qqqktrk85QQX0W16=dOiaro7A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Fixup drm-misc website link
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 5:59 PM Brian Norris <briannorris@chromium.org> wrote:
>
> https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html gives
> HTTP 404, and https://drm.pages.freedesktop.org/maintainer-tools/
> redirects to freedesktop.org now.

With a dash of irony, I actually listed the wrong URLs in the
description. (I used the properly-redirected ones, and claimed that
they were the broken ones.)

I'll send a v2, so a maintainer doesn't have to fix that up for me.

Brian
