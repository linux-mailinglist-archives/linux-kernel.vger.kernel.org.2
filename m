Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B04171FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbhIXMjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245265AbhIXMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:39:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17EFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:37:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c21so35102649edj.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=emF/n89T1EgeKKKG223R4wP2lObDfuVVuJMX8gbpTGg=;
        b=IhOFpZiqx5m+PHXyfrLCKxrb5rlM6BZ0QgtBJGuTAdyYzmWKRTyLura98cCGiaIHZS
         jlPkx/8zrBtddV5UszUVygKSCMI/s1fNd15WA3dTwdIH+WcZ9LBocvIxZrz6n7qURGjt
         qRHQX3XmJfPM1P9jUc0nxs850AkVfD3ryDWynjJ0gxFEAwSdRbO1dIVjj3Nj/920PQmK
         /Vaa1XlxDZETi4Vl1Pk0GOWeoHoemheESThVElUHlHTlD8Ww+fn2sbbsfdb7jXBQ/vJZ
         JrYKyuifZDeRVCoV4c1/eEbyJeCZDlM7CFXzyR6kudydozTjClQRJRYoRswf8fCAzFle
         WJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emF/n89T1EgeKKKG223R4wP2lObDfuVVuJMX8gbpTGg=;
        b=5D44iFMXXqi8k+LAWV+xfr7BuPgjSpkKgO+WoTglZyyuIyj3/CPSrCEbD+jw4m3WSQ
         B8sJY9W0hxoP8LjtyktIblvqgRW6/CZdUgKWtB6VjvWTPi+HmDVFdk6iChyohUkkyse7
         KQQFogBmDId1gLakR8WePirSJy6dtb+lFIY+QB6cmkvu1zqwct2CUqlUU8z4hMo4tf2H
         8weO/BhhwLN1kt5JFiF5btNzwrmposuhDmJalmfOIQ4wTtY1u5Am681yOkt2u66ktdbo
         HcHh13oJaQXTPQeJdfacobaCAKqTcNQQccNEdyiixDIi8MfcsF6xWZMD1obiBJT5uVa6
         Z4mQ==
X-Gm-Message-State: AOAM531fXoAEMUPhRlpwQttsJIiWiY801ceZho5w8oyk7f15QLdSbdyH
        wSkfxV4znSzajP9fxrZuOxE=
X-Google-Smtp-Source: ABdhPJyH/ccPOQC9ctRvzI44Il3JY6Sbmi+VC4LSE8JbSSFrM69KEvgCxuwfhEDsfHZzteyteA/T2A==
X-Received: by 2002:a17:906:c251:: with SMTP id bl17mr10743963ejb.219.1632487075519;
        Fri, 24 Sep 2021 05:37:55 -0700 (PDT)
Received: from localhost.localdomain (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id ca4sm4995920ejb.1.2021.09.24.05.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:37:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v9 10/16] staging: r8188eu: shorten and simplify calls chains
Date:   Fri, 24 Sep 2021 14:37:52 +0200
Message-ID: <1836626.W0nMHyKdkH@localhost.localdomain>
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 24, 2021 2:26:49 PM CEST Fabio M. De Francesco wrote:
> --- Preface ---
> 
> This is v10 of "shorten and simplify calls chain". The 14 (v7) + 2 (v8) 
> patches have already been applied to staging-testing, so we have been 
> requested to reset the numbering of the remaining patches to 01/16, while 
> discarding from v9 the above-mentioned 16 patches (otherwise we would
> have submitted a series containing 32 patches, that is 1 patch less than
> v8 because it has been dropped by us in what we considered it
> unnecessary - it was about fixing a misspelled word in a comment).

Hello all,

Please disregard this weird cover. I don't know how I've been able to make 
the mess you see in the subject. The good one has been sent soon after this.
And please, let me know if it is necessary to resend in order to have the 
cover letter as the first email of the thread.

Thanks,

Fabio




