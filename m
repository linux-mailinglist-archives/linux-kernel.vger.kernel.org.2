Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000863926B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 07:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhE0FCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 01:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233565AbhE0FB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 01:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622091625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WvNDULJK9zHRMwqe44K4RR3WKdtWUGMATeJjP7wtcZY=;
        b=Fhldo+YVuaqR8B6kgE4vBkuNUbrVQcmUO5Vu4nCykBoNFl2MwcqwH0O/ZNRC2sQjfvmFz5
        fVSE3PxIt0ykDX8QIvr2D2mm3K8Xyjv1wmfAUTvqf62Nz+RXryf5YYmQBxv39XxjgVc8h+
        l4IkG9WrGgmEyE0BjVA1ArgMW+YidEk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-T92fe91yNzabtcDn1OaVVA-1; Thu, 27 May 2021 01:00:23 -0400
X-MC-Unique: T92fe91yNzabtcDn1OaVVA-1
Received: by mail-pf1-f200.google.com with SMTP id o11-20020a62f90b0000b02902db3045f898so2097280pfh.23
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 22:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WvNDULJK9zHRMwqe44K4RR3WKdtWUGMATeJjP7wtcZY=;
        b=TBTW6785chIB2kCpBQyZzO01rD0Ai+gZ5OlJcf1tQH7NbjGUrOnorvqx+2qUJY2RDN
         p1dR4ffK/tPMfHb2FQ2frNZWBneIimRRs4OEVMxNAbrONMxzBPgAjWbZCjRXAVfVUx/A
         CHbBoT6Rh794CXSFER2wmRty6GzkpCR5j83STGaldYocItA2+okeaUvOmdXCyQxC9jhU
         4/TVvw4zHEFkaQfrFUyBFCduhvOWivVeV36aJJpbNF7NjggnSIXbQYh3fsfx/BpSavEw
         ZsPt4ZuAhUbZVwTWxDqtiG7nGIMySkm5Omk609E1oOpwJCnCa9GMHQUeIRpvRfli3aOV
         16rQ==
X-Gm-Message-State: AOAM531LWqWnbETjWeJbx7fDcFsVxxb7jJxREbBL+VlU8jbDnDF8snKu
        GA8Zv4bRv3RHPSFRLW5aa0rmRe6STnKF+I9INGSLcVJa5R2SPnWWf3neR7fG53cQc1k6ndGgVyC
        /z0QWRB8AMel5/oOoWO4zT2domPrjuL3sXmuaqLb3rDHy55hq5atz6YlgWhHb+/+D2Wyo5i8owJ
        bv
X-Received: by 2002:a17:90b:1d8f:: with SMTP id pf15mr1854547pjb.36.1622091617059;
        Wed, 26 May 2021 22:00:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbQssOI3XI76V4pKYYsFesmyrvxjTc0EKTWn6Zl6xKwlpjIji0dLlRJIWAqJ1uNqyHlcKbWw==
X-Received: by 2002:a17:90b:1d8f:: with SMTP id pf15mr1854461pjb.36.1622091616242;
        Wed, 26 May 2021 22:00:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u5sm715334pfi.179.2021.05.26.22.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 22:00:15 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
Date:   Thu, 27 May 2021 13:00:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/27 下午12:57, Yongji Xie 写道:
> On Thu, May 27, 2021 at 12:13 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/5/17 下午5:55, Xie Yongji 写道:
>>> +
>>> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
>>> +                           struct vduse_dev_msg *msg)
>>> +{
>>> +     init_waitqueue_head(&msg->waitq);
>>> +     spin_lock(&dev->msg_lock);
>>> +     vduse_enqueue_msg(&dev->send_list, msg);
>>> +     wake_up(&dev->waitq);
>>> +     spin_unlock(&dev->msg_lock);
>>> +     wait_event_killable(msg->waitq, msg->completed);
>>
>> What happens if the userspace(malicous) doesn't give a response forever?
>>
>> It looks like a DOS. If yes, we need to consider a way to fix that.
>>
> How about using wait_event_killable_timeout() instead?


Probably, and then we need choose a suitable timeout and more important, 
need to report the failure to virtio.

Thanks


>
> Thanks,
> Yongji
>

