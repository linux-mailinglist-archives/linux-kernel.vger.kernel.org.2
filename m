Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0B3124FF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhBGPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:12:50 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:35913 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBGPMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:12:44 -0500
Received: by mail-pj1-f43.google.com with SMTP id gx20so7344077pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 07:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHTl9VWjh3GJQucuZFlEVWf9/8TYlq0t85oO56hFUTc=;
        b=pUxooSCP5koLDjP/bXc7CquqW1B7qKv7QEnkHtaQ0unF3Cl+7ImSFxM3gfVlAYGtNP
         zAaD991Nb6rvhKq5wD7CpvkejEd6EWQfGawMQL2g69wNFBONZs6E6OnlWQm2TkTuTcU0
         oyNtFw+R/rWy60hSdqwLXpR//bmcNVI9xIMZIzZnKYPzHRZwv1QFmJXriovvB8qUDkFz
         3ExcoZQTBNDyzaaf6f6PERcF1rUHZJffRkUdJ2JAgfX3LdnLueCRabMN7AausOilxGEO
         wDIvcD7WLiMMyD2paVxEkoCmfW0EEpjgcwXg292AX9YbcUckAt0ePELzAXCiGuexJ9am
         CVfQ==
X-Gm-Message-State: AOAM5335juos7P4Jawgpu1aN9pmzzeT2/Gdf3fPe+Fn8Hm94RFUuKjvD
        DdBH1p0aJlARZD464r3FUi7QkGsxhn9w+Q==
X-Google-Smtp-Source: ABdhPJw5xwH7aOA6xnIlIm61lbjMQcXiU6LelQmNN/puDBx5uud/3/m6liFM6qVQrIHDzjCQjTVHIg==
X-Received: by 2002:a17:90a:1503:: with SMTP id l3mr12696581pja.41.1612710724011;
        Sun, 07 Feb 2021 07:12:04 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.2])
        by smtp.gmail.com with ESMTPSA id i14sm9851597pfk.28.2021.02.07.07.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:12:03 -0800 (PST)
Date:   Sun, 7 Feb 2021 20:41:59 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
References: <YB/2Uvj99+sReckM@karthik-strix-linux.karthek.com>
 <YB/6ZmZwCF3jeEue@kroah.com>
 <YB/9hS2S1oaCmuDq@karthik-strix-linux.karthek.com>
 <YB//EZl0aeLk/y+E@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB//EZl0aeLk/y+E@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 03:54:09PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Feb 07, 2021 at 08:17:33PM +0530, karthek wrote:
> 
> <snip>
> 
> For some reason you sent this only to me, which is a bit rude to
> everyone else on the mailing list.  I'll be glad to respond if you
> resend it to everyone.
> 
> thanks,
> 
i> greg k-h

ok anyway

Those both lines(from, signed-off-by) are exactly same, what's problem
with them?
