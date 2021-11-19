Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06A45722C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhKSPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhKSPz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:55:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FACEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:52:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b12so18897191wrh.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=URGGz2DffAqjn0dAbbmnD9qwB9QB95QEBB6LZZJOy3c=;
        b=LKWVO4if3eKNyClg05m39utn0okgtHUyAVEtBUCMmgRTN+4H4oEST79JdJVSjgLjJ4
         DU8Az3lHgHg/ihHnFJNfcZNvaqnZwqLDv/Vja4P3sKDdeRfszD2tbga6l7rq2aatyH3u
         0n0Mp2gJjs7YN0WUvjtUcXyO46AcyJ3WwhTu8WvfPObCQKNMIg9kmtB5OOPQOmWcEVkQ
         eqHJpKxVY9Rkf0JYtsg07xizvSEFcFtJ37/DCsDosceBy/usy+5/2RZKV6ONLV7d1kj6
         YYFub/2xEVmjd7pit9cExrU9xaCmcAjAA3PheClCHNuBzavMIiamkWjtQkMiYpsC2AuV
         GYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=URGGz2DffAqjn0dAbbmnD9qwB9QB95QEBB6LZZJOy3c=;
        b=Bxf/NPy6sWqNuj1WEbb5H7mov3Gb7CwnjfFPvSRrS8ShoKKyC3V6fBkF61Bx4EMnHs
         Mz0jTaiS3w4QnKe3Ek32b884/Shi/xAZfb2XSC990lWEEDXRNpABLhNyo93GFMznPXh8
         r4sMcsbhM3EnOQPTvEKdt6DW7Q0wb7kost+OMy8z1XosflfYeEW3rH0qZ8Ii08GgHNhI
         h4GOa13qQbKeGOF5dL6VMtiFlpfIxXWM7ljgAg7x5/hteWQEpMZswGABATwdro44yiq0
         Zhq4fHj6piGh7InpnrtCUWIal513KVl1szORsq3EzqxYa78RaPw3pC8bhiRA0yK6Vp6i
         8C/Q==
X-Gm-Message-State: AOAM532En1Ab6HKiMb3nh0VuukPxSLX3BbkK+mJfp3wNm2V1bLU5EgK3
        rqG7UbQU/eV9rJ/no6rlA235tOBiOdfHSg==
X-Google-Smtp-Source: ABdhPJzUBoYaVrTLL0awLWU/Y+x9YspluWNm1bh+LPesKtEwGqjBhkEp74V0VHLwqKydQeaR1HKOLA==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr8777969wri.69.1637337144186;
        Fri, 19 Nov 2021 07:52:24 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id z18sm146300wrq.11.2021.11.19.07.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 07:52:23 -0800 (PST)
Message-ID: <04bd3abf-44e3-ab2d-7226-b12ff951cd26@gmail.com>
Date:   Fri, 19 Nov 2021 16:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
 <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
 <YZfEHZa3f5MXeqoH@smile.fi.intel.com>
 <f1a90f53-060e-2960-3926-e30b44a1be28@gmail.com>
 <4a39bc52-53ff-ca79-8d34-4310b2894f43@gmail.com>
 <YZfHi0GXk129wmQE@smile.fi.intel.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <YZfHi0GXk129wmQE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/21 16:49, Andy Shevchenko wrote:
>>
>> I think the problem was in
>> <linux/memberof.h> requiring NULL from <linux/stddef.h>
>> <linux/stddef.h> requiring memberof() from <linux/memberof.h>
>> or something like that.
> 
> There is no memberof.h in the kernel. Something is done wrongly on your series.

memberof.h was my first addition in this patch series.

Since I replaced (((T *)0)->m) by memberof(),
and that construction is used in <linux/stddef.h>
for example for sizeof_field(),
I included <linux/memberof.h> from <linux/stddef.h>.



-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
