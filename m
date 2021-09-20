Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1A411538
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbhITNF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbhITNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:05:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:03:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t6so61084941edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ng9FHOie7WdRgx/Fd8/L0yfaAAf2x8mdXRfauIbEc68=;
        b=GAMg1xsI0vIDAne8KEypmhzhu5SferfXL5La8pyowp7JgjngY3zkPTA6TtXXbw4uO3
         lSqrgYuGzf1VrkY0TRZWWXz5VZdSL8A547A6M5ZlUpmgabVzud0ZG1UgRuLCknFx9LzT
         nz5y5W/s5t0zWKU1HCsb6dcoi+6uToFbKExgeI/GMM70fDfqccnydWvTTUPiIMWZcEha
         AEt319vRjVFmwoHWUiFK6h+5EZ9HaCQAbPZwpJU8Z4rr6UXUcSmvb8oqdP8u92134g6Y
         DHFYe+tzKZW60OcUeleomsdoHJTRsVI/i3p3TX0gmBiSQKdZTXrgvlmNBtAxD6WzKH8N
         kNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ng9FHOie7WdRgx/Fd8/L0yfaAAf2x8mdXRfauIbEc68=;
        b=oQBKQu1yKqtl/4lkwR4ZLcfFMUX0jOf+8IseNBKrOvxzHuegDBJBDl3dkF2zzXzGt5
         CywopjD9PoQxC+aC2Uzvmxj5PZT9X60ddNyn/CFGr3AmUF3j6jzsgT5jHw2ZCTgwFxoe
         ukc0nvcSZRcaPM7xD5uVz4N9sQCk9Owj2B0fcMFTJQnq5r50XhXm+TQY5zTJ6n0gRL+n
         UjG11Jb2/9zfnQXAV8rxy9+e7SHM4BYc03M60v5Tqyoyo12FXYd8tRm54AReBb+9v0Gv
         OZ5tc59bfk5YnV06kFqRxF78STofNF1bzO/sBpPLuYvsz2SrgSVZfqnh7k7M4YDR98IP
         lUjA==
X-Gm-Message-State: AOAM533xQmAmuNKU/C8zYR6tBoxz18ZEWmxuCtXoQS5/glPAt0J8x2dG
        eUvlN9bKxfli1Vqvb1J92r8=
X-Google-Smtp-Source: ABdhPJwL2KTcPT9Q9yKOXPQUiBoKdwYoeXYUp+3RkFn3b64YOy6owGegbB816MRRasy6SomDoP6YKw==
X-Received: by 2002:aa7:c81a:: with SMTP id a26mr29254195edt.323.1632143025942;
        Mon, 20 Sep 2021 06:03:45 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id o7sm6936553edt.68.2021.09.20.06.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:03:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 15/19] staging: r8188eu: change the type of a variable in rtw_read16()
Date:   Mon, 20 Sep 2021 15:03:44 +0200
Message-ID: <48009934.f5uHuSIIb1@localhost.localdomain>
In-Reply-To: <20210920115647.GR2116@kadam>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com> <20210919235356.4151-16-fmdefrancesco@gmail.com> <20210920115647.GR2116@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 20, 2021 1:56:47 PM CEST Dan Carpenter wrote:
> On Mon, Sep 20, 2021 at 01:53:52AM +0200, Fabio M. De Francesco wrote:
> > Change the type of "data" from __le32 to __le16.
> > 
> 
> You should note in the commit message that:
> 
> The last two bytes of "data" are not initialized so the le32_to_cpu(data)
> technically reads uninitialized data.  This can likely be detected by
> the KASan checker as reading uninitialized data.  But because the bytes
> are discarded in the end so this will not affect runtime.
> 
> regards,
> dan carpenter
> 

Dear Dan,

Thanks for your suggestion about this specific topic. 

We thought that, since "data" is in bitwise AND with 0xffff before being 
passed to the callee, it was enough to have reviewers know why we're doing 
that change of type with no further explanations. Actually it seems to be not 
enough to motivate that change.

We will surely use the note you provided. 

However, since I'm not used to blindly follow suggestions (even if I trust 
your words with no doubts at all) without complete understanding of what I'm 
doing, I will need to understand what KASan is before copy-paste your note.

Thank you very much,

Fabio


