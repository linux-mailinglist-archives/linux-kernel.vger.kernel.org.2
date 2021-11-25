Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3471845DE87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356326AbhKYQU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:20:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234992AbhKYQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637856943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2KR4RQ0Y3MoZbQHw5POdZV7GalDa4Jy+7l1ZIir+FVw=;
        b=G2QyjMXGAFreX1h7m4LVfMCRVCLbWvUc7O2qdkZKUoB8tWz1jVv/4FiBZfQCJMD1imGypy
        +2NOeDBdVJ0sQHjqcydbG4u4M/7rhiq6bsuUQgDLuEqg+q7ropXFrLxNG6sj9K0LTe6RGB
        H60i1GJp3n81ho7J3mq8GjrFX6u/amM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-mYE3IkmoNrqBjvL6fR8owg-1; Thu, 25 Nov 2021 11:15:42 -0500
X-MC-Unique: mYE3IkmoNrqBjvL6fR8owg-1
Received: by mail-ed1-f72.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so5866979edq.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2KR4RQ0Y3MoZbQHw5POdZV7GalDa4Jy+7l1ZIir+FVw=;
        b=Zg7NcuU0GVkKylLyc6JmXIj3CqNNnmtPuJYcb41OWUEQArZduPTzbuFN+rFF6COBlm
         ro/PYc7Qqnd1PW/k5y6N7sXNHjuaHE5HCDKhKRM/F6sRKSbS4f44eE7MXIeYSo4+Fy7n
         9LMURi5CgnKGnK1+f/QXs8CisWM0w219N/871mXsLBQ+MEFWXaLDPDEcPpcxIqgm+aR0
         9QkJy2All/DHvFc7yCKpHYXq2eM+4rGw+zuDgXkG5ijEBYJkhN7YEJOdBdlw3lWVZLOc
         YdLOmScyw1jQbE0l8VgmnmR8fTJqn2iGw2jRkbcLLLdSjjJawTQcnpkWAXf5GjBAs1eh
         yp2A==
X-Gm-Message-State: AOAM5319VVKShZALIEK4Mzud8TvNCYypypqgvw83Bpw+jNIfjK8vM0pw
        UHY6I1uAAoJG5gvt1EdbYPZv2RZtG3RUcmkIBEyowvvXNM1260Shz3o7XiS0+4VtoyjgW0ItRMt
        dUEpfCU+K5yq+tYg+knD6yVpO
X-Received: by 2002:a17:907:d14:: with SMTP id gn20mr31923173ejc.73.1637856940933;
        Thu, 25 Nov 2021 08:15:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFk9QcfhxCEL7BcCV9s1MaxWtAqsxHaQO8OQvgpOnFkZOtYqzhUSfxRBivVUUUwPpZZDXxmA==
X-Received: by 2002:a17:907:d14:: with SMTP id gn20mr31923141ejc.73.1637856940682;
        Thu, 25 Nov 2021 08:15:40 -0800 (PST)
Received: from redhat.com ([176.12.197.47])
        by smtp.gmail.com with ESMTPSA id qa7sm1863380ejc.64.2021.11.25.08.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 08:15:39 -0800 (PST)
Date:   Thu, 25 Nov 2021 11:15:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Parav Pandit <parav@nvidia.com>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: drivers/vdpa/vdpa.c:296 vdpa_mgmtdev_fill() warn: should
 '(((1))) << (mdev->id_table[i]->device)' be a 64 bit type?
Message-ID: <20211125111511-mutt-send-email-mst@kernel.org>
References: <202111250317.VUsGtdox-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111250317.VUsGtdox-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:03:28AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5d9f4cf36721aba199975a9be7863a3ff5cd4b59
> commit: 33b347503f014ebf76257327cbc7001c6b721956 vdpa: Define vdpa mgmt device, ops and a netlink interface
> config: i386-randconfig-m021-20211118 (https://download.01.org/0day-ci/archive/20211125/202111250317.VUsGtdox-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/vdpa/vdpa.c:296 vdpa_mgmtdev_fill() warn: should '(((1))) << (mdev->id_table[i]->device)' be a 64 bit type?
> 
> vim +296 drivers/vdpa/vdpa.c
> 
> 33b347503f014eb Parav Pandit 2021-01-05  280  static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
> 33b347503f014eb Parav Pandit 2021-01-05  281  			     u32 portid, u32 seq, int flags)
> 33b347503f014eb Parav Pandit 2021-01-05  282  {
> 33b347503f014eb Parav Pandit 2021-01-05  283  	u64 supported_classes = 0;
>                                                 ^^^^^^^^^^^^^^^^^^^^^
> This is a u64
> 
> 33b347503f014eb Parav Pandit 2021-01-05  284  	void *hdr;
> 33b347503f014eb Parav Pandit 2021-01-05  285  	int i = 0;
> 33b347503f014eb Parav Pandit 2021-01-05  286  	int err;
> 33b347503f014eb Parav Pandit 2021-01-05  287  
> 33b347503f014eb Parav Pandit 2021-01-05  288  	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_MGMTDEV_NEW);
> 33b347503f014eb Parav Pandit 2021-01-05  289  	if (!hdr)
> 33b347503f014eb Parav Pandit 2021-01-05  290  		return -EMSGSIZE;
> 33b347503f014eb Parav Pandit 2021-01-05  291  	err = vdpa_nl_mgmtdev_handle_fill(msg, mdev);
> 33b347503f014eb Parav Pandit 2021-01-05  292  	if (err)
> 33b347503f014eb Parav Pandit 2021-01-05  293  		goto msg_err;
> 33b347503f014eb Parav Pandit 2021-01-05  294  
> 33b347503f014eb Parav Pandit 2021-01-05  295  	while (mdev->id_table[i].device) {
> 33b347503f014eb Parav Pandit 2021-01-05 @296  		supported_classes |= BIT(mdev->id_table[i].device);
> 
> Which suggests that this should be BIT_ULL().
> 
> 33b347503f014eb Parav Pandit 2021-01-05  297  		i++;
> 33b347503f014eb Parav Pandit 2021-01-05  298  	}
> 33b347503f014eb Parav Pandit 2021-01-05  299  
> 33b347503f014eb Parav Pandit 2021-01-05  300  	if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
> 33b347503f014eb Parav Pandit 2021-01-05  301  			      supported_classes, VDPA_ATTR_UNSPEC)) {
> 33b347503f014eb Parav Pandit 2021-01-05  302  		err = -EMSGSIZE;
> 33b347503f014eb Parav Pandit 2021-01-05  303  		goto msg_err;
> 33b347503f014eb Parav Pandit 2021-01-05  304  	}
> 33b347503f014eb Parav Pandit 2021-01-05  305  
> 33b347503f014eb Parav Pandit 2021-01-05  306  	genlmsg_end(msg, hdr);
> 33b347503f014eb Parav Pandit 2021-01-05  307  	return 0;
> 33b347503f014eb Parav Pandit 2021-01-05  308  
> 33b347503f014eb Parav Pandit 2021-01-05  309  msg_err:
> 33b347503f014eb Parav Pandit 2021-01-05  310  	genlmsg_cancel(msg, hdr);
> 33b347503f014eb Parav Pandit 2021-01-05  311  	return err;
> 33b347503f014eb Parav Pandit 2021-01-05  312  }


Parav? Any patches for this one?

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

