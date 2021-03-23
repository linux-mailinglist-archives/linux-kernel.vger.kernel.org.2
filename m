Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5D8345A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCWJHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhCWJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:07:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6F9C061574;
        Tue, 23 Mar 2021 02:07:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u10so24633098lju.7;
        Tue, 23 Mar 2021 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r5SAZtnTWXxLSfp5x9mNUDN04JTLz5IpjnjCJ8TVqCM=;
        b=f7jt0gNGdizSy7AGbY2k+u1IwC505G9TcJFzN1tTZUMKMXLOTQYbac9XtjIkO2QYI8
         lmtO1uRyQwnbY8NoZVFJ0+kAz8Ci3dyRHLhXF1yt6qL1n9jqqhDUSQ93oqNSKNCQj81J
         491VFyZmtOTzNRDsjUAkTCG+0bQToZ4iYmPrcyQkwHkvWD/HUmEXpBVnMzCN33X3spO4
         I9zubvfpLWhHk+9hyoPTisPIWBTGoKlLdWWEZo+Eig+rtlmgtXD6Tdbn7Rv23iiTxLD8
         Hh4lNfnjQrx/4dCACveqq5BVnWbB0DcYWMPL8rZDheJuH1h0raS8zl8EulAySsyYYpY9
         XdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r5SAZtnTWXxLSfp5x9mNUDN04JTLz5IpjnjCJ8TVqCM=;
        b=GqoST2I0SzxzHe6+7jmN+kxFGRihsOIoZl5HK1aEM8uzWVrYpX+SDVPYSUDOOpnFKs
         8eaBrpKdiZyfuaolZ9Z+w322k+EhAzblerlWAxF9z8aMBGR+geHxu4thWhJ2xFicxbeb
         i1onCJ6NXeqw7fZkUPUjhbdi3ER480ItJkfhnSW6a2i4cfC19i1Eyp2Vp7EyQa41oLuJ
         StAblGiBXMrkV4ZN1EE3ps45PSmBz3f3QqIbVnsTe49myJ5M8dmkrCuax7CqFVydzZrs
         E0S5j+4C2PA8LNU2pUhFckU4023FAQbJ3vXcZ2S7HBCBbeFq+4qSWwQkfk3hbYXCvhDu
         AB0Q==
X-Gm-Message-State: AOAM530NWCy/ZRAfnZxOQg3XS1irDoMlm2ja0Y+6Q1kvCbKCuqYmMgy8
        HwdWYd+tJ4HITI7sLaRo6aM=
X-Google-Smtp-Source: ABdhPJywmUTFte0z9HFu9YRNCVTTVo/LOl4cWWDaRUxplW0BJuLorXxwUvKRfJ+EOuEmKfuUS07jMA==
X-Received: by 2002:a2e:2d02:: with SMTP id t2mr2426043ljt.488.1616490445739;
        Tue, 23 Mar 2021 02:07:25 -0700 (PDT)
Received: from [192.168.1.100] ([31.173.87.52])
        by smtp.gmail.com with ESMTPSA id w24sm2251214ljh.19.2021.03.23.02.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 02:07:25 -0700 (PDT)
Subject: Re: [PATCH v2 01/13] dt-bindings: usb: mtk-xhci: support property
 usb2-lpm-disable
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
References: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <32d4b418-a078-560a-2b65-4a80a2869aae@gmail.com>
Date:   Tue, 23 Mar 2021 12:07:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 23.03.2021 10:02, Chunfeng Yun wrote:

> Add support common property usb2-lpm-disable
              ^ for

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
[...]

MBR, Sergei
