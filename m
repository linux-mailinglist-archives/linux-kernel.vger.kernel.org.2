Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3BC3EB2D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbhHMIra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239327AbhHMIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628844422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/2LLLa4Knn+Y6OU5yiYg2idNmi6VgzjwtSnMoXh7QY=;
        b=Ky6LX6NdAkW/HCNFeM07Mqq9J3DhjfX3etpQvuuDkycsZW91dOQZ7zKamTeuvBovVOlG2j
        kl0VpyxGsVa+ZfJjEdtGrCCKvQHlhAVECoUdVPk2PB+c8SLBp0efBmehNfcMP62Y+HN5BM
        1P8Ei4ncGHDkeTT6RLll9050euOaHbE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-Q3Ct7z9gMqu6AIC7GOBMKQ-1; Fri, 13 Aug 2021 04:47:01 -0400
X-MC-Unique: Q3Ct7z9gMqu6AIC7GOBMKQ-1
Received: by mail-ed1-f69.google.com with SMTP id a23-20020a50ff170000b02903b85a16b672so4537830edu.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q/2LLLa4Knn+Y6OU5yiYg2idNmi6VgzjwtSnMoXh7QY=;
        b=BMkbPoFKLA/UuSpiyXMCP/Z2hx8pxabkh1jTVeWtC9t99bnm/gkXMMiIARSqHDVLem
         ZGGQAIQU8k+Joo5KQFOA4EEIMrXplH/M5Y6TVfjrIfcENWz9s3Y39CpNwsn98iPOmCPM
         dTIhRHyFt1BPXssk2/3ZDFlGO5NKRNUBnhUkrYpngB+7+PY00VpfTUdxWztkmfGN1gme
         BWbhPr5qLhhRMOXmU7RPHuEaCeQVATufq/4y04KmyzKMJpimhUmOwthkXc0A2yDSgj1C
         NeqHrKMb+p+78sorxnqBjnj9CU45F5C4mglNDXiDEyUddbgUtR16qgUtrmXPY9Ty10xc
         8umA==
X-Gm-Message-State: AOAM530vSj6PTzy6UeTGlXlrgsRMM3SfV65l3rcnK+dZPShj+is9Agii
        tMDFrCT33pjuO8LNvgUmQG84dUPc+tdGeIi4u4CUoySWCbOcmKMnankPA31oRHUK7+DejE2Miz2
        DxZTfHEoMMMCv2mt+ewlpDDsI
X-Received: by 2002:aa7:cc08:: with SMTP id q8mr1702204edt.225.1628844420130;
        Fri, 13 Aug 2021 01:47:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5EloBaEg+0tMtbqyttcX5xHezj44yloaXLpv99plL6aoifnGakzAUprzKQ5XPKCB4a6lvHg==
X-Received: by 2002:aa7:cc08:: with SMTP id q8mr1702186edt.225.1628844419980;
        Fri, 13 Aug 2021 01:46:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z4sm92658edc.33.2021.08.13.01.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 01:46:59 -0700 (PDT)
Subject: Re: [PATCH] asus-wmi: Add support for platform_profile
From:   Hans de Goede <hdegoede@redhat.com>
To:     Luke Jones <luke@ljones.dev>, Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20210813024201.9518-1-luke@ljones.dev>
 <35JRXQ.1ZW8QHWM1YRG@ljones.dev>
 <9cceb3cb-f6d3-ade4-b219-87b2bbce5798@redhat.com>
 <R1ORXQ.WGLIPS8I54X63@ljones.dev>
 <5b503320-c1a3-2653-b269-ba8d40568edf@redhat.com>
 <a4acaf03-b6b3-49f3-14e8-6766e9e24215@redhat.com>
Message-ID: <a1303271-d61e-a500-5c65-6b6bab4d40ce@redhat.com>
Date:   Fri, 13 Aug 2021 10:46:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a4acaf03-b6b3-49f3-14e8-6766e9e24215@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p.s.


<snip>

Note that inotify (and thus GFileMonitor) does not really work on sysfs files.

Interesting email thread about this here:

https://linux-fsdevel.vger.kernel.narkive.com/u0qmXPFK/inotify-sysfs

