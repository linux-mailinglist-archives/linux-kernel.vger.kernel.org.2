Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9249B34B54C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 08:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhC0Hvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 03:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhC0Hvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 03:51:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10345C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 00:51:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hq27so11760511ejc.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xsip9CSoJsuDo1J1wjfyLqKOAiGEpLyyYQJBNxTGRlE=;
        b=tGdqc3yWSNHNSmSBytobf1q2yGCF1aPdGvc+tf54sIHWW2+yRXT7nkOLzPmJ4fm8AK
         JwkC0fJ8OrTc+59xiIaeMmfIhtMSDqmOXKYeD0Mnfx7C/yELSTHUtNXppzQpU7qsSf3/
         MiPig6fWb/lW6N6SqcBD85K5bGCwuoja9iVvjrNkDbS6xwruTP4Fh+f3QcgAgqjqwNcR
         JiL4C2WdetgQEuVF8reZffKTSAovIFEZ/Mz+3fJOvvcazS2tWhn8Hy2I3Xn1P5qRfQx8
         vGiZLqWnas5RRZiOPXLZiClkuiXpqAp8VXbY5S2ViEetb8CFuHuw2Rztvx29hEm4OI52
         Pkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xsip9CSoJsuDo1J1wjfyLqKOAiGEpLyyYQJBNxTGRlE=;
        b=Enfgn6cBXpLCJymJJEiD9OTnUMWmZ4Tbh78FuXXquXzU1gNV9ODiRtRKnr9JmGpuie
         t5ldC1YUCSz4ti80PWgum/HMdFgP3cH/F1cecS8zaealhdzxYTjtNQOhnZBrWLj9EWgS
         W23JemZzsqgEqfJHcTq7qvSs4FqOYpOwHaShsvM+sv/0hSTiNvBE1pXYbCMZQQG018fF
         Brv3clxwUH6nsU6ykWJTFkbnxHGNtdz6RLqz6tK3dhlGxjVk4I2FKHZNHDHQHVj1lwY8
         0YYi7dzG28v352XvZKcFPTZUGDYwUF5JvBFL4AjWFLv25AXhjEnzkVUp3ocIv6TNJl7r
         kDkQ==
X-Gm-Message-State: AOAM532ItlDY/Zqi4zHkAcS/D6o/HVvpXDUF+boA9fGZb6D/YuiLt/wq
        B9aF/m6nYdgL/ESBT/VB+m2zLQ==
X-Google-Smtp-Source: ABdhPJySG+XVg0zU1mtv4oLycVhADK4Th0rCc42g7M1yPT66xibCkx+pwuPMRB2mxRPMSlb5bNaLDg==
X-Received: by 2002:a17:906:cb18:: with SMTP id lk24mr18512026ejb.70.1616831506265;
        Sat, 27 Mar 2021 00:51:46 -0700 (PDT)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id j7sm5335055edv.40.2021.03.27.00.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 00:51:45 -0700 (PDT)
Date:   Sat, 27 Mar 2021 08:51:45 +0100
From:   "javier@javigon.com" <javier@javigon.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: nvme: disallow passthru cmd from targeting a nsid != nsid of the
 block dev
Message-ID: <20210327075145.ecbjov5prhq2vjh7@mpHalley.local>
References: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.2021 19:48, Niklas Cassel wrote:
>From: Niklas Cassel <niklas.cassel@wdc.com>
>
>When a passthru command targets a specific namespace, the ns parameter to
>nvme_user_cmd()/nvme_user_cmd64() is set. However, there is currently no
>validation that the nsid specified in the passthru command targets the
>namespace/nsid represented by the block device that the ioctl was
>performed on.
>
>Add a check that validates that the nsid in the passthru command matches
>that of the supplied namespace.
>
>Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>---
>Changes since v1:
>-Added error print.
>
> drivers/nvme/host/core.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index f13eb4ded95f..a50352ea3f7b 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -1599,6 +1599,12 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> 		return -EFAULT;
> 	if (cmd.flags)
> 		return -EINVAL;
>+	if (ns && cmd.nsid != ns->head->ns_id) {
>+		dev_err(ctrl->device,
>+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
>+			current->comm, cmd.nsid, ns->head->ns_id);
>+		return -EINVAL;
>+	}
>
> 	memset(&c, 0, sizeof(c));
> 	c.common.opcode = cmd.opcode;
>@@ -1643,6 +1649,12 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> 		return -EFAULT;
> 	if (cmd.flags)
> 		return -EINVAL;
>+	if (ns && cmd.nsid != ns->head->ns_id) {
>+		dev_err(ctrl->device,
>+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
>+			current->comm, cmd.nsid, ns->head->ns_id);
>+		return -EINVAL;
>+	}
>
> 	memset(&c, 0, sizeof(c));
> 	c.common.opcode = cmd.opcode;
>-- 
>2.30.2

Looks good to me

Reviewed-by: Javier González <javier@javigon.com>
