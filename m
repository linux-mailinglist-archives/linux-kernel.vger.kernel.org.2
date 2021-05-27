Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CDE392B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhE0KMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbhE0KMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:12:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52112C061761
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:10:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 131so70536ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4yEjCZpjXjlLtm8fIGk3hS7YCL51ZB0U7PousVU3z0=;
        b=ehfhag2ColEd2R3+qduQ1URjFhb+8Dy6hnhyDGq+Z/YorltmfPecHA0Qzss59HJrj5
         6PzCTDrPNFTQmDDJI9s/Ic5C6WRxC1A2y+095uulcjneTfYYKOUIZeTUv+fv8EvvR86q
         0VemvTJREFYEOfXJ8XtOcP4X+X38X49UwA5ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4yEjCZpjXjlLtm8fIGk3hS7YCL51ZB0U7PousVU3z0=;
        b=gOTxdEf80OZ7pwS/bJE2bLuwCzQKjtyFSzkhnILJCkv1tApIsJyetO7N1ZUN/pwHm2
         PTuss5UmwLz1FePJWBrk2z6xaK0KhmuUpZuTi+iDuo2zMahHtEyFAfpsE9+OBzDAc6BJ
         RIpwR2YC/cEbl6TBMDbJ9EZ+nLW3BXcx/r4l+WthurGsdOZIVQT8jY/gi7ZlCltHkjFN
         VNf0ypnnFj7J6LUEZKedb6UL7YS8hYmK2nDqdS2XbqMFKh048PXNLWH+LizRI7hyocDt
         GvGiAEkfT/BI3HJIKfiVOe9zyYQE9+BtcX65ISpf2gKbdLDUjfpu4/m4/oHiUDXIkzik
         q+Bg==
X-Gm-Message-State: AOAM530QIKTuC+47G3u07MbXFwJpJlmZyyVKkILJRSgZKuDddX1n0tyA
        aCh0wWfnsYPBlLG2q1wFNBlsuPme2NQOZg==
X-Google-Smtp-Source: ABdhPJzGQ9VHd/NPUebge6qx3CYi8KFQwy6t2hxuXeJKcFuQPq413lpmYQ+YBdvbhH5Ux3HeNSdZnQ==
X-Received: by 2002:a2e:9896:: with SMTP id b22mr1935741ljj.329.1622110229766;
        Thu, 27 May 2021 03:10:29 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id k18sm174411lfg.200.2021.05.27.03.10.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 03:10:29 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id a5so6437765lfm.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:10:29 -0700 (PDT)
X-Received: by 2002:a19:6102:: with SMTP id v2mr1818325lfb.403.1622110228818;
 Thu, 27 May 2021 03:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org>
 <20210519143011.1175546-6-acourbot@chromium.org> <CA+Px+wUaA9o+Aom4weuTH4TDpCfFpxv0YHDArCJswEs6QmCw0A@mail.gmail.com>
In-Reply-To: <CA+Px+wUaA9o+Aom4weuTH4TDpCfFpxv0YHDArCJswEs6QmCw0A@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 27 May 2021 19:10:16 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXnv0g5knZ_KNhTKkwyRh29zQWqKV-vyA+dQyDn4qkMGA@mail.gmail.com>
Message-ID: <CAPBb6MXnv0g5knZ_KNhTKkwyRh29zQWqKV-vyA+dQyDn4qkMGA@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] media: mtk-vcodec: venc: support START and STOP commands
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 10:37 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Wed, May 19, 2021 at 10:31 PM Alexandre Courbot
> <acourbot@chromium.org> wrote:
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > [hsinyi: fix double-free issue if flush buffer was not dequeued by the
> > time streamoff is called]
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Per guideline[1]:
> > Notably, the last Signed-off-by: must always be that of the developer submitting the patch.
>
> In the case, should you provide another signed-off at the last line?
>
> [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

IIUC the main author's signoff should come first, and you should not
sign patches twice. checkpatch.pl did not raise any objection, so I
suppose the current form is correct?
