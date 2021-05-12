Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF32A37B8E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhELJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:13:27 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:34568 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230114AbhELJNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:13:25 -0400
Received: from [185.56.157.72] (port=41410 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lgkue-0005Hj-GI; Wed, 12 May 2021 11:12:16 +0200
Subject: Re: [PATCH 2/2] mfd: lp87565: handle optional reset pin
To:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        linux-kernel@vger.kernel.org
References: <20210226142852.19632-1-luca@lucaceresoli.net>
 <20210226142852.19632-2-luca@lucaceresoli.net>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <57d2d3d3-ee03-3e5d-ca39-b24cb57ca10f@lucaceresoli.net>
Date:   Wed, 12 May 2021 11:12:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226142852.19632-2-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/02/21 15:28, Luca Ceresoli wrote:
> Optionally handle the NRST pin (active low reset) in order to start from a
> known state during boot and to shut down the chip when rebooting.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Ping. Patch 2 is now in mainline. This patch applies cleanly on v5.13-rc1.

-- 
Luca
