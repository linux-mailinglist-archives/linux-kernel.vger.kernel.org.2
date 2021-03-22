Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DD6343B96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCVITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhCVITa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616401170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WoKk7mGrLBFPYHjSxhI5m6ZJ3T1eCo8ygoYac0Rpup8=;
        b=XdKRA5ppbvlhDYKky+q5phompi7SFKIJptOGbu7MkXRy2qNC4OqI6aZpKPVIps6ajwi6ph
        c1HoMgP7tW0q9yabrsSYo7XaEDrPCd90vbet9BZddso1xb2OCb5J7IP55Z2XiuTofb61U0
        2d5AptjC4ecaADbnGN91ZWWsDquW1Yc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-s3sNhZz_PLG4KXrPl5m5tw-1; Mon, 22 Mar 2021 04:19:28 -0400
X-MC-Unique: s3sNhZz_PLG4KXrPl5m5tw-1
Received: by mail-wr1-f70.google.com with SMTP id 9so10051381wrb.16
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WoKk7mGrLBFPYHjSxhI5m6ZJ3T1eCo8ygoYac0Rpup8=;
        b=ZFnDNlm1z//V0auPNh15kDS1rueH1iG0ukfcxAOCy42ucN0kk4hDI/UqCx1vzx+UR+
         41bo9gtxH34RsSMsthiJCbKldGbe8Q1epb+0gpf3sSAFLJjNrudFXWKVe9TF1SS/lN90
         NnHKR361F0TFlesVVJ9R7XedTntXfCCEgdDUnKOyhzBCDf77qFHRWbXoGZPh8inXFlpR
         oNojl5/k0Jjuyiio+XwVzkcg9IjJkOZYQGCeQkSC1qNVbX7Mqf1SXAGJ6hIoZ3pZB4wG
         S5z7ktTVYjfm6flJx2fxTw478wWfMn4s3rjKIOhYIktqJHfxErRbu029L9R4K/TBlqPg
         DTcA==
X-Gm-Message-State: AOAM530x+Bu11oAClK1uvTN4bIbWK8Ip9TCtD2KSG3muQ48WeCOB6EdD
        NScY+GJZGSjPWajruIM4EH+004MZvMHbXi56fh1DNDTAd4dRnYAkMEC3tVz/bcLSHXbyOutje8S
        QK+Cv8ij/7LQZghHzxWJw+ZD3
X-Received: by 2002:a7b:c346:: with SMTP id l6mr14925813wmj.34.1616401167060;
        Mon, 22 Mar 2021 01:19:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/hGKwIQ8AizOzUTlpxccYR1kU76/f9kIiC5G+j9WI50iF5Kv+8CR5Hj4QZ7N0ojmMTnKJkQ==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr14925787wmj.34.1616401166932;
        Mon, 22 Mar 2021 01:19:26 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
        by smtp.gmail.com with ESMTPSA id u15sm14813092wmq.4.2021.03.22.01.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 01:19:26 -0700 (PDT)
Date:   Mon, 22 Mar 2021 04:19:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jie Deng <jie.deng@intel.com>
Cc:     linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wsa@kernel.org, jasowang@redhat.com,
        wsa+renesas@sang-engineering.com,
        andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
        arnd@arndb.de, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
        rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
        u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
        yu1.wang@intel.com, shuo.a.liu@intel.com, viresh.kumar@linaro.org,
        stefanha@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v9] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210322041857-mutt-send-email-mst@kernel.org>
References: <e09c07532f5456816eb91ef4176bf910284df4ff.1616418890.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09c07532f5456816eb91ef4176bf910284df4ff.1616418890.git.jie.deng@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:35:59PM +0800, Jie Deng wrote:
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index bc1c062..6ae32db 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -54,5 +54,6 @@
>  #define VIRTIO_ID_FS			26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM			27 /* virtio pmem */
>  #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
> +#define VIRTIO_ID_I2C_ADPTER		34 /* virtio i2c adpter */

ADPTER -> ADAPTER?
adpter -> adapter?

>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.7.4

