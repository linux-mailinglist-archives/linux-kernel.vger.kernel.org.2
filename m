Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7EB3FB65C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhH3MtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232571AbhH3MtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630327701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiME9RlNm5SAhXvVsLRZq1lyvM9TxKc+Qrup6LJMOBU=;
        b=Nk0O9HhbNfKCZ/vzs6tRntKKFaNZH2azcOI5mdkdeYI0AKNgEodtHCxSrEm284+EZler0K
        7DHtc+P5hsR4dIn8DcBv/qw/oOvaaCO1iFTsFBS9CvusALqXCVQSubl9UPb93osgK4kiOh
        VrcYTKLQrfocqCrCHu4tFrI47WYwcGE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-WcLVSo_LMV2xi7EVFeaEeA-1; Mon, 30 Aug 2021 08:48:20 -0400
X-MC-Unique: WcLVSo_LMV2xi7EVFeaEeA-1
Received: by mail-wr1-f69.google.com with SMTP id h14-20020a056000000e00b001575b00eb08so3264026wrx.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FiME9RlNm5SAhXvVsLRZq1lyvM9TxKc+Qrup6LJMOBU=;
        b=rmz6X0nQYKRXDGhaI/lSIdh+mvqRxPFSpbZ8n8r+IAJOzr6qeh7ZhxYDTGPdSYTtZ0
         gOH1U7JJYfchsOkMy6APzyLuGetWfgKzxfntmzsz/oeFo1OZ0/fgA4BJCWo3JJn2B3qs
         t2t/h3NxcmwSaAkO9+8tzFdzpoCbHgfmJ6wPQUYRSrH4gMPvUjFcxD/jgdMS7QibyGZ+
         IU5JjWIAATmj21gRlgS6meKgdLFhBMtd0mM5RIhv+P5Ql99nHSSig/dmGIr+y6bwyjM1
         gRXkVdWNzwA4lT9GKpZRMGbE597RX1SR1/2EOVxQngZ8ZOPhnTsVd66MoSGuJLQsSbOQ
         gysA==
X-Gm-Message-State: AOAM530XN+pVusa+eqiZuUj6qjluO2gR4826Tcwv/eNKRs+oaFHQdkDS
        AxZesb7ZN6z52KquOt20ZJG89UvnT/GQHVgBw7xfw45cdlLgWqjYr7hUafgepH3IBUnRoGIukUY
        rcPEeDFdWljGnhKfApk43o/6X
X-Received: by 2002:adf:d191:: with SMTP id v17mr12776660wrc.345.1630327699094;
        Mon, 30 Aug 2021 05:48:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeb7+bjxDgvj9ov7Rye3qpLgWHpO/3cc11sdL8B9m9cled44vO/p+IA1s3PqiNIk0GpfbHkQ==
X-Received: by 2002:adf:d191:: with SMTP id v17mr12776644wrc.345.1630327698923;
        Mon, 30 Aug 2021 05:48:18 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3c08:b500:afb2:5ebc:3fd2:26de? ([2a0c:5a80:3c08:b500:afb2:5ebc:3fd2:26de])
        by smtp.gmail.com with ESMTPSA id j207sm3054072wmj.40.2021.08.30.05.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:48:17 -0700 (PDT)
Message-ID: <a2b6f361bdcf884c18c51f94010a81b488272481.camel@redhat.com>
Subject: Re: [RFC PATCH v2 1/4] drivers/mfd: sensehat: Raspberry Pi Sense
 HAT core driver
From:   nsaenzju@redhat.com
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Date:   Mon, 30 Aug 2021 14:48:17 +0200
In-Reply-To: <20210820180801.561119-2-cmirabil@redhat.com>
References: <20210820180801.561119-1-cmirabil@redhat.com>
         <20210820180801.561119-2-cmirabil@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-20 at 14:07 -0400, Charles Mirabile wrote:
> This patch adds the core driver file, containing methods to communicate
> with the board over I2C. We also add the header file shared by all
> three drivers, containing common data and definitions. In addition, we
> add a config option to toggle compilation of the driver.
> 
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---

Correct me if I'm wrong, but it seems to me that you could completely avoid
this driver if you used 'simple-mfd-i2c.c'. See 'kontron,sl28cpld' for an
example of how it's used.

Regards,
Nicolas

