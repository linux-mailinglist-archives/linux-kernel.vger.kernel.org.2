Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74E130DE18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhBCP1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233491AbhBCP1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612365949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+OO0QGxJRxpJr8sMMpFu2qoMc9u5TBcGuWeR7oxI9E=;
        b=hlytZJ5mRvFF+Jg/t2k7BZjAaEASgeQdN9AGYHmd3gCLiD8PDpDHcXoc/TsvhQ787eUgEI
        tPFKqtb2OOahFO8Z2iBo1vyxtBGlmmHBEowHaoKulojwQWWOojPLpCP2h4Wl9/DaH+9t9w
        bUNCU72Aj7GPAb+hwvgAJ0WgSoh4gfQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-J1NpUJCSPzmDcHiKnKnXqw-1; Wed, 03 Feb 2021 10:25:47 -0500
X-MC-Unique: J1NpUJCSPzmDcHiKnKnXqw-1
Received: by mail-qv1-f71.google.com with SMTP id n1so15278365qvi.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b+OO0QGxJRxpJr8sMMpFu2qoMc9u5TBcGuWeR7oxI9E=;
        b=PmmZS+ADkhJ/irU1UflAIQy1ZyFT0PlJV4jhDe1MJd4kk+i1war7xTpcQJi91uUjOh
         1UOPJLKTTdMrw5qwn0gq98B6A2GooQU4iiijJBXf8VkuYBHhYCtvG3j8lBkOMDxPBRtS
         ZD5cL+7bJktmlV6SquR/6werK+yVMKhJ0hWDIZXJVwIRR5qAM9kLETgslFFSj0/wXtiS
         j9UJfZjfl0uKUCnJVlGJIRFHdYxfwHAD0AP4Wy/u7tNmk83HMCldJtoGOGs6tmIKm6EA
         HxZX+nIfLSjXYr9SPLwma4LfI/fqq/C8Qng8hhcg5WRzq0KqIOpUfi7VgbaPCOlldTZT
         L95A==
X-Gm-Message-State: AOAM530XFW80ityHNavzJUnsjpAZLOSN9/NE0HFOn1sXALpfEjNopV0b
        9UOGVLxasocY0bg71voNeqAnrG9aReT0ycZ3+oRbyzssHeP0gi9qslOBjM5L7Du7BG+G1xgrJpM
        a3FqelHP9eTCq777VHvSVMWw0
X-Received: by 2002:a05:620a:9c3:: with SMTP id y3mr2924146qky.327.1612365944733;
        Wed, 03 Feb 2021 07:25:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZiAJoPsyG/rAEqjnRYQc8ncW+O35t7mvbUzNxC7oC8T/VxmCoGLid3marDzevZGs1K7oJJQ==
X-Received: by 2002:a05:620a:9c3:: with SMTP id y3mr2924127qky.327.1612365944419;
        Wed, 03 Feb 2021 07:25:44 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q11sm478459qtp.49.2021.02.03.07.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 07:25:43 -0800 (PST)
Subject: Re: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210202230631.198950-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <15f90871-170c-3487-0f99-47cf54163bb7@redhat.com>
Date:   Wed, 3 Feb 2021 07:25:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210202230631.198950-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

..snip..

On 2/2/21 3:06 PM, Russ Weight wrote:
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index 576e94960086..e5020e2b1f3d 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -80,7 +80,7 @@ struct dfl_afu {
>  };
>  
>  /* hold pdata->lock when call __afu_port_enable/disable */
> -void __afu_port_enable(struct platform_device *pdev);
> +int __afu_port_enable(struct platform_device *pdev);
>  int __afu_port_disable(struct platform_device *pdev);
>  

Should the '__' prefix be removed from __afu_port* ?

This would make the function names consistent with the other decls

Tom

>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);

