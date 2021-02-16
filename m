Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1717131D269
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhBPWCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBPWCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:02:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E4EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 14:01:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v15so15140316wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 14:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q/ewxnk0aYvnPGeUt2ZuJDAaVJgJ4X1z+2lefCJIaxA=;
        b=ABHwdjsloFI4xNT1MOn9nvUOR0+2MjiTHTp1JSejwWZdpjFSfJ2axhjmcAT9BiG6vl
         IACPpRUViD+LzlJalE0nh+BDl1bIUoo3zeUx7jeTp7HKB7LvfB8obs9tXMMIi4nuviUF
         nmKR6Zq9IOvzLbx5MEk2khYb/tVLFwVo72WTOtgHepKlvkthnSy3t92vFgslAbbxNPcJ
         q2lgT++NKaNBtvuzJqK4izr2ynBjFSkzVjKicbR1NN1ZhLon19L2c6IwR8o7NSAG9iFJ
         R9rtyphk6lKoC93YYWXLLbgzfv1cnRYcj9c6+SUcUESKspVVgljyRICWAiW/2FGGQ7Us
         Htqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/ewxnk0aYvnPGeUt2ZuJDAaVJgJ4X1z+2lefCJIaxA=;
        b=qcFJzVzTqk8kfP6GGWu8a0KoTVAbiAjJNh3srhAiKNKDNkmQiyiVDRNEFrrFsPcKpn
         iRKHl0NgBRb8sypSr2fSLNvrQPaRrlzeXS+lU+9yyyph5Z2R88bNjWGDSk6UP5iy/Seb
         ziA15i1v3BCc9br6wcnUtVwJfsmYHGd/ZXOZiJgOvWp4RXNOXnnC1nDezEW7VJ0qINSU
         mD+uxvqDQ2DhXjERBY5ceYQ6M93xa9fOwYF7ienuI8PHgi8OX3WsfXPjikoWtBtL80dL
         SAZEhuepQG8MqirKJxEP6sWbaxJwZr0o6t4nKIQSAhArYORg5eSs3vf8EXmex2vzyo0c
         fl4Q==
X-Gm-Message-State: AOAM531+9PsiXIBWXESEj0hedm8X88WeDQfKXKsWCTqoCiVxt0ATfaDW
        QZuD83u8GmklwRG7u/5FOKdO8Q==
X-Google-Smtp-Source: ABdhPJzo5h2X2huqBWTPTdm4R3AqUQ+W12CJua3Rv7aR8FeRdKd7ZCHtpnCzP0fQZISAKEnvJ2Q7oQ==
X-Received: by 2002:a5d:5910:: with SMTP id v16mr15097676wrd.304.1613512896747;
        Tue, 16 Feb 2021 14:01:36 -0800 (PST)
Received: from kernelvm (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id z2sm3725wml.30.2021.02.16.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 14:01:36 -0800 (PST)
Date:   Tue, 16 Feb 2021 22:01:34 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        vkor@vkten.in, insafonov@gmail.com, foxhlchen@gmail.com,
        linux-kernel@vger.kernel.org, yujian.wu1@gmail.com,
        matthew.v.deangelis@gmail.com, amarjargal16@gmail.com,
        pterjan@google.com
Subject: Re: [PATCH 0/6] staging: rtl8723bs: remove DBG_COUNTER
Message-ID: <20210216220134.GA82202@kernelvm>
References: <20210215233440.80617-1-phil@philpotter.co.uk>
 <20210216092438.GX2087@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216092438.GX2087@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:24:38PM +0300, Dan Carpenter wrote:
> Looks good.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 

Thank you Dan.

Regards,
Phil
