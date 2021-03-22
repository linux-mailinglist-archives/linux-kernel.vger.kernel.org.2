Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA803446AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhCVOHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:07:36 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.36]:17204 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231252AbhCVOHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:07:15 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 3FB9D10AC7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:07:12 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id OLD6lmvAab8LyOLD6lEDP1; Mon, 22 Mar 2021 09:07:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cUnSQxPQKJaaBLNa5F4iOd/DRePu6SyoFMhjlo3t0aY=; b=Wdg5z/ykxmBWAAPH5LBsYOWdvx
        RIrc2FuXw3dVtbZlZN4A9qkmNkhbCgiA3ILklNr2NXdL618tZNWK3jvKs5bPZ/bCV+h/LjlhrhJK/
        efaOOvs0P+tafocRNUnC+jmsVDWwgcxgBs2uyLdXgpD6cGDyfS4iwRmhrUEAlBSl2kjYFxLZ97q4z
        0gh8LGx06x8/z2pauN3A1nanrpZn7ts5/9ne0gPn4ybMmO17yhjv+gaxuve6N/vXmFg9XVrYOalQh
        68yIuFtFXnoUQ1kZfjINe+OppzJK0KRNbxSqSyKx3fKBAika7OfMHlrWK/9Q9a2320ebT7BpsRfM9
        BH7llxjg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:55746 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lOLD5-000Q4E-Mq; Mon, 22 Mar 2021 09:07:11 -0500
Subject: Re: [PATCH][next] drm/amd/display: Fix sizeof arguments in
 bw_calcs_init()
To:     "Chen, Guchun" <Guchun.Chen@amd.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210322125050.GA236782@embeddedor>
 <CY4PR12MB128770E0A2502A3CA0A26650F1659@CY4PR12MB1287.namprd12.prod.outlook.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <408ff15d-81ba-0a0b-113d-96d5cb49a2a6@embeddedor.com>
Date:   Mon, 22 Mar 2021 08:07:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CY4PR12MB128770E0A2502A3CA0A26650F1659@CY4PR12MB1287.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lOLD5-000Q4E-Mq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:55746
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/21 09:04, Chen, Guchun wrote:
> [AMD Public Use]
> 
> Thanks for your patch, Silva. The issue has been fixed by " a5c6007e20e1 drm/amd/display: fix modprobe failure on vega series".

Great. :)
Good to know this is already fixed.

Thanks!
--
Gustavo
