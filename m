Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2F3F42B9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhHWBC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhHWBCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:02:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0D3C061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:02:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n12so9199460plf.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PQyq0/mVTcHHR3kWPuGNHdEp5dRrFDPoWILopvZPKCY=;
        b=Aym8TDB5JHD/5Lr6oDIjoO9ZQjzTdmBusHnz8XJAsjfStp8QrIZN96f0J/h7wQzzJM
         lAvsMqbJ9N1FHpeFAWUurojBGPNsQSvfT50tLjMhnnAnyf/n8AmNtM8MyX00LLPSdmgW
         LcNAcrUZ103l3fPnkMKfEkJAj/ZXeAUmDJBCPdZHTOn2RvMnPX+Z49UpTQ3/7MMWNHJd
         H+MRf2HAqusgzeZ9H1Oyqgh2xD+zF3/E5YcLMUsnJnLuOdYJHFrOHUFn05mQMQbx8xKd
         FE1+9SaIzFjSYmlFyrkb2YUsGpBXuNBrRnOXtXcwb4UhC7Wiwnxx7Y1VxpZN3EJhcgRs
         kW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PQyq0/mVTcHHR3kWPuGNHdEp5dRrFDPoWILopvZPKCY=;
        b=uh8+NDjhZoA0QPzbmgCNmVU5P8+XxH/8SFuFhM7XDUSfZrUiHdd8Rzy5MX9WGcAiqe
         j6EYZagcfBMZVO0+azUOUIdZmNVfbSqGCombS5HjZ9F8UsOQAvXRPM7uueUZn+mZhZ4L
         7l7X0V+tQ8frHa0ueDI87xdisJatpLVAYl+Y72/xsBSyTbjvX3D1oLKL9PV81zK1GnzE
         0Y3KOJ/s80PIv/X6gIIohlpmdTpyb5FhtqLi6o4ZlpbhkaJCr1UzSpKJxGhfxlxbkQ3V
         7jB7fIvwhtWM1HfMhpk6q2dys0TbQk8kpE0MIiEt15BrzxHPNXXp6M9p9v+Knh6JfIBf
         IxiA==
X-Gm-Message-State: AOAM53147m0yZ6T41BjiYc4muH/LMFi3LjIJq7XdKwFrLU+2/wTcUafv
        zjU6W20a5vmBYuP8afbw8FI7Bw==
X-Google-Smtp-Source: ABdhPJyu/wpLxNB8SEq2XcHDaiK93Ex4V8Kz7PZdRsM6hvEe3guh/ya/2nT2D47T8XqNttkS/NSrNQ==
X-Received: by 2002:a17:90a:bc8d:: with SMTP id x13mr4585879pjr.66.1629680532120;
        Sun, 22 Aug 2021 18:02:12 -0700 (PDT)
Received: from [10.75.0.6] ([45.135.186.133])
        by smtp.gmail.com with ESMTPSA id s32sm14239643pfw.84.2021.08.22.18.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 18:02:11 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
 <1796ac2a-b068-467e-804e-163f9e1f3c41@linaro.org>
Message-ID: <9ab85a0a-80a7-4ccb-0657-a77c8a657089@linaro.org>
Date:   Mon, 23 Aug 2021 09:02:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1796ac2a-b068-467e-804e-163f9e1f3c41@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bjorn

On 2021/7/27 下午2:47, Zhangfei Gao wrote:
> Hi, Bjorn
>
> On 2021/7/13 上午10:54, Zhangfei Gao wrote:
>> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
>> actually on the AMBA bus. These fake PCI devices have PASID capability
>> though not supporting TLP.
>>
>> Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.
>>
>> v5:
>> no change, base on 5.14-rc1
>
> Would you mind take a look at this patchset.
> We need the quirk to enable sva feature of devices on HiSilicon 
> KunPeng920 and KunPeng930.

Any comments about this patchset.
Is it possible to catch up the 5.15?

Thanks
