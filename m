Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95531F566
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBSHn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSHn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:43:26 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE09C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 23:42:46 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o7so3235200pgl.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xuJKMqodZw6yBHjtrjDkBXosHWYiTB930PIXPwR5Klw=;
        b=GB06yo+q8+65ZQSHM3Jp5gbH+h1ewa/IEnk9yfinSlQpsIY96VA3LaEKMZ6hCXufKW
         UPjnHDVaZe2ac34qaTeAKdqeBgfN0bEl7WGZxtklql4VgN/te4e3qXwBamv2IwHz9qly
         UrqbfDWN8rpA/FHNRx1TYmQ5M9WKsBtXxd+KEyRAI1OBwnXu0PrMc3l/cEkzDGSZ3vCc
         mQahqJtXuECDSbo9my8yZmYPPSsPOic01PxAr0h42iahWB0Wa7Z5tmaTteR0l6D6LoeW
         xDoT7BrayERQKVMpeojAA2G9WdZo92UCe/mAUyT6nDcivkK63j/60gR2zpQNG5MKuUvG
         AXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xuJKMqodZw6yBHjtrjDkBXosHWYiTB930PIXPwR5Klw=;
        b=QgiyxmR9oR6uRG7kZhpYp+u+PVBf7Ygoxrlcc5isz+qeohJ+uZKLmplHJmaNMl34Ch
         90lU3VHN9LmHBhSlXEVD86yGw+5ir7p/NYLKPOBL2S0qTNoNvKwrEQLLto2MVPyY7ZJg
         BWdcKqQLrBYUcV+iooEpXGA5Lb+t/VQb9ZdzXhGh1jdUsnSFZ9vpdhL2duWqI697vP03
         LMV2YqaNt8B9qWESkn4/ef00hgGsLif7FwzEfZF+iP0tnjvDcaOcgXjMBpQhIC3bUm4b
         xfRjwyM6AqliEzFTm8PJTxozo+OAT9ZLmr7kcolsgljoFi+VmSfU4CsDIIdI/BkUGU1x
         L3dQ==
X-Gm-Message-State: AOAM531LdCBTrJyxXOmYK2PEzwzUWqQStjkzOcwX0XmwOV7V9/74Xqzx
        zNyBBErwLIqY/7W5qzi/r2gQcdK4Ojg=
X-Google-Smtp-Source: ABdhPJybhlPyyJIz6HRLY9B5E2HzzH0nTkfNcm3VCrQJJE1JUV8d7RKZtZDZ6VkJia8LIbMhcqmtQQ==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr7326259pgk.61.1613720565479;
        Thu, 18 Feb 2021 23:42:45 -0800 (PST)
Received: from atulu-nitro ([2401:4900:332d:41e0:d86c:60a5:c3:7d1c])
        by smtp.gmail.com with ESMTPSA id j2sm7371655pgq.34.2021.02.18.23.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 23:42:45 -0800 (PST)
Date:   Fri, 19 Feb 2021 13:12:39 +0530
From:   Atul Gopinathan <atulgopinathan@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: comedi: cast function output to assigned
 variable type
Message-ID: <20210219074239.GA4525@atulu-nitro>
References: <20210218084404.16591-1-atulgopinathan@gmail.com>
 <8f73b7a1-02dd-32ef-8115-ad0f38868692@mev.co.uk>
 <20210218104755.GA7571@atulu-nitro>
 <YC5bsXa+1KSuIh+v@kroah.com>
 <20210218125220.GA19456@atulu-nitro>
 <20210218155159.GL2087@kadam>
 <20210218164128.GA9289@atulu-nitro>
 <20210219065514.GN2222@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219065514.GN2222@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 09:55:14AM +0300, Dan Carpenter wrote:
> No problem.  These days I have fibre to my house, but I still remember
> trying to clone the kernel when I could only buy 20MB of data at a
> time.  :P

Whoaa, that's tough! Respect to you for still trying to contribute
to the kernel. Hope no one gets such a situation. :D

Regards,
Atul
