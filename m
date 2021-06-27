Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED173B537C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 15:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhF0Ntx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 09:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhF0Ntt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 09:49:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31543C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 06:47:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so8618181pji.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fJSoA46EGJPMh4KCGh0AvMNTym/VRIZfvgO78Nh3WHY=;
        b=XFUj04S1IvtMBMrNxSHUrQdfjMsTK6ceV/VmG9GdcBQK5aWjQ5+rf3Bk8ABUqyq23x
         /cPSijpfIZl2ccuqgsz+Ik5g/4Q2qB2I6k60ILhUViJmUOZoJs3lCPwNxugWrCLe9ufg
         +G9rfB+d84i69spQRtCf+7paphH+5I4seXk9WyYmjaPyllIDKEFKBemcokIRTCMr+cbn
         4tUaBMm65rRMBNxmAHiqs2p4YM++/Td1PM1Tb92KktIpC+6kIIfMBCYu3hSofxuL9++o
         DVxmsHWThe9fA6Y3rQTzepjOwb2HoMXdimzpgiLR9VZrcWLjllVbNL0RsnQlXcEiQAF/
         vLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fJSoA46EGJPMh4KCGh0AvMNTym/VRIZfvgO78Nh3WHY=;
        b=MJoaR5r+tV/6wbHdmUbRwSsJe1pYDWClRAl65cvMqjLhrZ6cLDvs8cg02JJrlAPz0M
         1Q5fu0B31ys13JIlsdpgGj+ZsZ84mbLNk/tKL6tjTP+irSDq3rNEbx1aW/8AfdqgoKpl
         uJ5lQP2D7N+y/I3cbVEx8a42yN3jAsDiptArrW3+XkmWcLtA/Em8hkOfA2JJ+hcY66rH
         /FG7nWpLXWnl9U5zq1R6Z6V9L1cOR/27anlkjSiJJiMiA23lV3K6D5hMp92o7Lizhevd
         Tiol0HDYZcqRqgcpOHuv4WGm2o+W7j58GL2Of7YgNeG0/7tEEb7ENuUefbkb1B4jjofA
         jxtw==
X-Gm-Message-State: AOAM530B7xQ65UhHFwdiCsBN7YV33P0zAoJ1tWIBnzbTOOZG4ZwGapm/
        biHeu68gDvldJdallHUOgRg=
X-Google-Smtp-Source: ABdhPJy7Va7MAOwfFxr4qQ1sx90Yqi7htESGJULb092qSsZzQo6foZOwzrp2UiAU39FKgAsVYAr2fQ==
X-Received: by 2002:a17:90b:1d06:: with SMTP id on6mr21356378pjb.149.1624801644619;
        Sun, 27 Jun 2021 06:47:24 -0700 (PDT)
Received: from [192.168.1.30] (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id s20sm7628116pji.19.2021.06.27.06.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 06:47:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-fc: Update hardware queues before using them
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-2-dwagner@suse.de>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <f5c53785-077e-0e2a-ae3d-178b3e73b80b@gmail.com>
Date:   Sun, 27 Jun 2021 06:47:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625101649.49296-2-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/2021 3:16 AM, Daniel Wagner wrote:
> In case the number of hardware queues changes, do the update the
> tagset and ctx to hctx first before using the mapping to recreate and
> connnect the IO queues.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 8a3c4814d21b..a9645cd89eca 100644

Makes sense.  Thanks.   Although it does bring up that perhaps, if the 
hw queue count changes, thus it no longer matches what was set on the 
target, the new value should be set on the target to release resources 
on the target.

Note: the same behavior exists in the other transports as we all started 
from the same lineage. So those should be updated as well.  Granted 
you'll need to break out the queue count set and checking which was done 
on fc but not on the other transports.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

