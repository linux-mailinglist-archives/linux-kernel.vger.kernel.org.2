Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB393ECF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhHPHPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbhHPHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:15:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39E0C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:14:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so10952601wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E7eQnXnZH7iFuJ3XmJwQ4GomWFlgLsrkSimeTQa7III=;
        b=A8J3bXdYUMLxQSgsMfUpB3y0Zk4iH5w0w14a1DfTpaGhQVPs+eNwxCIh1nw7RDGDkw
         0oSTJeHIQ8v6vBilBtp7ItLioFGKkKwPUky9Vd5VMJFAqyI8+WCUqPpa7P4Z1CW7tWMr
         N/GuFBju1AcjJL3fs1v6ExN5c9aOqQNC+/e44wWzyLt6kibwDzVImpjoQpWdmjEUEqBs
         auNQtZF0CdCTOAjcIzNhNrej+wrpOPoD2FNBDZypBPSERSaLJNdMUsjeLyV4HSvbSJHI
         LElI7iDutGF4lWg30JbkeONwR/og5GuM9PN3R2Xujwm+i+XzYESZdRF6VlPYGQVh2bJO
         8Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E7eQnXnZH7iFuJ3XmJwQ4GomWFlgLsrkSimeTQa7III=;
        b=b34OUNsZSNaNDG5nnU+wV0ZWvqGIyAasdyg5iQXY6+SXsmJqOdeq6JPTgT3x06R+3w
         i7LvfM+ip6EjdLewIl9P7hikhcbppT5cutog+UGU4OLJpfgOxl6XDzVi7dVY2x4nw/kG
         PFLYo/4WJ+H2umtulSdmmQyF7qqV8/sGvtgvYgF4zzQn5tTpX4zJjySGMscwJYvwugAo
         h3dzij7uyEAqrgRS9UegzI8Xo0XG/s3wLNUHHCuoipWORj21AgI2LFIjv7Jp8f+mMd9D
         XoTFte9Chhi99Gvq+R2wpt1ct+YVuectNMNttmqWjpRAXLPND7Ax9Kf+srYjmWDolxLs
         tJKQ==
X-Gm-Message-State: AOAM530tXwMU8r9BplkYpNz2/D5qTHlM4nAjpvCBp3WHvlywSTpb9MR1
        93TImJXXRj699zhAzhjXKsvF9A==
X-Google-Smtp-Source: ABdhPJzYC526t8f315NcpYgoC4MkUwm3UII0piSXQ/CWMVdXxYhy/wvTnvlU4iQOoZBr5WpNIB3lHA==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr13424130wmq.159.1629098071223;
        Mon, 16 Aug 2021 00:14:31 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id z19sm10760853wma.0.2021.08.16.00.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 00:14:30 -0700 (PDT)
Date:   Mon, 16 Aug 2021 08:14:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v3] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YRoQWCAWC8R27/XG@google.com>
References: <1624034232-7952-1-git-send-email-min.li.xe@renesas.com>
 <OS3PR01MB659329DB91410939ABEB5621BAF99@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB659329DB91410939ABEB5621BAF99@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021, Min Li wrote:

> Hi Lee
> 
> This is Min again. Any chance that you can review this patch next week?

I applied it on the 13th July.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
