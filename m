Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA44A42EBF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbhJOIYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235117AbhJOIYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634286139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hVtSE3UAjwBOXw7iqPb3EiCk271xlAhTvppR9x36J8=;
        b=W72Pe2cCEI9McLon5buHiuyHt7Vie0u7fghypsaJtuk0U3YTmQdBs2dTdv1GTNw4xfjw/X
        7YnBzzVg2ojpObpIdBv7Ks06wrrM5CtcRIO3kCZBGgKVMboOSmojqspDFFxJ2A5KbraAhO
        YrWEYbRtke0GAWetXoOxqlbJlFgkIgk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-2PYU8ze0NdyRh2tPw_oZIQ-1; Fri, 15 Oct 2021 04:22:17 -0400
X-MC-Unique: 2PYU8ze0NdyRh2tPw_oZIQ-1
Received: by mail-pf1-f200.google.com with SMTP id t79-20020a627852000000b0044d0ecd9f7aso4907219pfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/hVtSE3UAjwBOXw7iqPb3EiCk271xlAhTvppR9x36J8=;
        b=U4EuA+UuLsVR715gVaMo2CgdoNEeDJa5oo2KfSxrXSGKvgCRYts6SzGR/falmlLIfC
         2AQHyHb1XqFBcxN6rjO8XBY/XL9T7OMWMRp2kuxyzxjxPXc8TtfVM23XssmQdN4YPY2b
         W2LdcXwGZPUSlg3Y1TuwpjNamgzzkcSl1xunvSCd6/BOUis/AHKv4mmy847XEfpN8tRo
         NPb+9Fx352w8pdDq8n1kcLIGv+nBJhAhs9+h7lK8+87yf4VDGsFBJFhYS3xAtWih0maq
         rQppqbTYYWR3V5d3DJTZW5TE+jiLDddNeS+Y78viF5wnNjqTbQIMViLTDkfgTZhorzFn
         66CQ==
X-Gm-Message-State: AOAM531ypIsdw98hI2fju6ndw8MOwuw0md8UxolM3bExBkMwM4SsMNDa
        3qOLdukYidwxDMnN15DoLHpwffW5V/uYesqj646OD2xivy+1NaWzPGxmDlXgMWdGc/o8IT0cfrF
        4zLHoD5JwXlOeAK9r6n8NF17k
X-Received: by 2002:a05:6a00:1883:b0:44c:e073:f2ce with SMTP id x3-20020a056a00188300b0044ce073f2cemr10065109pfh.37.1634286136501;
        Fri, 15 Oct 2021 01:22:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrC0PzzXQnPwaFNb+dmRT5iTWFhKV0XBcPLsrEtEELLmF3JRURWafF67rkt2hIgZ25jkwhrw==
X-Received: by 2002:a05:6a00:1883:b0:44c:e073:f2ce with SMTP id x3-20020a056a00188300b0044ce073f2cemr10065073pfh.37.1634286136192;
        Fri, 15 Oct 2021 01:22:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id oo9sm4771857pjb.53.2021.10.15.01.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:22:15 -0700 (PDT)
Subject: Re: [PATCH v5 1/8] virtio-pci: introduce legacy device module
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <17a38d70dd6f598f98eca68731746b6945a36d36.1634281805.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d6f47283-2bbf-e7b8-f52b-776914eb3015@redhat.com>
Date:   Fri, 15 Oct 2021 16:22:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <17a38d70dd6f598f98eca68731746b6945a36d36.1634281805.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/10/15 ÏÂÎç3:14, Wu Zongyong Ð´µÀ:
> +void vp_legacy_set_queue_enable(struct virtio_pci_legacy_device *ldev,
> +				u16 idx, bool enable);


Similar to previous one, this function is not implemented in this patch.

Thanks

