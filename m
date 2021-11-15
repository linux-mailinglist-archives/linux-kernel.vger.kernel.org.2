Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81D450515
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhKONOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhKONOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:14:09 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533DEC061714
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:11:13 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c4so15003538pfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ROQCjN5k2UVnWi2zQNfIiQtMQl7MmqXKJ/5+MhErzDo=;
        b=zggvuMC9M0eHUvSUyqa7tJvLh/y0iQYZN4C464D9f5aQz7qaVDsolc3tq33SAFA6Fo
         vp6BBdl39AEnUfr5RT4GakwkGMbQvHfejCrrLzYAZ6+f6II7l3SGdutl3QEVjsSamrDh
         BoVvUU67a1h7VPNn5m+f8iz2WJz4jnQzhkRFHfPyXAna39hfbYyFyx2AY3LbURYEDX3M
         KmY5Kse7evxEuNEKAhe+umLvFzjE8Frzx6frS5nitNRw8EBw5aXq1X97cEv20hgcVrQC
         tddppToqj9lVpKg6r9zl+kWVLVNLcS4VvfHE1QB5jkEUruFSKFi/Mf5qnLzGyButLVN1
         cHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ROQCjN5k2UVnWi2zQNfIiQtMQl7MmqXKJ/5+MhErzDo=;
        b=EYCClJb1I6hbzuDePxGP2mTnx6PL3QojxcdJo1S/OsE2gIEtrIH5yTpE3qTFcA63hl
         FH2bbuRdgt+TuQFErmqfBWO5htIzgxAJCInhex752HoIAMZPrYSgWawMbzkOqYDu9MRS
         oQ3PBzR937+j+O5B57RKtUiqURK195kiCkkODCmcYTD6ah8IX4IA2w+eSOTIECwgqjaC
         zQPrn9s5oMimjr4K0EyX4004REswwICTRlsyuLyuuIpgV2nyLBctF1HUnJwy+yQOG+yM
         wZ+yoO6K3qrP/w1b+uYex4qwVSU8QEdWMT45zYYwbHPCddZ9VBdcb9NErrvfJi3ecmNF
         vV0A==
X-Gm-Message-State: AOAM533IukK+UyiSDJDY/qF7raYa7oYJ7ZT9yA2e+GuQdkMUaWQfa0l3
        VK+GwIhkro/4msaDd3Q1V+tKnQ==
X-Google-Smtp-Source: ABdhPJwyVSeiAp2rJm2KcS0PXuotYeFbe/pDzTBO9nopAz1aF6VfBFx1Q3EpqVlgfmBO40wzvZ9q+A==
X-Received: by 2002:a63:788d:: with SMTP id t135mr23986887pgc.2.1636981872533;
        Mon, 15 Nov 2021 05:11:12 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([204.124.181.117])
        by smtp.gmail.com with ESMTPSA id c20sm16705942pfl.201.2021.11.15.05.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 05:11:11 -0800 (PST)
Date:   Mon, 15 Nov 2021 21:11:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Ruyi Wang <wangruyi@huawei.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>
Subject: Re: [PATCH] mailbox: hi3660: convert struct comments to kernel-doc
 notation
Message-ID: <20211115131106.GB265221@leoy-ThinkPad-X240s>
References: <20211115033119.11175-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115033119.11175-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 07:31:19PM -0800, Randy Dunlap wrote:
> Convert hi3660 struct comments to kernel-doc notation and fix
> other kernel-doc warnings:
> 
> drivers/mailbox/hi3660-mailbox.c:47: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Hi3660 mailbox channel information
> drivers/mailbox/hi3660-mailbox.c:62: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Hi3660 mailbox controller data
> hi3660-mailbox.c:53: warning: contents before sections
> hi3660-mailbox.c:67: warning: contents before sections
> 
> Fixes: 41c0e939d70d ("mailbox: Add support for Hi3660 mailbox")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Ruyi Wang <wangruyi@huawei.com>
> Cc: Kaihua Zhong <zhongkaihua@huawei.com>

Thank you for fixing and improvment comments.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
