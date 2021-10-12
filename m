Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B0C42A8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbhJLPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 11:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbhJLPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:43:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8B0C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:41:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u18so68404252wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UTtSB/AxX+nSKnjq3c2L4Uc0/wQulxnMO92eFOXOlYQ=;
        b=MmwgVDETVJouQBmc3HR0QBJHA2yCYg7nOK9wdX24BdMwb15QNzWm4KcN/8Bb0oTo17
         PHkQZsm6Ngg7F/cN6jcrFT2QvAb0e92JUAVV9UA0e+NMmk2f9uKUuiWr5c3POlYf4Yhv
         zg9cBpOl7f9DSyY0tdtNUWeBNvQFH7ioHPm4ecBAXXh4kxTB4z42r0fuITeOo5QaXpxL
         WjLCPsZjLqhYFE1vpSPcS3YLbR7fhoXnUY5xIYzNlL5fbPqT2nPzsJFWdwFl6W+QcG9O
         URGwnTBuFNwURuAcuh9dJWex/Xgl4vCB2EllYmY8n6ZvWjF/0gycf4EjFG4y0qxO0Lv2
         94Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UTtSB/AxX+nSKnjq3c2L4Uc0/wQulxnMO92eFOXOlYQ=;
        b=QMpMzhwsCZVlAeDvcpCGQWnO9LUqQPWqK8d63xSB+uRaQkMcNQnlb51+BNepjN/4Le
         oneqpg9sXJnLtRl/ZA6ctwR/j79IHdw5c0AZ4j2nzaEK4y9d3rHhy2z3dktqQUvxH1RI
         jKYWSb9N0wlpthMZF7BioF+yHSuHX4/vE3mtqJq4jOz3ZTywmdXKg6Jyn+CjOeunxmmn
         Lj+d014Sgj+wgmJ5s5/54S4GY7bSCByHDNI/JmkraARbZC2/duwj5wjBduHUDvPmePlQ
         ZnRSRk50iiOlGLLw1NPSGaChgNYzO1mzLa9LlN/+WGOMK9h2sMn5m6WFD2KkYWx9IeV3
         k8wQ==
X-Gm-Message-State: AOAM530ScCYe/6mHbhxFlwQeZ4wc40Ts3EcXClEJc72aSvMRv/qu8drk
        WBuRkUFIW1RTaqXv60a//JqOfg==
X-Google-Smtp-Source: ABdhPJwxDHwuJQc5gA52Ios6lKJyqwI1A27lY5AbKwzJqazbY/YH/HnLJtkOUMdNrZRwnolvQW8Iug==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr6436165wmi.170.1634053315482;
        Tue, 12 Oct 2021 08:41:55 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:4e93:9fa7:4d66:4f5c? ([2001:861:44c0:66c0:4e93:9fa7:4d66:4f5c])
        by smtp.gmail.com with ESMTPSA id w5sm10829357wrq.86.2021.10.12.08.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 08:41:55 -0700 (PDT)
Subject: Re: [PATCH v5 5/8] drm/omap: Add global state as a private atomic
 object
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        Benoit Parrot <bparrot@ti.com>
References: <20210923070701.145377-1-narmstrong@baylibre.com>
 <20210923070701.145377-6-narmstrong@baylibre.com>
 <2609ca32-90e8-1335-2769-14dcbcdfafde@ideasonboard.com>
 <ab06e379-1579-2352-3525-dbdca6a94f9b@baylibre.com>
 <00ad704f-cd01-cfc2-0418-1cb0561c41a5@ideasonboard.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <aa8eb332-83d9-2212-2d3d-cb5ad40ef73a@baylibre.com>
Date:   Tue, 12 Oct 2021 17:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <00ad704f-cd01-cfc2-0418-1cb0561c41a5@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2021 15:38, Tomi Valkeinen wrote:
> On 12/10/2021 16:23, Neil Armstrong wrote:
> 
>>>> +    struct drm_private_obj glob_obj;
>>>> +
>>>>        struct drm_fb_helper *fbdev;
>>>>          struct workqueue_struct *wq;
>>>> @@ -88,5 +105,9 @@ struct omap_drm_private {
>>>>        void omap_debugfs_init(struct drm_minor *minor);
>>>> +struct omap_global_state *__must_check
>>>> +omap_get_global_state(struct drm_atomic_state *s);
>>>> +struct omap_global_state *
>>>> +omap_get_existing_global_state(struct omap_drm_private *priv);
>>>
>>> These could also be separated by empty lines. At least to my eyes it gets confusing if those declarations are not separated.
>>
>> Atomic states can be extremely confusing, and hard to track.
>> I checked and they do what they are documented for...
>>
>> The omap_get_existing_global_state() is the most confusing since the result depends if
>> we are in an atomic transaction of not.
> 
> So here I was just talking about the cosmetics, how the lines above look like. I have trouble seeing where the function declaration starts and where it ends without looking closely, as both lines of the declaration start at the first column, and there are no empty lines between the declarations.

Ok, it's a legacy of the 80chars max, will reformat.

> 
> But now that you mention, yes, the states are confusing =). And this series is somewhat difficult. I think it's important for future maintainability to include explanations and comments in this series for the confusing parts (plane-overlay mapping and state handling, mostly).

Yep I added some hopefully useful comments explaining that.

Neil

> 
>  Tomi

