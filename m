Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7B41BAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 01:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbhI1XUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 19:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230349AbhI1XU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 19:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632871128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/J9uXh/NpiD0hENFRRaixgk3dGd3d67B8zszzrfj9Pw=;
        b=XL9/IeHBbU0CapeSE3a6xWkQJGbrfKPcciAmo2LCrxehI32qtTaRdiCp9Wbv87ZLE75kj3
        AL+SFf2ufDyQB7FWYtn5McaE02gcNONUhHqmlWmf4IQyu3By5MZvrIFLAnRA7pbK5WBS7u
        0wMU84baiQg8DDa93FfgmmZgC7MIUOg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-ip4cVZG-MQaan0I56xYIig-1; Tue, 28 Sep 2021 19:18:46 -0400
X-MC-Unique: ip4cVZG-MQaan0I56xYIig-1
Received: by mail-wm1-f71.google.com with SMTP id 200-20020a1c00d1000000b0030b3dce20e1so1843774wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/J9uXh/NpiD0hENFRRaixgk3dGd3d67B8zszzrfj9Pw=;
        b=Kdc1icfAU7pOJb2ElY5o5WOt/afsz/HZkfrvoMHmSQvPdJXJNefYw+rcStxeGJwgwq
         rgdbxf8DxafyVv7QyLSSTpWP9SX/2kfKJGkcyxFLZm6cBU9MA/QhoG7cuWR0Hrh8beHd
         IxINhbAjd13nYVvzi5fOW+dp7ZbKchLdNDgycWoTmX3xgnjAD7IzRG+S7lFaQ+hgdo7C
         J580VXiOcy0yLtmj80f5dtSaTmF4FxWB9dPFhTz++W60e9YBLEwSxY0TacpCpjt+kyPh
         uRKdp+hAVNZbz7sbwPImrf8OMa5/7ioSC88+rGjMRHe3kBtRqqjYXHMWEDr/8I3dNOY5
         bO4w==
X-Gm-Message-State: AOAM531Ci0QNKFVR9/crpkV2PdUltDFJB9Xud5MyHNfOh2KNd8Fun8iZ
        g/ORfLj8b73xGyhVVR95I9yt4i3NmvrMXhUGDMsBFS9+xNudiwe6Yi9N7hvOGnRTIcwiw3ljbv3
        GAMKdHbT8T9+EzFxKWzjQREuF
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr7095918wmj.173.1632871125500;
        Tue, 28 Sep 2021 16:18:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz2pejIQePBmmgXCTt1XcJxswV5FS7A1YZhpMN6QJ6KrvvPKhD8QAM4eLrCzDP/Vxa0Zq6bA==
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr7095905wmj.173.1632871125362;
        Tue, 28 Sep 2021 16:18:45 -0700 (PDT)
Received: from redhat.com ([2.55.4.59])
        by smtp.gmail.com with ESMTPSA id d7sm456977wrh.13.2021.09.28.16.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:18:44 -0700 (PDT)
Date:   Tue, 28 Sep 2021 19:18:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc1
Message-ID: <20210928191714-mutt-send-email-mst@kernel.org>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913035750.GA1196001@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913035750.GA1196001@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 08:57:50PM -0700, Guenter Roeck wrote:
> The qemu runtime failure bisects to commit 694a1116b405 ("virtio: Bind
> virtio device to device-tree node"), and reverting that commit fixes the
> problem.  With that patch applied, the virtio block device does not
> instantiate on sparc64. This results in a crash since that is where the
> test is trying to boot from.
> 
> Good news is that I don't see any new runtime warnings.
> 
> Guenter

I think the fix is now merged by Linus - could you please try it out and
confirm that it's ok?

Thanks a lot for the testing!

-- 
MST

