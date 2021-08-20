Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703FB3F29DE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbhHTKF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237085AbhHTKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629453919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GG+WwY8t9kNcO21SWNktAH0sK+js5lPhS1V+A4xkDog=;
        b=C1mBatXQ25U6MoCKnPb89CHdqm3jk8KYyX6ea0RE0tdHbQa/EH34lV+EcpGqoms8sPZhnM
        z02u8SHBWPJ1j8EfkKI5tW2zzNmfR8hMGbMNjBWEROLXiSDFoVFvINnzai/s+FGpSp9ELs
        D21bVj7OOTAqyZLcx+C4NSvLr3DNuUc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-kLjDdKzcPwGU9nVzZ6oabw-1; Fri, 20 Aug 2021 06:05:18 -0400
X-MC-Unique: kLjDdKzcPwGU9nVzZ6oabw-1
Received: by mail-ed1-f70.google.com with SMTP id eg56-20020a05640228b8b02903be79801f9aso4260930edb.21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 03:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GG+WwY8t9kNcO21SWNktAH0sK+js5lPhS1V+A4xkDog=;
        b=lDlMfPRN5KhY8R9QM7Gl2jul9SP9cxEwpJlVLzazGAa0/3mDK1o0qLvEhpPJ8h2WFP
         wqKcsrPHPeuap/gAHQRM6i7Et0hj8nsB4PH6OlReoduAlpRsMNB5QKKLrRMDlpTUe0i4
         cDIy1FPATDJ5XCUORHQqd6k463o4t4CthrqPnIsRjr5Wmp0V85aETQTti5xPtHzcCO/h
         eA2XlRzrc0mqVWvoS6p4mTCGP8C52EwtRNJ1AO3bnLP9RCxAUGovs2UJZ/uj5N3An6yF
         9iYMM+HWawO7uigMorsi3bllCi4W3+iU/IDAouKYDlz8GkuiS81aN5x/Y3MD8JsbDRch
         GlCQ==
X-Gm-Message-State: AOAM533XY/kEDt5VnIqOSOk410C+RNXwIU+LGSKCOpagJsASAW1YPQPp
        a6GfUDyolfaamQHABBtGoLNImJDhwG4wuNA0LqQS1SBJ53Wt9NB9ADyEB4Sj0qr+8gEhiOdTuYs
        6BFAAgmAG02sa2Hp/RENI6qbq
X-Received: by 2002:aa7:c585:: with SMTP id g5mr21297512edq.340.1629453917339;
        Fri, 20 Aug 2021 03:05:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9BVyOnzAFrOSm0z+04j//k8Vozy/wuvc5CtI84RxVhxfVpOShGX+Kus37622YuYsH3O5EWg==
X-Received: by 2002:aa7:c585:: with SMTP id g5mr21297503edq.340.1629453917234;
        Fri, 20 Aug 2021 03:05:17 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u17sm508662ejt.39.2021.08.20.03.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 03:05:16 -0700 (PDT)
Subject: Re: [PATCH v4 0/1] asus-wmi: Add support for custom fan curves
To:     "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     hadess@hadess.net, platform-driver-x86@vger.kernel.org
References: <20210820095726.14131-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b94a452c-696f-d879-d239-701223c8caff@redhat.com>
Date:   Fri, 20 Aug 2021 12:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820095726.14131-1-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,
On 8/20/21 11:57 AM, Luke D. Jones wrote:
> Add support for custom fan curves found on some ASUS ROG laptops.
> 
> The patch has gone through a few revisions as others tested it and
> requested bahaviour changes or reported issues. V4 should be considered
> finalised for now and I won't submit a new version until V4 has been
> reviewed.
> 
> - V1
>   + Initial patch work
> - V2
>   + Don't fail and remove wmi driver if error from
>     asus_wmi_evaluate_method_buf() if error is -ENODEV
> - V3
>   + Store the "default" fan curves
>   + Call throttle_thermal_policy_write() if a curve is erased to ensure
>     that the factory default for a profile is applied again
> - V4
>   + Do not apply default curves by default. Testers have found that the
>     default curves don't quite match actual no-curve behaviours
>   + Add method to enable/disable curves for each profile

You are sending new revisions pretty fast. I don't really have an issue
with that, but can you let me know when you think this has stabilized
a bit ?  Then I can review it when it is not changing so much anymore :)

Regards,

Hans

