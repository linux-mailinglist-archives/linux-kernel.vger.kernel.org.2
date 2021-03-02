Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9B32A1D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836296AbhCBHAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:00:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1577121AbhCBFop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614663798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1nmciMgkZ+IaIXXkMRC5e7HPFjY7bXKmsBF/n5bymw=;
        b=VviDtDMAGeYYEvw73fuwHT21MhNo8GCVRj6RhIRZlQydXUcZc560z+eyCl+XdEyufhNFdI
        XDR1LxUnqBqOK7Apcqqt3Te+8Q7qwhGmnyO31Khf89PRvsTXyGS47E/v6CJpP9gX26Rh3e
        f2KvGOlzrm02sUrDfucD63bry3WIbi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-JO6z7fOiN0uCDL3B1KZo3A-1; Tue, 02 Mar 2021 00:43:14 -0500
X-MC-Unique: JO6z7fOiN0uCDL3B1KZo3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44A3118B613D;
        Tue,  2 Mar 2021 05:43:11 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-133.pek2.redhat.com [10.72.12.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DFD75D71F;
        Tue,  2 Mar 2021 05:42:55 +0000 (UTC)
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jie Deng <jie.deng@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        conghui.chen@intel.com, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com,
        Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
        Mike Rapoport <rppt@kernel.org>, loic.poulain@linaro.org,
        Tali Perry <tali.perry1@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        yu1.wang@intel.com, shuo.a.liu@intel.com,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
 <20210302040114.rg6bb32g2bsivsgf@vireshk-i7>
 <20210302042233.7ppagwjk3rah3uh3@vireshk-i7>
 <5e66fc1b-81d3-341e-4864-adb021e9ce1e@intel.com>
 <20210302051607.gul2w66xpsffzpnm@vireshk-i7>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2fae0d65-e52d-4275-d106-fd9d9a6703f0@redhat.com>
Date:   Tue, 2 Mar 2021 13:42:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210302051607.gul2w66xpsffzpnm@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/3/2 1:16 下午, Viresh Kumar wrote:
> On 02-03-21, 13:06, Jie Deng wrote:
>> Yeah. Actually, the backend only needs "struct virtio_i2c_out_hdr out_hdr"
>> and "struct virtio_i2c_in_hdr in_hdr" for communication. So we only need to
>> keep
>> the first two in uapi and move "struct virtio_i2c_req" into the driver.
>>
>> But Jason wanted to include "struct virtio_i2c_req" in uapi. He explained in
>> this link
>> https://lists.linuxfoundation.org/pipermail/virtualization/2020-October/050222.html.
>> Do you agree with that explanation ?
> I am not sure I understood his reasoning well, but it doesn't make any
> sense to keep this in uapi header if this is never going to get
> transferred over the wire.


I think I was wrong. It should be sufficient have in_hdr and out_hdr in 
uAPI.

Thanks


>
> Moreover, the struct virtio_i2c_req in spec is misleading to me and
> rather creates unnecessary confusion. There is no structure like this
> which ever get passed here, but rather there are multiple vq
> transactions which take place, one with just the out header, then one
> with buffer and finally one with in header.
>
> I am not sure what's the right way of documenting it or if this is a
> standard virtio world follows.
>

