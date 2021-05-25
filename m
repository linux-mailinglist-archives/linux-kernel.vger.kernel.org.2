Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A7F390321
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhEYNzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233517AbhEYNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621950776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PW7OrrfjfM61YRapb5tPZf3kCsKbCNzZN/BPGRKNoNU=;
        b=hhsZqvbLUmNdI9nUTEu6pqq0wvEEUdmGPqttIsrdRkyoW0hJ/GH/KRq7J9sISzJgdJ293D
        bqazXXt/2eBPXTdrtPxNaUwtEroJF+iDaqH4Egw5aixQIyJ5OYCCK1nnJzXzMA4TkUOGie
        rIhf5+6ycbO7gffOuxxflGUF/Phfcns=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-X-EA_lcONvuZj6b1GGgkqA-1; Tue, 25 May 2021 09:52:53 -0400
X-MC-Unique: X-EA_lcONvuZj6b1GGgkqA-1
Received: by mail-wm1-f69.google.com with SMTP id l185-20020a1c25c20000b029014b0624775eso5931693wml.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 06:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PW7OrrfjfM61YRapb5tPZf3kCsKbCNzZN/BPGRKNoNU=;
        b=ib7nnx5vI/KGyrPch2xRKyeHSaDqE4/HBFIoy0ERtdbkNSaVEZro0kzg/66NnIfX6e
         IgMuvBo5mIPeeoKqVTrK7E7vVOo5GeRVnS+uqTtDItgZn5Ow/yduAHdZuGSd93XSzVSm
         I9gqd8K5afRESkg5jJV4jq1oSvpMx25G+KV6XwyecIC5cLlpJ5h5akbfSNlQQwE9EjVU
         bYjTUp5pKKWWdxLu3xB7qfanQ3fqTmcxa3QLBvzUGCwkd1YpoXy//krCiF+hz23dxRQ9
         RLDsyghemTmkdCbp1K8vU6qVV48BEyf/BdjcbtLU6IBnrmDhyQfC756j9h/n4BqZ/oKc
         QUkQ==
X-Gm-Message-State: AOAM5310sx9dT/iIiqwtLUiaLUUWgvN8e5QEv1ovNzT75h/oEz8h8l7w
        6Qkn90NuXvLIP0VcPTdD4RjhSv6Qr8msSWB29ZXkjKak+qBi23cIm1Pbg7B2UYYeyl4COXf+8Cq
        IPjvRNRbVVfgnU3CLnZv89DBL
X-Received: by 2002:a7b:cc83:: with SMTP id p3mr24768903wma.169.1621950772424;
        Tue, 25 May 2021 06:52:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoD0S7iFDYWpnFLr+WwG/M35YgaD7ABz77zKNWv7ODMUul6QdqZLBzVMLAVnyvv7vXt1v2ZA==
X-Received: by 2002:a7b:cc83:: with SMTP id p3mr24768893wma.169.1621950772267;
        Tue, 25 May 2021 06:52:52 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z18sm16767823wro.33.2021.05.25.06.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 06:52:51 -0700 (PDT)
Subject: Re: [PATCH] drm/fb-helper: improve DRM fbdev emulation device names
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20210521131910.3000689-1-javierm@redhat.com>
 <YKfS2GDCXPJ/q8gT@phenom.ffwll.local>
 <3a6f9235-5375-b2cb-2d63-a47c5f9752bb@suse.de>
 <bfd6fa47-497a-64bc-c2fc-a081bd41d5ec@redhat.com>
 <fc6540fa-1945-a15d-239d-e87bb4d3fa9e@suse.de>
 <YKz2vbxYXSKQE1Ng@phenom.ffwll.local>
 <4e81ab57-a240-952a-7423-22dc830bc62f@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <79f227c4-5ed6-23e8-2d74-3197871359f8@redhat.com>
Date:   Tue, 25 May 2021 15:52:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4e81ab57-a240-952a-7423-22dc830bc62f@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 5/25/21 3:34 PM, Thomas Zimmermann wrote:

[snip]

>>
>> If you guys with your distro hats on all think it doesn't matter, then
>> yeah I'm all for dropping the somewhat silly -drm or drmfb suffixes. I
>> think that was just way back so it's easier to know you've loaded the
>> right driver, back when there was both drm and native fbdev drivers
>> around. But now I think for new hw there's only drm, so should be all
>> fine.
> 
> Suse doesn't use fbdev, except for some outliers; most notably hypervfb 
> and generic efifb/vesafb. Both are now being replaced with drm code. 
>  From what I've seen, it's the same for other distros. And X11 checks 
> for the existence of device files anyway IIRC.
Yes, I believe is the same for us.

I'll post a patch to just remove the suffix then. Thanks you both
for the feedback.

> 
> Best regards
> Thomas
> 
>> -Daniel
>>
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

