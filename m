Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDFE3BC827
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhGFI6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:58:34 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.48]:33963 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhGFI6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:58:33 -0400
X-Greylist: delayed 1259 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 04:58:33 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id F128814AB9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 03:34:53 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 0gXdmaomCK61i0gXdm0jru; Tue, 06 Jul 2021 03:34:53 -0500
X-Authority-Reason: nr=8
Received: from host-95-244-220-40.retail.telecomitalia.it ([95.244.220.40]:40218 helo=x1.bristot.me)
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1m0gXc-001fP3-BI; Tue, 06 Jul 2021 03:34:52 -0500
Subject: Re: kvm-vm boot fail: ttm_bo_cleanup_memtype_use?
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <8c1ea35a-9ec9-bf11-ace4-8c604b04bbc3@kernel.org>
 <fef73358-748f-f1d0-bca9-43efa6497f44@amd.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
Message-ID: <ab86c676-2753-6670-87de-57e1043c61c3@kernel.org>
Date:   Tue, 6 Jul 2021 10:34:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fef73358-748f-f1d0-bca9-43efa6497f44@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.244.220.40
X-Source-L: No
X-Exim-ID: 1m0gXc-001fP3-BI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-244-220-40.retail.telecomitalia.it (x1.bristot.me) [95.244.220.40]:40218
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/21 8:53 AM, Christian König wrote:
> Hi Daniel,
> 
> looks like a simple missing NULL check to me. Please test the attached patch.
> 

It works!

Feel free to add:

Reported-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Tested-by: Daniel Bristot de Oliveira <bristot@kernel.org>

> We recently changed the structure of the resources, so probably introduced while
> doing that.
> 
> Christian.

Thanks!
-- Daniel
