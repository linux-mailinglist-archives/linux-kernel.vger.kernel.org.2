Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660D8442618
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhKBDgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhKBDga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:36:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92088C061766
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 20:33:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s24so13899104plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 20:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9wL6e6Rl6omDkjcl8QpQbRrkQlAk7mdAPYBPin+CVyw=;
        b=sr9LMU/0B9YZmnps9ZwovfhG6XGReafmiDTIHlX7hKnopo1nuSLxf60/tLBQZE9nyi
         YuKBQIyUOkLtGmCthfnxaNxHUlYhvle3LEAtlIN9WRM+05Swo6BlvUiABoEHgP9Z8Gye
         ZBEDZd2Hkpo4WBpOJppuL/YEqqCjv9IjlkGpgQopb7uPsTorsXXqZbgfRct8JHjqJsxS
         8hf2j/oOaBcRj8U3p2Hc6VwFozosrefUDG8YbOyM4p44zlvZyne4axnuuoEo1iGZ9fHv
         YdSbyBGEtUM4LCrA3axNztJNJlrvB8tWOhq23mA1FootsUHnSMq0P7Griia6WSuzjynW
         rbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9wL6e6Rl6omDkjcl8QpQbRrkQlAk7mdAPYBPin+CVyw=;
        b=P772tIbhLZjwt3zx6Si42RK0+wGKVK0mCCMz1MgXCthoihg/TDsvGuQbFKTd4GdpK0
         vS+CX9eiRe0p8ABIanoieHt9XBf8XAG5ZWLvIlEGVRcfuc1trPYrnmcjltiv7iq3Zl0k
         Utl4FYZuahPhqBzKaC7GgLwO3+L3cQ9YblJfWE2E8CTI88ShK3zPluZTxtXb0R23MjZU
         628OnIadjqOjvq9e0QRz1jg6qhFB2mUowjdMCaowMjB6WMdSNl3EF82X6Cm+LYyVk0V/
         WudgFL5p/o07//5hylShMQaPyyHC4aqG49AfKsBccuj/pNv4N+S4M1/Jp8doRp2j7P3F
         37BQ==
X-Gm-Message-State: AOAM530pMLEDeAtwz5SkSysI6YND70NAgClfXQJDd8lb8X/+ZmhHSqMx
        t3EDRfc94y31AuIRXpjwK+Q+zQ==
X-Google-Smtp-Source: ABdhPJx4N2536lXrqEoILHMVErOOpiqbnJ3ORZ+r+y1oWUc8bc0saalhkhVXA+jDAws5J37zsepRfQ==
X-Received: by 2002:a17:90a:191c:: with SMTP id 28mr3498852pjg.121.1635824036118;
        Mon, 01 Nov 2021 20:33:56 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id j6sm14002047pgq.0.2021.11.01.20.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 20:33:55 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:03:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Jason Wang <jasowang@redhat.com>, linux-gpio@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_gpio: drop packed attribute
Message-ID: <20211102033354.rka35agybojk65n7@vireshk-i7>
References: <20211101091122.442512-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101091122.442512-1-mst@redhat.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-21, 05:11, Michael S. Tsirkin wrote:
> Declaring the struct packed here is mostly harmless,
> but gives a bad example for people to copy.
> As the struct is packed and aligned manually,
> let's just drop the attribute.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_gpio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio_gpio.h
> index 0445f905d8cc..25c95a034674 100644
> --- a/include/uapi/linux/virtio_gpio.h
> +++ b/include/uapi/linux/virtio_gpio.h
> @@ -25,7 +25,7 @@ struct virtio_gpio_config {
>  	__le16 ngpio;
>  	__u8 padding[2];
>  	__le32 gpio_names_size;
> -} __packed;
> +};

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
