Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D07540B03C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhINOHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhINOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:07:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31462C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:05:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o20so18562355ejd.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OStgA6BGSrOeE1owL122sV6WqITjN7ZcXrkuShEwznM=;
        b=QTglR5JMNhQx4U74zOjBwL5GtZPbuguosufJf1OEwvdzXd71mgIbk79C9X17SpLpnr
         dkOQ1hdfBND+joZ+ff5itcSMDjtz/deZV8ju4KBv0HrLMOz4fcFbs+Av9qveWldjVTK1
         owHg/bu2wpMlohAOXkf96a+5V/zdFGUH/jt2PYRordSNObXYnAJcoFRQmyaT5LxQhT+g
         yv00OArrQ/W2Q/16sN4NXdiP9v1L4qDgs+BqNv6NqGeL5slUPQMMA7lqKk6nBJMDYRoO
         WpczNipIffKWE4bvgZ7JtZEDbalRgdiC0+diAd/UcyJQgU9b0QwMth9vFzytepXU8q5g
         5RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OStgA6BGSrOeE1owL122sV6WqITjN7ZcXrkuShEwznM=;
        b=UUhHYkWD8NYgPbaDBCOagqv7JdYrWphCgRoUY299fkdErKTkDn13jEI0Yv1oLnR1zU
         IbPOGyuyFx/AZGYFUelix6A29cZddqULWPSHAv0onxg9ENAmx15Td0YV3v+VN3oS0A6F
         1o6QdqB3vKEfV9wqKtG10LoAKo44OOXPAJN97Z/UYP6cLeTg6PrtBsoHiy7RajIdv05h
         e82CGv3dETGRAlZvXJn1tawDhapeOfXh+MhL/cgfGGb2KAtaePZl/GlooRrVhBcTI0tT
         7q5ie9mgWY8CrmUP/Y5hftnVnM/msWGaxcEe+LWC/66Q7sWjz9Y8WFvED2JLzkxGOhMg
         m5cA==
X-Gm-Message-State: AOAM530N0YlQ/4qyIGVE/CXr3p/MG10Y7B4XGdcEFgq9zf9z5DuzL0/P
        tLjBVklMZvxaYTpPCsHelww=
X-Google-Smtp-Source: ABdhPJyA8xP5SMNVSUzytDl0/3rJYZPfHu3iQNtsEaQY0luP5yBe9fqh5Ox9Y0AgSdcAgX7dORNaAw==
X-Received: by 2002:a17:906:32d6:: with SMTP id k22mr18775395ejk.228.1631628347807;
        Tue, 14 Sep 2021 07:05:47 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id e7sm5996134edk.3.2021.09.14.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:05:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v4 15/18] staging: r8188eu: hal: Clean up usbctrl_vendorreq()
Date:   Tue, 14 Sep 2021 16:05:45 +0200
Message-ID: <11594204.TA4nE9Oavg@localhost.localdomain>
In-Reply-To: <20210914133007.GE2116@kadam>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com> <1670478.viNvIS23Oo@localhost.localdomain> <20210914133007.GE2116@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 14, 2021 3:30:07 PM CEST Dan Carpenter wrote:
> On Tue, Sep 14, 2021 at 03:24:06PM +0200, Fabio M. De Francesco wrote:
> > [...]
> David and I are saying the same thing.  "Reverse Christmas Tree" vs
> "reverse xmas tree".  It's like an upside down pine tree.
> 
> 	asfklajsdfljasldf
> 	asdflkjasldfjal
> 	asdflkjalsdfj
> 	asldfkjalsdf
> 	asldfkjl98
> 	lwkejrlw
> 	ljklkjl
> 	lkjkll
> 	kjld
> 	asdf
> 	x
> 
> regards,
> dan carpenter

Oh, sorry. I interpreted David's message the other way because it seemed to 
me that the code already had this RXT style (with the only exception of the 
"wvalue" variable that now is gone forever). Now I see that I got it wrong 
and that something got lost in translation.

Thank you again,

Fabio



