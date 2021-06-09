Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D87D3A0940
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhFIBf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhFIBfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:35:25 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49FC061787;
        Tue,  8 Jun 2021 18:33:17 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso22310241otu.7;
        Tue, 08 Jun 2021 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y+Gv8RpwQ/0Fdi5PTBLJL1r54nosJqzKDzXmUWr8YWE=;
        b=IdiC6/WBNOz+N9t1ajJjCOaE13Xv/NnHt34yZjUc4p/WqRR8C68kWonJm7tWfZd5ED
         MmetnF1k7E2V6IY2MFWSS89DwezgHKBDXIT2tejtjSwbVbkuVuXmuHGxurd1phGqsSnS
         6zFLuGWDGivOrpdRKiMzIl7uNy7DwkYopGa5OvJFiL2bbidCnX+8kNm+VBLE8x5Ef7l/
         fxReepZu+vd61i9WC/7nCsc3E/0LEQNLChYfHI9q0P/QrTNpYClLOR4OfJJGmC0/3n+O
         zClRoT5aY+oaM/SEBEzjlyQwzFnkRghApuAOB7wShDG6SCOFiZEWYaoGLTKlbqOiM2KL
         CeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Y+Gv8RpwQ/0Fdi5PTBLJL1r54nosJqzKDzXmUWr8YWE=;
        b=PS6ybcw8NNnI7fDAXBn99xAgQUC/Y0zY4q4sQWdz1wtgMQpV5yECTNuvt2DlgdbQF6
         RzlXHMAj7JGgBSA6eqGhw87g4sZWwquq+EM+IHLqebE/a37FTwQQuPoWWyTj278+KICS
         SycUt7Se2Z06XXXNYER8chMUPBtRWavv1W9nKgsXitV+VQ6DxXWH8uVI4cT+PHrjkG2r
         1OxCnRE1cqt08gnSVOVOAAle8jqBLaKy9ySfMiumTtTDrzC5Jw/ehhvO2ix6E/nyvMTo
         +5WootVK45gieMrXwwRcwEoL5QRyVaVMVTzjkDZeU23OZKmPi8clS031r6G8NVLuOzyU
         adwg==
X-Gm-Message-State: AOAM5327CmNuytMuT8/L7VbBTRfWKDU4eDCR4AO/4PfBbLXFbLZsWrUK
        RbvGoGoFedy7vNbNMInfcG+INPVIjfo=
X-Google-Smtp-Source: ABdhPJyqq1MGujtoYYOPqjwVx+9bNapmUv00YgHwZzoAQZvK58fRCNDHpOuVUFbkcEsUk/4RNH480Q==
X-Received: by 2002:a05:6830:19fd:: with SMTP id t29mr15709132ott.296.1623202396764;
        Tue, 08 Jun 2021 18:33:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o14sm3224809oik.29.2021.06.08.18.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 8 Jun 2021 18:33:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] hwmon: (pmbus/pim4328) Add pim4328 PMBus driver
Message-ID: <20210609013314.GA1248285@roeck-us.net>
References: <20210608104416.6941-1-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608104416.6941-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 12:44:11PM +0200, Erik Rosen wrote:
> Add hardware monitoring support for the Flex power interface modules
> PIM4006, PIM4328 and PIM4820.
> 
> The modules are equipped with dual feed input and has support for
> hotswap, holdup and various circuit protection functionality.
> 

Please re-send the series and copy linux-hwmon@vger.kernel.org (not
Dlinux@...).

Thanks,
Guenter
