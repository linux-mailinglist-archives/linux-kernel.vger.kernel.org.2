Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE45C32340C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhBWW41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhBWWka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:40:30 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB1CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:39:48 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p21so56348lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ee4pFk6jWgrY2YJbXXX7SSyhDpedfC2qAYauzov/YXE=;
        b=p82Kj/jPd2Wm4DBhMyVkhbKfZPLeCC6Jts3dsXC6Jf7Uz3+ilUDTNDX+rV0dHkbtHi
         pX/7BHqVFuVcJ6oVQeh01ZFhtmZpSSNj9Pi580ma1ytrmP62+R1aqD97gPc3upEd/7Dp
         C7n4Q8Phn/hITZxbhU4FwKOelNHscQLBxKh7ocijKaoxh6bInc9Apuojx9x4uGjFraI2
         OmwN+mHLgtyVbA/7rpdAtyp23/x0rZ9zu2duUEpZhptGcVtoyMW4qtGss9gogjEZgfk5
         KLYvVWxO93thSERhZ9EkJ2KpwN8ZNZ3fJC7LRHtU9+D+pS/nDyYqkz0NGoLBVDM/z1f1
         CwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ee4pFk6jWgrY2YJbXXX7SSyhDpedfC2qAYauzov/YXE=;
        b=ZdzymTXcLQh4cw4/je84szrffi0/cntcI5H5ENYl8IibAFjdx5MhLRadWNigFMVr16
         FIysPIvbQCi7i/VfNTR00HtVY6bgHwdB9SZyFumcJZhre9r3TePHUtakomt2ou1ui4oL
         IYgGLWi95CVjftCRfMPrL3krd5rtfMtqP86jKGu/G61DlkDYdWwQFk6NTMhSYXoTEdzZ
         mJsmcwj5GtliNBHPlWkpacgSDZNJE2W+m5Eu/NUxSoqZUC6HIQtLGuNTr54Obi/gbq8l
         WP4nFOJ1po0ZC5vR3hJG9iKq1B16ScllrE/AzLnbcvglB7YH03Y9CuufeHc3CowT8ov4
         POUQ==
X-Gm-Message-State: AOAM530847CCGFSjJMa3EEwybAP6j5pvZhSJleUW1CYsuXZPshOzjF+x
        gItVSerCs4isgt61+Xhju7sxSoEZzHLsGa2nDvfQLQ==
X-Google-Smtp-Source: ABdhPJzBSxGooRO1g4kr2Y4/POPmP/l99/Ytc8DCrMYJtzvi39yx0zr0KGUpIzlCpVkif/7+ZRL5ggYY8cW4jQ0ooRU=
X-Received: by 2002:a05:6512:33b8:: with SMTP id i24mr17363663lfg.7.1614119987273;
 Tue, 23 Feb 2021 14:39:47 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLU3B8YcS_MTnr2Lpasvn8oLJvD2qO4hkfkZeEwVNfeHXg@mail.gmail.com>
 <20210223063130.GA16292@lst.de>
In-Reply-To: <20210223063130.GA16292@lst.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 23 Feb 2021 14:39:36 -0800
Message-ID: <CALAqxLVtM0PKSen8eo_bud+NmBEamEJjK7qZTT49pTX5QtqvrA@mail.gmail.com>
Subject: Re: [REGRESSION] "add a disk_uevent helper" breaks booting Andorid w/
 dynamic partitions
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
        linux-block@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 10:31 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Please try the patch below:
>
> ---
> From 85943345b41ec04f5a9e92dfad85b0fb24e2d2eb Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 23 Feb 2021 07:28:22 +0100
> Subject: block: don't skip empty device in in disk_uevent
>
> Restore the previous behavior by using the correct flag for the whole device
> ("part0").
>
> Fixes: 99dfc43ecbf6 ("block: use ->bi_bdev for bio based I/O accounting")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yes, this seems to fix the problem! Thank you so much!
Tested-by: John Stultz <john.stultz@linaro.org>
