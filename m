Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5645EC41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbhKZLPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhKZLNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:13:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB5C08EB1F;
        Fri, 26 Nov 2021 02:32:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 293091F4640A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637922720; bh=EuVPphaZZHTIORgNUJBNbSYK215LbmQjkprREz5uJ58=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F4JId67VGNEu5LJXAn8aS9r/oXSoaWwzBv/o5EF0qKQczIe+/9s1MuPVHAg9itCth
         4r1HdOPXA6PoqsXk7NYTkB77x6EeKhF29KY3DJYxqus+1cX1nKAdDq4jHXF/pX1P79
         +fKoQgmtW/MmK9abf0he9VrSiD523i0u+vEnu8p1bKNg2XNCkFmiFPTDuXRbOFb8YZ
         wfdoYD3R9jWPksp7AP/rk4Yi9SuhWk7AHU1d4OBAnkM8FGuuD+P7YMqq8lBLAc/hGU
         w3v2ujn6sqaMdxe6nigJT8VOqhe2qMXccwwbZsQRcB7j9KlMSectJd5mNlAhru9ljE
         UbxELATJrigqw==
Subject: Re: [PATCH 2/3] usb: xhci-mtk: add support ip-sleep wakeup for mt8195
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
 <20211102060049.1843-2-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <c3e56137-7dee-9418-9d69-d583fa26b034@collabora.com>
Date:   Fri, 26 Nov 2021 11:31:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102060049.1843-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/11/21 07:00, Chunfeng Yun ha scritto:
> Add support ip-sleep wakeup for mt8195, it's a specific revision for
> each USB controller, and not following IPM rule.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
