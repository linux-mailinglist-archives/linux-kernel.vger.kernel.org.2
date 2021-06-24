Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3F3B3942
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhFXWge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhFXWgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:36:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A1C061574;
        Thu, 24 Jun 2021 15:34:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k5so4354898pjj.1;
        Thu, 24 Jun 2021 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vaqx8Tu4xi2tq8ingioolTC+HDDOxaWjKj+delaC9w=;
        b=cA253rD/7SqHLs/OV2ESl8swvlvOSpVFpwvRUsBEzy7uH9Td8vuY7qvZkRqz3icwTv
         z5j7WrU/ngrfgs5TVqf0bdojUXLiUtf2QGHTUbDsTXKPKp/ZRRJ15C+dwkzMt2sFUwZa
         H8esgFggpDD9y/tfsfCaJUoimkNkv2Mty9wYF2JkJwX/fn8Ko6juI30kBuFBjDTkZtum
         F4g0QK9h1LOoQUbswLdnnutc1/VU+IyXNUeQXSvqeD+X/cz3ywjc8KGOGep+ReSlT1Xn
         LZuXOA0pAMRJkSG4eOun2dFSgXgRcmW6edGz53dvj5vuwe7HNvvHrGryywG7ghMPsqQn
         DadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vaqx8Tu4xi2tq8ingioolTC+HDDOxaWjKj+delaC9w=;
        b=mz6SThRbi425YEVc9GIpo9eWkFedMtO6DEjJIL4I3bMDj3EixY46xl9bD6eyq1GT0P
         W8LJkZxDdun4pBmEu8JOD76o2j39yN2d7JiQuaTVhnGmeETkA+CikXZrdmWMpfVMKaRk
         aUy8wPqrCu4bLwKWR/I3Db4QaGKqectL8CO2gZwPeaK1jc7sgzX18DNOi7AXEh2fPLE1
         TccR5xVk1BtTiRnlHhvKnSAvKRvxfeZwQk56JIh5/oM+ThtDjS4kt84n9+5hWwwjHhpf
         Uev8/0YDZ3CC8/tt8kGL8o6yfEGPPj9QGkP8Z3j2PM2tM3O5xDeDwDcExRv4N6ECpDG8
         m6GQ==
X-Gm-Message-State: AOAM533GQdHpenjtQrrDLcHLD1EG5FKT+V2lYU22a8AZKiMtuWB+GWZu
        fR2fLuBlR4BVfyJt2h74r6Q=
X-Google-Smtp-Source: ABdhPJwWF4PslP9ZRoXix9vW6h+RX0DNFB24ihXYBvkZODshI4FoJjqCNRwzsfvtKv6Qn6mmPNV2Ng==
X-Received: by 2002:a17:903:304e:b029:11d:41c:fa73 with SMTP id u14-20020a170903304eb029011d041cfa73mr6170726pla.82.1624574049854;
        Thu, 24 Jun 2021 15:34:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t1sm3622200pfe.61.2021.06.24.15.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:34:09 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivek Unune <npcomplete13@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM: dts: NSP: add MDIO bus controller node
Date:   Thu, 24 Jun 2021 15:34:07 -0700
Message-Id: <20210624223407.1315430-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210613094639.3242151-3-mnhagan88@gmail.com>
References: <20210613094639.3242151-1-mnhagan88@gmail.com> <20210613094639.3242151-3-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jun 2021 10:46:36 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> This patch adds the node for the MDIO bus controller, present on the NSP
> SoC.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
