Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2AE39DB3C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFGL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhFGL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:28:42 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E28C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 04:26:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso16294592otl.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1R/0jEahsgVmz19yd9MfRXa5dIsPrCAKGQ/qRWmt3w4=;
        b=sHDj5xh/kQEP5Eri1Zy6LzrrK4wsZNn3FUNaSSdtthZVPdY+8e7nUfz2JhzXzlNGKM
         bnRkt6nJRA76irflia3gQ3kRweRo10I8RqjlbVj10yrFtjpMqWsiqyonmaf0+mu4btm8
         brUbyBfzU/iCM5HeHuVrz4daIxiJyBHkNUOXytlTn3EwI4ret5ixR4wywZsnai5ZllQ+
         sUOGA7zvlltVBbutIyZ3LZDQcKGAOzrfc4ExpFMf5GG9bLUiVGjoa3IqsOyQ9WnshMHS
         p1bBHeBBvgIMRApO2Pzuv3Q1D9nxVrUnm5ZCPsCnXhYWDZP6vNJ66pYCuLF0hWw6Qxt5
         sZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1R/0jEahsgVmz19yd9MfRXa5dIsPrCAKGQ/qRWmt3w4=;
        b=f0ch0yWrzENDDd19Heskf0U8U+CqHNWEUvOYNOLN8lhikbap4qrcO1mrDEnxHUl01z
         Rsnm6T/u7nxwJiFNk33ua+LbUFbDami1O5roDdCCIzQQ/xjz0Iwck9np/pAcsklhhuOS
         WaZ/McMO+qgXWdRzzgZP9E+o23I63KLZt1uL2wp/Ypn5+w7yhAfIlP/c2ddgM+tOsb2S
         RT27TocQ3IOdUwAUWkwQ2sTw8fBqRLHcPF8oylOiV3MiXpcPpiflxez+hOdK4qOm5m0U
         95nbm5I1tOAUW9l9pXQ4eNbNkd2Jv1x6ZoXS3p4ykrDgKiNlGKggtYP5JDC9QX5hfq96
         2Qmw==
X-Gm-Message-State: AOAM5323fR5xWoL3ZFHNCFo4UdAJfPkQMKUKkMehkYgfZN09vJIu3Z7M
        qYjUCgd8DzRm2xmXF1V7zf8=
X-Google-Smtp-Source: ABdhPJzAQnbKKUpILUTU2nWGFoqkG0Gu2iEAt72uOrtphnULjb9EkW4zPQnG1moZVPNXDMA8ZSol6w==
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr13202993ote.316.1623065210351;
        Mon, 07 Jun 2021 04:26:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c13sm1245151otr.23.2021.06.07.04.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:26:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 7 Jun 2021 04:26:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use list iterators and helpers
Message-ID: <20210607112648.GA314533@roeck-us.net>
References: <20210428173301.149619-1-linux@roeck-us.net>
 <20210604172632.GA1526@agape.jhs>
 <20210605005422.GB255680@roeck-us.net>
 <20210607111704.GT1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607111704.GT1955@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 02:17:04PM +0300, Dan Carpenter wrote:
> On Fri, Jun 04, 2021 at 05:54:22PM -0700, Guenter Roeck wrote:
> > On Fri, Jun 04, 2021 at 07:26:33PM +0200, Fabio Aiuto wrote:
> > > Hello Guenter,
> > > 
> > > On Wed, Apr 28, 2021 at 10:33:01AM -0700, Guenter Roeck wrote:
> > > > The rtl8723bs driver manually re-implements list helper functions
> > > > and macros in various ways. Replace with existing list helpers.
> > > 
> > > I'm testing rtl8723bs on a baytrail tablet (Lenovo Ideapad MIIX 300-10IBY)
> > > and applying the tag staging-5.13-rc4, loading r8723bs makes the whole
> > > system freezing while trying to connect to local AP.
> > > 
> > > Only a power off is allowed.
> > > 
> > > I found that commit b3cd518c5abd42fbc747ef55a5fdc40bf7bf01c0
> > > (staging: rtl8723bs: Use list iterators and helpers)
> > > introduced the bug.
> > > 
> > > I'm trying to find out what's wrong with this patch, have you any suggestions?
> > 
> > Some of the iterators needed the _safe variant which I didn't take into account.
> > I thought that was fixed, but maybe some locations were missed.
> 
> Ah...  Crud.  As near as I can tell Martin fixed a lot of these in the driver
> he is working on, rtl8188eu.  But they still aren't fixed in rtl8723bs.  I looked
> at the functions and the following loops need to changed to list_for_each_safe().
> (Doing a search for list_del_init() helped during review).
> 

Hans wants the patch introducing the problem reverted, so I won't bother
sending a fix. Sorry for the trouble. Learned a lesson (I hope).

Guenter

> expire_timeout_chk() (both loops)
> rtw_acl_remove_sta()
> rtw_sta_flush()
> stop_ap_mode()
> 
> rtw_free_network_queue()
> chk_bmc_sleepq_hdl()
> rtw_free_all_stainfo()
> rtw_free_xmitframe_queue()
> dequeue_xmitframes_to_sleeping_queue()
> wakeup_sta_to_xmit()  (both loops)
> xmit_delivery_enabled_frames()
> 
> xmit_xmitframes()
> cfg80211_rtw_del_station()
> 
> regards,
> dan carpenter
> 
> 
