Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88079319066
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhBKQxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:53:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231175AbhBKPke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613057947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gs1a/tfbUH/PEd0iLsgDabgczhYAOe2MzROMxzb4Y+s=;
        b=TIV/n3dCFNvq46t5QdYPainGQbC52MCDxKJCE104zYEk2KK9i2KxKrN+XnFWWIhwmP6tGC
        1lXp6YrcoDLmeglcBp7tahNQ1BD+s9ywhXRTAnunhiZPSp0vGZNJNMekU+lexYhWNMlFrw
        +33TO6vAYMyRl3iwZCJ2GfazLyU1e6o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-q_ftwGtRO1yMA5mQpB0bIw-1; Thu, 11 Feb 2021 10:39:04 -0500
X-MC-Unique: q_ftwGtRO1yMA5mQpB0bIw-1
Received: by mail-ej1-f72.google.com with SMTP id m4so4971147ejc.14
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 07:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Gs1a/tfbUH/PEd0iLsgDabgczhYAOe2MzROMxzb4Y+s=;
        b=ZATbJ6vz57Kh7vxIh9VGsNDC4tsTS5o+cISfp5YptjGJOb5YPg259Dy4JSV6RPwqnX
         J7buze337LPX26pKmZ6g/DJpqtHRDif/zHePMQe8zB8PcYpTdpICsb2F+q/qE90+CILa
         +kIiLTKpE9FWR8gbswq4ga+q4TNyvLzP2pcXBBsXNIi8yOkUMBj7F4pADm9AImNvhqjT
         EX6uCvVhQKW0DLW0vt6GLWHFwVLTS2u/UTkrSacWq6PQ/ZQxdaC/EMbAyAECO0R468Y4
         Ic1nZVSKMb54dn6PaPRKihzhs6rNguppe3fzqDZo+v3LWwnJ1PYfopeItrHOmTpSe0r/
         4Xeg==
X-Gm-Message-State: AOAM533Qgkxa1SkFhVQs+Nx8BJL0+4t0jyFrSf3K+nKzb9JUSOm1KrVf
        dWMQvoAHQpdX74V49u5F1Z+3MWXh5nMar1pkFitqc+ULSxlTPgjnOcGjCrzwSlPW9Xks9x6CrX4
        dgI6+9zs56jnpvSDqNPwcVgBi
X-Received: by 2002:a05:6402:4382:: with SMTP id o2mr9044871edc.371.1613057943712;
        Thu, 11 Feb 2021 07:39:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxW9DLr3Fwvy/0i2Ny6ozJLK40wr3ifKDYjwGfcSlxo4Hey4OMqRrCfpwF7GiQUNMtt0jAnpg==
X-Received: by 2002:a05:6402:4382:: with SMTP id o2mr9044847edc.371.1613057943458;
        Thu, 11 Feb 2021 07:39:03 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id u18sm4626476ejc.76.2021.02.11.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 07:39:03 -0800 (PST)
Date:   Thu, 11 Feb 2021 16:39:00 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        Parav Pandit <parav@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210211153900.tzmyxw5wlxxk7vbl@steredhat>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
 <20210209090014.xolf5kxri3xdmacz@steredhat>
 <cdd75885-3610-8685-14f3-5467a8ef1501@redhat.com>
 <20210210071129-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210071129-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 07:12:31AM -0500, Michael S. Tsirkin wrote:
>On Wed, Feb 10, 2021 at 12:17:19PM +0800, Jason Wang wrote:
>>
>> On 2021/2/9 下午5:00, Stefano Garzarella wrote:
>> > On Tue, Feb 09, 2021 at 07:43:02AM +0200, Eli Cohen wrote:
>> > > On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
>> > > > It's legal to have 'offset + len' equal to
>> > > > sizeof(struct virtio_net_config), since 'ndev->config' is a
>> > > > 'struct virtio_net_config', so we can safely copy its content under
>> > > > this condition.
>> > > >
>> > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported
>> > > > mlx5 devices")
>> > > > Cc: stable@vger.kernel.org
>> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > >
>> > > Acked-by: Eli Cohen <elic@nvidia.com>
>> > >
>> > > BTW, same error in vdpa_sim you may want to fix.
>> > >
>> >
>> > Commit 65b709586e22 ("vdpa_sim: add get_config callback in
>> > vdpasim_dev_attr") unintentionally solved it.
>> >
>> > Since it's a simulator, maybe we can avoid solving it in the stable
>> > branches. Or does it matter?
>>
>>
>> I think not, since the module depends on RUNTIME_TESTING_MENU.
>>
>> Thanks
>>
>
>Well people use the simulator for development...
>I'm not going to block this patch on it, but if someone
>has the cycles to post a stable branch patch, that would be
>great.
>

Okay, I'll do it.

Thanks,
Stefano

