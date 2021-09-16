Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911E240ED5D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbhIPWcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbhIPWci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:32:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BE7C061767
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:31:17 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q68so7613994pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jq2pEkfzG/N/ZlcEaPUhDD6YnDUDJH8gP5gq0CVP3+w=;
        b=eri6bAYhWpudI+T6zUXUrufJqNcXsrOB96ZHkemoazzkhMNOd326abJC5oKYaQ9aNn
         gwtJbOXw0o8/1ZVd3guA0sYj5vT5xePqDuyU1pwf5Bvx/xIULEPMmw/iRum29JhYHYzH
         yQHYnkoHz6fSMlcLgVQUHibM1DXJl8lu6NeWAdPBdFmxpcRuZAMPFUd7C3e7/9z4tk6g
         MldYrxw1iRLXJ+l5hH101pUvr3FSp7RpZvExmE9OJhNZ+pwWNH6BhEnfM1jOPKzDDiBe
         9Z0UBheLpyHDmTE4xZ3JR8yGFflfjifx9ddS5EeK7jt1KSKRrcLRRQk7CY6bIuSblIDe
         zMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jq2pEkfzG/N/ZlcEaPUhDD6YnDUDJH8gP5gq0CVP3+w=;
        b=Dg6NXJa74jXq3oMEDJoJumUh4NXIDwSjEdu1rxeLwr987Orkh+TgWG935MXNTTfGTi
         L2f4IrmEJpxvazeOPkVXjpCmWcvrwxPixnFJLpiYHI2JF0h9MU0+i+g67wa4RRMBlead
         5uKWqH6DcEeSR+nNl014W7PrnOnBZ32zIvfdgR5UiZ/JGUijRrqKiMrAaz1zZCRPAzKX
         uQ+TzzAI0r/JejwWUhHQpbXHubDCStIvH1yXR3pVozaWR2qRVSmsUu742r850R3vOic5
         jJzGpP4f+kgSgasRLEjCQ/YEJ3nrA9cK9kWfw4G1N7wuZDxz3DXdoTtAO9UkQzPDufwh
         Q5ag==
X-Gm-Message-State: AOAM5318AcNc5vorgKf3pbrOZ9/epHLyFxXxyfgG4hNwTb7s6cdda0LF
        1rPjH8POUa0uYBJwwHzr12U=
X-Google-Smtp-Source: ABdhPJw1hiFXMGxBDHQIrwCcoBDVm7TLTpZquMD18L6+RIQLYmFI3SV3Pqcs3vH5V1xKtqIHDoRnHw==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr6947452pgj.407.1631831477263;
        Thu, 16 Sep 2021 15:31:17 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c123sm4031976pfc.50.2021.09.16.15.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:31:16 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72116
Date:   Thu, 16 Sep 2021 15:31:15 -0700
Message-Id: <20210916223115.1952219-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914222146.214115-4-f.fainelli@gmail.com>
References: <20210914222146.214115-1-f.fainelli@gmail.com> <20210914222146.214115-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 15:21:46 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 72116 uses a quad core Brahma-B53 CPU complex which uses the same tuning
> as done for previous chips, add that chip to the list.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
