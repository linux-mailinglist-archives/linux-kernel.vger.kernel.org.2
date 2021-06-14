Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554893A5EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhFNJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:14:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC4C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 02:12:32 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso12347925wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rE75OEJmRkiphAQgbNylsb5lS5RCqZ1mYOeIVhrqISM=;
        b=WJ3tpnBEfeWF0/kH/8/+lrientdHvkK3PS68x9IVO1JQSI80J/yHCOlh0IsPbvC/8I
         H0oKk58f/d6u3mGdZ2I/4JFU3VQ2jKNlcURVirhImT8qQwO27j7UMg7n5cRpDhbFAsyQ
         WBz2vIXdJr/L4A2hYljUyPHoDdib7yk46Od391zO0go6EhSbJu3Y6C4IzuOvABo9TAbI
         /83Z3taXs2o1IXw819dLQ/mlByGgjGKTGFkeSdOU3y2TKYg9IZzZCsM1JN/W82BQ1B1f
         6OiNDqPfBkF6xDlf64u8nG44qMNItoXaIvR5myFDxxc3/D1ojcgDLFi3DMjLazEXA89W
         1llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rE75OEJmRkiphAQgbNylsb5lS5RCqZ1mYOeIVhrqISM=;
        b=OLxnxercs2UKUqhfoclR/85JsJXIruqyUBD+cmoWWzojD9wyiu+Q/5ZQX9X4xpLPst
         LIeTkzrgZ9dNp95u5rI6KOpEayLn469t9i2OcPHnaRWoIJMRNKbqdC+NAKPpcrhUBFqp
         4x29DIJ83tV8BQOUoJsBndXXLI8wZ+KlxIJ1cBPGzAJeLegmptIANUfgoqyib1IkHReg
         jGdq9QHB9KLbGiroRKcT4j448dHVew8wAZ7XNYZt2WwjPSMEfHho4/C0rzF+espyqQz4
         hMP6vjIYlH5X68KCnA+R9RQrxQYooHjZg408pIKRAbDpDtL5WkwuFtnmN82i126Stkes
         Iu9g==
X-Gm-Message-State: AOAM531Z4bqPruE49KhBy9kgPI8dwmdx/1uoXo1PFKMSE7RnUIS+5afO
        qecIO1JzRK37CX1xSVJT0cG8SQ==
X-Google-Smtp-Source: ABdhPJxMA2/SLYA8c9iSQV5GCW8IQfyxI5XFtS2VihpYEMDIJhKH2AYMV290kDl3xx9dJ+TgccNGSg==
X-Received: by 2002:a1c:dcc3:: with SMTP id t186mr15902760wmg.23.1623661951291;
        Mon, 14 Jun 2021 02:12:31 -0700 (PDT)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id k16sm12442514wmr.42.2021.06.14.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:12:30 -0700 (PDT)
Date:   Mon, 14 Jun 2021 10:12:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Adrian Sun <a.sun@sun.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linux-ide.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Benoit Poulot-Cazajous <poulot@chorus.fr>,
        Christian Brunner <chb@muc.de>,
        "Christopher J. Reimer" <reimer@doe.carleton.ca>,
        CJ <cjtsai@ali.com.tw>, Clear Zhang <Clear.Zhang@ali.com.tw>,
        "David S. Miller" <davem@davemloft.net>,
        Duncan Laurie <void@sun.com>,
        Erik Andersen <andersee@debian.org>,
        Frank Tiernan <frankt@promise.com>,
        Gadi Oxman <gadio@netvision.net.il>,
        Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Lord <mlord@pobox.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Waychison <crlf@sun.com>, or <source@mvista.com>,
        Paul Mackerras <paulus@samba.org>,
        Robert Bringman <rob@mars.trion.com>,
        Scott Snyder <snyder@fnald0.fnal.gov>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        Tim Hockin <thockin@sun.com>
Subject: Re: [PATCH 00/21] Rid W=1 warnings from IDE
Message-ID: <20210614091228.GB5285@dell>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
 <YL3YMGl9kmtv55B/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YL3YMGl9kmtv55B/@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jun 2021, Christoph Hellwig wrote:

> Please don't touch this code as it is about to be removed entirely.

Do you have an ETA for this work?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
