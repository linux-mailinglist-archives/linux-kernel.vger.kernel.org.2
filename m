Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B2B3C7E55
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 08:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbhGNGGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 02:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237958AbhGNGF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 02:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626242587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7Q8ciSmkkFwqcK9Ly2flr5V7ufFOKmLdTuweetcBqc=;
        b=E1kUuGEwUuWTqdjMtWx/JNg0XuPX2Q5Kmg0wsr0gq6DuFWgMr1yHK2wB3zqw+zKTLxJCkW
        NIQtMuTL2jq+lus1ptoRUf7VLZzUvhFKhtsnaNwhOt0IVvs3UFeHLePXE77EoHYwUVad1V
        unYs1m7ZcSgRsFBnmjL42U+JIzTLvrw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-6nMhLxyiMs2XldbDoN871Q-1; Wed, 14 Jul 2021 02:03:05 -0400
X-MC-Unique: 6nMhLxyiMs2XldbDoN871Q-1
Received: by mail-pl1-f197.google.com with SMTP id a6-20020a1709027d86b02901019f88b046so727168plm.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 23:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c7Q8ciSmkkFwqcK9Ly2flr5V7ufFOKmLdTuweetcBqc=;
        b=SewI4R1x7offw8NhasIDPOMvaOcrTIi5TRn+30D/+CDqyRst6gV5BZTPi5yu+BCSW0
         l3BSRWus/6Rigd2FGqVGgKKWMDAunq8rgw0izKnRE6yy/f0dmAN/KkigLmCZvwswku5K
         Mor2Tzj4HAuqFN3fcHJL93M0gGayTNWGDXo6Gaythbo0oSt0S0C52WLZ6eHCVQTbFIG+
         U4O7NFYgURvenxaLhMBmL9Ky7zEwsJCMDNCS7mAJc5+uK9ExvziCMt1tJHv8EdsnqHnZ
         0YpfK+xwn6e+GCWujlSEB4YCLg59CVw05022hU/DepgRUojZcqMevnvgOzbxlHACM3hU
         M/ag==
X-Gm-Message-State: AOAM531cZ3DXMALNMCiHSyx0HgggTBgHFLg35XQYClaStF1OWh2HMbtf
        wddiVWtOFzhjcHDqwH1IdoC10clBIxMNWtxKwMow+bvhEUb+JQRy1TcKC4fqVsocHLt3AYmPkNR
        kgxzazbIEtfzz7oeTpPsK79H/GDrKQJO1aclwlHikyhsVK4IKeMr4h6YrelRNc8g4rIj3hW60sq
        Tu
X-Received: by 2002:a63:111a:: with SMTP id g26mr7785904pgl.103.1626242584167;
        Tue, 13 Jul 2021 23:03:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdA7Ox90h5XXIshMvBjDNcFMeGycsIxzhnY5/F/BBeS8iYsHUo11OJSfqeDY+OH4iEPOdWBg==
X-Received: by 2002:a63:111a:: with SMTP id g26mr7785847pgl.103.1626242583780;
        Tue, 13 Jul 2021 23:03:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d2sm4572795pjo.50.2021.07.13.23.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 23:03:02 -0700 (PDT)
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
 <20210714014817-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0565ed6c-88e2-6d93-7cc6-7b4afaab599c@redhat.com>
Date:   Wed, 14 Jul 2021 14:02:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714014817-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/14 ÏÂÎç1:54, Michael S. Tsirkin Ð´µÀ:
> On Wed, Jul 14, 2021 at 01:45:39PM +0800, Jason Wang wrote:
>>> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
>>> +			      struct vduse_dev_msg *msg)
>>> +{
>>> +	int ret;
>>> +
>>> +	init_waitqueue_head(&msg->waitq);
>>> +	spin_lock(&dev->msg_lock);
>>> +	msg->req.request_id = dev->msg_unique++;
>>> +	vduse_enqueue_msg(&dev->send_list, msg);
>>> +	wake_up(&dev->waitq);
>>> +	spin_unlock(&dev->msg_lock);
>>> +
>>> +	wait_event_killable_timeout(msg->waitq, msg->completed,
>>> +				    VDUSE_REQUEST_TIMEOUT * HZ);
>>> +	spin_lock(&dev->msg_lock);
>>> +	if (!msg->completed) {
>>> +		list_del(&msg->list);
>>> +		msg->resp.result = VDUSE_REQ_RESULT_FAILED;
>>> +	}
>>> +	ret = (msg->resp.result == VDUSE_REQ_RESULT_OK) ? 0 : -EIO;
>>
>> I think we should mark the device as malfunction when there is a timeout and
>> forbid any userspace operations except for the destroy aftwards for safety.
> This looks like if one tried to run gdb on the program the behaviour
> will change completely because kernel wants it to respond within
> specific time. Looks like a receipe for heisenbugs.
>
> Let's not build interfaces with arbitrary timeouts like that.
> Interruptible wait exists for this very reason.


The problem is. Do we want userspace program like modprobe to be stuck 
for indefinite time and expect the administrator to kill that?

Thanks


>   Let userspace have its
> own code to set and use timers. This does mean that userspace will
> likely have to change a bit to support this driver, such is life.
>

