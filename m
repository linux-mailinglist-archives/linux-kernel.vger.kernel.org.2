Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DFA3A3752
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFJWqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:46:35 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55282 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFJWqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:46:34 -0400
Received: by mail-wm1-f49.google.com with SMTP id m3so1817522wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L9Zxj74oCQK3jH0pzFS5VeFrkuqgVWHZv+3oj2SKFSE=;
        b=oPdyl42BfktkhaGMJ8Z/bWhE5J56cvh3gOM0WJGfci4Jbwsal4LwBPPppceKeQMt3P
         aJfhq6BEK3mvMoDIoKEX7w9spDXGWuJ6R1b1tzTg9AIz4li6O4F7jFkzGcVLcLyb9Qv2
         Jfa+SK5VeNBGYhSUbJ+7IMW6plUTw0fODD6/1NdX4TB1xQ1aX6zAMGj7mv7k68FxNAg8
         5D+ec09OzuVpoGfjZcSEoeAoF2MLYgqjvBO7k1CeBL3V7mV7T/n+MMx6qywCGAWkm8U3
         s08R3lem1M1XgnU6wAhRY+SOp2ZwGjI81FzzDtTlJt42GM87yUtlKBpKNF/LJaY8Xl+X
         JzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L9Zxj74oCQK3jH0pzFS5VeFrkuqgVWHZv+3oj2SKFSE=;
        b=KPQrclgIDUJ1G06YEIoog32DGilYqJ3XL6s80xRfezSd/wRqN0lO3doVSLo1ngyAOI
         EsUDDm7BQHn+oBcqc/z2Oeiqe5Rbmw0jJtz3MwriRD6RxWzc4ckpMkG5mIqfGo/nbqva
         b/zNZBHcadglR6Ko/X/ohkq3jVCX4Ki9ijsvisoGINUOCE6Jjb3OCk3TWVj5xd08EMO8
         fp1HSLnLSQbl5Imf+JQ/gnP20BwUPM4eyJkOfo64ujPpPlrYP5RwX5liZkE/BZRDFYEH
         hUe3tHUT2Mg8faxwlzjS4cBfJD9pStxseiYIX5BTGnUrINHUNX0QalCjiEdSgJzw3DaY
         8tfg==
X-Gm-Message-State: AOAM531q4zivVqY6W+QwkCiKUGp36uWnT9NICZjabPiFcqZtn2iZzBb5
        cJ23ljdxVyf/NNge4gna4OadgA==
X-Google-Smtp-Source: ABdhPJxfHoAeJnu14bJsUP3jRULG6F7yYEMGgb26pkQtGvQytp2Bm38KUVStozmrGDxiNGy92KRNzg==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr17329393wmc.96.1623365000973;
        Thu, 10 Jun 2021 15:43:20 -0700 (PDT)
Received: from KernelVM (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id b10sm4466588wrx.57.2021.06.10.15.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 15:43:20 -0700 (PDT)
Date:   Thu, 10 Jun 2021 23:43:18 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, kaixuxia@tencent.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: replace two ODM_RT_TRACE calls in
 hal/phy.c
Message-ID: <YMKVhgwbfLqWH3bd@KernelVM>
References: <20210608235609.6726-1-phil@philpotter.co.uk>
 <20210609092106.GE1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609092106.GE1955@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 12:21:06PM +0300, Dan Carpenter wrote:
> On Wed, Jun 09, 2021 at 12:56:09AM +0100, Phillip Potter wrote:
> > Within rtl88eu_dm_txpower_track_adjust function, retrieve the struct
> > net_device pointer, and replace both calls to the ODM_RT_TRACE macro
> > with equivalent netdev_dbg calls, as well as modifying layout, wording
> > and spacing slightly. The purpose of this, and patches like it, is to
> > eventually remove the need for include/odm_debug.h, which is an overly
> > complex way of printing debug/tracing information about the driver.
> > 
> 
> In the original code DebugComponents is always zero so the ODM_RT_TRACE()
> stuff was dead code and could never be printed.  I would prefer we just
> delete it all instead of fixing it.
> 
> regards,
> dan carpenter
> 

Dear Dan (and Greg),

Thank you for your feedback. I will just remove all the ODM_RT_TRACE
calls in a follow up patch set in that case.

Regards,
Phil
