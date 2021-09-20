Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C97D41174F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbhITOnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbhITOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:43:16 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F0AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:41:50 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso16910014ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fL+AzXhgquHQUasnCamb6PGeywzRH2M/eDrRwx6fqI=;
        b=XEMyYrjtQg84L9kMgSD8fG+DKeLblEtrbgWDIqGd69Okof7pacFePN+aXB8/srnj4S
         mf2CNYWwhhCqZcpw/vkVwPM7xCII3cI5Jj2SEDl4ZGqvwzHWDoZajyTDEKx29qzEUzbg
         y8gAhkGRNEULhsFI4ucL9dzazz//rcvVsd1LaR55O4yDCki2nQf8PYXy39T8eJUVszrt
         WqE+NSJKayAgw/Bcr+CylZE4pgTx3H8cSOdX/eywxFGtEw/EGokMRnizsX/ZIBmDxCim
         SYM6PPxpImEp0tgNxmPZqeQUsMu3DQeDYtnpq/Dd3Lu3ZV5e4WyskQXe9wF8nHPqxi5g
         utTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=8fL+AzXhgquHQUasnCamb6PGeywzRH2M/eDrRwx6fqI=;
        b=KE8qbXxm9MdYfCOOl4s2qTQ+z3vOwi56M4O4/jJRimiU/kHGGkpHaJa0yhAm+ASSYL
         YpJdFpKkXAMqlF+5i/AGzzTONt0yvhe3bJh/kzpjpkFuGabiHleVPaGk15J8ninTeUPG
         Lm9r1vR4ZcGHElNfbjQnG1gZbt/wTr8xcndwiy3G1bg16L5T9MllB9vSKpCvXOhmoK6S
         AnWbezv2ocXyRxnM0ebUkh3xJcx2/zzsq9jZtNeOir+AKEBjRDkyj+tjmxj3gzmzHO4k
         j/oUrKggudFoMTLFuer+4Z/GGjId86BMna2l6laFaFO/yE7nxFguWMfCsfTGVZQ6H58f
         PTsA==
X-Gm-Message-State: AOAM533EID30QYK/eHsOvaiH+bbe4HUDCMf2Y/34IAUdCF6/fO9Y7H42
        t8d8V9DEDDZLSUULxKlAaA==
X-Google-Smtp-Source: ABdhPJzeqzTCUFPHNVnz8FT1VWYkTEFb+Wl9zWx6gi1ks73px4f4Pwco1J5vRr1wzRyQ+4/1C4cPQw==
X-Received: by 2002:a05:6830:1513:: with SMTP id k19mr5690836otp.41.1632148909302;
        Mon, 20 Sep 2021 07:41:49 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id d7sm561053otl.19.2021.09.20.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 07:41:48 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:85f2:365c:992b:e354])
        by serve.minyard.net (Postfix) with ESMTPSA id 95F941800EF;
        Mon, 20 Sep 2021 14:41:47 +0000 (UTC)
Date:   Mon, 20 Sep 2021 09:41:46 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Anton Lundin <glance@acc.umu.se>
Cc:     openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Openipmi-developer] Issue with panic handling and ipmi
Message-ID: <20210920144146.GD545073@minyard.net>
Reply-To: minyard@acm.org
References: <20210916145300.GD108031@montezuma.acc.umu.se>
 <20210916163945.GY545073@minyard.net>
 <20210917101419.GE108031@montezuma.acc.umu.se>
 <20210917120758.GA545073@minyard.net>
 <20210917125525.GF108031@montezuma.acc.umu.se>
 <20210917131916.GB545073@minyard.net>
 <20210917132648.GG108031@montezuma.acc.umu.se>
 <20210920113802.GC545073@minyard.net>
 <20210920141231.GH108031@montezuma.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920141231.GH108031@montezuma.acc.umu.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 04:12:31PM +0200, Anton Lundin wrote:
> On 20 September, 2021 - Corey Minyard wrote:
> 
> > Well, that was dumb.  Fix follows...
> > 
> > Thanks for working on this.  On your approval, I'll send this to Linus.
> 
> Winner winner chicken dinner!
> 
> This fixes the issue, and now panic timer works, and we get crashdumps
> to pstore.
> 
> Great job, I approve!
> 
> 
> Thanks for your help getting this fixed.

Thanks for reporting this.  I'll get the patch in.

-corey

> 
> 
> //Anton
