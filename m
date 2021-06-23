Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46DD3B13C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 08:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhFWGPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 02:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWGO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:14:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD0EC061574;
        Tue, 22 Jun 2021 23:12:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i4so594305plt.12;
        Tue, 22 Jun 2021 23:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=y4xXS6IuFyqYEqoC2hQM9Va++hGF0TUuSWjzbIiNMwY=;
        b=nxOQRZgxWtOaWHe+NkmkNIgW09bqbJJtKDcAemlZg+dGtbCBeaV/zBCN6weL2QkcgV
         w2Fyz/8pMizyiD3IWIVGzZcqqAo0zm+SDKxDwxYEVwSmFbo0Zr6By2kIpNcvYYZUjuwG
         9qB/we62vUbxyZOx8A2Xkf5APcM//T5Zr227xyA0V+wY0uuheUpRfDSSNAQ65AIwQ8Mq
         x9jEAWxG5ssXdeUFYb4BEypOKCaDBe5YRgtmBJ1qtg0bg02GxtxaPdLPr4Z/GY1CkEMR
         ISaSf1CGndJ+1Zo9C6rrBdjjgeSuoR9abPP5QXng5/AiMezVFKBoQQSnt7knq+cVcugP
         g0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=y4xXS6IuFyqYEqoC2hQM9Va++hGF0TUuSWjzbIiNMwY=;
        b=nzqfPcc8c+8kKwFI/r8mgarGLHrDvS70VOB/u4MOWU2QahhL+oT71LvnDErkveyBS6
         SKU/NU31YMtloEU80HmbLhDIh11lXtq2IFvbnFqRnqkaH8UyslRYlB9B2qNWtXus8/hU
         3rgIcQyuZSTOh8/Hz8fEzYaWNyzhj1HYQxel64KBj1kejiJEdCFpFOEC01nD/sgvkKFu
         URkf6yl3LpM6Ujql7AVSjRAgSCMmvVqNLZC/PO1zjI5Z6sxpZInmmP5HfRHkSrATYsmv
         vFV5xzc1fhXfknYvhQ8Kqze2MF13UQln0r7qoBW5dRx1lf0q5pXqr4HcwmwQfsI+nweV
         Ucyw==
X-Gm-Message-State: AOAM530Zgz+9EiA3Jt2utiiS/L/u5VhWl0tu5eyH4TMsPjApsdAvnbFP
        RvOZcwTeWNK4yX4jhJV9NxJ1tMlavWy1x3o5
X-Google-Smtp-Source: ABdhPJwwAs6nyXmBVdQ+T9PamsEt/X1cDCvmD9Xqwihu4nGmxBwkFgOE5dSl/iEKdsmQqxAXpBGjfA==
X-Received: by 2002:a17:90b:107:: with SMTP id p7mr7829617pjz.1.1624428761507;
        Tue, 22 Jun 2021 23:12:41 -0700 (PDT)
Received: from [192.168.0.118] ([103.242.196.10])
        by smtp.gmail.com with ESMTPSA id c6sm1178779pfb.39.2021.06.22.23.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 23:12:40 -0700 (PDT)
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Subject: [question] De-registration does not remove port
To:     vgupta@synopsys.com, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Pavel Andrianov <andrianov@ispras.ru>
Message-ID: <3e131267-e1b3-1b83-f8be-0577da479223@gmail.com>
Date:   Wed, 23 Jun 2021 11:42:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/tty/serial/arc_uart.c, arc_serial_remove always returns 0, 
instead of calling uart_remove_one_port to remove uart port from serial 
core. The comment says "This will be never be called". In my 
understanding, a port added using uart_add_one_port should be removed 
during de-registration.

Is there a reason for this behavior?
