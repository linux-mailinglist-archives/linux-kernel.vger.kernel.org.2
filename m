Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D250D3A717E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhFNVoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:44:13 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:34576 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhFNVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:44:08 -0400
Received: by mail-wm1-f44.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso581908wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z21EI5hlHO2FdftCAK4e0yVv2XOKsZo600PaVBZ/a00=;
        b=ObiocvvAMZNg7yKn8rkioKfb/QDvHvd8PuNp8WVDyZIk/9wyvKvY4jh7QMQN/xMIiE
         j9l+My26LPg1qpgPMwU9ylX5FFwu7eYgJJ9RgDKcwan49rea/aiHfAFRHsrQxSyRn1P0
         cc3bWjNVy9xdCDDE5Zk66A1oonFWpwsfxc4/WtdH5ArLWta3srhBxsZFQ9ZmRxRgQJ/s
         4XZoPNz0iAfqDHmsUY+tHs7RXpIGl30G+052NfOqMDaQdH8ZYjqQsJ4kE0Q5dAr2Oz2A
         UJtGzgyUH5gYokaFRKqf3ldUZp0WHwZIdFiLiUcKf9SscyyHni8PSDuscK/kKR1+Nnu6
         tPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z21EI5hlHO2FdftCAK4e0yVv2XOKsZo600PaVBZ/a00=;
        b=lx5JbklMEp98iGo33l4+Im9P9jANflouRSamT3GLawnnzXmadjDyv5BZ5tRlq0cWZh
         whTS+lYxuwutRC7Fyp5BsmWMMapoy6bp/Y1uUi4IQIx/CFK1iCCPtFp+z3PvpoajVUZ4
         YdOpkfqmG66NuDLMzHse+IupV7+4+J1mxIHduvAsBQyOir2ZOdD7zXzYZAz1EPPvL4wA
         YiHbbsNHVd26KTfGlhDjzHQg5RvHdvjFFFZCdS3bi8ikGXpjB2HHyHBx2dRUVjTGDrDT
         +WvJ1xyM8B1YKXZND8qsFpMiQhqITVNLSG2I8P4rk3UMG2eGXAS3gkCweP+71AFbtqKo
         wqSQ==
X-Gm-Message-State: AOAM531tACvZJX6OMRlnbY6Z8SDZ9m1FZYKE7EjvxQJbCJ34wYspsFv4
        1B0SSkOueRPp4PPCfT2c6deVsg==
X-Google-Smtp-Source: ABdhPJyS+xO6yBb4PipX9VNgYqe4QwsaPTyUlieGHj2oegyAI79aepEXvbOTh9nArgn6YGl+hJiU6A==
X-Received: by 2002:a05:600c:2256:: with SMTP id a22mr1222729wmm.113.1623706850778;
        Mon, 14 Jun 2021 14:40:50 -0700 (PDT)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id r6sm16878726wrt.21.2021.06.14.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:40:50 -0700 (PDT)
Date:   Mon, 14 Jun 2021 22:40:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <20210614214048.GA5782@dell>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
 <OS3PR01MB65933BCAA4614F104DC8CAEDBA319@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB65933BCAA4614F104DC8CAEDBA319@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021, Min Li wrote:

> Hi Lee
> 
> Any chance that you can review this change this week?

I returned back from vacation today.

Hopefully I'll be able to clear the back-log by the end of the week.

Unfortunately, since I go through my mail in chronological order
(oldest to newest) pinging threads like this just puts reviews to the
bottom of the pile.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
