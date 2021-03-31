Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67835061A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhCaSPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbhCaSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:14:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E367C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:14:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ha17so9944627pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhdND9zkLVUVj6+CJBtL/Ys4Rr2sXVO9jACjXPoCdUI=;
        b=EKmn/tN7+1mL6iKVz7BK5jZywSMEiFRIvsjxNMBnV5OAQ6vS2AmbllwHm1gAx/8Nqq
         YmP889wOFJdo1Zf5Mhbblt01S0z2k+FkxHyy/dGzX0JmvH/iLFrbdBPi5G/TanSGfQ2G
         LZExroNhlXnP59A3bk4QR4rH6p79+V1Do8P36AbIkxfouAYcZGZZzvH04DZswsjYAi+r
         JZvZwvcAAP5TkA5A6g73suv8UubDZUtjMSc/A5fC9sjmpTZMeuY4Fboj20dICQrdJuUK
         sYwguDqX5AUehPzPyuzEbgAMQL6NgvcvD7XWKN+0TXUgELq2/LcL0evzjp69nOxKYA8g
         vv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhdND9zkLVUVj6+CJBtL/Ys4Rr2sXVO9jACjXPoCdUI=;
        b=uiXf+j9dhDb1w2PhukmOK8rd5HmaIL6s7jefPaBoTCH+ecgiA6fRGhL8a8w1C6b7OS
         he5cvquAHgiwt0AZEwh2GBmBI7ZxiiHQzfQ4M6jniYAdD6IL6IGh2442iBp95x2ZxDM3
         2d6w3o9CZSdWI8AhGHJKh7+DCuydQGYte5IGxSBHUAmFN4Z7WQFaZv1vF0aMMIkplV9I
         VCn1WPU4M2rLYFJrAUuIJlLleOxSIOmUnRU2WqlJ9ln59ida5dSAaCFXFSnFZLL1zXxY
         ARK5oFw8E1Csrwr46DMZoeK06U2LG2ME0NBfYrh35qAKLAo2SefimG48DrM6bbTmHcS7
         z2og==
X-Gm-Message-State: AOAM533+802u4d4hoAkoILkBO1PkQLynHfaHfYkY2AemdMn775mTTVQz
        eRlSFUsRK6XyzAUz0UW90ZU=
X-Google-Smtp-Source: ABdhPJxWrH0pK+ZssWgRgLtp1FukBw+vAwNd0N3V1fg0S/JTD2579WJPJBmQdhdwtuPrIzHrEcW94g==
X-Received: by 2002:a17:902:e80e:b029:e4:b2b8:e36e with SMTP id u14-20020a170902e80eb02900e4b2b8e36emr4155843plg.45.1617214487842;
        Wed, 31 Mar 2021 11:14:47 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f21sm2904848pjj.52.2021.03.31.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 11:14:47 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: bcm: brcmstb: remove unused variable 'brcmstb_machine_match'
Date:   Wed, 31 Mar 2021 11:14:46 -0700
Message-Id: <20210331181446.1538071-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1617179999-71706-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1617179999-71706-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 16:39:59 +0800, Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
> Fix the following clang warning:
> 
> drivers/soc/bcm/brcmstb/common.c:17:34: warning: unused variable
> 'brcmstb_machine_match' [-Wunused-const-variable].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Applied to drivers/next, thanks!
--
Florian
