Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3593626CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbhDPRb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbhDPRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:31:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE565C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:31:01 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q11so1252526plx.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:in-reply-to:to:cc:subject
         :content-transfer-encoding;
        bh=eVm7fzMrS3gNt2tz30VRFlPB65aZXiIaR8dlHiQjB+I=;
        b=Ntoj7WicRgw6IMgnZeOI/m2F9jwhlgNQHBf2A7La2t0WF2AsQifFcjeIn5tRQs1JtO
         PWT9YYl6QRZ6acVGszHbP/zV31pYZc3EXqmeW3rEBajwmm+ly/JmKHdH8ekus8N6f9IM
         adkNnU6vRgusLhLWyXES8VZTfR5sZv4aGULSw7nt/mXzabI9LT+a/cwZpc3jQKGVFqxN
         MUET8hqoCsggti/wugecvKV9TCrKugai+RFqFjvUVvv4vrtMks8k2hJakTXuw4PTh/I2
         m7cGSW72blFJAHw5SYR9IPi2ZuU7WHpfPOtUzceVMdcGqFKNSVeSphdTInnAHtSbB8Ip
         RLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:in-reply-to:to:cc:subject
         :content-transfer-encoding;
        bh=eVm7fzMrS3gNt2tz30VRFlPB65aZXiIaR8dlHiQjB+I=;
        b=U8Wv2Pf+9DbzA7lkF84gRGVpPjZ1PaX1IkyCJb1/yFA0XZf8gfBCf1FqkszR9cX2d+
         YkTwbA7GZHpGPTdJrhRz3g+tqDAu4WSnXa3BFiwDtn0XverIydC8eeRzQ2LNbv6RsJjS
         MAqM3m7Gghuaw+LoJI4EbX9ehzsoX9XW1dk3O66bwMBmYl53ax0rAUnllj6TBrBAgFS4
         efCeZsnnhqCpeO2QFCYlf+0FfTC0Hpy0ZyM26H6mEe3ID7gakC59Q19FE7EXv3uN2eS0
         AGGBym7zortVUcVBOq/KDjjJAmvP3BsEBOW/GUzFTcgqSZh3/bOsQr7mXr2jyPWoH9xw
         G1WA==
X-Gm-Message-State: AOAM530nwDI6Douv+lZDW/hn5ZSaR6JCQy06eQyKkxbyGBeu8VYtMiIQ
        b3OKzoMBC/RfC0JhkrT59KEjTIdchz61wtvZwr8=
X-Google-Smtp-Source: ABdhPJy+98u0iYf8qcRv5HsBKVPk0z7QUADgd4kCmpfBRtxqK8WrVLCAFZICdFjxu/stSQHGtiYwYg==
X-Received: by 2002:a17:90a:300f:: with SMTP id g15mr11409516pjb.88.1618594260839;
        Fri, 16 Apr 2021 10:31:00 -0700 (PDT)
Received: from cl-arch-kdev (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id fw24sm6013644pjb.21.2021.04.16.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:31:00 -0700 (PDT)
Message-ID: <6079c9d4.1c69fb81.f4140.08ad@mx.google.com>
Date:   Fri, 16 Apr 2021 10:31:00 -0700 (PDT)
X-Google-Original-Date: Fri, 16 Apr 2021 17:30:59 GMT
From:   Fox Chen <foxhlchen@gmail.com>
In-Reply-To: <20210415144413.146131392@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 5.11 00/23] 5.11.15-rc1 review
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 16:48:07 +0200, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 5.11.15 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Apr 2021 14:44:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

5.11.15-rc1 Successfully Compiled and booted on my Raspberry PI 4b (8g) (bcm2711)
                
Tested-by: Fox Chen <foxhlchen@gmail.com>

