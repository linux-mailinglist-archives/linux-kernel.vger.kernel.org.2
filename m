Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5823C34C329
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhC2Fre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2FrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:47:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE4C061574;
        Sun, 28 Mar 2021 22:47:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l4so17469660ejc.10;
        Sun, 28 Mar 2021 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXlnApRgNcMIGT76ZQV04rA/bCo848YrNvuPlqGQpvQ=;
        b=t5H1cq6mR2J0tNuRkpuD+P0HTf9//Q22IVkgTelMDLHB/+bIZG7ylZ2HP/w7E5HXkY
         bfV25OEHAbbMQkyZbBctBs/eTnc3jSKTZn8R2WzQCnlaArK6aqjJYFPtrpv91BSk7tH1
         gncpjD5X4FwLEn8q3Z6LZh6PElzsHQoEjkT1pa74GNuuBeIACZj+BfUswV+MJ37IMCjn
         u4q5JI0Bm11dyaR9j1kgWKI6heTey/cgjNE/eoOxo3d5+1DLxmtAozDWZ6zTDN4dzOog
         A9x7UZbvFtczgl9u+NsFfVx1wSBV2fwhI1VTVd3iz5qBtZRfQTlrRPoHdZ7Kh6SkZbJU
         Y2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXlnApRgNcMIGT76ZQV04rA/bCo848YrNvuPlqGQpvQ=;
        b=QTV8AdGIRKFMom2tY6BHyZS6GmNgXvGMOphus4JGLjlKHOX+3HjqDd4/Fm+OoRTmBo
         8vHLnmm8RkngS9Dpc87i0/0qA0iIx3Qxzkzt6exrGlWouxPhZdQ8wdtiJAvyh+maEKsE
         aWWHrRDVFdIoJuAF/vvdIM97JtscN1oHXgZdY3TvR4ekT1jTBo//c/FV+IM/iWsp2lof
         T1ktO9j7cTy61aQYIOxUQWdo6sc0mSg+O5Oly5QlgCr/bpLCj+vc7Z7ZOfNPXWY8KmYp
         3YIpMZc+mtAtYKxvZP3JB7EsuWYvhrbAjq9I+49SGuudqsYRZUQbGgcp0+bIlSVj3U4G
         yNnw==
X-Gm-Message-State: AOAM5302XW+CoRp31SCXRj5+DkfYJfq1NAb/ypzkvcoEwA4pr0PNIDrY
        m83D4APgXQG3PsSvFkr9wd8tY1FV0biRPzkPgKWBdUG7
X-Google-Smtp-Source: ABdhPJwsXHthTgYYf5UWRTTp8fSSNWg4ScWBunwhAhbFWXal+Dh9hBCdEvFYZ0Zi1hquu/AVrO97JjiZ4rJHejGMElM=
X-Received: by 2002:aa7:d316:: with SMTP id p22mr26038498edq.107.1616996231621;
 Sun, 28 Mar 2021 22:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616992679.git.unixbhaskar@gmail.com> <b103bd6a8bcdad7f90806dbe7680017235cf1d9c.1616992679.git.unixbhaskar@gmail.com>
In-Reply-To: <b103bd6a8bcdad7f90806dbe7680017235cf1d9c.1616992679.git.unixbhaskar@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 28 Mar 2021 22:37:00 -0700
Message-ID: <CAMo8BfKj+ojEbc1ZJ6QL+f9Sq+7oZeqVNMu6nTP=OSbrqD2XOg@mail.gmail.com>
Subject: Re: [PATCH 01/23] atomctl.rst: A typo fix
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 10:18 PM Bhaskar Chowdhury
<unixbhaskar@gmail.com> wrote:
>
> s/controlers/controllers/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/xtensa/atomctl.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/xtensa/atomctl.rst b/Documentation/xtensa/atomctl.rst
> index 1ecbd0ba9a2e..a0efab2abe8f 100644
> --- a/Documentation/xtensa/atomctl.rst
> +++ b/Documentation/xtensa/atomctl.rst
> @@ -23,7 +23,7 @@ doing a Cached (WB) transaction and use the Memory RCW for un-cached
>  operations.
>
>  For systems without an coherent cache controller, non-MX, we always
> -use the memory controllers RCW, thought non-MX controlers likely
> +use the memory controllers RCW, thought non-MX controllers likely

In this line you could also do s/thought/though/.

-- 
Thanks.
-- Max
