Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736443FD505
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbhIAIOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242766AbhIAIOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630484028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uyDrxtsR94VMPU5MaJ7LybPMEr60Xgeln0jH3Y/pfWo=;
        b=XfQUZ9459Mkp9CXknjwL4UHFFjaCWlzAWC3bSwLbkArAyXFXsv1lhFajSg5ZxryYSKE0Ap
        GMSQzFq/b3Uhhl7IGCNd1lI0shORTUhVt5Bt60H41hswCp58Fi+FPT4WYYc2VXfc2f9tv/
        hOY9rYIa6T9v5SOrOda2bSZsRiPw0WA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-8DUBKaJsPP-iLw6b2alC9w-1; Wed, 01 Sep 2021 04:13:47 -0400
X-MC-Unique: 8DUBKaJsPP-iLw6b2alC9w-1
Received: by mail-wr1-f71.google.com with SMTP id j1-20020adff541000000b001593715d384so143675wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 01:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uyDrxtsR94VMPU5MaJ7LybPMEr60Xgeln0jH3Y/pfWo=;
        b=Y3j6RV+BxU2nMABkLV+RVi8d2LoZ1YSHNneHtb7VDFkuSgtFNhx+1HR9z4D/0YXXiQ
         7IXgnOCjP33tpmuAdM4GZjPXSHe0x04PMfcmmQLgADVCuN9tMbTYvCQHa396EaL9GnrT
         V6S542L8lTjO9QZZ65r5rVzp97N3F0RTqNentGktaYPTd8L2dxUxhvRByuI01pMIAwtc
         p/jc0+dmzrho/nSuRfzDop3/cAs5qsG3Ij5Yx0lR1WsRNsIHEp7Nz1MbIysIWteAAE2p
         VyMAk8ljSHvHX+dQw3uozTIVN1tmCvLZ38fkY6LmtP4oIhmUK1pZBS8KyznL/KCpu/Mr
         x0cg==
X-Gm-Message-State: AOAM533i7yvw1Tm68dQEUWEwgmf0NJfLh3BDXbn7xPRIGm4POSASN37Y
        Kqo6MmAjcI/UARhBoW5l9luAJjnz+MOpGno93qvmaGLs+Dbrq+fcVk9mwjTg1TA13NyKmncOww1
        gus0l2EhKyrw+YNlJyfBIYRle
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr36069380wrg.358.1630484026644;
        Wed, 01 Sep 2021 01:13:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrnLwgdxjrPnEWEVBAyYagEpAefLy0ZBMaW08Mk0jB8RfFU+GX3ibBFf9h6AshyJy/RQ8VRg==
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr36069361wrg.358.1630484026470;
        Wed, 01 Sep 2021 01:13:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id u25sm4703254wmj.10.2021.09.01.01.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 01:13:46 -0700 (PDT)
Message-ID: <0b030119a755fb246a617f3ab30c7664d4f95323.camel@redhat.com>
Subject: Re: [PATCH] [v3] mptcp: Fix duplicated argument in protocol.h
From:   Paolo Abeni <pabeni@redhat.com>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Date:   Wed, 01 Sep 2021 10:13:45 +0200
In-Reply-To: <20210901031932.7734-1-wanjiabing@vivo.com>
References: <20210901031932.7734-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 2021-09-01 at 11:19 +0800, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> ./net/mptcp/protocol.h:36:50-73: duplicated argument to & or |
> 
> The OPTION_MPTCP_MPJ_SYNACK here is duplicate.
> Here should be OPTION_MPTCP_MPJ_ACK.
> 
> Fixes: 74c7dfbee3e18 ("mptcp: consolidate in_opt sub-options fields in a bitmask")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Not sure what happen to my previous reply, most probably PEBKAC, sorry.

WRT this patch, note that the dup is harmless, as in the input path we
always use the mask and not the individual bit - vice versa in the
output path. Still the cleanup is worthy and patch LGTM.
Acked-by: Paolo Abeni <pabeni@redhat.com>

