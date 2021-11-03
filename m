Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34754446E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhKCRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhKCRUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:20:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68D9C061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 10:18:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y196so2556689wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QmVc9Je73rZQ/JXi2kSeHK45robtjQUCtsTvhzPdR/Q=;
        b=f1kzxmILHxk6ryEldtMA/STMiylac96ou/kUudthn9UoTm1IWCCwnmHEwKaBbm+mrk
         qG0XG8lcutYXlOXFoi8GSwcV1qKdrVA/KNM4K2Ba2aPGJbQo38gReTEG8jt1cvhLA/3A
         uNtFn0QgRGcvb0zOkD6TQsvAcG3NDbyjcOw9XaydNhzLKEQOB4DAtxDs+BqP6N9bSmoV
         vfTiDSVUnLTyP/U5b0swS3Ih2G9wzRztSRqCTaJ4fIjtuOg5a6/0Rm8lLKITUfMZPRg8
         6KgBA8zosImuHahkRQi9Q0ecFSEw+RWytxDe9DBpsu3UFSfm1owaO+sPWVRLBF9u1ScQ
         GDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QmVc9Je73rZQ/JXi2kSeHK45robtjQUCtsTvhzPdR/Q=;
        b=GSRfx0oh4iy9zC4E4cCf1ZqKwhcGkVVgPim3l0n2ng0ppK/ISVMNv0Nstltr/GRfJR
         eS+R5/rxXLcWSxtBVp534NNTksF0UY9qBf5aJIWw8JFuiwJpDTZoBllfTEQO9b78P+z3
         l9pHBC3VtCxBPNMxmWgp2ouA7AIJhBq6GvlTUjtrsZBr5xLI3K3RJ/VwmZz5utaN49GS
         NFMfOKMOOuxjcCEQ5VlUHJItczOkDTQU745VXuodqImUqxyhjflAyYRPVt5Mh/J4Iyoc
         J2b6Dilk7Hy36DSG3l5MG9k+3/6rS4Faybkp1vF/pZBXx2oe8mXNNSKar2jtXMFKcFeR
         Iglw==
X-Gm-Message-State: AOAM533AsVt8Ff0wbp4wMSwtfbB8TYMxqhO8MTUQFqVxl+qnhMBA909Q
        MUzGeIn0rYZObnYm8IouxnYBSQ==
X-Google-Smtp-Source: ABdhPJytEVA3WQjrHJG2sA/bxnMXKTuDgE7l0CN2G/o7J4Vi5JAQr4pbv0uZCl/6aR4hMNxR40Tmlg==
X-Received: by 2002:a1c:9dc7:: with SMTP id g190mr17055937wme.130.1635959880277;
        Wed, 03 Nov 2021 10:18:00 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b10sm2637233wrt.36.2021.11.03.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:17:57 -0700 (PDT)
Date:   Wed, 3 Nov 2021 17:17:56 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] backlight: lp855x: Add support ACPI enumeration
Message-ID: <20211103171756.wxthncse2f4syeiz@maple.lan>
References: <20211102225504.18920-1-hdegoede@redhat.com>
 <20211102225504.18920-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102225504.18920-3-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 11:55:04PM +0100, Hans de Goede wrote:
> The Xiaomi Mi Pad 2 tablet uses an ACPI enumerated LP8556 backlight
> controller for its LCD-panel, with a Xiaomi specific ACPI HID of
> "XMCC0001", add support for this.
> 
> Note the new "if (id)" check also fixes a NULL pointer deref when a user
> tries to manually bind the driver from sysfs.
> 
> When CONFIG_ACPI is disabled acpi_match_device() will always return NULL,
> so the lp855x_parse_acpi() call will get optimized away.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
