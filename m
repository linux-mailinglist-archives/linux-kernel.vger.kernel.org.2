Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F4737906D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbhEJORT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232983AbhEJOOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620655982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsE4Hu1jfyAgBnO9Xt9Yk2kkAWYBUYyQ7xRMEnEGmO0=;
        b=HCM3JbLodXoVGYaeRY6II7xFUX3fGLVuajIzHP9sqXlytWAtuFvyI2lJ/gLUf5Liiuubcd
        Lg5P1iVdP4Wg98iqvQf25JrReb4ftMT5E5evj1KLBWAhSZE5iJqcV82E/+t12WcWx/EkNw
        Y2d9bOk/5DS4RrPl+QU5xlzFYFCZZ1Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-x2x8ZUbFO72U-80F4nd6GA-1; Mon, 10 May 2021 10:13:00 -0400
X-MC-Unique: x2x8ZUbFO72U-80F4nd6GA-1
Received: by mail-qv1-f71.google.com with SMTP id y24-20020a0ca9180000b02901d367101f9dso12720981qva.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jsE4Hu1jfyAgBnO9Xt9Yk2kkAWYBUYyQ7xRMEnEGmO0=;
        b=fFZEfLo14bXBxR9hViPYqAUq0GXC/kN2v1UHnJ2vbT+b1ThHfrriYMAVaWvYWbWrcb
         fH1oRT60Y673v6v0Dkz8TkiuorJc9JGb43aufJodlQPzvqog/hztQRJJFUeOdUQdzS/K
         V36WXRIiRQsgABUd8qsrbL2b7l9nMSrBA2uZov8YW0L4yPTqFNQxa5JjHg8ge9LHzIO/
         4nc1OklLvwIuzz5NRw14mgL3+auQlItchltMjI7NvRSymrmNRF5/c4UsxCdbpONT/BmK
         Zl6wG2s3g+63G5cFzLZl3KY6xj+X2wAztsS672dPqmbwdvvhG3Qhupgy1/WJhAJFKB7r
         4MLA==
X-Gm-Message-State: AOAM530SkU7zQ3BBiSZKTUdwngeX2QjFgRz3Og8qWOARIB2uL/SiJk3E
        swjL+UIviA/gHxZBzSrm5pXcyry6L4S6Nq38l1t6kmOY81QFXYyjPUGPSVmw3hS2mHhcGwKhy9Q
        HXzNKBtx9VPRyU8JaqvL9aJZl
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr23282246qki.159.1620655980280;
        Mon, 10 May 2021 07:13:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsz1KIzKqaoZqip0lZ+ej6Lo6hmON3jwnFv+dFMaAM1pY0v6DAVkwcOpGnU/1t8FDiz0YU8w==
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr23282219qki.159.1620655980094;
        Mon, 10 May 2021 07:13:00 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r5sm11395577qtp.75.2021.05.10.07.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 07:12:59 -0700 (PDT)
Subject: Re: [PATCH v12 0/7] FPGA Security Manager Class Driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
References: <20210503213546.316439-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6f3ce0db-883e-2c5b-e671-9ccc363ee532@redhat.com>
Date:   Mon, 10 May 2021 07:12:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503213546.316439-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/3/21 2:35 PM, Russ Weight wrote:
> The FPGA Security Manager class driver provides a common
> API for user-space tools to manage updates for secure FPGA
> devices. Device drivers that instantiate the FPGA Security
> Manager class driver will interact with a HW secure update
> engine in order to transfer new FPGA and BMC images to FLASH so
> that they will be automatically loaded when the FPGA card reboots.

Russ,

These have my Reviewed-by, but since it has been a while, I am looking 
these over again.

If you do not hear anything from me in the next couple of days, please 
assume everything is fine.

Tom

