Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78149343C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCVI5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCVI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:57:11 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9806DC061574;
        Mon, 22 Mar 2021 01:57:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r20so20064302ljk.4;
        Mon, 22 Mar 2021 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RABOW3vLVSon7z+xmw1AN4LsWgRUfXSREm0MZvyOp+I=;
        b=uV6+VtLxkVleYOErjwhJ5y6R+uh1cg+P97eZ8ERs43LvVp1a8SqmKFZ+gN0nfJc0UK
         y/6EY61Q9K1E5nlnYl0di/a/zhZqCTdV/X/EYI4IUhlWMW44a6aDlrhXUOJg2rnGGUp1
         OuQI4r0pqDXLYIzomIhuvzUnonSuC/Lc6L2rPXZcSqH1EOTn2b/X4v33mBvuBSwsVln/
         l33ydwoYJ3xAgQwHqYy8jZVyT65idAyHvbl/vFmAw3/6H3ZQlxDTuUacvrnB94lhq+jG
         DlH/zfXT8xtv8pJBSCUcUTLBMFvJmCT3ym7DybSnbPZW8EJF8z3fOpulcexvGEYzmt9/
         Lz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RABOW3vLVSon7z+xmw1AN4LsWgRUfXSREm0MZvyOp+I=;
        b=WmrqByejff5kDMV3cR+MJF2+k51d7vdDTZ98Allo1SFkRzJJ5BMa0plC4psHiTP81k
         SBJpqtaTg8iP3Qi6JBItsnB7KguoWCxIiavFh9q/PJVYuwMv6bDhz7ykugQgxgIFGFtU
         OBVmZreZp5HbT2PEtHK4LqcDHq6LyBasWrdm2uhHkkN8Y/27AO6OUqgS0K4+5RGDqF/U
         y489ZF6UkDHgvjQqQLkGfAhdJzrfSwMEMLZd6x4nI3KfLChUp+pwIXzB8UjpQob9619P
         7yqFkXyPjbq0UkF0j1R/7G+oWT15eev3PJ/8mPwqc4ORcG0vAzMlwB79EcWnnhYUQVsk
         41bw==
X-Gm-Message-State: AOAM530qDgJMljZH3OR31mLRe6F7Hrwa57u+AL1IGjXQkxwbCFr0qvYB
        27So6njCWy+CyXLJiORyIWU=
X-Google-Smtp-Source: ABdhPJy0T5rI4v4i/DWJYPXbO/RLuo0lOwhPUhWCMlZCVeRpkurmIMC/GJRMw+xJXkrg6C7lgCcafw==
X-Received: by 2002:a2e:5315:: with SMTP id h21mr8697762ljb.299.1616403429065;
        Mon, 22 Mar 2021 01:57:09 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.79.3])
        by smtp.gmail.com with ESMTPSA id 68sm1494178lfd.9.2021.03.22.01.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 01:57:08 -0700 (PDT)
Subject: Re: [PATCH 10/13] usb: mtu3: support ip-sleep wakeup for MT8183
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
References: <1616382832-28450-1-git-send-email-chunfeng.yun@mediatek.com>
 <1616382832-28450-10-git-send-email-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <47c8e339-114c-9693-222b-173e54bf298e@gmail.com>
Date:   Mon, 22 Mar 2021 11:57:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616382832-28450-10-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same comments as to the patch #6.

MBR, Sergei
