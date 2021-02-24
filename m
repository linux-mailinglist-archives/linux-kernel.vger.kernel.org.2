Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5293323B65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhBXLns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232806AbhBXLni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614166931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6pjX4SLHgTz0NJkBF1xScFLT/BBC4Z4bjLRPd8FdtM=;
        b=BjY2vZ+dT8aD1IhF/l8Pj4ApKZcP6jCY98hJ2qv+a0dEzAGrSUG0zj7ZXjl0qy852gQOiJ
        jukbn2fg5lLiXKlnVJ5G6y/qlse552xAsrGiv9TJ03sTuGa7+uCps863QbCETQ3Wg+1Wqw
        D0vjlmEqAS14n00SzCsXNWtO07AHESk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-wLzghFYvN2uNjefIIWTNKQ-1; Wed, 24 Feb 2021 06:42:09 -0500
X-MC-Unique: wLzghFYvN2uNjefIIWTNKQ-1
Received: by mail-pl1-f200.google.com with SMTP id z2so1374595pln.18
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6pjX4SLHgTz0NJkBF1xScFLT/BBC4Z4bjLRPd8FdtM=;
        b=VIFfvPgECljXun+ZNfiGnXgvMk7+/3fx1aQ8vpE7d8JJ0xoP0QrV+L2PWGe0xemdMD
         Vj5Eg4SFF+7FeuzympC6bKHVfXvljTRhOr0rDqaX3ooY1HjtS0h3yZNu2wDQl63RZrKW
         2JaREPoP26BXPtZBo3oMHvqKffKm/qP/j1QtpfFxOIWQ+mdD8EZY0CG65nox9Up+CB12
         uENRfjN4uid5dBT7suJ1PLN0FReG2GXwI99Y2ipY+2wKG69+KeJhHBc6qdPt46sv+UDJ
         YMKP17AxWZiA4fuTjYI8GH2tEeqq3hU5fpZ6X8kQdJORo1nENjsmbzqqDhuOI4MnxKqU
         AZIg==
X-Gm-Message-State: AOAM530vjSNpyPgAMPDdSymcIUUpGWY4mtOjK2f55/MWMOUdmkF/b5KN
        op/AnBNdJWTjAZ5/jAomLI8+iPCV7gslgZKzlIwIOXau8+09OAc4VR3sO55ej/R7aja7qSdUX2B
        /IpgB5rIO3B57d9mfJaQc3mo/
X-Received: by 2002:a17:902:b089:b029:e3:28:b8ee with SMTP id p9-20020a170902b089b02900e30028b8eemr32658034plr.84.1614166928541;
        Wed, 24 Feb 2021 03:42:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqpnHDahCWOdYmYR1vBlv9n4xutt88MFzERot9njK4Fmx0jTWJnpgdpd507/I2r/HCRGxxCg==
X-Received: by 2002:a17:902:b089:b029:e3:28:b8ee with SMTP id p9-20020a170902b089b02900e30028b8eemr32658021plr.84.1614166928325;
        Wed, 24 Feb 2021 03:42:08 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l190sm2602018pfl.205.2021.02.24.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 03:42:07 -0800 (PST)
Date:   Wed, 24 Feb 2021 19:41:41 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, kexec@lists.infradead.org,
        intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] i40e: don't open i40iw client for kdump
Message-ID: <20210224114141.ziywca4dvn5fs6js@Rk>
References: <20210222070701.16416-1-coxu@redhat.com>
 <20210222070701.16416-5-coxu@redhat.com>
 <20210223122207.08835e0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210223122207.08835e0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

Thank you for reviewing the patch!

On Tue, Feb 23, 2021 at 12:22:07PM -0800, Jakub Kicinski wrote:
>On Mon, 22 Feb 2021 15:07:01 +0800 Coiby Xu wrote:
>> i40iw consumes huge amounts of memory. For example, on a x86_64 machine,
>> i40iw consumed 1.5GB for Intel Corporation Ethernet Connection X722 for
>> for 1GbE while "craskernel=auto" only reserved 160M. With the module
>> parameter "resource_profile=2", we can reduce the memory usage of i40iw
>> to ~300M which is still too much for kdump.
>>
>> Disabling the client registration would spare us the client interface
>> operation open , i.e., i40iw_open for iwarp/uda device. Thus memory is
>> saved for kdump.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Is i40iw or whatever the client is not itself under a CONFIG which
>kdump() kernels could be reasonably expected to disable?
>

I'm not sure if I understand you correctly. Do you mean we shouldn't
disable i40iw for kdump?

-- 
Best regards,
Coiby

