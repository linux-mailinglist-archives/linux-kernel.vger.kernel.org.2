Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D125440ED5C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbhIPWcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbhIPWca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:32:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08246C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:31:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so5870871pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kFsyxAMwzbN2z2vn+Iock4d3+L8AQ/Xxo2M4EOE59pA=;
        b=aBC5s9DGmjZVkFoOMbpPqJuK2mu+Waz0prssP5g0ySzwE1ygtlOa+NqiX92lcN0X9Y
         q65Nj4vjvKldG7mGoMmBdCIpYtn0Qy1UAHCJyTvo6u/8GakiBWWXQjjsREHph4AbgJPt
         01kPLgIh5lvSVGeMUiZ8ttPbS9yfx1aDZCOcnWWxYW3k+3NDP8sBQFpY18T+o5U0mRiE
         vSHfLBIh4vb2TusOgR8kCMZ/bfO6Mia3llDqCMmt2M1ccakB997/91dulngHvB9WtOg3
         V21O6AXQdrfyT+e7je2/1Z1V3uWE8d1KqFhuXjpYEa008/T0XshF1GqJhUqYZ/vZPVHD
         i53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kFsyxAMwzbN2z2vn+Iock4d3+L8AQ/Xxo2M4EOE59pA=;
        b=3KfhK0bTTpV6Y1PH0JxU7Eftq0pofKOLg1QuAFgJKOWD6XpmrLuqFJJ45kRI6QBIzm
         J5Pl2AcR2vHMSPEEdb9cRiP9KMHsSsa45sauPsESyyw7fUge5b+E0uzUbVVlQPFNVlpP
         W9hoI/78NR1z7p7Z+tnPHdbv+2l7ynyrkUcBpvzXqpuoSNjBIEvTJ/JtDtS8FXla3mkC
         Lv4fiwozJNyDYyLqxE+KyJ2RXHdEa4riR5D3vswxxkYONDYcSwg6x4hiei+vHB1TQLLb
         9UTt8qNkw4blahmblPBgNF5TAGnMTAcOxHIKG7+si6X5AL7W3aEVxot/KF2eQhdmi2+t
         ZPqg==
X-Gm-Message-State: AOAM532NR51cAyOzNnXkA2e8sJZQg6ZK6ex68P2RALOZxRHKysAuBeUm
        W20mMgZ+CPSa5jVvMv2jOKs=
X-Google-Smtp-Source: ABdhPJxQf3DsL70VPEt3421oproLLRo+w+O/2lunRSrEujE/HIBNQQtquBJZirC7SUgaqxBvzLdnzQ==
X-Received: by 2002:a17:90b:4b49:: with SMTP id mi9mr17155779pjb.79.1631831469407;
        Thu, 16 Sep 2021 15:31:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t13sm3609016pjg.25.2021.09.16.15.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:31:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72113
Date:   Thu, 16 Sep 2021 15:31:07 -0700
Message-Id: <20210916223107.1952103-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914222146.214115-3-f.fainelli@gmail.com>
References: <20210914222146.214115-1-f.fainelli@gmail.com> <20210914222146.214115-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 15:21:45 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 72113 uses a dual core Cortex-A72 CPU complex which requires tuning of
> its bus interface unit the same way that the existing Cortex-A72 based
> systems are tuned.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
