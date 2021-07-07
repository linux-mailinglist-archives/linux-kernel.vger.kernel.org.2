Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71C53BE2A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhGGFll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230108AbhGGFlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625636340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kGTF9aX4UU8SQB/ux5DynjlqPbikwmwfckJttBuZsBQ=;
        b=hlvV+6YFBirr9zSO3dcdhyI1VtRMHysCEyWZMrD0QhTeIQhh7uDpWGuY658AqxeI3t5jgc
        UehPjneZauR2xBx8fpycXEQKzF72F7m06ueh7riX8uSrYlhq/LExO5jMMYhr6zrB2pg3xb
        lokVmmhA6aP8WAVgdvdRQ4HdWpL8bPk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Lxfo5zMLP12IJfWCzNt0YQ-1; Wed, 07 Jul 2021 01:38:58 -0400
X-MC-Unique: Lxfo5zMLP12IJfWCzNt0YQ-1
Received: by mail-pj1-f72.google.com with SMTP id mm9-20020a17090b3589b029016e99e81994so3189877pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 22:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kGTF9aX4UU8SQB/ux5DynjlqPbikwmwfckJttBuZsBQ=;
        b=G6VpL0Z+U1gPJPGnmOVb2DOZNsvbu+NxxDhGaCB+hWcXvPGDG5jEHgmOCdzVuzunU8
         QwKH1ZuLM65WLmeQQ/p0jFt05mrRGDUagvwWWjfZXywYwf4UtT+qXK0Toys7+UgI1Hj2
         TsQqeEccsFFdJSfrPigXu5p4UxNOmqRXtr8xgpp7u0e9rfSXMUTeKI3rY5G/pqRQ3v3/
         bpjh3W99m5EB680AonOzZvQZDybIax+VrCZvQd42gvk6Uzfwerh53vqJXSiz/vyoZVxm
         E+w6Avtn1LVLkqJ3JRRWLosICw/Qa5qu8oKntkz6wJQD2FywHoxg90TXBLg5B10exsSo
         MCcg==
X-Gm-Message-State: AOAM531QKb/eOXt32L3aZNsLdLUpIqbOFjWvQVs4lGNZ3rnQ/Ai2YEM0
        rlcDNhi6OBcbySm1hclDWHn7BbzyQzPHw/X/uaf+YdYlCBs5UWU94lCGvD7QruFekQWaxQvfc2O
        zWMzwSSGuv3qcwptEgGal+N7G
X-Received: by 2002:a63:d709:: with SMTP id d9mr24915997pgg.337.1625636337942;
        Tue, 06 Jul 2021 22:38:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdcAYzPe9Td2iDIGFQQSaewh4hvbPDcFQ56fjCZjz8xFGYhjP3HXr2pwcyE40/rv2oyxP9Dg==
X-Received: by 2002:a63:d709:: with SMTP id d9mr24915987pgg.337.1625636337752;
        Tue, 06 Jul 2021 22:38:57 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id pj4sm4703749pjb.18.2021.07.06.22.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 22:38:57 -0700 (PDT)
Subject: Re: [PATCH 1/2] vdpa: support per virtqueue max queue size
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, netdev@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <20210705071910.31965-1-jasowang@redhat.com>
 <CACycT3tMd750PQ0mgqCjHnxM4RmMcx2+Eo=2RBs2E2W3qPJang@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f655025b-5db4-a146-ff85-a211576e29af@redhat.com>
Date:   Wed, 7 Jul 2021 13:38:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tMd750PQ0mgqCjHnxM4RmMcx2+Eo=2RBs2E2W3qPJang@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/7 下午12:04, Yongji Xie 写道:
>>   static long vhost_vdpa_get_vring_num(struct vhost_vdpa *v, u16 __user *argp)
>>   {
>> -       struct vdpa_device *vdpa = v->vdpa;
>> -       const struct vdpa_config_ops *ops = vdpa->config;
>>          u16 num;
>>
>> -       num = ops->get_vq_num_max(vdpa);
>> +       /*
>> +        * VHOST_VDPA_GET_VRING_NUM asssumes a global max virtqueue
> s/asssumes/assumes. Other looks good to me.
>
> Thanks,
> Yongji
>

Will fix.

Thanks

