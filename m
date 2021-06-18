Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B3B3AC05F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhFRBCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhFRBCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:02:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5D5C061574;
        Thu, 17 Jun 2021 18:00:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p7so13473617lfg.4;
        Thu, 17 Jun 2021 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIJQ3I2aHHqEFy6allhgHQlkD9N//YkR+UZzwYu38T8=;
        b=rrti8oDyrMEoM9XLaCuvXzr0MgHlOC17ZpO5+kA359xY2RzstvIYo//N78Dm7ZBEjB
         v2GcxrH/Zu0dzBBmz8IpGqdC7QLYMs0UoN7xIqcTj6sTXd9WBRrJC2QKzTWT2F86WVKb
         YTAlmai4NQOy1yZFGNDYynUGtZ1d4EA1dtnYDt7FpcdclkFfFK/g9o/nBZTESb8rpDMe
         2Zbzlr1mdcAZWV+8XnnjcMD+IoVS0qf/BvnhratmzDAmOv1HV3pLRIT1I5TDcjk3IEOw
         KsdYE1kMpbaIY0mRBoEClodFe6gu9HLqwj/0+9UyqwOz75pxsqnmviBjc00jB4WEoSYY
         2vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIJQ3I2aHHqEFy6allhgHQlkD9N//YkR+UZzwYu38T8=;
        b=B8PgMXehj6kfxOXPx7vo4zFGCzUHJwaOpYeFeq9FQtT45MuZ7VKCTGGm2nXlJp+xEQ
         ltHQZBn5qjcvU/CYzfWqtoOZBkEog4AGIvLQpX63MVHDz8yloePl9XH+bJpd1ujJTzZy
         vxkuWtDR8KXifs7hRaN8OyyE4AHuOfH7cyZQ1wxHewxgwneqB2WlpDxbmYVK78Z8mv4S
         nIoBPQrFzKNO58cGKdArgnb1AjAjwaswUM0u153wPTQmaFEEq7X+acWKEQD6WGiuBBOO
         VGimN82rZ418MSqmG5aSF/hSoKg786Sd9lckJtFJ41pGv4gohxp320ek5y4uT1gxnn1k
         4Oqw==
X-Gm-Message-State: AOAM53145Yh/HVreHJZ32Gavxv4rcKC0Mm7Awj1Xf25RVdfLuoSu7Wm7
        Uuxkz8TjY/kcVSMycdGTxVzmk3ehxumMV5C9kSE=
X-Google-Smtp-Source: ABdhPJxs8nkwun6tCij6fdduNRqIwTBFpsdMk/+o8cxsHnN0y+mF+gca4qia/fI3A8l6DztRQkF5Ky3D2Zq7J9Osb0g=
X-Received: by 2002:a05:6512:3d15:: with SMTP id d21mr910768lfv.252.1623978035887;
 Thu, 17 Jun 2021 18:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210527091618.287093-1-foxhlchen@gmail.com> <162396935764.29912.16256561662425331146@noble.neil.brown.name>
In-Reply-To: <162396935764.29912.16256561662425331146@noble.neil.brown.name>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Fri, 18 Jun 2021 09:00:24 +0800
Message-ID: <CAC2o3D+QjbowvyCvCsW2bFVhAhVMq4DhzLgB8X2y_p6WJsFn7w@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] docs: path-lookup: Update pathlookup docs
To:     NeilBrown <neilb@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, vegard.nossum@oracle.com,
        Al Viro <viro@zeniv.linux.org.uk>, rdunlap@infradead.org,
        grandmaster@al2klimov.de, linux-doc@vger.kernel.org,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 6:36 AM NeilBrown <neilb@suse.de> wrote:
>
> On Thu, 27 May 2021, Fox Chen wrote:
> > The Path lookup is a very complex subject in VFS. The path-lookup
> > document provides a very detailed guidance to help people understand
> > how path lookup works in the kernel. This document was originally
> > written based on three lwn articles five years ago. As times goes by,
> > some of the content is outdated. This patchset is intended to update
> > the document to make it more relevant to current codebase.
> >
>
> Thanks for persisting.  Sorry for the delay.

Thanks for the review. :D

> All:
>   Reviewed-by: NeilBrown <neilb@suse.de>
>
> I've noted a couple of little issues with one patch.  Hopefully Jon can
> simply fix those up rather than requiring a resubmission of the whole
> series.

if needed, I can resubmit just this single patch.

> To be honest, I haven't examined patch 4 in as much detail as I'd like,
> and it required the biggest change since last time.  But I think it is
> good enough.  It might even be excellent.
>
> NeilBrown

thanks,
fox
