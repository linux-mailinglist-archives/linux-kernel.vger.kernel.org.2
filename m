Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C6B45EBB4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377145AbhKZKgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:36:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48200 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhKZKex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:34:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D11DC1F46790
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637922699; bh=H06EdMXymS4zBmamOUkgbxwP59hf5SsyyaBQT8e4hSc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P3w+IgB2bojbnEejZcPtLhFEklaVwa+TxNDQ+wPhx6G4l0QlNc7VKNvc3XXjAcatT
         4OPpLFN0c5JfxqzNXSh+u2OuTdh4oMir4cEFw7LsDHojbsz+TOTJdQs4eQL6dSbYGA
         btzOqeqMJV4MizPDsRNt/xT56Lonoo11oWLav8TLDY2Mq618hEE46Bn7VSzMAo2mRP
         rKtNDLjwQNAOVt0p6hF1h75m9nSGVrfHsmdNUUGG1ul/46szMMEE9Vnoi16a24LW2Y
         SN8iJM+0CYZKx+j3bdBSUeS9oTLOUry5Q7dMNK4/CuHJNRpvzlKYF3eo88pqFkf97h
         lho9hf+PJcgOA==
Subject: Re: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add support ip-sleep for
 mt8195
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <ef3991ab-846d-0d2f-5fde-3677c2f7db9c@collabora.com>
Date:   Fri, 26 Nov 2021 11:31:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/11/21 07:00, Chunfeng Yun ha scritto:
> There are 4 USB controllers on MT8195, each controller's wakeup control is
> different, add some spicific versions for them.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
