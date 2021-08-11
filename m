Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3005A3E8D41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhHKJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbhHKJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:31:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27671C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:31:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x12so2082473wrr.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i+238jwSCXHQqmEbgjIzlgckTMFLhUBBmLjyo/HYZD8=;
        b=tyEiKPTNfEinjX3TbBEjAgu5sAivydzdzdr5SzkY+/rNqmO+7BZ/ObQQW3CsYxnAYp
         7PziXML11kCwjs9Sk3T6bsQ6mI2j4amE0w+4I8ynL8g+DA66bnsCOLlSMcdio4nT+J7t
         +GSEUMgwxKfgX0K5ERuofrsfEYp788xjzTWIhcr+wRcEK5cY9brXq1OW0fAPIIuhvb2o
         blW0sk9DGlVgfPxNSWhnUJg9VxPmg8PbsthHS2Rw2d3tNsGE0A/9pJosPpKt+icn+lOI
         01g7/XI+XrYYP+tS/gq+YXbaUk2dg+E88ftqm2IXPJncsw7BsmApA6Wd8LJz/mcp+/TT
         6I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i+238jwSCXHQqmEbgjIzlgckTMFLhUBBmLjyo/HYZD8=;
        b=qpdQZPp+oT4WlGbUYb3AanBEqM0WM3LEhoHgAdIYOs5YbDzFPZXZdg2vjVGYahM7om
         wMtFvUVpz4Ak2FT2uZ73j9yzhZUukGD53FE4XanUll0tjyUeCutz5hzSqYJWJ4QR+JOZ
         DyICrPbVuiNHnr8I2VGevoQPjW0dueHmUXQF5G6R0u03Q5lWVFnaN01iFQLcdqIpF2J0
         S5cAdhQQu6CI9Yh1M59dCcWQTpjqbT/CCFVkp6STc1ZXDvzgesDmww5O1tRfVs2fx8em
         BN9LKp8m2O05xl98dNo3ykq0CzBReFhHEMKnFq1Q2DrVoS7nGM+7irH582VwV5B1D0co
         tRpA==
X-Gm-Message-State: AOAM530PMb88nKBujn6MNWvJcuRT2NvnFwzBGpRvg+a3exYZDxTxqDUW
        Ygnwh66mLQT9WjBCuTCzovjv/9JMWWpEc6KN
X-Google-Smtp-Source: ABdhPJz9X1dryGzeIrrmIlHKjUuFly3XEDHvEoOtsQrchrSq7e1rd66PhETWLAhrRqwbm+lzrkaUSg==
X-Received: by 2002:adf:90b1:: with SMTP id i46mr22281975wri.159.1628674294586;
        Wed, 11 Aug 2021 02:31:34 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id a18sm5335628wmg.43.2021.08.11.02.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 02:31:34 -0700 (PDT)
Date:   Wed, 11 Aug 2021 09:31:21 +0000
From:   Floris Westermann <westermann@google.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 00/17] Introduce SCMI transport based on VirtIO
Message-ID: <YROY6YntswWxfaub@google.com>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712141833.6628-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

I am currently working on an interface for VMs to communicate their
performance requirements to the hosts by passing through cpu frequency
adjustments.

Your patch looks very interesting but I have some questions:


On Mon, Jul 12, 2021 at 03:18:16PM +0100, Cristian Marussi wrote:
>
> The series has been tested using an emulated fake SCMI device and also a
> proper SCP-fw stack running through QEMU vhost-users, with the SCMI stack
> compiled, in both cases, as builtin and as a loadable module, running tests
> against mocked SCMI Sensors using HWMON and IIO interfaces to check the
> functionality of notifications and sync/async commands.
>
> Virtio-scmi support has been exercised in the following testing scenario
> on a JUNO board:
>
>  - normal sync/async command transfers
>  - notifications
>  - concurrent delivery of correlated response and delayed responses
>  - out-of-order delivery of delayed responses before related responses
>  - unexpected delayed response delivery for sync commands
>  - late delivery of timed-out responses and delayed responses
>
> Some basic regression testing against mailbox transport has been performed
> for commands and notifications too.
>
> No sensible overhead in total handling time of commands and notifications
> has been observed, even though this series do indeed add a considerable
> amount of code to execute on TX path.
> More test and measurements could be needed in these regards.
>

Can you share any data and benchmarks using you fake SCMI device.
Also, could you provide the emulated device code so that the results can
be reproduced.


Cheers,
Floris
