Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9E357CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhDHGrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHGrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:47:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818CC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 23:47:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h10so1011983edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eEMG+quC1tEexFmdg2ovTE5avx1YqEXkN0uVd1QBehA=;
        b=rFE+UkPyGFvebDufiBQLobp12xwMIBjhS9/FzqNoWvSUBpXxRepEofAoQUN0hJLKIX
         RQbrvbTD2v87/xTEDzhdNUsADb6D6FvnDXFkMp/9qsHWtER4oTzfY5DlO4NEzHHaacuM
         kY43Yp0/3t7kBAKkGpOvRVMnQb+JflNmptmhNA5rH3Rx+39HXUeKx7mQTPi2F1uKGiLY
         KAVY+cJwA2QBqwT7F6XnuAkd9XCqLzjgAYi6ruI2A6TNBLHuvtZ7VxB5Ua++L8atXnSm
         HgzXsqvt5rMaBljfw5xBRrYwT62CficZrcsBjOLYyYRP/WVB3AoVRmSfZYTZso3ihTU2
         7Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eEMG+quC1tEexFmdg2ovTE5avx1YqEXkN0uVd1QBehA=;
        b=WPbFOneKfipOL92PuTF6vowa3TgH7Qx4dnasps7crZLBGapE1Ba9au4bZMSFOh/1sV
         JCx3TDsGqDRzfr7NbkTyX6FQyIYxW9ButAgyWqHvNUi4x53HlhPyYzBzjSYwZGKF6LRr
         zDLPlHTx6tLvcuU2HSpTZeYGajRKHPXEfwfphoiQT14swnPR2amcqe0t2r/bSV8H0yso
         IVkY2bnnYttr27NAmfRkD3WsoorI/uOSGlLH2s6Z1C3s+phnkeQ0ToB3WooIi04PBRYI
         eV9rdnAbZsyIxQ6GGJ+06SFXCkfBQ/z9BaDuyyup0o/sAFaOCzyruWIzoa8vDtGsq6eB
         2npQ==
X-Gm-Message-State: AOAM532L21rDG7v1KU6U1+r25UeITeS7go90L7oj0x3R0IgIHB7n82GD
        eAPF7cbZ5SJWOeSLZL4JqU0QDrNKJGtYHC24
X-Google-Smtp-Source: ABdhPJw7LHzQhaZo08cmoZgbty/zDZFqVTEi2zswHvc26002BUm+57Da0wjO8KoGx+zRifxI/sj42w==
X-Received: by 2002:a05:6402:3092:: with SMTP id de18mr9089033edb.96.1617864444634;
        Wed, 07 Apr 2021 23:47:24 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id w1sm9087622edt.89.2021.04.07.23.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 23:47:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v3] staging: rtl8723bs: hal: Remove camelcase in sdio_ops.c
Date:   Thu, 08 Apr 2021 08:47:22 +0200
Message-ID: <18387208.g0g5C3WDPH@localhost.localdomain>
In-Reply-To: <YG6hsvA54ieV6ujj@kroah.com>
References: <20210407181914.7079-1-fmdefrancesco@gmail.com> <YG6hsvA54ieV6ujj@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 8, 2021 8:24:50 AM CEST Greg KH wrote:
> On Wed, Apr 07, 2021 at 08:19:14PM +0200, Fabio M. De Francesco wrote:
> > Changes from v2: Remove unnecessary comment. Shortened a function name.
> > Changes from v1: No changes to the code but only to the subject for the
> > purpose to differentiate this patch because other removes of camelcase
> > have been made in other files of the same directory.
> 
> The "changes" need to go below the --- line, not here in the changelog
> text.
>
Sorry, I knew that. I had already done this in other patches
but this time I got distracted. I am about to send a v4 patch.

Thanks,

Fabio
>
> thanks,
> 
> greg k-h
> 





