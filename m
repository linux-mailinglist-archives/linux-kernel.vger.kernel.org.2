Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891953E36E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 21:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhHGTAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 15:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGTAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 15:00:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9ABC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 12:00:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so24545498pji.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EGk17tDDJKHOmFznPIy6VbkAZ1gOzvK0JhRy1Ul/s8E=;
        b=qOEhjBtbIXyOBljCvlI4ADH7tajHse1i85tBgjdwzp/ATU0NHVd4TJOOK9aQHiw0Rg
         fvJ4hquohISIZ12h/dH4E6xxAY2sTB+B4BDsSOj7cuZuR48Dw/Ea3g+SI3L3KiSEMgIZ
         I10pQ60ewL8NCrE2c00V2Dzt1qrcvzrZSVlzvfDReHVzZXRxGBIPoOX1YHxLA/yBQIcl
         jzwXfrAfFrBAdW0wpiwwdwnTFhCYkPc1fFYEtfUqhwKcmK30NKsCWQGGX/Mh3VLeBw5a
         vU5Jjo9ZZd4LERCOhH/JOss3xLlCXayvyw29GS5+SSRKDi2INACXKOZZ9PRnP0i7FZ6W
         Qf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EGk17tDDJKHOmFznPIy6VbkAZ1gOzvK0JhRy1Ul/s8E=;
        b=j0iHAFh4JgFGjNviDDk0CSaHt1OBp59p1MqCoQJYEfNv6kei4v7cc/wR6P+rfX6pjP
         QQiBIy3Yxo89TpxPGmvvTobD6BYF1o9N9h1ScxZEze72hdXroBjy5TUdJTbUYpdq60ku
         krr+t6RVXB6e51xwycim0dd73GcvzZKVdEE0hyu9K4A3ExOqr8ug527UPt5SSrkEXgsV
         uIdfZVvDKS09hj2MwveAsnFMO1m9cWeYRgbs/OjVQfAAsGaF+jvpknZV2Og/piefwtsR
         xyi1NHEnv//hTUArn3BtUYXwPq5ZJM+vO/kGTkB537yU4cWvvyb/OJorPUjTViqT7Vm/
         mQnQ==
X-Gm-Message-State: AOAM532Sr+HIC/4FQNJ6isYrhHn+fxjbIuQBSmhwS9VNdZgTS67ZHcLr
        qfp4hxpaeX4ZHKu2iNvFGss=
X-Google-Smtp-Source: ABdhPJzvE+ByPg3iky222S1GUCm6NQvoZYlg2lcObd/6R8awALt7DlCNHo3NMDVMyPMFdwRQv9weVg==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id w16-20020a170902a710b029012b9b9fc461mr13773727plq.59.1628362824355;
        Sat, 07 Aug 2021 12:00:24 -0700 (PDT)
Received: from user ([106.212.234.168])
        by smtp.gmail.com with ESMTPSA id o10sm11942354pjg.34.2021.08.07.12.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 12:00:24 -0700 (PDT)
Date:   Sun, 8 Aug 2021 00:30:17 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        saurav.girepunje@gmail.com, insafonov@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, will+git@drnd.me,
        dan.carpenter@oracle.com, apais@linux.microsoft.com,
        yashsri421@gmail.com, marcocesati@gmail.com,
        ross.schm.dev@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: rtl8188eu: os_dep: Remove unused variable
Message-ID: <YQ7YQTCW0kwbxuwm@user>
References: <20210807102232.6674-1-saurav.girepunje@gmail.com>
 <20210807102232.6674-2-saurav.girepunje@gmail.com>
 <20210807145042.GC1425@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807145042.GC1425@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Aug 2021 16:50, Fabio Aiuto wrote:
> Hello Saurav,
>
> On Sat, Aug 07, 2021 at 03:52:29PM +0530, Saurav Girepunje wrote:
> > Remove unused variable data and data_len from mon_recv_decrypted() in mon.c
> >
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > ---
> >  drivers/staging/rtl8188eu/os_dep/mon.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8188eu/os_dep/mon.c b/drivers/staging/rtl8188eu/os_dep/mon.c
>
> did you rebase you local tree on current staging-testing?
> rtl8188eu has been deleted... now there's r8188eu.
>
> thank you,
>
> fabio

I had not done. Now I did it.

thanks fabio for pointing this.

saurav
