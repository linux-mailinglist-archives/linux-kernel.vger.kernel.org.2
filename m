Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EC44273C9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 00:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbhJHWcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 18:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbhJHWco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:32:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D853C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 15:30:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y1so7003778plk.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QPKX4399w87EXmhlXJlVL2A5oJDbJGbtRWqBg3+A5Ac=;
        b=DQD6hB5Y9t22iWbef1SQFHv9G5obUCp0YHAXuiAZ/PKNlYH1Zj/5/d5ycuw0uocY46
         YF+6iVrcDdPjyusNSSI4G2OVXvH90834VN+ntK3Y/8nGNR2LLrkTp3llpmzIeaw/dVd2
         Z00/RBhJ0O8Y26m0YVDLT4EcCyF09fir8s6TfxTm218TQZgI+dBGW+t6R0uSUrLGiC37
         1yRcH41Hx6LUVE4wp9e9QE2pDKmxa152OPAbgRbXJ4icP9zZ2ZgRXkv4UqTtDVvPDrSv
         O0DI93GtcbciqbxEiWB/Av+9e50GrubnKlNi5nYaz6urE+7jMHGUwsj2agh2m5iYNuE7
         ivBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QPKX4399w87EXmhlXJlVL2A5oJDbJGbtRWqBg3+A5Ac=;
        b=k+t97ZYneyuZNLgh5J2DCjvO3++lQYko9pGKrA94a9UpJ4gquMYrY6x/vtu6QzdufB
         PBkXTxU91dz7MB0JWu+it+YiS9w3Fg6QRiHVEw9TtT8ay+SCOvm/8PBMjD9g2uskN3OZ
         iKWaBSRAzxpN2su+Sw/y+g45xzbHq9BBhwA57IBOdoXQ7vUCND1GS1Aid8ujMYwaHu13
         jHSQ1pfj9CPEhZCtoptQ+Xep/BCR++HmO3SWMjXoamTWswQqrtO0RQkVVlBZDUE1AuFs
         Y5xvq6xEpQkG3eSFsKPmzksIyhnSl0J+kLAvx20Nhp4UKeWfpF4joL4UB7ZaBaZromW4
         vcrQ==
X-Gm-Message-State: AOAM530EKaE/uKsjjjpHbpF3qIQVmHbstKAGARuU8dZOXn3JVAqUQmOd
        h1LHaQXZyYniuyK4ydbrXHc=
X-Google-Smtp-Source: ABdhPJzn9nvG7iuePfhVEuRcZsqQ/r+XKk18QnPYEgv5U0Abn0AF1zWXmyIpmsFIDaEaG6gMCYKp+w==
X-Received: by 2002:a17:90a:8c84:: with SMTP id b4mr15037682pjo.240.1633732248754;
        Fri, 08 Oct 2021 15:30:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n9sm10181736pjk.3.2021.10.08.15.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 15:30:48 -0700 (PDT)
Subject: Re: [GIT PULL 2/2] bcm2835-dt-fixes-2021-10-06
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20211006081849.1434867-1-nsaenzju@redhat.com>
 <20211006081849.1434867-2-nsaenzju@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7391b8b9-178c-7183-cb06-380950a6414f@gmail.com>
Date:   Fri, 8 Oct 2021 15:30:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006081849.1434867-2-nsaenzju@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 1:18 AM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-fixes-2021-10-06
> 
> for you to fetch changes up to 75fcbda959b059d47c38c43f19658527eff4a470:
> 
>   ARM: dts: bcm2711-rpi-4-b: Fix usb's unit address (2021-10-06 09:50:37 +0200)
> 
> ----------------------------------------------------------------

Merged into devicetree/fixes, thanks Nicolas!
-- 
Florian
