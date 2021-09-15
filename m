Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BCF40CB98
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhIORYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhIORYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:24:06 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57C2C061574;
        Wed, 15 Sep 2021 10:22:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f129so3426977pgc.1;
        Wed, 15 Sep 2021 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=if+Oxfc9r3mAC+EiZGn7r+WWYsmde9lhPlbyKnYhzuQ=;
        b=GE3mQtMTDx/kVYzMVBOCMACL/4Xp8c0yfrYkMB0Pu3uYdGXCAkmkGBRFWkb1a6MW77
         IoXoHR3l1+dCt2fLHAhRsiIlXyv89LKJRnKfVHR59vcsx/saKoa6KNJ5NPfUlNfh5RTe
         Y7G67uo4sHDzQLgfSeXoyMX3o28zfSRSDl/xMbzElkMhdfTNnq1FupLRcX1iCnSzPTbT
         CrQbRyGm9+Klqv1OU48+xNIfjntBsDmfUN94p/LX4lhcLwgWO+7SyDQhFDiYLdP+Oy0h
         0s4I2jySz97+qDFbxgiTCS7XzB2gyF4uSN1kKr26F8E2MT+kEpM0g8vWUkBMlvC/unj8
         ytJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=if+Oxfc9r3mAC+EiZGn7r+WWYsmde9lhPlbyKnYhzuQ=;
        b=CVM9MpfMbdxCKczkLIvxOz+gVcdnZqPvx1v7RHUN7fl6QNxUwBLH6z8plpTuLwGV4i
         VjGsByFYplE52psfpxl7lYM5yNlIBAbTdKCuU4KdOgVvn98dNaClR/hZns0rRSCvyduj
         bkYAmxYIiyxtrsuqpDBMD43vYsSfB97CqLy7JFZg+r91yTZ5zqkpWPUl5YcK/A++n5pg
         t0XXj/sxBXlORNOUxc00BCcrX1PlFf4vf+MsCc8Sg0zKWY+7vTf3jODkokSFL5Pg1LWt
         rX51ThC28zhmGu22YOV+pXMlU+hX8EXObdl/cYs0qMC4dn2YZqgMdK59D9QoL6WO5ZKf
         v2Xg==
X-Gm-Message-State: AOAM533A15PzdRvuVKtii81VKyHQ8yC7gjd7dRPr/+wL5p4oNHb+cOKy
        a4JFoSMSfIIXj5NmSAf9/qvUvlDQ7ec=
X-Google-Smtp-Source: ABdhPJwnmJv9hJ3KPXAGXT/VeLTWr0f+Q2dKPsemiEfsjoB2wkJAac9lyQCubsBIkVCVVBxiGACOYw==
X-Received: by 2002:aa7:8481:0:b0:43e:c776:e20b with SMTP id u1-20020aa78481000000b0043ec776e20bmr730488pfn.45.1631726566687;
        Wed, 15 Sep 2021 10:22:46 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id v8sm5088615pjh.24.2021.09.15.10.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 10:22:46 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] extcon: usbc-tusb320: Initial TUSB320L support
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210901161339.223973-1-y.oudjana@protonmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <46b969d0-9039-67e4-53f9-c461718ff089@gmail.com>
Date:   Thu, 16 Sep 2021 02:22:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210901161339.223973-1-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 9. 2. 오전 1:13, Yassine Oudjana wrote:
> The TUSB320L is a newer chip with additional features. It is close enough to TUSB320 so it works
> to some extent out-of-the-box, but for some reason it can start in UFP mode which is not desirable.
> 
> This series adds support for reset and mode setting for both chips, and does that while probing
> to ensure the chip starts with the default mode of following the PORT pin.
> 
> Changes since v3:
>   - Remove unused tusb_modes.
>   - Remove extra blank line.
> Changes since v2:
>   - Read state before setting default mode, then update it again after resetting.
>   - Remove mode tracing from irq handler
>   - Add a delay after reset to handle tSOFT_RESET
>   - Use a separate mode setting function for each of TUSB320 and TUSB320L.
> Changes since v1:
>   - Split first patch into two patches, one adding support for mode setting and reset on TUSB320,
>     and the other adding support for TUSB320L.
>   - Fix dt_binding_check warning:
>     ../Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml:15:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
> 
> Yassine Oudjana (3):
>    extcon: usbc-tusb320: Add support for mode setting and reset
>    extcon: usbc-tusb320: Add support for TUSB320L
>    dt-bindings: extcon: usbc-tusb320: Add TUSB320L compatible string
> 
>   .../bindings/extcon/extcon-usbc-tusb320.yaml  |   4 +-
>   drivers/extcon/extcon-usbc-tusb320.c          | 156 +++++++++++++++++-
>   2 files changed, 154 insertions(+), 6 deletions(-)
> 

Applied them. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
