Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA2343C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCVJDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCVJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:03:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691FBC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:03:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f17so6196342plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pAsptSW3SHx362kkQRPfFNxuGD8CX/Lmyp72Cp1h67A=;
        b=nOxEKkHxNONIJZI0Cvm4WcqpWi6evJwfvPN/AYZX4Ei9DLvA4026T/msmjh3CV48Pf
         2cnVXxEOK68GsW/OUk+bHJS9hQ4VsqKOcuvU+PzKHRpqFHWTqA7lXvEaUDx0HFHJO1be
         a1kh/Sod5qFoBJtwlybpw+h2PLjXNza6XisMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pAsptSW3SHx362kkQRPfFNxuGD8CX/Lmyp72Cp1h67A=;
        b=tqunB/JYiIVVLZ4vxvjLJr6UGryVAuTLKkdSXTkEnDiDWHFvcvnftNmGvE8sExauOP
         /lnDeSsFmUZiYrYcyrpC736C/CTaz+3NNkcFfL6aNhXVR2FONVPKOHOrjq4TvZbNO66Y
         b3aVcpV/kelgmU2gEjeRyYYjtculF2A7qO4iuI8PAFnsU0LU19utIgll7z4Sk7IiTQax
         b5MngvC/8hg93mBCqsF6v3EMyr1W5WlSsvL21gsermSG3SDaD32dSrWjN8WY5avBduh1
         +VefnGxKAFB8/csFGDxvDlQpMlNsgL9By6jRwo8O+BI42SJVfBiqofcLf149pFbNcTRB
         Hrjg==
X-Gm-Message-State: AOAM533yj3Al7b+402fEFUGFOxivXWCLPcK0yt2gGKXjPkyETMANfohc
        uw01jzCWykU7VRIVPtros+DMig==
X-Google-Smtp-Source: ABdhPJxTH5siZmLLuSoU6dQ3qFmv6uAobhfSe64SMSCD5eQSdp8TkB/yhGjtNESdJBql+UqtV3NM0Q==
X-Received: by 2002:a17:902:dac9:b029:e4:b52f:1d38 with SMTP id q9-20020a170902dac9b02900e4b52f1d38mr26677110plx.15.1616403807886;
        Mon, 22 Mar 2021 02:03:27 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b1b5:270:5df6:6d6e])
        by smtp.gmail.com with ESMTPSA id u79sm12937895pfc.207.2021.03.22.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:03:27 -0700 (PDT)
Date:   Mon, 22 Mar 2021 18:03:21 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <YFhdWeedjQQgJdbi@google.com>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
 <20210322081512.GI1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322081512.GI1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/22 08:15), Matthew Wilcox wrote:
> 
> What's the scenario for which your allocator performs better than slub
> 

IIRC request and reply buffers can be up to 4M in size. So this stuff
just allocates a number of fat buffers and keeps them around so that
it doesn't have to vmalloc(4M) for every request and every response.
