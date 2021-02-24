Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4D13238D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhBXIlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:41:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234201AbhBXIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614155815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CE7U1bZ1YGl3XEvcRWSU6EnQV8VmyBEPYCmQyZoxSGU=;
        b=Dq6RTdIDkuEZym9rurDfnvd3BHDdMHAi5ExSXUlYPySJGXJqBomgbf3oIxq3bsxSlnE114
        b7Iok0duY2fhkUTlkAtd3jBUUz+axSq0nTcqux6k6SIDjvlTvontNsA1Ny0X4j4bJpL5cI
        6RqgPBGX8S7NMx2AX3TpgNsF7tLecaA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-On5QGTq-O7i7dOcQ3BPp2w-1; Wed, 24 Feb 2021 03:36:20 -0500
X-MC-Unique: On5QGTq-O7i7dOcQ3BPp2w-1
Received: by mail-wr1-f72.google.com with SMTP id v3so708916wro.21
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CE7U1bZ1YGl3XEvcRWSU6EnQV8VmyBEPYCmQyZoxSGU=;
        b=XcMeiH5zCd36FWnj9nNRzoTtehrgB61VzZzmTTFRUnMSyLbI2j5PoxLAFWDm7lqppA
         Dfo/MBq6NoO35XaWFnETpxGVHDo5Pknhc3xR9X9WpbUXQ3k/hNEOp/o3bSV3Pd4lyDSr
         goDYP+7JeC0ixdnybaJxl/c00zZAvCp4+fZj/0dua0uyu882uW1UXBi4Ls7kLAncLuXf
         8cAnz6pFZ93cC9S97gT4Gfu4uzHAb9pNvVaFItSR13Vlm54+0T1lHDSIKsCCnoVMwr7Z
         PeG1KvipPoskZU4Bpt1Z/kQ5RzKLkokjRC/yn/xKNQoGI84qMjZEvCrDeva4YL/pdHn1
         jMgA==
X-Gm-Message-State: AOAM5339uf2fvLJDC4HCWT1geqJhCgBywzgur3Ts39nGnQXSK1/v8llp
        wzKyBASEwqMG1AoX3/XykSbg888XTdkwuVrrXcjY82fj3Bianx8DFcxtc5FH2cyxhV1+DUeyZ7i
        4+vrfUiiktMtmZ3/vqbMh67RV
X-Received: by 2002:a7b:cf0c:: with SMTP id l12mr2617561wmg.41.1614155779515;
        Wed, 24 Feb 2021 00:36:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAhQcAI7N30VO8jh2UgZcBUTCQKzHiQPGY/fG+BniOkSvX+sc5ciX0JXEQvcLrR72Del5zwg==
X-Received: by 2002:a7b:cf0c:: with SMTP id l12mr2617543wmg.41.1614155779327;
        Wed, 24 Feb 2021 00:36:19 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id v1sm1585860wmj.31.2021.02.24.00.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:36:19 -0800 (PST)
Date:   Wed, 24 Feb 2021 09:36:16 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5.10 03/29] vdpa_sim: store parsed MAC address in a buffer
Message-ID: <20210224083616.ha6xhjt5itb43477@steredhat>
References: <20210222121019.444399883@linuxfoundation.org>
 <20210222121020.153222666@linuxfoundation.org>
 <20210222195414.GA24405@amd>
 <20210223080655.ps7ujvgvs6wtlszf@steredhat>
 <20210224082954.GB8058@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210224082954.GB8058@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 09:29:54AM +0100, Pavel Machek wrote:
>Hi!
>
>> >>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >>@@ -42,6 +42,8 @@ static char *macaddr;
>> >> module_param(macaddr, charp, 0);
>> >> MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
>> >>
>> >>+u8 macaddr_buf[ETH_ALEN];
>> >>+
>> >
>> >Should this be static?
>>
>> Yes, there is already a patch [1] queued by Michael but not yet upstream.
>> When it will be merged upstream I will make sure it will be backported.
>
>Having it in mainline is enough, I don't really think it causes
>anything user-visible, so it does not need to be in stable.

Got it.

Thanks,
Stefano

