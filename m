Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA71441859F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 04:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhIZC2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 22:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230231AbhIZC2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 22:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632623215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZp3xnAES6bAUGTev2VfXmn+NF0yWoU2lNUUhQffVj0=;
        b=L77moiKVMPlw8SBVLv47MjcaB+NKBO5cFWqiL6JaiEoBvTNHok7PXynkmJPyVcLWPiFzA+
        wYjOsyfNOK3VYKdUzzKR+MvrB9N8UyhZppfLSaSzOgBK36i4UA5OpMfnWGEXeFShBCuBug
        /hTlqF2pmB7Ila28SVbPJh8Pk3VESAs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-aAslRlNKO7m84RAL6j4B3g-1; Sat, 25 Sep 2021 22:26:53 -0400
X-MC-Unique: aAslRlNKO7m84RAL6j4B3g-1
Received: by mail-pj1-f71.google.com with SMTP id rm6-20020a17090b3ec600b0019ce1db4eaeso13119154pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 19:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bZp3xnAES6bAUGTev2VfXmn+NF0yWoU2lNUUhQffVj0=;
        b=MPbmkhUC80XZTZhAosW//xsK0QLIsqRIdm1SL74WZfVBIEUypOTa8isUz+5CKYoCva
         VJiiVYdqQ0knR3ho+AJxQamG3KLmpljf0D8jB5YaMRseHH9VeZZdU86M4dU4qYyJFL6T
         6moiirqigRzgyh+3OHTH2BdWlZDi0SooeCp1JIwsJUvX8ATxxoS6lhNNB3NDak9/XJ6z
         ts1VLY2Z5dR7pgopWJSHzcFFksgl0FwN1+YdKrXjGtJOxia3BmZPhxbyMybC/zMvv/0X
         C865G0FeCnD3/aCol1ro8vptAbQ4s9sUwhJFA8r0bfJZtyqCVLdYR7PYMKO/F/EDy1uz
         79YQ==
X-Gm-Message-State: AOAM531kNvMyMVBrF44tIwrK2h1vMhBSi4GcPQ2GV6s+7RQs6uLoPobE
        e4453UctjRj19dZ6kuOwyhD4I4gjjyc0r8OvNjMWarGHwpql66bdIf52O8+psGccj56FUeoFub9
        0IwNxV1PACx0vZvO17Qc5EmnB
X-Received: by 2002:a17:90a:6401:: with SMTP id g1mr5333394pjj.228.1632623212647;
        Sat, 25 Sep 2021 19:26:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7KLo22gZhWpfJgkJwqMH222Hu0zANjiomgMWe6mB4nUvwQfhFNqK79qHgPTDvfLoznGRuRw==
X-Received: by 2002:a17:90a:6401:: with SMTP id g1mr5333376pjj.228.1632623212405;
        Sat, 25 Sep 2021 19:26:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z62sm15540013pjj.53.2021.09.25.19.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Sep 2021 19:26:52 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] eni_vdpa: add vDPA driver for Alibaba ENI
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8341d7ef-d31d-5536-864b-7d5127b7ec9f@redhat.com>
Date:   Sun, 26 Sep 2021 10:26:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/9/22 ÏÂÎç8:46, Wu Zongyong Ð´µÀ:
> +
> +#ifdef __LITTLE_ENDIAN


I think disable the device via Kconfig is better than letting user to 
meet errors like this.

(Or if the device is always using little endian, we don't even need to 
bother this).

Thanks


> +static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct eni_vdpa *eni_vdpa;
> +	struct virtio_pci_legacy_device *ldev;
> +	int ret, i;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +

