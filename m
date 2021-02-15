Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB631BC04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 16:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBOPOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 10:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230494AbhBOPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613401412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6OX4vimRIYcAltpLrS5Z53hifPCnMBDqbANLVQyXP1s=;
        b=F8RurZ0ZPHzEyWL8V46Kc/onknZSfjNLApHm1u8TaHfFVNV3D5jEpqCS1sa9OMbatLrxbW
        TcBiMBMQ2cE8AkpfYcdo8girm3WiA+kfcGjWzskT+AdNj/ncm1RNEj4K7f8hBzTHinQYmP
        3AowOrtqDLczSS9IMVFLOEx7B1bdx+s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-b1ZH_cvmN46h0ex3jDG_3A-1; Mon, 15 Feb 2021 10:03:31 -0500
X-MC-Unique: b1ZH_cvmN46h0ex3jDG_3A-1
Received: by mail-wr1-f70.google.com with SMTP id f5so10141850wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6OX4vimRIYcAltpLrS5Z53hifPCnMBDqbANLVQyXP1s=;
        b=lMb/KK+u+A2tEc06bXxDLMhgQ8CIEExMkVvU/g9Y99yMDGbF8/dNj9gS9tpewoLC+Z
         3i/2Vs8drVa0KamAUHB0p+YgBtzRMgt76/vnMqOABEHD4er2NiqC4oArQTTQOnnkqjCE
         eKGHqowq1mtzJ9vmOeLPzMiU46ymFeiERzJPF7Un1Buks/DjRKcf4Ktt+IQhWhG5n9FD
         dpCj3/zKdgkkClotTw+HyUCv2cux+ZHQTy228/ua0CiO5nwhJHJAjwEO5FcMlUomFmQN
         5Pro5h0F0fmBr6ft/kGAC+dMZHKPEn9hLisCtCPRFSw/ARq2mLRAH7LNrRJP7b5DwDLo
         24kQ==
X-Gm-Message-State: AOAM530xSdNupEawK68aGdG3XgiZMMRGGcJuyqhql/mJqElYbozotyJ8
        1q+DnH6c0dl/EipEB358OWPTc6O0biYrWHaRC4x9kb66YmzH2FRn/CaQFPVz86QrSapc3FxgT5E
        zwWlKiHpzX33KuX+dEZP1yEN1
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr4159277wmb.155.1613401408244;
        Mon, 15 Feb 2021 07:03:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/AtAp079VBfkMV3Qo2wZFlU4QfgHEV8WJ1TqhKlNz8DDguCYh2aLXGYfoY3y+v1FTjOTtKQ==
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr4158972wmb.155.1613401404026;
        Mon, 15 Feb 2021 07:03:24 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id s10sm23992860wrm.5.2021.02.15.07.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:03:23 -0800 (PST)
Date:   Mon, 15 Feb 2021 16:03:21 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH for 5.10] vdpa_sim: fix param validation in
 vdpasim_get_config()
Message-ID: <20210215150321.anwcogkifg6sefp6@steredhat>
References: <20210211162519.215418-1-sgarzare@redhat.com>
 <YCqF891BLn5zsUwd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCqF891BLn5zsUwd@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 03:32:19PM +0100, Greg KH wrote:
>On Thu, Feb 11, 2021 at 05:25:19PM +0100, Stefano Garzarella wrote:
>> Commit 65b709586e222fa6ffd4166ac7fdb5d5dad113ee upstream.
>
>No, this really is not that commit, so please do not say it is.

Oops, sorry.

>
>> Before this patch, if 'offset + len' was equal to
>> sizeof(struct virtio_net_config), the entire buffer wasn't filled,
>> returning incorrect values to the caller.
>>
>> Since 'vdpasim->config' type is 'struct virtio_net_config', we can
>> safely copy its content under this condition.
>>
>> Commit 65b709586e22 ("vdpa_sim: add get_config callback in
>> vdpasim_dev_attr") unintentionally solved it upstream while
>> refactoring vdpa_sim.c to support multiple devices. But we don't want
>> to backport it to stable branches as it contains many changes.
>>
>> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>> Cc: <stable@vger.kernel.org> # 5.10.x
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 6a90fdb9cbfc..8ca178d7b02f 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -572,7 +572,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>>  {
>>  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>
>> -	if (offset + len < sizeof(struct virtio_net_config))
>> +	if (offset + len <= sizeof(struct virtio_net_config))
>>  		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
>>  }
>
>I'll be glad to take a one-off patch, but why can't we take the real
>upstream patch?  That is always the better long-term solution, right?

Because that patch depends on the following patches merged in v5.11-rc1 
while refactoring vdpa_sim:
   f37cbbc65178 vdpa_sim: make 'config' generic and usable for any device type
   cf1a3b35382c vdpa_sim: store parsed MAC address in a buffer
   a13b5918fdd0 vdpa_sim: add work_fn in vdpasim_dev_attr
   011c35bac5ef vdpa_sim: add supported_features field in vdpasim_dev_attr
   2f8f46188805 vdpa_sim: add device id field in vdpasim_dev_attr
   6c6e28fe4579 vdpa_sim: add struct vdpasim_dev_attr for device attributes
   36a9c3063025 vdpa_sim: rename vdpasim_config_ops variables
   423248d60d2b vdpa_sim: remove hard-coded virtq count

Maybe we can skip some of them, but IMHO should be less risky to apply 
only this change.

If you want I can try to figure out the minimum sub-set of patches 
needed for 65b709586e22 ("vdpa_sim: add get_config callback in 
vdpasim_dev_attr").

Thanks,
Stefano

