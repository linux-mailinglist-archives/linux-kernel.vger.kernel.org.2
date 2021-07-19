Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809473CCCCF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhGSDsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:48:30 -0400
Received: from phobos.denx.de ([85.214.62.61]:45916 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234345AbhGSDs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:48:29 -0400
Received: from [192.168.1.107] (fibhost-66-234-106.fibernet.hu [85.66.234.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hs@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1F7278033E;
        Mon, 19 Jul 2021 05:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626666329;
        bh=ajhJrL/O5jCDrfjMHFqj2/38Xg58vxi40OeuMTyIfZk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TFYRpjE1p4t17tlIXF8AMWwwbjVIhh9YcFRahD5rbmFWA89dT6SGL8n7B4JY0EAM4
         7dvfXA6kMv5ZC3hNCQru0HTYdqQyYTuIAtrlrOsj7da79zOxkHXuX2Cy+A3bjx59t3
         G7R2wdhagN6jUhD+YnVo+UBAI4Ck80VG0zDDYAIIjdyN44oD4ZfvQtndujB429UfeB
         TYtyPlSLmgJqH1/ZJYwczYzApNFudjtXWM1lM9ZrhHx55itwiS+AgJfh05LWgWkPSH
         lvVjtpn4/mxZoPruFEEBig2965TWva+56F0mSoS+cCwiSq9qAVsEIQjCUpG/8P/UoN
         o4UAqvcs6TePg==
Reply-To: hs@denx.de
Subject: Re: [PATCH] mtd: devices: mchp48l640: Fix memory leak on cmd
To:     Colin King <colin.king@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210712145214.101377-1-colin.king@canonical.com>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <807e8798-e64f-0026-90c3-eda8825b6828@denx.de>
Date:   Mon, 19 Jul 2021 05:45:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210712145214.101377-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Colin,

On 12.07.21 16:52, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The allocation for cmd is not being kfree'd on the return leading to
> a memory leak. Fix this by kfree'ing it.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: 88d125026753 ("mtd: devices: add support for microchip 48l640 EERAM")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mtd/devices/mchp48l640.c | 1 +
>  1 file changed, 1 insertion(+)

Good catch, thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
