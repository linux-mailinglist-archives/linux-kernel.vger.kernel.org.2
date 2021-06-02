Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94604398299
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhFBHHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhFBHH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622617545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7AFjn1kAaIwJ7yXpW9H7ltpl4fJk13y2xBWVC0JT2Y=;
        b=K8VHHNTVtPHvvdqkBPMIb9BmaGnOIEKwuTWBX4rhfoZSwvikPEs7E/0t4vBDhTQDoK3LcG
        eMBTcvnYX/pf05JciR30Tw4wvAjL7W8qLpxn7kUKnDi272J1uth7teyTtE239DwhsxUuda
        tNvemHFQVVcWcU57E1xWAvxD/8KdWXU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-Y02yENvJPN2up5esJJxfTg-1; Wed, 02 Jun 2021 03:05:41 -0400
X-MC-Unique: Y02yENvJPN2up5esJJxfTg-1
Received: by mail-pj1-f72.google.com with SMTP id jw3-20020a17090b4643b029016606f04954so1077470pjb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 00:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N7AFjn1kAaIwJ7yXpW9H7ltpl4fJk13y2xBWVC0JT2Y=;
        b=HXwtNtSjeR9H6A2VPupENHfeXUrpA9d/uwtE0ItazufWLL/V1DxoSq0PTzsLWx0jVk
         Yd+DwCWpnINwAxA1SuvQI8wcv+sXMQVsJFVEI3kn8KWESp95DChDri4r9x4ZtZRZPQ3x
         DgnWL7AgZ4jR9VbhlPjJQ7OYR0XtWXjWJyMeH0GkeWjNTn3hmfpZQKLif74H6ah8FWrG
         Q/3XaUlpu9uJZ3MRJVdcd/Ku8QUpQ87QMbiOqWR65JG/UEeWF+vBDvjK1otxLIb14FzE
         Bcau4WWaioHdWlFhe3/hNAiQEciJoNml2wAbKlJCZprysKOnS19Xs4kHMDcaJg0pSxQB
         5feg==
X-Gm-Message-State: AOAM533Ik11vGRFFecPN9sbc/81RYb50nBSYREdWm7ohTsJQsu1Y/jEv
        CyMhpS+Ew2s+q9o9h1dKlYCqrUDDGgXW2kQJert9vhtMz75HTL2Ml6aGA1XVizxxQbpz0uIfbla
        MQOQlgPqyestkNLyIX2SUpMjQ
X-Received: by 2002:a63:d908:: with SMTP id r8mr17698729pgg.414.1622617540708;
        Wed, 02 Jun 2021 00:05:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi1fo5eUxqSSq1jhRLtWR5oM/z3BQO8r5DzrHXf+icFTZlIa8TZoB63MRifCqrns7bI6/5cA==
X-Received: by 2002:a63:d908:: with SMTP id r8mr17698704pgg.414.1622617540453;
        Wed, 02 Jun 2021 00:05:40 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x19sm15554961pgj.66.2021.06.02.00.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 00:05:40 -0700 (PDT)
Subject: Re: [PATCH V2 3/4] vp_vdpa: allow set vq state to initial state after
 reset
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, eli@mellanox.com
References: <20210602021043.39201-1-jasowang@redhat.com>
 <20210602021043.39201-4-jasowang@redhat.com>
 <20210602061324.GA8662@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <091dc6d0-8754-7b2a-64ec-985ef9db6329@redhat.com>
Date:   Wed, 2 Jun 2021 15:05:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602061324.GA8662@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/2 ÏÂÎç2:13, Eli Cohen Ð´µÀ:
> On Wed, Jun 02, 2021 at 10:10:42AM +0800, Jason Wang wrote:
>> We used to fail the set_vq_state() since it was not supported yet by
>> the virtio spec. But if the bus tries to set the state which is equal
>> to the device initial state after reset, we can let it go.
>>
>> This is a must for virtio_vdpa() to set vq state during probe which is
>> required for some vDPA parents.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vdpa/virtio_pci/vp_vdpa.c | 42 ++++++++++++++++++++++++++++---
>>   1 file changed, 39 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>> index c76ebb531212..18bf4a422772 100644
>> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>> @@ -210,13 +210,49 @@ static int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
>>   	return -EOPNOTSUPP;
>>   }
>>   
>> +static int vp_vdpa_set_vq_state_split(struct vdpa_device *vdpa,
>> +				      const struct vdpa_vq_state *state)
>> +{
>> +	const struct vdpa_vq_state_split *split = &state->split;
>> +
>> +	if (split->avail_index == 0)
>> +		return 0;
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int vp_vdpa_set_vq_state_packed(struct vdpa_device *vdpa,
>> +				       const struct vdpa_vq_state *state)
>> +{
>> +	const struct vdpa_vq_state_packed *packed = &state->packed;
>> +
>> +	if (packed->last_avail_counter == 1 &&
> Can you elaborate on the requirement on last_avail_counter and
> last_used_counter?


This is required by the virtio spec:

"
2.7.1 Driver and Device Ring Wrap Counters
Each of the driver and the device are expected to maintain, internally, 
a single-bit ring wrap counter initialized to 1.
"

For virtio-pci device, since there's no way to assign the value of those 
counters, the counters will be reset to 1 after reset, otherwise the 
driver can't work.

Thanks


>
>> +	    packed->last_avail_idx == 0 &&
>> +	    packed->last_used_counter == 1 &&
>> +	    packed->last_used_idx == 0)
>> +		return 0;
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>>   static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
>>   				const struct vdpa_vq_state *state)
>>   {
>> -	/* Note that this is not supported by virtio specification, so
>> -	 * we return -ENOPOTSUPP here. This means we can't support live
>> -	 * migration, vhost device start/stop.
>> +	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>> +
>> +	/* Note that this is not supported by virtio specification.
>> +	 * But if the state is by chance equal to the device initial
>> +	 * state, we can let it go.
>>   	 */
>> +	if ((vp_modern_get_status(mdev) & VIRTIO_CONFIG_S_FEATURES_OK) &&
>> +	    !vp_modern_get_queue_enable(mdev, qid)) {
>> +		if (vp_modern_get_driver_features(mdev) &
>> +		    BIT_ULL(VIRTIO_F_RING_PACKED))
>> +			return vp_vdpa_set_vq_state_packed(vdpa, state);
>> +		else
>> +			return vp_vdpa_set_vq_state_split(vdpa,	state);
>> +	}
>> +
>>   	return -EOPNOTSUPP;
>>   }
>>   
>> -- 
>> 2.25.1
>>

