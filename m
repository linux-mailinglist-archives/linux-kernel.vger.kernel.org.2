Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DC545B556
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbhKXHbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:31:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233172AbhKXHbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637738879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7OMKb/dKyQjD+7Ebuijop8gviQ0xaO52iurY6HFF7Ms=;
        b=iO1+v94mNylZmgixiiLOgVtReL0FM/QM7jlI+jNAojIazL5Y49gRRmHQaV9ZzQ/8EpvTtT
        YSSVp/XM2ZO9LCT/oOQ1Cqtt1vK0hGsgxJN/G1e/xEDH5BZTiywl5kfNmXGvRaiUzP+QJu
        aoYNBZqd3YagolwL77E/TTAt3ImyXu4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-C62exlaCMWiKcIZ8gN4oMQ-1; Wed, 24 Nov 2021 02:27:58 -0500
X-MC-Unique: C62exlaCMWiKcIZ8gN4oMQ-1
Received: by mail-wm1-f70.google.com with SMTP id y141-20020a1c7d93000000b0033c2ae3583fso872106wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7OMKb/dKyQjD+7Ebuijop8gviQ0xaO52iurY6HFF7Ms=;
        b=06fyK28WPVhN7uI0quV4p4v6WaCdMaT0bfkrEar6rcPe+da1RzIgwAvpJqv3r75gAc
         X32pSsJkuhl/8GOdodBn9pZ9Du+nJ4lWyMPj/0qDVFKoYFVoysxgR4PG3+G6M6r7Q9uv
         VzajxK6zLMBYCL2ufnby1qXhgq5aH5wlE+Wc6IbzUrYDXThXcGKvvJNdx935BqB8UEdJ
         v28guS85CZ168ot2kmngmUq3SefYShQ12H9WGTVPaij7QNeSPNNMQmFKWCe0mnX9k7dc
         m4uRZZdfe/qLMK/MR5yTqxxmNv0ieytS5LMVdFtr5nqRr70aG8mSCsFgyUr8Eo0O33pm
         1qyg==
X-Gm-Message-State: AOAM532A99paz1kABmGq89E5hvL+XMWNE6L7rShDFb+qC7vRNWVT0F/H
        t2wrA+n3HD3RQ0blXzDqVaAT8cc1qAFHfMVdHO0bV0t83uIWFxTOh7/u5oudUcrC4Bs5ojcFOS1
        jt3RgYqWGJMrixgB9iApkGf1h
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr12220761wmp.127.1637738876726;
        Tue, 23 Nov 2021 23:27:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKOF81PKuYHScyvKNeh2HR3n1yW8CNky/HtkVkC3Rw5qTxlFr0FyufIKB0etRC53vcTyWsTw==
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr12220733wmp.127.1637738876497;
        Tue, 23 Nov 2021 23:27:56 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t17sm446705wmq.15.2021.11.23.23.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 23:27:56 -0800 (PST)
Message-ID: <10d86e45-67fa-a361-db74-468c1cc686fb@redhat.com>
Date:   Wed, 24 Nov 2021 08:27:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] spidev: Make probe to fail early if a spidev compatible
 is used
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
References: <20211109225920.1158920-1-javierm@redhat.com>
 <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
 <YZaZpx7cudaAEGIP@sirena.org.uk>
 <20211119074015.kji2hzarevxgfl5l@pengutronix.de>
 <9b41eb05-a095-39af-8b76-a73fa2532e92@redhat.com>
 <YZ0A6rrpDlN6e5Vh@sirena.org.uk>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YZ0A6rrpDlN6e5Vh@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 11/23/21 15:55, Mark Brown wrote:
> On Fri, Nov 19, 2021 at 09:32:32AM +0100, Javier Martinez Canillas wrote:
>> On 11/19/21 08:40, Uwe Kleine-König wrote:
> 
>>> Not this affects also devices that use
> 
>>> 	compatible = "myvender,devicename", "spidev";
> 
>> This is indeed a corner case and I'm less sure what the kernel should do
>> about it. I just learned now that of_device_is_compatible() return value
> 
> TBH I feel like that falls into the same bucket as any other uses of
> spidev so I'm not overly worried.  Grepping around it looks like we have
> no examples of this in tree, only a few plain spidevs in DTs for older
> platforms that were most likely converted from board files and *probably*
> aren't too relevant at this point.
>

Agreed.
 
>> Or just consider DT nodes with a general "spidev" compatible string to
>> also not be valid. I would lean towards this one I think.
> 
> Yes, I think so.  Your other options are worth exploring if it turns out
> to be an issue but hopefully it's not.
>

I think that's a good plan.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

