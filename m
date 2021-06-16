Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA43AA1E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFPQ6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhFPQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:58:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A87C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:56:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id og14so4994721ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDUWKMhDng5NBWGQ0iuMjqcvNRC2fdcuBx5BZPpTnHs=;
        b=VdFt53cWOxe/3XDbVYRmakE9EmrsXFMokamCiiY15CYCKtf4OZ0ItHDjSJ6uMtNsXp
         DK/7kYxbtSy1jHEfG9Toh8PiHWKzGLyOUsT4F0l3vKozRuIu/aXs/WmIRHGhMuMeZBDt
         074icNiwRKS26w0nOEKzihcaCTfvkTOY+wjP1e394d3fQogawwHu0tauf0XJG/vEo91R
         JZ4PHxprUrjnhCsw022zYZ7M+loop5NXjhHHk9Y5U4zj/OC2suhKXjxL7K7SLTYajgGd
         ysh/Ort/YJdViCCgvyzRN/dxQFnp3r5Ez/7YemD5j3pvMQ6rOsVz8KoEWvWt4uceO5dS
         136w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDUWKMhDng5NBWGQ0iuMjqcvNRC2fdcuBx5BZPpTnHs=;
        b=ZRQ/L/iM+0IoSIoLam20lOZ8mrNBYnlu5wEDVmQ3+w2dvXHvynNRz+abLOKQT0h7ad
         xl8uM41bzsSFns9FN/7niYZO4ve5BhMosLMvSxcY+BC9LRkXU0+HF4LnbXLu7RCrqfzi
         t53U5PiAvWKpENwmb570HfTzIk/V74U9J2z9wgp1xttredfpy8kuawwKjyPv/wTbpdBJ
         H3c9zpAlQYZyiqobu0ujLf95RkGHM4rsOaOCrY012J2SllHFFFrxOwT0ari/BpQ1c32Y
         aXp/a0wy/oqfilqpp9oPWNoWOFxtR36bxsMNmWnkP6+j3qlkG1i1O+ywhT/x9QVxz0HB
         i7vQ==
X-Gm-Message-State: AOAM5317NtKpY94dh6rqExv3qslXwiKG/L/dKoCeinOxwbHPzSqZX/eh
        Hu1fPw+ganVc5mx8GJw/Fb8=
X-Google-Smtp-Source: ABdhPJzWQcE3F9VJ/gAUCFIYQHzJFiVfBo0ITH+0drszHNqZs2ESSkKAVXLXEDHtKXNB94LbaSEidA==
X-Received: by 2002:a17:906:6814:: with SMTP id k20mr455348ejr.455.1623862602139;
        Wed, 16 Jun 2021 09:56:42 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id ci4sm1901102ejc.110.2021.06.16.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:56:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v8 RESEND] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Wed, 16 Jun 2021 18:56:39 +0200
Message-ID: <3316425.tqDOt8T8LQ@linux.local>
In-Reply-To: <YMiT9+msL8H2+3yV@kroah.com>
References: <20210514081112.19542-1-fmdefrancesco@gmail.com> <YMiT9+msL8H2+3yV@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 15, 2021 1:50:15 PM CEST Greg Kroah-Hartman wrote:
> On Fri, May 14, 2021 at 10:11:11AM +0200, Fabio M. De Francesco wrote:
> > Converted visorhba from IDR to XArray. The abstract data type XArray is
> > more memory-efficient, parallelizable, and cache friendly. It takes
> > advantage of RCU to perform lookups without locking. Furthermore, IDR is
> > deprecated because XArray has a better (cleaner and more consistent)
> > API.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> 
> Given a lack of response from the unisys maintainer, I'll go apply this
> now and see what breaks :)
>
Hi Greg,

I'm really grateful to you for having applied that patch notwithstanding the 
lack of response from Unisys. Understanding IDR, XArray, and the flow of the 
code, has been a hard task for a newcomer having only a month of experience to 
kernel development.

Thanks very much,

Fabio
> 
> thanks,
> 
> greg k-h




