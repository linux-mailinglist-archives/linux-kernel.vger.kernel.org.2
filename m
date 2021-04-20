Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5689D366221
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 00:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhDTWS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 18:18:59 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.187]:16387 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233769AbhDTWS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:18:58 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 1B08C7EDCC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:17:27 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YygRlg5aO1cHeYygRlnnBJ; Tue, 20 Apr 2021 17:17:27 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IqU1MVnkdAvu7/gdvMsvZ0UoM0R9qMbLSGUvD8bDyo0=; b=t25+aD0FWGgg1MTsiBu8RqM+6u
        XuNDC1IGpHeaMXQ/FDcbBb9MwHAKKXpa2IIp5FdKlC8j7gx/qpEGLOMJaAQ9IIh1dRTeNIL+GHg5D
        z/LOitlLpayD8MIOy43peMioMdQ10hUNqBoUve7nB1PQk4caMZgHhiTu6EM+It4TtfBZrdwh/qAVd
        vXLfSVS8p6F3dZAD8VJinwbA200XXf0hQj8m+ydrEL1gZpK4uFCZSy2fkuxIsjIn8Bs0DcPyemfjT
        Cg+K5Mm5OUI7GORV80LtOux+35CHIg2z9zqZP4h8lIsThqBNdGAg3INIlQfcj+4jFFEE7UJy7QBEA
        ScAJRZBQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:50542 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYygN-001kpE-J7; Tue, 20 Apr 2021 17:17:23 -0500
Subject: Re: [PATCH 027/141] drbd: Fix fall-through warnings for Clang
To:     Jens Axboe <axboe@kernel.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <44663f18fb12e39c53b0e69039c98505b7c6d5da.1605896059.git.gustavoars@kernel.org>
 <ba77fcbe-8770-d234-509b-7dc5ac079319@embeddedor.com>
 <2c942833-ae0f-bda5-b023-e2a1860be50f@kernel.dk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <6610a212-6095-0527-c260-49bb2637b7f4@embeddedor.com>
Date:   Tue, 20 Apr 2021 17:17:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2c942833-ae0f-bda5-b023-e2a1860be50f@kernel.dk>
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
X-Exim-ID: 1lYygN-001kpE-J7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:50542
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/21 16:23, Jens Axboe wrote:

> Applied, thanks.

Awesome. :)

Thanks
--
Gustavo
