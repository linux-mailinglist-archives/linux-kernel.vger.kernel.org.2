Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6825F3D9168
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbhG1O4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237358AbhG1O4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627484181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=it5Te9P2fE9hEACV7bmI0ZQUC4eOMZ6L7HHf6MGR5Mo=;
        b=gqvKyC+oxaz04/LupRrVhApxsAbNgvSUJrWeGJC4ogPu16glJkj9wAr9H2Gnh7brvC5MIV
        aeX6zn23o+v4t9/5ecRKiaNInBbUQKwdXBOvnVrDzlX7IR+8u+wHLIajIC8AHXkKuyQKSx
        YntlWJhdU5QrhqNWLKFoIxgk6YF9hf0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-oBR2cllCP0uo2zSGPUj_iA-1; Wed, 28 Jul 2021 10:56:20 -0400
X-MC-Unique: oBR2cllCP0uo2zSGPUj_iA-1
Received: by mail-qk1-f200.google.com with SMTP id q9-20020a05620a0c89b02903ba3e0f08d7so1800927qki.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=it5Te9P2fE9hEACV7bmI0ZQUC4eOMZ6L7HHf6MGR5Mo=;
        b=Ad1eOhj4M8dTAp8LhLmjpxbzLywBPOT83IN4KkLCXdNkYrzcly8zBB5Z237rgSiWaP
         M+NihSbbfemTk6SpPx/jqHADzNmNWxoKCX/Wu2URnYTyvNjpB5olB98E5mAW4uzYPUnQ
         +HFISwtcTiNoLKaTnfj/7PV4G5Ni8RQ4DvddKxd+TQxUr/fZS3++vGWCT4Gc8YH9d3ts
         OeRkglqMBxDy2KkmwepRDrJSqk4Avq2Vzx9/QGD0pSsZ6cpzFu74Prqz6pRgMf5IpueT
         iRHFjV9vReQF18i+XQ9IbFJT3sz/mQQoiPhQ5VG//m2SI1eOClIC5943TzZF/0cSlznt
         Z6Jw==
X-Gm-Message-State: AOAM5318Ze7K//FIcu6NVMFz5MQ/Ksg1AOp5+WCDLRBqlssj/JNZftJz
        p71g5xDurwBjOXwADagH5SFxhyPV3Vq5ljz2hz3UvSimYu5RB+Ma14wfKgML7fPZdezSjzHVVfM
        tajU/7bSpH0ki/8o8uGctCG5V
X-Received: by 2002:a05:622a:104b:: with SMTP id f11mr23864107qte.134.1627484179604;
        Wed, 28 Jul 2021 07:56:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7m6DREgWBE6Hlfac89TKVr/iCoUvG1oqWqS55n/ROdB1Bdnlx4nra3hys5EdZ7ULEdaF4Dw==
X-Received: by 2002:a05:622a:104b:: with SMTP id f11mr23864096qte.134.1627484179449;
        Wed, 28 Jul 2021 07:56:19 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s81sm104241qka.82.2021.07.28.07.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 07:56:19 -0700 (PDT)
Subject: Re: [PATCH v13 0/4] Intel MAX10 BMC Secure Update Driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Wu, Hao" <hao.wu@intel.com>
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210727225859.153572-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <65ed311d-a492-413e-33a8-f64e9c41e7c2@redhat.com>
Date:   Wed, 28 Jul 2021 07:56:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210727225859.153572-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russ
> Russ Weight (4):
>    fpga: m10bmc-sec: create max10 bmc secure update driver
>    fpga: m10bmc-sec: expose max10 flash update count
>    fpga: m10bmc-sec: expose max10 canceled keys in sysfs

Since sec-mgr is taking a long time, I am looking at splitting out parts 
we can agree on.

These 3 patches are a new dfl specific driver and do not depend on sec-mgr.

Here is a poc on char-misc-next, splitting them and moving them before 
sec-mgr

https://github.com/trixirt/linux-next/commits/sec-mgr-reorder

Moritz, Hao

Could these 3 patches go into fpga-next now ?

Tom


>    fpga: m10bmc-sec: add max10 secure update functions

