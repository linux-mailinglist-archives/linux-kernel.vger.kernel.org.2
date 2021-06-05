Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38739C4A5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 02:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhFEA41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 20:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFEA40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 20:56:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D29C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 17:54:25 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t9so1923160qtw.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 17:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NXAAlR719ENS+6C5c36KajeUdOG3OvOItiqbEK2oPLg=;
        b=fbuVu0lM6+/bd926/ICmPduXJesNzGTKTe750vre3Aj5tcfED1brCvXrJ7ilyOCBz5
         NTSyuzTWSH98JTZ6Jmjt46+SergozH/63ihz5vvdyZ2C67yZVW4g6MQXzXJwxobVcclL
         9FpYOlOSO787HRrEzijqzcgoWfPzqt03L8VAiGTYWKTbshFW39WZqZ00XiesaXTxglh2
         Nm8bFopSnqAfyoVli2rS3sGqYVNyzjueOxi7dno82MV/yo5qOsD5DB1JUey1QbEO+/O+
         +HI0X2Av+h5dP7G/XI2FRiI6dW/2uUTE/rfyQZlj7EtGmck54kwrc/R8/r96716B0eKj
         fqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NXAAlR719ENS+6C5c36KajeUdOG3OvOItiqbEK2oPLg=;
        b=KWx8ref3J1VY9k8lAnoI1i2u5o7dnEV6c0lnLb91HNDTAx/5QodzZpJUFr5+92Adpd
         ccRpcAoii1JmuphWpoH2YVkqwstX1ANOxmS/sadDIRahqbGr/emrcDia5qratyXHHIdQ
         tqJdzsMol1mB0f+nmU+dhg54X9h2RCY8bKrsgVtSsOTXx0faLA+RCSrqJZ8kVWKPqxNM
         emroX7pURikxl9xxy4VI+LP2M6GlmjV+6BFQatNSgMWX/9Z6w0kctCG+ZaAnfdrr4itH
         H5qiNuy5kgcabGkT/+Ij9JA2qLodLeA8/3pd69f+bK0IWaja5lbKsrROersCpdYSCtNQ
         O53A==
X-Gm-Message-State: AOAM530e3ld0+kyixf94iqZUQAlYnuoUFE1rmhPpALKBuQ2DM5uxEfYj
        lc3deDu6AVi5LDw7/npr4gk=
X-Google-Smtp-Source: ABdhPJyWUZMhqNlBfL//DMx4Q+YFN4wCxyUo84Qkhc4nARkGLqt22N9NvEaP4oQF+CJpR4QfVoOeVw==
X-Received: by 2002:ac8:5a86:: with SMTP id c6mr3924413qtc.242.1622854464485;
        Fri, 04 Jun 2021 17:54:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d12sm5060851qkn.126.2021.06.04.17.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 17:54:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 4 Jun 2021 17:54:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use list iterators and helpers
Message-ID: <20210605005422.GB255680@roeck-us.net>
References: <20210428173301.149619-1-linux@roeck-us.net>
 <20210604172632.GA1526@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604172632.GA1526@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 07:26:33PM +0200, Fabio Aiuto wrote:
> Hello Guenter,
> 
> On Wed, Apr 28, 2021 at 10:33:01AM -0700, Guenter Roeck wrote:
> > The rtl8723bs driver manually re-implements list helper functions
> > and macros in various ways. Replace with existing list helpers.
> 
> I'm testing rtl8723bs on a baytrail tablet (Lenovo Ideapad MIIX 300-10IBY)
> and applying the tag staging-5.13-rc4, loading r8723bs makes the whole
> system freezing while trying to connect to local AP.
> 
> Only a power off is allowed.
> 
> I found that commit b3cd518c5abd42fbc747ef55a5fdc40bf7bf01c0
> (staging: rtl8723bs: Use list iterators and helpers)
> introduced the bug.
> 
> I'm trying to find out what's wrong with this patch, have you any suggestions?

Some of the iterators needed the _safe variant which I didn't take into account.
I thought that was fixed, but maybe some locations were missed.

Guenter
