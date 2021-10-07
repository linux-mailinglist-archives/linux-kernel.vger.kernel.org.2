Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16E542531D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbhJGMfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:35:12 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:53846 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbhJGMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:35:11 -0400
Received: by mail-pj1-f52.google.com with SMTP id ls18so4744836pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 05:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zcIvFiYhRKMqQujItHi+qZ6KPUhilr5DfP6u2dQO6Ww=;
        b=1LYaVjTl4eFYWsQjKkyvz55qjqUMGu+xbUVFjMERzF3B4OpvBeRq92fq/8hz4TAJzC
         M++wQkXJs/M1XDq/C/6/JU27oCXc4kJKYoookY3JbVB1Xq+C7tUfP80z5RH3JItpO0I2
         C6osG0Kf3u2wAjxeyPhEIudJKxib49Y6G67l3jC4Hw3xU6P1ZlYxRcr9zYMWwH8aRhdY
         4rliC79p8zZwqDnD1NufwE3JKUG7tpUFEwsQ82BS3QXUVpx2ezbhKk6T+PSR3eqG+rmp
         EBbMfus3rgq7Wz1wtVdme/cWVS6XNS6ild9wF8eX57iX/IEA81Dbmp/Obg/ojU1dl+Zm
         IcWw==
X-Gm-Message-State: AOAM530nfFwUYJqG+6GZDDJFbFl7pGmICp1E/NedtDIe4qKupjy8oZOF
        ec0IUAtg1pP5Nl/sndxA3LrJEpfsGNA=
X-Google-Smtp-Source: ABdhPJyifAhQo/jxxY6dX3/EePc6wFk1HhVlaqEbomvt9llg9gLGujMpVCGCxaB2r5anI+c90c7abg==
X-Received: by 2002:a17:90a:bf91:: with SMTP id d17mr5163332pjs.158.1633609997934;
        Thu, 07 Oct 2021 05:33:17 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u17sm8090786pjn.30.2021.10.07.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:33:17 -0700 (PDT)
Date:   Thu, 7 Oct 2021 14:33:07 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [lpieralisi-pci:pci/dwc 5/7]
 drivers/pci/controller/dwc/pcie-visconti.c:282:17: error: unused variable
 'dev'
Message-ID: <YV7pA/gPpS8v3AUm@rocinante>
References: <202110072056.ZVezTzRp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202110072056.ZVezTzRp-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[...]
> >> drivers/pci/controller/dwc/pcie-visconti.c:282:17: error: unused variable 'dev' [-Werror,-Wunused-variable]
>            struct device *dev = &pdev->dev;
>                           ^

Doh!  This has been since fixed in v2.

	Krzysztof
