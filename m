Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBED37FAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhEMP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234485AbhEMP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620919644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syc9KYvk2Qv0VepNu59RlX1jozcF6x0a6FAg9dMOIuw=;
        b=Ad2XCciOgvc+RdHgDIEGyBKrpkVs54tBJAmUwr5e8eC3/UpOnqksK9SXb28krI+YNwQhHe
        4VniHtiMADIO3VxjPQ67tGDZK8w9JNp0DSrTAF8mk30Hh5h2yx+YUPucTD0MUU+5jpCkKe
        7HdoFwuLUCWZxD5Ha+KOYIG6wIVNVwI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-RT58LSglOW64drxMGCUwfg-1; Thu, 13 May 2021 11:27:21 -0400
X-MC-Unique: RT58LSglOW64drxMGCUwfg-1
Received: by mail-qk1-f198.google.com with SMTP id u9-20020a05620a4549b02902e956c2a3c8so19689058qkp.20
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=syc9KYvk2Qv0VepNu59RlX1jozcF6x0a6FAg9dMOIuw=;
        b=kazSIbUkABVsO6/0QVK7OTC3zxjA3UOuw99uBMPCOkUEzBfoH9hcuJQMRk2H9HgLpQ
         JLZjzzUbdzigxDGhD5oUhyU3yyNBFkVsBR4BTr4Sm59uvegtcCiAO69qbtxkKW6hiIjh
         V1lZILtTIJdHNHu2PgizGunFC8rNDVC2BRL3khVPEdVOMAC+4/Rq/YVu2YGY4kOIx/6O
         g5S8kf2ZM6qQosm6w/xATUfO/b3pZs+tCKxdEzlBfblbhNRYpe1g/wOw5I4f29mY2W49
         o84g8Gq6BQWfJ13uGcKxzcXigLe1dPLcFRQRUjRMugWXrC8/9he60j5SvuJ4hIVRFqOs
         PVNw==
X-Gm-Message-State: AOAM530MmmNvmQ9KuAQ53Xg7OXh2NmNpPNUvslVUls39/dEYt7zR1svC
        uOVNW10W/hxtvQBCSyx2U8o5nHwPZsgh1qcA6Bk0YYX0k2meo3XodZrX7ciD1gnOvfKwRUJP31T
        EsE6JUmMFfcPinoVR9AfFk8xz
X-Received: by 2002:a05:620a:20d7:: with SMTP id f23mr19036854qka.484.1620919640668;
        Thu, 13 May 2021 08:27:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3s/xgTHrnlHcj6/c+rnyyDWYIe13AuITQm/PZaxgBas7dHJddX7yNG1GdULm1D6prHyFK6Q==
X-Received: by 2002:a05:620a:20d7:: with SMTP id f23mr19036838qka.484.1620919640467;
        Thu, 13 May 2021 08:27:20 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 123sm2695552qkg.0.2021.05.13.08.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 08:27:20 -0700 (PDT)
Subject: Re: [PATCH V6 XRT Alveo 08/20] fpga: xrt: driver infrastructure
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
 <20210512015339.5649-9-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c6ed9349-1a9a-62a9-521f-a12ec8c4a5a5@redhat.com>
Date:   Thu, 13 May 2021 08:27:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512015339.5649-9-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/11/21 6:53 PM, Lizhi Hou wrote:
> Infrastructure code providing APIs for managing leaf driver instance
> groups, facilitating inter-leaf driver calls and root calls.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> Reviewed-by: Tom Rix <trix@redhat.com>

> +
> +int xrt_subdev_root_request(struct xrt_device *self, u32 cmd, void *arg)
> +{
> +	struct device *dev = DEV(self);
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(self);
> +
> +	WARN_ON(!pdata->xsp_root_cb);
> +	return (*pdata->xsp_root_cb)(dev->parent, pdata->xsp_root_cb_arg, cmd, arg);

I am running v6 through clang's static analyzer.

It reports this problem

drivers/fpga/xrt/lib/subdev.c:72:9: warning: Called function pointer is 
null (null dereference)
         return (*pdata->xsp_root_cb)(dev->parent, 
pdata->xsp_root_cb_arg, cmd, arg);
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Though there is a warn_on, can you also add a

return -EINVAL;

To cover this case?

Tom

> +}

