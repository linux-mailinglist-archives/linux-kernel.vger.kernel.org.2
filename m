Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD3E3E1416
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbhHELrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhHELrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:47:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A39C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 04:47:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h9so9088449ejs.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBX3Xccp6bI54eSUznvP+6mMefHCK9TZwZhPwT50a08=;
        b=lTrn5cZNoWXqzAgGOwj5Ih69j5jyWhRh9SlLjGef3DYLtYYBKx4o4Wm5ZBnuHXfK4M
         zp7cHfSB7Xsehk15UR36MVM/Oo26W8d3pYNxu2ivajL8gILjIjc94J+L3XzcUaerMaJA
         YUzsBMifPy0Ah0b6qgiSVaMSEmgYzA+J2ciFOsogudhUKFgXSkiraIV8JiXifUGsSz5I
         efof0eYyge0emxB8J/bwPuMU0s3oJMXCL0YDAH+MVjzQhy+AwEy4u0goH5t9n29MJobN
         Hq3ItNV2cd+2mkwQ5kOqSSqASGdcVWMAwhQRI06F+3EABE1AYSxE/uU8hE5w2c4OkbLl
         JkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBX3Xccp6bI54eSUznvP+6mMefHCK9TZwZhPwT50a08=;
        b=nxEp5/UPPQ/3OkP/xHAFan46aMjKjFTz/lOnDkOMPgKySa64lvRGl4tDpWCLC1oFnr
         Dw1q0CUgM/tnVxRpqzayO4iRvNEPW2B/77fpr521+1a+ohMXosAHxY4WoysSI5gZ5REk
         xj/1ZY6ql9GkAOfYNPRjvTg9UDkKCIqS20695n8x1oxtnwCy7iPF817NHY7FAA2TEb6V
         DKAkKHKViPHJuw3ScZqZY06L45fPkgLD5yA0g/5+Yp6Lee86GlXGUyzVmABTHNi2nMJ4
         VTKW3ZbT2JOUiVEveYm/vbdYXt+1qP7PYuuHBscMuG5SL4Ieb9PepTwVMHvrS458yxml
         YG/g==
X-Gm-Message-State: AOAM532S4jPUn3ZU/6GXZ45gngZLoMSqUskY1qgm95pgFFOkKOYNJUZS
        iUpENEYK/rO3LWb5QzzGmJc=
X-Google-Smtp-Source: ABdhPJypvf/JPpUIIfitGvd/jw8HyAKKFLrzW6oH2/GdeZY6KY0SHKIkBSz61OkRgPcNfYuemUn/3g==
X-Received: by 2002:a17:906:24c3:: with SMTP id f3mr4397984ejb.145.1628164027969;
        Thu, 05 Aug 2021 04:47:07 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id o23sm2179103eds.75.2021.08.05.04.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 04:47:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: core: Remove rtw_mfree_all_stainfo()
Date:   Thu, 05 Aug 2021 13:47:06 +0200
Message-ID: <4588980.OG3HjkdD0c@localhost.localdomain>
In-Reply-To: <406c6f84-a2f6-1a0e-3a52-9406df41973c@lwfinger.net>
References: <20210802005517.12815-1-fmdefrancesco@gmail.com> <CAP71bdUDEX=B6Km9wZO1AyHpVzqqkGNw6xNvspBz3qUABSKMEQ@mail.gmail.com> <406c6f84-a2f6-1a0e-3a52-9406df41973c@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 4, 2021 8:10:37 PM CEST Larry Finger wrote:
> On 8/4/21 10:09 AM, Larry Finger wrote:
> 
> []
>
> After looking at the original code for several other drivers, routine
> rtw_mfree_stainfo() just ends up calling a couple of routines that free a
> spinlock. That operation for Windows and FreeBSD is not trivial, but for 
Linux,
> the routine does nothing. Thus, despite its name, rtw_mfree_stainfo() does 
not
> free anything, and it can be deleted.
> 
> The original patch is
> 
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> Larry

Larry, 

Thanks for looking at that routine and acking my patch,

Fabio



