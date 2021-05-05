Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B5373E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 17:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhEEPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 11:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhEEPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 11:11:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87DC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 08:10:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so1338310wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DVmLzOMSAp4MzyBbE9IavSC4LhAdh9HISmFzp/3ey4M=;
        b=PX1CStE/I9J3q2IioHK6rLAPgNG2uQMGooDPLqVfOPEbs5iV4Dysl8GxmNZ9f7HnEG
         dHUkYska5PMvwywUux3KhNAAXJsKPPe3E8yk/53tMJVYrDYuHwO8CjNOXdvn7r6a5iHN
         awUELTnnM6GVm0sdm3u4KLCz7hLYNRvaOVgwkomXWWNBKuZXzo9YiyhchLAmO+fyWo9V
         kBsPsIiKVQiKlWFKE84faQ1yUgkIE6XFlowfw3i7RkByMrRGCitnNEhZ37Keat+aOcYZ
         xsOKNbf4G4D2SLyPIHJXbXrpNkL/DPS808MqexuN8D5esQvnqUfYsGkrV9MKcCJMNmvE
         v+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DVmLzOMSAp4MzyBbE9IavSC4LhAdh9HISmFzp/3ey4M=;
        b=A3Q+YsU/yVXCkCdJ9Y7y7imjRH51zQ/FKCeFTXztaE+lQs4KFJGNtx2ZWozLF5h0vZ
         1l3QC9PncDbw3AkQotJE3oP9AXZiyXiUCD8B+FOYS6QgCMcCy5mZMHD5JywPu+v3SfGk
         qPEU9pB3B004o15tlSHyHyxsC2dYhInWwv3nyXtR+jTMZtI3A9gAaoGXzZ5xh1dC2JJC
         eth41ENSMuCgPBbHSEtYVS+ZVZI4Wpy51MI/thXRkRWuD/UZkOyUiFyca98GgLzUDHM9
         lAPtmSkY78bcD7vgGhU8HdxKy0zYz6MXgUF62NApZW524oSDgw++h7vXTbf+A//oX8My
         pDHA==
X-Gm-Message-State: AOAM531RNI4ViBHV5y/PJg6/MALn6NfHDYANhn2R48+PEgLAtQkMiw5z
        b+iyrvDIAK9cwLkx0eZ/fg9sqw==
X-Google-Smtp-Source: ABdhPJy8nlJ3qXwtvGqfZLn39XjnqS6y85vyrZ8H+l0LX0opXU8h1lq+H+YOBMHVhce9a2ebnvx21w==
X-Received: by 2002:a05:600c:228b:: with SMTP id 11mr10351164wmf.6.1620227434761;
        Wed, 05 May 2021 08:10:34 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id c14sm8482425wrt.77.2021.05.05.08.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 08:10:34 -0700 (PDT)
Date:   Wed, 5 May 2021 16:10:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <20210505151032.GA5109@dell>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
 <TYCPR01MB6608C23DE6681CF77729C04ABA599@TYCPR01MB6608.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB6608C23DE6681CF77729C04ABA599@TYCPR01MB6608.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 May 2021, Min Li wrote:

> Hi guys
> 
> Can some one please review this patch? It's been submitted back and
> forth a few months now without a meaningful review. Thanks for your
> attention for this issue.

Please be mindful of the release cycle.

The merge-window is currently open.

A review will be conducted shortly after -rc1 has been released.

Please be patient.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
